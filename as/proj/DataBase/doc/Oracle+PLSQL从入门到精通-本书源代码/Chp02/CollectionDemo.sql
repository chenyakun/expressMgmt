DECLARE 
  --定义员工名称索引表
  TYPE Emp_Table IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER;
  EmpList Emp_Table;   --定义表类型的变量
  --定义游标类型
  CURSOR empcursor IS SELECT EName FROM emp;
BEGIN
  --如果游标没有打开则打开游标
  IF NOT empcursor%ISOPEN THEN
     OPEN empcursor;
  END IF;
  --从游标结果中提取所有的员工名称
  FETCH empcursor BULK COLLECT INTO EmpList;
  --使用FOR循环显示所有的员工名称
  FOR i IN 1..EmpList.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('员工名称：'||EmpList(i));
  END LOOP;
  CLOSE empcursor;   --关闭游标
END;
/