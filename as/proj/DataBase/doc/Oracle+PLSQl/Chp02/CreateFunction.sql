CREATE OR REPLACE FUNCTION GetAddSalaryRatio(p_Job VARCHAR2)
RETURN NUMBER AS
  v_Result NUMBER(7,2);
BEGIN
 IF p_Job='CLERK' THEN                       --如果为职员，加薪10%
   v_Result:=0.10;
 ELSIF p_Job='SALESMAN' THEN                 --如果为销售职员，加薪12%
   v_Result:=0.12;    
 ELSIF p_Job='MANAGER' THEN                  --如果为经理，加薪15%
   v_Result:=0.15;
 END IF;
 RETURN v_Result;   
END;


--循环结构示例，演示循环为所有员工加薪
DECLARE
 v_Job VARCHAR(100);                         --定义职位变量
 v_EmpNo VARCHAR(20);                        --定义员工编号变量
 v_Ename VARCHAR(60);                        --定义员工名称变量
 v_Ratio NUMBER(7,2);
 CURSOR c_Emp IS SELECT job,empno,ename from Scott.emp FOR UPDATE;
BEGIN
 OPEN c_Emp;   --打开游标
 LOOP          --循环游标
   FETCH c_Emp INTO v_Job,v_EmpNo,v_Ename;   --提取游标数据
   EXIT WHEN c_Emp%NOTFOUND;                 --如果无数据可提取退出游标
   v_Ratio:=GetAddSalaryRatio(v_Job);        --调用函数，得到加薪率
   UPDATE scott.emp SET sal=sal*(1+v_Ratio) WHERE CURRENT OF c_Emp;        
 --显示完成信息
 DBMS_OUTPUT.PUT_LINE('已经为员工'||v_EmpNo||':'||v_Ename||'成功加薪!'); 
 END LOOP;
 CLOSE c_Emp;                                --关闭游标 
 EXCEPTION
 WHEN OTHERS THEN                            --处理PL/SQL预定义异常
   DBMS_OUTPUT.PUT_LINE('没有找到员工数据');
END; 


ROLLBACK;