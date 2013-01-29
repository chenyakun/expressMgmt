--分支结构示例，演示为员工加薪
DECLARE
 --定义加薪比率常量
 c_Manager CONSTANT NUMBER:=0.15;
 c_SalesMan CONSTANT NUMBER:=0.12;
 c_Clerk CONSTANT NUMBER:=0.10;
 --定义工种变量
 v_Job VARCHAR(100);
BEGIN
 --查询指定员工编码的员工信息
 SELECT job INTO v_Job FROM scott.emp WHERE empno=&empNo1;
 --执行分支判断
 IF v_Job='CLERK' THEN
   UPDATE scott.emp SET SAL=SAL*(1+c_Clerk) WHERE empno=&empNo1;
 ELSIF v_Job='SALESMAN' THEN
   UPDATE scott.emp SET SAL=SAL*(1+c_SalesMan) WHERE empno=&empNo1;   
 ELSIF v_Job='MANAGER' THEN
   UPDATE scott.emp SET SAL=SAL*(1+c_Manager) WHERE empno=&empNo1;   
 END IF;
 --显示完成信息
 DBMS_OUTPUT.PUT_LINE('已经为员工'||&empNo1||'成功加薪!');  
 EXCEPTION
 --处理PL/SQL预定义异常
 WHEN NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('没有找到员工数据');
END; 