CREATE OR REPLACE FUNCTION GetAddSalaryRatioCASE(p_Job VARCHAR2)
RETURN NUMBER AS
  v_Result NUMBER(7,2);
BEGIN  
  CASE p_Job                     --ʹ��CASE WHEN�����������ж�
  WHEN 'CLERK' THEN              --ְԱ
    v_Result:=0.10;
  WHEN 'SALESMAN' THEN           --����
    v_Result:=0.12;
  WHEN 'MANAGER' THEN            --����
    v_Result:=0.15;
  END CASE; 
 RETURN v_Result;                --����ֵ
END;



BEGIN
  DBMS_OUTPUT.PUT_LINE(GetAddSalaryRatio('bc'));
END;
/


