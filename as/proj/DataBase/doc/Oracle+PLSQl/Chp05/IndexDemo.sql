
CREATE TABLE emp_index AS SELECT * from scott.emp;

/* Formatted on 2011/08/26 12:24 (Formatter Plus v4.8.8) */
SELECT owner, index_name, table_name, uniqueness
  FROM all_indexes
 WHERE table_name = 'EMP' AND table_owner = 'SCOTT';


SELECT * FROM emp_index;

SELECT *
  FROM emp
 WHERE empno = 7369;

SELECT *
  FROM emp_index
 WHERE empno = 7369;


