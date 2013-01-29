/* Formatted on 2011/08/14 06:42 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FUNCTION selectallemployments
   RETURN sys_refcursor           --定义一个返回sys_refcursor的函数
AS
   st_cursor   sys_refcursor;
BEGIN
   OPEN st_cursor FOR             --使用该函数查询所有的员工记录
      SELECT *
        FROM emp;
   --返回指向游标的指针
   RETURN st_cursor;
END;
/

/* Formatted on 2011/08/14 07:01 (Formatter Plus v4.8.8) */
DECLARE
   x       sys_refcursor;    --定义引用游标变量
   v_emp   emp%ROWTYPE;      --定义获取游标结果的记录类型
BEGIN
   x := selectallemployments;--调用函数获取游标指针
   --循环遍历游标指针
   LOOP
      FETCH x                --提取游标数据
       INTO v_emp;
      --当没有找到游标记录时则退出
      EXIT WHEN x%NOTFOUND;
      --输出记录信息
      DBMS_OUTPUT.put_line (   '员工编号：'
                            || v_emp.empno
                            || '   员工名称：'
                            || v_emp.ename
                           );
   END LOOP;
END;