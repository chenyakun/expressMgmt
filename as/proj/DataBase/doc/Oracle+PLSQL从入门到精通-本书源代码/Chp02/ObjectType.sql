CREATE OR REPLACE TYPE Emp_obj AS OBJECT
(
  empno NUMBER(4),     --Ա���������
  ename VARCHAR2(10),  --Ա����������
  job VARCHAR(9),      --Ա��ְ������
  sal NUMBER(7,2),     --Ա��нˮ����
  deptno NUMBER(2),    --���ű������
  --��н����
  MEMBER PROCEDURE AddSalary(radio NUMBER)
);
--������������壬ʵ�ֶ��󷽷�
CREATE OR REPLACE TYPE BODY Emp_obj AS
  --ʵ�ֶ��󷽷�
  MEMBER PROCEDURE  AddSalary(radio NUMBER)
  IS
  BEGIN
    sal:=sal*(1+radio);  --�����ض�������нˮ
  END; 
END ;

CREATE TABLE Emp_obj_tab OF emp_obj;
