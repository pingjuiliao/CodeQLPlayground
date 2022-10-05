/**
  * @name DUMMY
  * @description DUMMY
  * @kind problem
  * @problem.severity error
  * @id cpp/memcpy
  * @tags maintainability
  */

import cpp
import semmle.code.cpp.dataflow.DataFlow

class MemcpyCall extends FunctionCall {
  
  MemcpyCall() {
    this.getTarget().hasQualifiedName("memcpy")
  }
  
  // Problem: Cannot detect variable derived from strlen
  predicate sizeIsStrlen() {
    this.getArgument(2) instanceof StrlenCall 
  }
  
  // 
  predicate sizeDerivedFromStrlen() {
    exists(DataFlow::Node source, DataFlow::Node sink |
        DataFlow::localFlow(source, sink) 
        and sink.asExpr() = this.getArgument(2)
        and source.asExpr() instanceof StrlenCall)
  }
}


from MemcpyCall mcpy
where mcpy.sizeDerivedFromStrlen()
select mcpy, "This memcpy call has the probability of overflow"
