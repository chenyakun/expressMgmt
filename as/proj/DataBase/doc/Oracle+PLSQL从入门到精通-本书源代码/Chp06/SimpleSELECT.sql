/* Formatted on 2011/08/31 12:17 (Formatter Plus v4.8.8) */
SELECT view_name, text
  FROM user_views;

SELECT ename, empno, job, hiredate
  FROM scott.emp;
SELECT empno, ename, sal * (1 + 0.12)
  FROM emp;
SELECT empno, ename, sal * (1 + 0.12) raised_sal
  FROM emp;
SELECT empno 员工名称, ename "员工姓名_NAME", job 职级, sal AS 薪水
  FROM emp;


SELECT ename || '的薪资为：' || sal 员工薪水
  FROM emp;


SELECT *
  FROM emp
 WHERE deptno = 20;

SELECT *
  FROM emp;


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE sal BETWEEN 1500 AND 2500;


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE sal >= 1500 AND sal <= 2500;


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE hiredate BETWEEN TO_DATE ('1981-01-01', 'YYYY-MM-DD')
                    AND TO_DATE ('1981-12-31', 'YYYY-MM-DD');


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE job IN ('SALESMAN', 'CLERK', 'ANALYST');


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE mgr IN (7698, 7839);


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE mgr = 7698 OR mgr = 7839;


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE ename LIKE 'J%';


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE hiredate LIKE '%81';

SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE ename LIKE '__A%';



SELECT *
  FROM emp;


SELECT empno, ename, job, mgr, hiredate
  FROM emp
 WHERE mgr IS NULL;



SELECT empno, ename, job, mgr, hiredate
  FROM emp
 WHERE mgr IS NOT NULL;


SELECT *
  FROM emp;



 --查询部门编号20并且员工入职日期为1982年的员工列表。
SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE deptno = 20 AND hiredate LIKE '%82';

 --查询部门编号20或员工入职日期为1982年的员工列表。  
SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE deptno = 20 OR hiredate LIKE '%82';


SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE NOT (deptno = 20 AND hiredate LIKE '%82');


SELECT *
  FROM emp;

SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE job NOT IN ('CLERK', 'MANAGER', 'SALESMAN');

SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE sal NOT BETWEEN 1000 AND 2500;

SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE ename NOT LIKE '%A%';


SELECT   empno, ename, job, mgr, hiredate, sal, deptno
    FROM emp
   WHERE deptno = 20
ORDER BY empno;


SELECT   empno, ename, job, mgr, hiredate, sal, deptno
    FROM emp
   WHERE deptno = 20
ORDER BY empno, ename DESC;


SELECT   empno, ename, job, mgr, hiredate, sal, deptno
    FROM emp
   WHERE deptno = 20
ORDER BY 4 DESC;

SELECT   empno, ename, job, mgr, hiredate, sal, deptno
    FROM emp
   WHERE deptno = 20
ORDER BY 8 DESC;



SELECT empno, ename, hiredate
  FROM emp;

--在emp表中，查询出来的ename都为大写字符，为了具有更友好的显示方式，可以使用Oracle提供的INITCAP函数转换显示方式为首字母大小，如下语句所示：
SELECT empno, INITCAP (ename) ename, hiredate
  FROM emp
 WHERE deptno = 20;


SELECT CONCAT (empno, INITCAP (ename)) ename, hiredate,comm
  FROM emp
 WHERE deptno = 20;
 
 
SELECT empno, ename, hiredate,ROUND(comm) comm
  FROM emp
 WHERE deptno = 20;
 
 
SELECT COUNT (*) 记录条数 FROM emp;

SELECT COUNT (*) 记录条数 FROM emp WHERE deptno=20;



SELECT * FROM emp;


SELECT * FROM dept;



SELECT COUNT(comm) 提成员工数 FROM emp;


SELECT COUNT(ALL comm) 提成员工数 FROM emp;


SELECT * from emp;


SELECT COUNT(DISTINCT job) 职位个数 FROM emp;



SELECT * FROM emp;


SELECT AVG(sal) 平均薪资,AVG(comm) 平均提成 FROM emp;

SELECT MIN(sal) 最低薪资,MAX(sal) 最高薪资 FROM emp;


SELECT MIN(hiredate) 最早雇佣日期,MAX(hiredate) 最晚雇佣日期 FROM emp;


/* Formatted on 2011/08/31 20:58 (Formatter Plus v4.8.8) */
SELECT MIN (ename), MAX (ename) FROM emp;

SELECT MIN(NVL(comm,0)) 最低提成,MAX(NVL(comm,0)) 最高提成 FROM emp;

DELETE FROM emp WHERE deptno IS NULL;
commit;


/* Formatted on 2011/08/31 21:45 (Formatter Plus v4.8.8) */
SELECT   deptno, SUM (sal) 部门薪资小计
    FROM emp
GROUP BY deptno;

SELECT   deptno, SUM (sal) 部门薪资小计
    FROM emp
GROUP BY deptno;


SELECT   deptno, SUM (sal) 部门薪资小计
    FROM emp
GROUP BY deptno
ORDER BY SUM (sal);


SELECT   SUM (sal) 部门薪资小计,AVG(sal) 部门薪资平均值
    FROM emp
GROUP BY deptno
ORDER BY SUM (sal);


SELECT   deptno, job, SUM (sal) 薪资小计
    FROM emp
GROUP BY deptno, job;


