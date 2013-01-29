DELETE FROM dept;
TRUNCATE TABLE dept;

SET DEFINE OFF;
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (10, '����', 'ŦԼ');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (20, '�о���', '����˹');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (30, '���۲�', '֥�Ӹ�');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (40, 'Ӫ�˲�', '��ʿ��');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (60, '������', 'Զ��');
Insert into DEPT
   (DEPTNO, DNAME, LOC)
 Values
   (50, '������', '��ʿ��');
COMMIT;

TRUNCATE TABLE emp;
SET DEFINE OFF;
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7369, 'ʷ��˹', 'ְԱ', 7902, TO_DATE('12/17/1980 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1755.2, 129.6, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7499, '����', '������Ա', 7698, TO_DATE('02/20/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1700, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7521, '�ֵ�', '������Ա', 7698, TO_DATE('02/22/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1350, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7566, 'Լ��', '����', 7839, TO_DATE('04/02/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3570, 297.5, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7654, '��', '������Ա', 7698, TO_DATE('02/28/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1350, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7698, '������', '����', 7839, TO_DATE('03/01/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    2850, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7782, '������', '����', 7839, TO_DATE('05/09/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3587.05, 200, 10);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7788, '˹����', 'ְԱ', 7566, TO_DATE('12/09/1982 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1760.2, 129.6, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7839, '��', '�ϰ�', NULL, TO_DATE('11/17/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    8530.5, NULL, 10);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7844, '����', '������Ա', 7698, TO_DATE('08/08/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1600, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7876, '�ǵ�˹', 'ְԱ', 7788, TO_DATE('01/12/1983 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1440, 120, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7900, '��ķ', 'ְԱ', 7698, TO_DATE('12/03/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    1050, 400, 30);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7902, '����', '������Ա', 7566, TO_DATE('12/03/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    3600, 300, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7892, '�Ű�', NULL, NULL, NULL, 
    NULL, NULL, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7893, '����', NULL, NULL, NULL, 
    NULL, NULL, 20);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7894, '��ʮ', NULL, NULL, NULL, 
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
   (7903, 'ͨ��', 'ְԱ', NULL, TO_DATE('12/04/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    2000, 200, NULL);
Insert into EMP
   (EMPNO, ENAME, JOB, MGR, HIREDATE, 
    SAL, COMM, DEPTNO)
 Values
   (7904, '����', 'ְԱ', NULL, TO_DATE('12/08/1981 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
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

