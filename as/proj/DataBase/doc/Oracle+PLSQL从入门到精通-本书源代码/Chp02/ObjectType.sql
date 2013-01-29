CREATE OR REPLACE TYPE Emp_obj AS OBJECT
(
  empno NUMBER(4),     --员工编号属性
  ename VARCHAR2(10),  --员工名称属性
  job VARCHAR(9),      --员工职别属性
  sal NUMBER(7,2),     --员工薪水属性
  deptno NUMBER(2),    --部门编号属性
  --加薪方法
  MEMBER PROCEDURE AddSalary(radio NUMBER)
);
--定义对象类型体，实现对象方法
CREATE OR REPLACE TYPE BODY Emp_obj AS
  --实现对象方法
  MEMBER PROCEDURE  AddSalary(radio NUMBER)
  IS
  BEGIN
    sal:=sal*(1+radio);  --加上特定比例的薪水
  END; 
END ;

CREATE TABLE Emp_obj_tab OF emp_obj;
