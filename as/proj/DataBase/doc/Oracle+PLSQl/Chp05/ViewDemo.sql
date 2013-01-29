SELECT * FROM DEPT;
SELECT * FROM emp;

DROP VIEW view_emp_dept;

/* Formatted on 2011/08/28 09:58 (Formatter Plus v4.8.8) */
CREATE OR REPLACE VIEW view_dept_emp
AS
   SELECT emp.empno, emp.ename, emp.job, emp.mgr, emp.hiredate, dept.dname,
          dept.loc
     FROM emp, dept
    WHERE emp.deptno = dept.deptno;
    
    
SELECT * FROM view_dept_emp;    



/* Formatted on 2011/08/28 14:51 (Formatter Plus v4.8.8) */
CREATE OR REPLACE VIEW v_deptemp
AS
   SELECT empno, ename, job, mgr, hiredate, sal, comm
     FROM emp
    WHERE deptno = 20;
    
    
INSERT INTO v_deptemp VALUES(7999,'李思','经理'，7369,SYSDATE,8000,NULL);



CREATE OR REPLACE VIEW v_deptemp_readonly
AS
   SELECT empno, ename, job, mgr, hiredate, sal, comm
     FROM emp
    WHERE deptno = 20
   WITH READ ONLY;
   
   
 DROP VIEW v_deptemp_readonly;
 
 DROP VIEW v_deptemp_alias;
 
/* Formatted on 2011/08/28 15:45 (Formatter Plus v4.8.8) */
CREATE OR REPLACE VIEW v_deptemp_alias (员工编号,
                                        员工名称,
                                        职位,
                                        经理,
                                        雇佣日期,
                                        薪水,
                                        备注
                                       )
AS
   SELECT empno, ename, job, mgr, hiredate, sal, comm
     FROM emp
    WHERE deptno = 20;


SELECT *
  FROM v_deptemp_alias;
  
  

  DROP VIEW v_sumdept;
 SELECT * FROM v_sumdept;
 
 
/* Formatted on 2011/08/28 16:36 (Formatter Plus v4.8.8) */
CREATE OR REPLACE VIEW v_sumdept(部门名称，部门编号)
AS
SELECT   dept.dname, SUM (emp.sal) sumsal
    FROM emp, dept
   WHERE emp.deptno = dept.deptno(+)
GROUP BY dept.dname;

DROP VIEW v_deptemp_check;

/* Formatted on 2011/08/29 06:14 (Formatter Plus v4.8.8) */
CREATE OR REPLACE VIEW v_deptemp_check
AS
   SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
     FROM emp
    WHERE deptno = 20
          WITH CHECK OPTION CONSTRAINT v_empdept_chk;
          
/* Formatted on 2011/08/29 06:31 (Formatter Plus v4.8.8) */
CREATE OR REPLACE VIEW v_deptemp_check
AS
   SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
     FROM emp
    WHERE deptno = 30;
          
          
/* Formatted on 2011/08/29 06:16 (Formatter Plus v4.8.8) */
INSERT INTO v_deptemp_check
     VALUES (7992, '赵六', '职员', 7369, SYSDATE, 8000, NULL, 30);
     
     
     
/* Formatted on 2011/08/29 20:27 (Formatter Plus v4.8.8) */
SELECT last_ddl_time, object_name, status
  FROM user_objects
 WHERE object_name = 'V_DEPTEMP';
 
 
 ALTER TABLE emp MODIFY ename VARCHAR2(20);
 
 
 ALTER TABLE emp DROP COLUMN grade;
 
 
 ALTER VIEW v_deptemp COMPILE;