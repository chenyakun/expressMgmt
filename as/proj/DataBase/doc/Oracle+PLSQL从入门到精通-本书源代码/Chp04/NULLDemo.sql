/* Formatted on 2011/08/18 23:36 (Formatter Plus v4.8.8) */
DECLARE
   done   BOOLEAN;
BEGIN
   FOR i IN 1 .. 50
   LOOP
      IF done
      THEN
         GOTO end_loop;
      END IF;
       --标签定义
      <<end_loop>>
      NULL;        --使用NULL什么也不做
   END LOOP;
END;


/* Formatted on 2011/08/18 23:37 (Formatter Plus v4.8.8) */
DECLARE
   v_counter   INT := &counter;  --允许用户输入变量值
BEGIN
   IF v_counter > 5              --如果变量值大于5
   THEN
      DBMS_OUTPUT.put_line ('v_counter>5');  --输出信息
   ELSE                          --否则
      NULL;                      --仅占位符，不做任何事情
   END IF;
END;