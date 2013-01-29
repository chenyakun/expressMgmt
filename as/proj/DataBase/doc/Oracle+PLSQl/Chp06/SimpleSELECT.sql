/* Formatted on 2011/08/31 12:17 (Formatter Plus v4.8.8) */
SELECT view_name, text
  FROM user_views;

SELECT ename, empno, job, hiredate
  FROM scott.emp;
SELECT empno, ename, sal * (1 + 0.12)
  FROM emp;
SELECT empno, ename, sal * (1 + 0.12) raised_sal
  FROM emp;
SELECT empno Ա������, ename "Ա������_NAME", job ְ��, sal AS нˮ
  FROM emp;


SELECT ename || '��н��Ϊ��' || sal Ա��нˮ
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



 --��ѯ���ű��20����Ա����ְ����Ϊ1982���Ա���б�
SELECT empno, ename, job, mgr, hiredate, sal, deptno
  FROM emp
 WHERE deptno = 20 AND hiredate LIKE '%82';

 --��ѯ���ű��20��Ա����ְ����Ϊ1982���Ա���б�  
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

--��emp���У���ѯ������ename��Ϊ��д�ַ���Ϊ�˾��и��Ѻõ���ʾ��ʽ������ʹ��Oracle�ṩ��INITCAP����ת����ʾ��ʽΪ����ĸ��С�����������ʾ��
SELECT empno, INITCAP (ename) ename, hiredate
  FROM emp
 WHERE deptno = 20;


SELECT CONCAT (empno, INITCAP (ename)) ename, hiredate,comm
  FROM emp
 WHERE deptno = 20;
 
 
SELECT empno, ename, hiredate,ROUND(comm) comm
  FROM emp
 WHERE deptno = 20;
 
 
SELECT COUNT (*) ��¼���� FROM emp;

SELECT COUNT (*) ��¼���� FROM emp WHERE deptno=20;



SELECT * FROM emp;


SELECT * FROM dept;



SELECT COUNT(comm) ���Ա���� FROM emp;


SELECT COUNT(ALL comm) ���Ա���� FROM emp;


SELECT * from emp;


SELECT COUNT(DISTINCT job) ְλ���� FROM emp;



SELECT * FROM emp;


SELECT AVG(sal) ƽ��н��,AVG(comm) ƽ����� FROM emp;

SELECT MIN(sal) ���н��,MAX(sal) ���н�� FROM emp;


SELECT MIN(hiredate) �����Ӷ����,MAX(hiredate) �����Ӷ���� FROM emp;


/* Formatted on 2011/08/31 20:58 (Formatter Plus v4.8.8) */
SELECT MIN (ename), MAX (ename) FROM emp;

SELECT MIN(NVL(comm,0)) ������,MAX(NVL(comm,0)) ������ FROM emp;

DELETE FROM emp WHERE deptno IS NULL;
commit;


/* Formatted on 2011/08/31 21:45 (Formatter Plus v4.8.8) */
SELECT   deptno, SUM (sal) ����н��С��
    FROM emp
GROUP BY deptno;

SELECT   deptno, SUM (sal) ����н��С��
    FROM emp
GROUP BY deptno;


SELECT   deptno, SUM (sal) ����н��С��
    FROM emp
GROUP BY deptno
ORDER BY SUM (sal);


SELECT   SUM (sal) ����н��С��,AVG(sal) ����н��ƽ��ֵ
    FROM emp
GROUP BY deptno
ORDER BY SUM (sal);


SELECT   deptno, job, SUM (sal) н��С��
    FROM emp
GROUP BY deptno, job;


SELECT   deptno, job, SUM (sal) н��С��
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
SELECT SUBSTR (ROWIDTOCHAR (ROWID), 0, 6) ���ݶ�����,
       SUBSTR (ROWIDTOCHAR (ROWID), 7, 3) �ļ����,
       SUBSTR (ROWIDTOCHAR (ROWID), 10, 6) �ļ����,
       SUBSTR (ROWIDTOCHAR (ROWID), 16, 3) �ļ����
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
--��ʾ���ڵ�Ϊ
START WITH manager_id IS NULL
--PRIOR��ʾ���е�employee_id�����ڵ�ǰ�е�manager_id
CONNECT BY manager_id = PRIOR employee_id;