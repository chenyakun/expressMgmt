/* Formatted on 2011/08/16 16:51 (Formatter Plus v4.8.8) */
DECLARE
   v_sal     NUMBER (10, 2);          --定义保存薪水的变量
   v_empno   NUMBER (10)    := &empno;--用来查询的员工编号
BEGIN
   SELECT sal                         --获取员工薪资信息
     INTO v_sal
     FROM emp
    WHERE empno = v_empno;
   --使用搜索CASE语句，判断员工薪资级别
   CASE
      WHEN v_sal BETWEEN 1000 AND 1500
      THEN
         DBMS_OUTPUT.put_line ('员工级别：初级职员');
      WHEN v_sal BETWEEN 1500 AND 3000
      THEN
         DBMS_OUTPUT.put_line ('员工级别：中级管理');
      WHEN v_sal BETWEEN 3000 AND 5000
      THEN
         DBMS_OUTPUT.put_line ('员工级别：高级经理');
      ELSE
         DBMS_OUTPUT.put_line ('不在级别范围之内');
   END CASE;
END;
   
   
   