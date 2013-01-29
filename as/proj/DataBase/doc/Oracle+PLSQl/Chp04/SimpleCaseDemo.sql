/* Formatted on 2011/08/16 15:59 (Formatter Plus v4.8.8) */
DECLARE
   v_job     VARCHAR2 (30);             --定义保存CASE选择器的字符型变量
   v_empno   NUMBER (4)    := &empno;   --定义用来查询员工的员工编号
BEGIN
   SELECT job                           --获取选择器v_job的值
     INTO v_job
     FROM emp
    WHERE empno = v_empno;
   --当指定了CASE的选择器为v_job后，所有的WHEN子句的类型必须匹配为VARCHAR2类型
   CASE v_job 
      WHEN 'CLERK'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.15)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('为普通职员加薪15%');
      WHEN 'ANALYST'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.18)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('为分析人员加薪18%');
      WHEN 'MANAGER'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.20)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('为管理人员加薪20%');
      WHEN 'SALESMAN'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.22)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('为销售人员加薪22%');
      ELSE                  --使用ELSE语句显示信息
         DBMS_OUTPUT.put_line ('员工职级不在加薪的行列！');
   END CASE;                --终止CASE语句块
END;