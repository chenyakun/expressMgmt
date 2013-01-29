/* Formatted on 2011/08/17 09:11 (Formatter Plus v4.8.8) */
DECLARE
   counter   NUMBER := 1;          --定义计数器变量
BEGIN
   WHILE (counter < 10)            --判断循环的条件为counter<10
   LOOP
      DBMS_OUTPUT.put_line ('计数器 [' || counter || '].');    
      IF counter >= 1              --如果循环计数器大于等于1
      THEN
         counter := counter + 1;   --将循环计数器加1
      END IF;
   END LOOP;
END;
/


