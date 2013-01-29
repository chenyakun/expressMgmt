/* Formatted on 2011/08/10 15:56 (Formatter Plus v4.8.8) */
DECLARE
   c_salary_rate   CONSTANT NUMBER (7, 2) := 0.25;  --定义加薪常量值
   v_salary                 NUMBER (7, 2);          --定义保存薪资结果的变量
BEGIN
   SELECT sal * (1 + c_salary_rate)                 --查询数据库，返回架薪后的结果
     INTO v_salary
     FROM emp
    WHERE empno = &empno;
   --输出屏幕消息
   DBMS_OUTPUT.put_line ('加薪后的薪资：' || v_salary);
END;