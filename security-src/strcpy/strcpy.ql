/**
  * @name Dummpy
  * @description check memcpy, strcpy, strncpy
  * @kind problem
  * @problem.severity error
  * @id cpp/strcpy_local
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
  predicate fixedDstSize() { 
    exists(DataFlow::Node source, DataFlow::Node sink |
      DataFlow::localFlow(source, sink) and
      sink.asExpr() = this.getArgument(0) and
       (source.asExpr().(MallocCall).isFixedSize() or  
        (source.asExpr().getType().(ArrayType).hasArraySize() and 
         not source.asExpr() instanceof FunctionCall
        )))
  }
  predicate fixedSrcSize() {
    exists(DataFlow::Node source, DataFlow::Node sink |
      DataFlow::localFlow(source, sink) and 
      sink.asExpr() = this.getArgument(1) and 
      source.asExpr().isConstant() )
  }
}

from StrcpyCall scpy
where scpy.fixedDstSize()
select scpy, "destination buffer has fixed size!!"
