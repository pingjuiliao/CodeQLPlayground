/**
  * @name Dummpy
  * @description check memcpy, strcpy, strncpy
  * @kind problem
  * @problem.severity error
  * @id cpp/strcpy_global
  * @tags maintainability
  */

import cpp
import semmle.code.cpp.dataflow.DataFlow


class MallocCall extends FunctionCall {
  MallocCall() {
    this.getTarget().hasQualifiedName("malloc")
  }
  predicate isFixedSize() {
    this.getArgument(0) instanceof Literal
  }
}

class StrcpyCall extends FunctionCall {
  StrcpyCall() {
    this.getTarget().hasQualifiedName("strcpy")
  }
}

class StrcpyDstDataFlowConfiguration extends DataFlow::Configuration {
  StrcpyDstDataFlowConfiguration() {
    this = "StrcpyDstDataFlowConfig"
  }
  
  override predicate isSource(DataFlow::Node source) {
    exists(GlobalVariable gv | 
      source.asExpr().(MallocCall).isFixedSize() or
      source.asExpr().getType().(ArrayType).hasArraySize()
    )
  }
  
  override predicate isSink(DataFlow::Node sink) {
    exists(StrcpyCall scpy| sink.asExpr() = scpy.getArgument(0))
  }
}

class StrcpySrcDataFlowConfiguration extends DataFlow::Configuration {
  
  StrcpySrcDataFlowConfiguration() { this = "StrcpySrcDataFlowConfig" }
  
  override predicate isSource(DataFlow::Node source) {
    exists(GlobalVariable gv |
      source.asExpr() instanceof StringLiteral or
      (source.asExpr() = gv.getAnAccess() and
       gv.getAnAssignedValue() instanceof StringLiteral)
    )
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(StrcpyCall scpy | sink.asExpr() = scpy.getArgument(1))
  }
}

from StrcpyDstDataFlowConfiguration destBuffer, 
     DataFlow::Node src0, 
     StrcpySrcDataFlowConfiguration srcBuffer,
     DataFlow::Node src1, 
     StrcpyCall strcpy
where srcBuffer.hasFlow(src1, DataFlow::exprNode(strcpy.getArgument(1))) and
      destBuffer.hasFlow(src0, DataFlow::exprNode(strcpy.getArgument(0)))
select strcpy, "size overflow determineable!"
