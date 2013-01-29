/*包规范定义*/
CREATE OR REPLACE PACKAGE EmpSalary 
AS
--执行实际的加薪动作
PROCEDURE AddEmpSalary(p_Ratio NUMBER,p_EmpNo NUMBER);
--使用IF-ELSIF语句得到加薪比率
FUNCTION GetAddSalaryRatio(p_Job VARCHAR2) RETURN NUMBER;
--使用CASE语句得到加薪比率
FUNCTION GetAddSalaryRatioCASE(p_Job VARCHAR2) RETURN NUMBER;
END EmpSalary;
/
/*包体定义*/
CREATE OR REPLACE PACKAGE BODY EmpSalary
AS
   PROCEDURE AddEmpSalary(p_Ratio NUMBER,p_EmpNo NUMBER)
    AS
    BEGIN
      IF p_Ratio>0 THEN         --判断传入的参数是否大于0
        --如果大于0,则更新Emp表中的数据
        UPDATE scott.emp SET sal=sal*(1+p_Ratio) WHERE EMPNO=p_EmpNo;
      END IF;
       --提示加薪成功。
      DBMS_OUTPUT.PUT_LINE('加薪成功!');
    END;
    
    FUNCTION GetAddSalaryRatio(p_Job VARCHAR2)
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
    
    FUNCTION GetAddSalaryRatioCASE(p_Job VARCHAR2)
    RETURN NUMBER AS
      v_Result NUMBER(7,2);
    BEGIN  
      CASE p_Job                     --使用CASE WHEN语句进行条件判断
      WHEN 'CLERK' THEN              --职员
        v_Result:=0.10;
      WHEN 'SALESMAN' THEN           --销售
        v_Result:=0.12;
      WHEN 'MANAGER' THEN            --经理
        v_Result:=0.15;
      END CASE; 
     RETURN v_Result;                --返回值
    END;      
END EmpSalary;
/

commit;


