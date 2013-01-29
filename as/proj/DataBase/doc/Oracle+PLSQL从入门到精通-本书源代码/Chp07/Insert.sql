SELECT * FROM emp;

/* Formatted on 2011/09/05 06:22 (Formatter Plus v4.8.8) */
INSERT INTO emp
            (empno, ename, job, mgr,
             hiredate, sal, comm, deptno
            )
     VALUES (7890, '刘七', '副理', 7566,
             TO_DATE ('2001-08-15', 'YYYY-MM-DD'), 8000, 300, 20
            );
            
            
INSERT INTO emp
     VALUES (7891, '刘七', '副理', 7566, TO_DATE ('2001-08-15', 'YYYY-MM-DD'),
             8000, 300, 20);
             
/* Formatted on 2011/09/05 06:45 (Formatter Plus v4.8.8) */
INSERT INTO emp
            (empno, ename, deptno
            )
     VALUES (7892, '张八', 20
            );
     
     
/* Formatted on 2011/09/05 06:47 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp
 WHERE empno = 7892; 
                  
 
INSERT INTO emp
            (empno, ename, deptno
            )
     VALUES (7892, '张八', 20
            );
            
/* Formatted on 2011/09/05 09:35 (Formatter Plus v4.8.8) */
INSERT INTO emp
            (empno, ename, deptno
            )
     VALUES (7898, 'O''Malley', 20
            );       
            
            
SELECT * FROM emp;            
            
INSERT INTO emp
VALUES(7893,'霍九',NULL,NULL,NULL,NULL,NULL,20);

INSERT INTO emp
VALUES(7894,'霍十','',NULL,'',NULL,NULL,20);


INSERT INTO emp 
VALUES(7895,USER,NULL,NULL,TRUNC(SYSDATE),3000,200,20);

/* Formatted on 2011/09/05 09:27 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp
 WHERE empno = 7895;
 
 
DROP TABLE emp_copy;
 
 
CREATE TABLE emp_copy AS SELECT * FROM emp WHERE 1=2; 


/* Formatted on 2011/09/05 10:11 (Formatter Plus v4.8.8) */
INSERT INTO emp_copy
   SELECT *
     FROM emp
    WHERE deptno = 20;
    
SELECT * FROM emp;    
    
INSERT INTO emp_copy
   SELECT *
     FROM emp
    WHERE deptno = 20;    
    
    
/* Formatted on 2011/09/05 10:36 (Formatter Plus v4.8.8) */
INSERT INTO emp_copy
            (empno, ename, job, mgr, deptno)
   SELECT empno, ename, job, mgr, deptno
     FROM emp
    WHERE deptno = 30;
    
  
  CREATE TABLE emp_dept_10 AS SELECT * FROM emp WHERE 1=2;
  CREATE TABLE emp_dept_20 AS SELECT * FROM emp WHERE 1=2;
  CREATE TABLE emp_dept_30 AS SELECT * FROM emp WHERE 1=2;
  CREATE TABLE emp_copy AS SELECT * FROM emp WHERE 1=2;    
    
    
   INSERT FIRST
   WHEN deptno = 10               --如果部门编号为10
   THEN  
        INTO emp_dept_10          --则插入到emp_dept_10表
   WHEN deptno = 20               --如果部门编号为20
   THEN
        INTO emp_dept_20          --则插入到emp_dept_20表  
   WHEN deptno = 30               --如果部门编号为30
   THEN
        INTO emp_dept_30          --则插入到emp_dept_30表  
   ELSE                           --如果deptno不为10、20或者是30
        INTO emp_copy             --则插入到emp_copy 表  
   SELECT *
     FROM emp;                    --查询emp表中的所有数据，插入到目标表



SELECT rowid,x.* from emp x;





TRUNCATE TABLE emp_dept_10 ;
TRUNCATE TABLE emp_dept_20 ;
TRUNCATE TABLE emp_dept_30 ;
TRUNCATE TABLE emp_copy ;


/* Formatted on 2011/09/05 13:39 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/05 13:43 (Formatter Plus v4.8.8) */
INSERT FIRST
   WHEN deptno = 10                    --如果部门编号为10
   THEN
        INTO emp_dept_10               --插入到emp_dept_10，使用VALUES指定字段
             (empno, ename, sal, deptno
             )
      VALUES (empno, ename, sal, deptno
             )
   WHEN deptno = 20                    --如果部门编号为20
   THEN
        INTO emp_dept_20               --插入到emp_dept_20，使用VALUES指定字段
             (empno, ename
             )
      VALUES (empno, ename
             )
   WHEN deptno = 30                   --如果部门编号为30
   THEN
        INTO emp_dept_30              --插入到emp_dept_30，使用VALUES指定字段
             (empno, ename, hiredate
             )
      VALUES (empno, ename, hiredate
             )
   ELSE                                --如果部门编号即不为10、20或30
        INTO emp_copy                  --插入到emp_copy，使用VALUES指定字段
             (empno, ename, deptno
             )
      VALUES (empno, ename, deptno
             )
   SELECT *
     FROM emp;                         --指定插入子查询        
     