SELECT   deptno, job, SUM (sal) 薪资小计
    FROM emp
   WHERE deptno IN (20, 30)
GROUP BY deptno, job
  HAVING SUM (sal) > 2000;
  
  
  
  
  /* Formatted on 2011/09/01 12:13 (Formatter Plus v4.8.8) */
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;


/* Formatted on 2011/09/01 16:01 (Formatter Plus v4.8.8) */
SELECT ROWNUM, x.*
  FROM emp x
 WHERE x.deptno = 20;
 
 
 /* Formatted on 2011/09/01 16:07 (Formatter Plus v4.8.8) */
SELECT ROWNUM, empno, ename, job, mgr, hiredate
  FROM emp
 WHERE deptno = 20;
 
 
/* Formatted on 2011/09/01 16:15 (Formatter Plus v4.8.8) */
SELECT ROWNUM, empno, ename, job, mgr, hiredate
  FROM emp
 WHERE ROWNUM <= 10;
 
 
 /* Formatted on 2011/09/02 06:24 (Formatter Plus v4.8.8) */
SELECT ROWIDTOCHAR (ROWID), x.ename, x.empno, x.job, x.hiredate
  FROM emp x
 WHERE ROWNUM <= 5;
 
 
 
/* Formatted on 2011/09/02 06:37 (Formatter Plus v4.8.8) */
SELECT SUBSTR (ROWIDTOCHAR (ROWID), 0, 6) 数据对象编号,
       SUBSTR (ROWIDTOCHAR (ROWID), 7, 3) 文件编号,
       SUBSTR (ROWIDTOCHAR (ROWID), 10, 6) 文件编号,
       SUBSTR (ROWIDTOCHAR (ROWID), 16, 3) 文件编号
  FROM emp
 WHERE ROWNUM <= 5;
 
 
 SELECT ROWID,x.* FROM emp x;
 
 
 CREATE TABLE emp_rowid AS SELECT * FROM emp;
 
 
 INSERT INTO emp_rowid SELECT * FROM emp;
 
 
 /* Formatted on 2011/09/02 06:50 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp_rowid
 WHERE ROWID NOT IN (SELECT   MIN (ROWID)
                         FROM emp_rowid
                     GROUP BY empno);
select empno  from emp_rowid group by empno having count(*) >1;


SELECT ROWIDTOCHAR (ROWID), x.ename, x.empno, x.job, x.hiredate
  FROM emp_rowid x;
  
  
  
/* Formatted on 2011/09/02 07:01 (Formatter Plus v4.8.8) */
DELETE FROM emp_rowid
      WHERE ROWID NOT IN (SELECT   MIN (ROWID)
                              FROM emp_rowid
                          GROUP BY empno);




/* Formatted on 2011/09/03 07:59 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp
 WHERE sal > (SELECT sal
                FROM emp
               WHERE ename = 'SMITH');
               
/* Formatted on 2011/09/03 10:42 (Formatter Plus v4.8.8) */
SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE job = (SELECT job
                FROM emp
               WHERE ename = 'SMITH');
               
               


SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE job = (SELECT MIN(sal)
                FROM emp
               WHERE ename = 'SMITH');               
               
               
/* Formatted on 2011/09/03 10:50 (Formatter Plus v4.8.8) */
SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE sal = (SELECT MIN (sal)
                FROM emp);                   
                
                
/* Formatted on 2011/09/03 11:00 (Formatter Plus v4.8.8) */
SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE sal IN (SELECT   MIN (sal)
                   FROM emp
               GROUP BY deptno);    
               
               
SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE sal >SOME(SELECT sal FROM emp WHERE job='CLERK') 
 AND job<>'CLERK';                   
 
/* Formatted on 2011/09/03 16:07 (Formatter Plus v4.8.8) */
SELECT empno, ename, job, mgr, hiredate, sal
  FROM emp
 WHERE sal > ALL (SELECT sal
                    FROM emp
                   WHERE job = 'CLERK') AND job <> 'CLERK';
                   
                   
    /* Formatted on 2011/09/03 16:07 (Formatter Plus v4.8.8) */
SELECT   e1.empno, e1.ename, e1.deptno
    FROM emp e1
   WHERE e1.sal > (SELECT AVG (sal)
                     FROM emp e2
                    WHERE e2.deptno = e1.deptno)
ORDER BY e1.deptno
                   

SELECT * FROM emp;                   



CREATE TABLE emp_history AS SELECT * FROM emp;


/* Formatted on 2011/09/04 06:56 (Formatter Plus v4.8.8) */
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp
   WHERE deptno = 20
UNION
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp_history
   WHERE deptno = 30;
   
   
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp
   WHERE deptno = 20
UNION ALL
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp_history
   WHERE deptno = 20;  
   
   
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp
   WHERE deptno = 20
INTERSECT
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp_history
   WHERE deptno = 20;     
   
   
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp
   WHERE deptno = 20
MINUS
SELECT   empno, ename, sal, hiredate, deptno
    FROM emp_history
   WHERE deptno = 20;        
   
      
   
SELECT * FROM employees;  
   
   
SELECT     LEVEL, LPAD ('  ', 2 * (LEVEL - 1)) || last_name "EmpName",
           hire_date, salary
      FROM employees
--表示根节点为
START WITH manager_id IS NULL
--PRIOR表示父行的employee_id，等于当前行的manager_id
CONNECT BY manager_id = PRIOR employee_id;