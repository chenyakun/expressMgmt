/*���淶����*/
CREATE OR REPLACE PACKAGE EmpSalary 
AS
--ִ��ʵ�ʵļ�н����
PROCEDURE AddEmpSalary(p_Ratio NUMBER,p_EmpNo NUMBER);
--ʹ��IF-ELSIF���õ���н����
FUNCTION GetAddSalaryRatio(p_Job VARCHAR2) RETURN NUMBER;
--ʹ��CASE���õ���н����
FUNCTION GetAddSalaryRatioCASE(p_Job VARCHAR2) RETURN NUMBER;
END EmpSalary;
/
/*���嶨��*/
CREATE OR REPLACE PACKAGE BODY EmpSalary
AS
   PROCEDURE AddEmpSalary(p_Ratio NUMBER,p_EmpNo NUMBER)
    AS
    BEGIN
      IF p_Ratio>0 THEN         --�жϴ���Ĳ����Ƿ����0
        --�������0,�����Emp���е�����
        UPDATE scott.emp SET sal=sal*(1+p_Ratio) WHERE EMPNO=p_EmpNo;
      END IF;
       --��ʾ��н�ɹ���
      DBMS_OUTPUT.PUT_LINE('��н�ɹ�!');
    END;
    
    FUNCTION GetAddSalaryRatio(p_Job VARCHAR2)
    RETURN NUMBER AS
      v_Result NUMBER(7,2);
    BEGIN
     IF p_Job='CLERK' THEN                       --���ΪְԱ����н10%
       v_Result:=0.10;
     ELSIF p_Job='SALESMAN' THEN                 --���Ϊ����ְԱ����н12%
       v_Result:=0.12;    
     ELSIF p_Job='MANAGER' THEN                  --���Ϊ������н15%
       v_Result:=0.15;
     END IF;
     RETURN v_Result;   
    END; 
    
    FUNCTION GetAddSalaryRatioCASE(p_Job VARCHAR2)
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
END EmpSalary;
/

commit;


