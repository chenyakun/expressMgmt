select rowid,emp.* from scott.emp;
SELECT emp.empno,dept.deptno from scott.emp,scott.dept where emp.deptno=dept.deptno and dept.deptno>=20;

SELECT * FROM SCOTT.EMP;


DECLARE
 v_EmpName VARCHAR2(50);
BEGIN
 SELECT EName Into v_EmpName FROM Scott.EMP WHERE empNo=&EmpNo;
 DBMS_OUTPUT.PUT_LINE('��ǰ��ѯ��Ա�����Ϊ��'||&EmpNo||'Ա������Ϊ��'||v_EmpName);
END;
/