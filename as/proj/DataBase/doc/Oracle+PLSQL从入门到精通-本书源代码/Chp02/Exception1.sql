DECLARE
  v_Ename VARCHAR2(30);       --定义员工名称保存变量
BEGIN
  --查询表中的员工名称
  SELECT ename INTO v_Ename FROM emp WHERE empno=&EmpNo;
  DBMS_OUTPUT.PUT_LINE('员工名称为：'||v_Ename);
  --异常处理块 
  EXCEPTION
  --异常筛选器
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('没有找到记录!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('其他未处理异常!');
END;