CREATE OR REPLACE PROCEDURE AddEmpSalary(p_Ratio NUMBER,p_EmpNo NUMBER)
AS
BEGIN
  IF p_Ratio>0 THEN         --�жϴ���Ĳ����Ƿ����0
    --�������0,�����Emp���е�����
    UPDATE scott.emp SET sal=sal*(1+p_Ratio) WHERE EMPNO=p_EmpNo;
  END IF;
   --��ʾ��н�ɹ���
  DBMS_OUTPUT.PUT_LINE('��н�ɹ�!');
END;


