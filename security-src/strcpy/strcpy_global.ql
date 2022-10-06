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


class StrcpyCall extends FunctionCall {
  StrcpyCall() {
    this.getTarget().hasQualifiedName("strcpy")
  }
}

class StrcpySrcDataFlowConfiguration extends DataFlow::Configuration {
  
  StrcpySrcDataFlowConfiguration() { this = "StrcpySrcDataFlowConfig" }
  
  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof StringLiteral or
    source.asExpr().getType().(ArrayType).hasArraySize()
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(StrcpyCall scpy | sink.asExpr() = scpy.getArgument(1))
  }
}



from StrcpySrcDataFlowConfiguration dataflow, DataFlow::Node src, DataFlow::Node sink
where dataflow.hasFlow(src, sink)
select sink, "src buffer has fixed size"
