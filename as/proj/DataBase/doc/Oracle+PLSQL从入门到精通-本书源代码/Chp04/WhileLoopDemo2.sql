/* Formatted on 2011/08/19 22:05 (Formatter Plus v4.8.8) */
DECLARE
   v_count   PLS_INTEGER := 1; --循环计数器值
BEGIN
   WHILE v_count <= 5          --循环计数器小于等于20
   LOOP
      --循环计数索引的输出
      DBMS_OUTPUT.put_line ('While循环索引值: ' || v_count);
      v_count := v_count + 1;   --变更索引值以免死循环
   END LOOP;
END;