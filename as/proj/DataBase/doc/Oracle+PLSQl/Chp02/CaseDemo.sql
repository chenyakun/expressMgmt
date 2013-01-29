CREATE OR REPLACE FUNCTION GetAddSalaryRatioCASE(p_Job VARCHAR2)
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



BEGIN
  DBMS_OUTPUT.PUT_LINE(GetAddSalaryRatio('bc'));
END;
/


