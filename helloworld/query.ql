/**
  * @name Helloworld program for codeql-cpp
  * @description detect unused if-else block
  * @kind problem
  * @problem.severity error
  * @id cpp/detect-unused-blocks
  * @tags maintainability
  */

import cpp

from IfStmt ifstmt, BlockStmt block
where ifstmt.getThen() = block and 
  block.getNumStmt() = 0
select ifstmt, "This 'if' statement is redundant."
