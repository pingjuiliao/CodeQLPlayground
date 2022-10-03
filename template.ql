/**
  * @name DUMMY
  * @description DUMMY
  * @kind problem
  * @problem.severity error
  * @id cpp/DUMMY0
  * @tags maintainability
  */

import cpp

from IfStmt ifstmt, BlockStmt block
where ifstmt.getThen() = block and 
  block.getNumStmt() = 0
select ifstmt, "This 'if' statement is redundant."
