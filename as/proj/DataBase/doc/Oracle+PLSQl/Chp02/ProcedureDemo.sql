CREATE OR REPLACE PROCEDURE AddEmpSalary(p_Ratio NUMBER,p_EmpNo NUMBER)
AS
BEGIN
  IF p_Ratio>0 THEN         --判断传入的参数是否大于0
    --如果大于0,则更新Emp表中的数据
    UPDATE scott.emp SET sal=sal*(1+p_Ratio) WHERE EMPNO=p_EmpNo;
  END IF;
   --提示加薪成功。
  DBMS_OUTPUT.PUT_LINE('加薪成功!');
END;


