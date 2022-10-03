/**
  * @name DUMMY
  * @description DUMMY
  * @kind problem
  * @problem.severity error
  * @id cpp/libc_ovfl
  * @tags maintainability
  */

import cpp

class OverflowCall extends FunctionCall {
  OverflowCall() {
    this.getTarget().hasGlobalName("strncpy")
  }
  Expr getSize() {
    result = this.getArgument(2)
  }
}

from OverflowCall ovflcall
where ovflcall.getSize() instanceof 
select
