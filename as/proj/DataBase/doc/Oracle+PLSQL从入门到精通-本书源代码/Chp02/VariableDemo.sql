DECLARE
  v_DeptName VARCHAR2(10);        --定义标量变量
  v_LoopCounter BINARY_INTEGER;   --使用PL/SQL类型定义标量变量
  --定义记录类型
  TYPE t_Employee IS RECORD (EmpName VARCHAR2(20),EmpNo NUMBER(7),Job VARCHAR2(20));
  v_Employee t_Employee;          --定义记录类型变量
  TYPE csor IS REF CURSOR;        --定义游标变量
  v_date DATE NOT NULL DEFAULT SYSDATE;--定义变量并指定默认值
BEGIN
 NULL;
END;
/