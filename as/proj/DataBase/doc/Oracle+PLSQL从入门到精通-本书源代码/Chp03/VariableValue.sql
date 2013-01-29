DECLARE
   v_counter INTEGER;          --定义一个变量
BEGIN
   v_counter:=0;               --为变量赋初值
   v_counter:=v_counter+1;     --没有为变量赋初始值直接计算
   DBMS_OUTPUT.put_line('未赋值的变量示例结果：'||v_counter);
END;  


DECLARE
   v_salary NUMBER(7,2);
   v_rate NUMBER(7,2):=0.12;
   v_base_salary NUMBER(7,2):=1200;
BEGIN
   v_salary:=v_base_salary*(1+v_rate);  --使用表达式为变量赋值
   DBMS_OUTPUT.put_line('员工的薪资值为：'||v_salary);       
END;


DECLARE 
   v_string VARCHAR2(200);
   v_hire_date DATE;
   v_bool BOOLEAN;                       --PL/SQL布尔类型
BEGIN
   v_bool:=TRUE;                         --布尔类型赋值
   v_hire_date:=to_date('2011-12-13','yyyy-mm-dd');  --使用函数为日期赋值   
   v_hire_date:=SYSDATE;                --使用日期函数赋值
   v_hire_date:=date'2011-12-14';       --直接赋静态日期值    
   v_string:='This is a string';        --赋静态字符串    
END;   
/



/* Formatted on 2011/08/09 21:55 (Formatter Plus v4.8.8) */
DECLARE
   v_empno      emp.empno%TYPE;                  --定义变量
   v_ename      emp.ename%TYPE;
   v_hiredate   emp.hiredate%TYPE;
BEGIN
   SELECT empno, ename, hiredate                 --查询数据库并为变量赋值
     INTO v_empno, v_ename, v_hiredate
     FROM emp
    WHERE empno = &empno;
   --输出变量的内容
   DBMS_OUTPUT.put_line ('员工编号:' || v_empno);
   DBMS_OUTPUT.put_line ('员工名称:' || v_ename);
   DBMS_OUTPUT.put_line ('雇佣日期:' || v_hiredate);
END;


DECLARE
   v_empno emp.empno%TYPE;    --使用%TYPE定义emp表empno列类型的变量
   v_empno2 v_empno%TYPE;     --定久与v_empno相同的变量
   v_salary NUMBER(7,3) NOT NULL:=1350.5;  --定义薪水变量
   v_othersalary v_salary%TYPE;
BEGIN
   NULL;
END;
/

