DELETE FROM dept;
TRUNCATE TABLE dept;

SET DEFINE OFF;
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (10, '财务部', '纽约');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (20, '研究部', '达拉斯');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (30, '销售部', '芝加哥');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (40, '营运部', '波士顿');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (60, '行政部', '远洋');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (50, '行政部', '波士顿');
COMMIT;

TRUNCATE TABLE emp;
SET DEFINE OFF;
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7369, '史密斯', '职员', 7902, TO_DATE('12/17/1980 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1755.2, 129.6, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7499, '艾伦', '销售人员', 7698, TO_DATE('02/20/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1700, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7521, '沃德', '销售人员', 7698, TO_DATE('02/22/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1350, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7566, '约翰', '经理', 7839, TO_DATE('04/02/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3570, 297.5, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7654, '马丁', '销售人员', 7698, TO_DATE('02/28/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1350, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7698, '布莱克', '经理', 7839, TO_DATE('03/01/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    2850, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7782, '克拉克', '经理', 7839, TO_DATE('05/09/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3587.05, 200, 10);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7788, '斯科特', '职员', 7566, TO_DATE('12/09/1982 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1760.2, 129.6, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7839, '金', '老板', NULL, TO_DATE('11/17/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    8530.5, NULL, 10);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7844, '特纳', '销售人员', 7698, TO_DATE('08/08/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1600, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7876, '亚当斯', '职员', 7788, TO_DATE('01/12/1983 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1440, 120, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7900, '吉姆', '职员', 7698, TO_DATE('12/03/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1050, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7902, '福特', '分析人员', 7566, TO_DATE('12/03/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3600, 300, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7892, '张八', NULL, NULL, NULL, 
    NULL, NULL, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7893, '霍九', NULL, NULL, NULL, 
    NULL, NULL, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7894, '霍十', NULL, NULL, NULL, 
    NULL, NULL, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7895, 'APPS', NULL, NULL, TO_DATE('09/05/2011 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3000, 200, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7903, '通利', '职员', NULL, TO_DATE('12/04/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    2000, 200, NULL);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7904, '罗威', '职员', NULL, TO_DATE('12/08/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    2000, 200, NULL);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7898, 'O''Malley', NULL, NULL, NULL, 
    NULL, NULL, 20);
COMMIT;

SELECT * FROM emp;
SELECT * FROM dept

