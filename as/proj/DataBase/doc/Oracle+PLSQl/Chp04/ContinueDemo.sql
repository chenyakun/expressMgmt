/* Formatted on 2011/08/17 06:24 (Formatter Plus v4.8.8) */
DECLARE
   x   NUMBER := 0;
BEGIN
   LOOP               -- 开始循环，当遇到CONTINUE语句时，将重新开始LOOP的执行
      DBMS_OUTPUT.put_line ('内部循环值:  x = ' || TO_CHAR (x));
      x := x + 1;
      IF x < 3
      THEN                            --如果计数器小于3，则重新开始执行循环。
         CONTINUE;             --使用CONTINUE跳过后面的代码执行，重新开始循环
      END IF;
      --当循环计数大于3时执行的代码
      DBMS_OUTPUT.put_line ('CONTINUE之后的值:  x = ' || TO_CHAR (x));
      EXIT WHEN x = 5;         --当循环计数为5时，退出循环
   END LOOP;
   --输出循环的结束值
   DBMS_OUTPUT.put_line (' 循环体结束后的值:  x = ' || TO_CHAR (x));
END;
/


DECLARE
   x   NUMBER := 0;
BEGIN
   LOOP               -- 开始循环，当遇到CONTINUE语句时，将重新开始LOOP的执行
      DBMS_OUTPUT.put_line ('内部循环值:  x = ' || TO_CHAR (x));
      x := x + 1;
      CONTINUE WHEN x<3;
      --当循环计数大于3时执行的代码
      DBMS_OUTPUT.put_line ('CONTINUE之后的值:  x = ' || TO_CHAR (x));
      EXIT WHEN x = 5;         --当循环计数为5时，退出循环
   END LOOP;
   --输出循环的结束值
   DBMS_OUTPUT.put_line (' 循环体结束后的值:  x = ' || TO_CHAR (x));
END;
/