SELECT * FROM emp_dept_10;



SELECT * FROM emp;



UPDATE emp SET sal=3000 WHERE empno=7369;

UPDATE emp SET sal=3000,comm=200,mgr=7566 WHERE empno=7369;

SELECT * FROM emp;

SELECT AVG(y.sal) FROM emp y WHERE y.deptno=20;

/* Formatted on 2011/09/05 15:38 (Formatter Plus v4.8.8) */
UPDATE emp x
   SET x.sal = (SELECT AVG (y.sal)
                  FROM emp y
                 WHERE y.deptno = x.deptno)
 WHERE x.empno = 7369;
 
 
 
/* Formatted on 2011/09/05 15:43 (Formatter Plus v4.8.8) */
UPDATE emp
   SET sal = (SELECT sal
                FROM emp
               WHERE empno = 7782)
 WHERE empno = 7369;
 
 
 select * from emp_history;
 
 DROP TABLE emp_history;
    
 
/* Formatted on 2011/09/05 15:50 (Formatter Plus v4.8.8) */
UPDATE emp x
   SET (x.sal, x.comm) = (SELECT AVG (y.sal), MAX (y.comm)
                            FROM emp y
                           WHERE y.deptno = x.deptno)
 WHERE x.empno = 7369;
 
 CREATE TABLE emp_history AS SELECT * FROM emp;
 
 
/* Formatted on 2011/09/05 16:09 (Formatter Plus v4.8.8) */
UPDATE emp_history x
   SET (x.sal, x.comm) = (SELECT sal, comm
                            FROM emp y
                           WHERE y.empno =x.empno )
 WHERE x.empno = 7369;
 
 
 SELECT * FROM emp_history;
 
 SELECT * from emp;
 
 /* Formatted on 2011/09/05 16:09 (Formatter Plus v4.8.8) */
UPDATE (SELECT x.sal sal, y.sal sal_history, x.comm comm, y.comm comm_history
          FROM emp x, emp_history y
         WHERE x.empno = y.empno AND x.empno = 7369)
   SET sal_history = sal,
       comm_history = comm;          
           
       
UPDATE /*+bypass_ujvc*/  (SELECT x.sal sal, y.sal sal_history, x.comm comm, y.comm comm_history
          FROM emp x, emp_history y
         WHERE x.empno = y.empno AND x.empno = 7369)
   SET sal_history = sal,
       comm_history = comm;        
                    

DELETE FROM emp WHERE empno=7894                   
       
INSERT INTO emp
VALUES(7894,'霍十','',DEFAULT,'',NULL,NULL,20);

SELECT * FROM emp_copy;

SELECT * FROM emp;

/* Formatted on 2011/09/05 21:15 (Formatter Plus v4.8.8) */
MERGE INTO emp_copy c           --目标表
   USING emp e                  --源表，可以是表、视图或子查询
   ON (c.empno = e.empno)
   WHEN MATCHED THEN             --当匹配时，进行UPDATE操作
      UPDATE
         SET c.ename = e.ename, c.job = e.job, c.mgr = e.mgr,
             c.hiredate = e.hiredate, c.sal = e.sal, c.comm = e.comm,
             c.deptno = e.deptno
   WHEN NOT MATCHED THEN        --当不匹配时，进行INSERT操作
      INSERT
      VALUES (e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm,
              e.deptno);
              
              


DELETE FROM emp WHERE empno=7903;         


DELETE FROM dept WHERE deptno=20;   


SELECT * FROM dept;  
     
     
     

/* Formatted on 2011/09/05 22:54 (Formatter Plus v4.8.8) */
DELETE FROM emp
      WHERE deptno = (SELECT deptno
                        FROM dept
                       WHERE dname = '销售部');      
      
      
      
      
DELETE FROM emp_copy;      
     

DELETE FROM emp x
      WHERE EXISTS (SELECT 1
                      FROM emp_copy
                     WHERE empno = x.empno);

/* Formatted on 2011/09/05 23:02 (Formatter Plus v4.8.8) */
DELETE FROM emp x
      WHERE empno IN (SELECT empno
                        FROM emp_copy
                       WHERE empno = x.empno);

 


TRUNCATE TABLE dept;


ALTER TABLE dept ENABLE CONSTRAINT pk_dept;


ALTER TABLE emp DISABLE CONSTRAINT PK_EMP;


CREATE TABLE dept_copy AS SELECT * FROM dept;

TRUNCATE TABLE dept;


INSERT INTO dept SELECT * FROM dept_copy;