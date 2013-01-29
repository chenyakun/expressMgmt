CREATE TABLE emp_copy AS SELECT * from scott.emp


DROP TABLE emp_copy;


CREATE TABLE emp_copy AS SELECT * from scott.emp WHERE 1=2;


