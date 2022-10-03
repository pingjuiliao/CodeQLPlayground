/**
  * @name Dummpy
  * @description check memcpy, strcpy, strncpy
  * @kind problem
  * @problem.severity error
  * @id cpp/detect-unused-blocks
  * @tags maintainability
  */

import cpp

from FunctionCall call
where call.getTarget().hasName("strncpy")
select call, "This is the copy command."
