/* Formatted on 2011/08/16 21:45 (Formatter Plus v4.8.8) */
DECLARE
   v_count   NUMBER (2) := 0;         --定义循环计数变量
BEGIN
   LOOP                               --开始执行循环
      v_count := v_count + 1;         --循环计数器加1
      --打印字符信息
      DBMS_OUTPUT.put_line ('行' || v_count || '：Hello PL/SQL!');
      --如果计数条件为10,则退出循环
      IF v_count = 10
      THEN
         EXIT;       --使用EXIT退出循环
      END IF;
   END LOOP;
   --循环退出后，将执行这条语句
   DBMS_OUTPUT.put_line ('循环已经退出了！');
END;


DECLARE
   v_count   NUMBER (2) := 0;         --定义循环计数变量
BEGIN
   LOOP                               --开始执行循环
      v_count := v_count + 1;         --循环计数器加1
      --打印字符信息
      DBMS_OUTPUT.put_line ('行' || v_count || '：Hello PL/SQL!');
      --如果计数条件为10,则退出循环
      EXIT WHEN v_count=10;
   END LOOP;
   --循环退出后，将执行这条语句
   DBMS_OUTPUT.put_line ('循环已经退出了！');
END;