DECLARE
  --定义记录类型
  TYPE Emp_Info_Type IS RECORD
  (
    EmpName VARCHAR2(10),
    Job VARCHAR(9),
    Sal NUMBER(7,2)
  );
  --声明记录类型的变量
  EmpInfo emp_Info_Type;
BEGIN
  --查询数据并保存到记录类型中
  SELECT ename,job,sal INTO EmpInfo FROM emp WHERE empno=&EmpNo;
  --输出记录类型变量中保存的员工消息
  DBMS_OUTPUT.PUT_LINE('员工信息为：员工姓名：'||EmpInfo.EmpName||
  ' 职位：'||EmpInfo.Job||
  ' 薪资：'||EmpInfo.Sal); 
END;