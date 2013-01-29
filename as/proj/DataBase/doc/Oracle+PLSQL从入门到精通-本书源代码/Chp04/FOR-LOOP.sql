/* Formatted on 2011/08/17 20:47 (Formatter Plus v4.8.8) */
DECLARE
   v_total   INTEGER := 0;    --循环累计汇总数字
BEGIN
   FOR i IN 1 .. 3            --使用FOR循环开始循环计数
   LOOP
      v_total := v_total + 1; --汇总累加
      DBMS_OUTPUT.put_line ('循环计数器值：' || i);
   END LOOP;
   --输出循环结果值
   DBMS_OUTPUT.put_line ('循环总计：' || v_total);
END;


DECLARE
   v_total   INTEGER := 0;    --循环累计汇总数字
BEGIN
   FOR i IN REVERSE 1 .. 3    --使用REVERSE从高到低进行循环
   LOOP
      v_total := v_total + 1; --汇总累加
      DBMS_OUTPUT.put_line ('循环计数器值：' || i);
   END LOOP;
   --输出循环结果值
   DBMS_OUTPUT.put_line ('循环总计：' || v_total);
END;



/* Formatted on 2011/08/17 23:19 (Formatter Plus v4.8.8) */
DECLARE
   v_counter   INTEGER := &counter;  --动态指定上限边界值变量
BEGIN
   FOR i IN 1 .. v_counter           --在循环中使用变量定义边界
   LOOP
      DBMS_OUTPUT.put_line ('循环计数：' || i);
   END LOOP;
END;
