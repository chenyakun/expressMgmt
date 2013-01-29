select rowid,emp.* from scott.emp;
SELECT emp.empno,dept.deptno from scott.emp,scott.dept where emp.deptno=dept.deptno and dept.deptno>=20;

SELECT * FROM SCOTT.EMP;


DECLARE
 v_EmpName VARCHAR2(50);
BEGIN
 SELECT EName Into v_EmpName FROM Scott.EMP WHERE empNo=&EmpNo;
 DBMS_OUTPUT.PUT_LINE('当前查询的员工编号为：'||&EmpNo||'员工名称为：'||v_EmpName);
END;
/