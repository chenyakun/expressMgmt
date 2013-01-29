--循环结构示例，演示循环为所有员工加薪
DECLARE
 --定义加薪比率常量
 c_Manager CONSTANT NUMBER:=0.15;
 c_SalesMan CONSTANT NUMBER:=0.12;
 c_Clerk CONSTANT NUMBER:=0.10;
 v_Job VARCHAR(100);                         --定义职位变量
 v_EmpNo VARCHAR(20);                        --定义员工编号变量
 v_Ename VARCHAR(60);                        --定义员工名称变量
 CURSOR c_Emp IS SELECT job,empno,ename from Scott.emp FOR UPDATE;
BEGIN
 OPEN c_Emp;   --打开游标
 LOOP          --循环游标
   FETCH c_Emp INTO v_Job,v_EmpNo,v_Ename;   --提取游标数据
   EXIT WHEN c_Emp%NOTFOUND;                 --如果无数据可提取退出游标
 IF v_Job='CLERK' THEN                       --如果为职员，加薪10%
   UPDATE scott.emp SET SAL=SAL*(1+c_Clerk) WHERE CURRENT OF c_Emp;
 ELSIF v_Job='SALESMAN' THEN                 --如果为销售职员，加薪12%
   UPDATE scott.emp SET SAL=SAL*(1+c_SalesMan) WHERE CURRENT OF c_Emp; 
 ELSIF v_Job='MANAGER' THEN                  --如果为经理，加薪15%
   UPDATE scott.emp SET SAL=SAL*(1+c_Manager) WHERE CURRENT OF c_Emp;  
 END IF;
 --显示完成信息
 DBMS_OUTPUT.PUT_LINE('已经为员工'||v_EmpNo||':'||v_Ename||'成功加薪!'); 
 END LOOP;
 CLOSE c_Emp;                --关闭游标 
 EXCEPTION
 WHEN NO_DATA_FOUND THEN     --处理PL/SQL预定义异常
   DBMS_OUTPUT.PUT_LINE('没有找到员工数据');
END; 

