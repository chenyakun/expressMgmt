/* Formatted on 2011/08/16 14:13 (Formatter Plus v4.8.8) */
/* Formatted on 2011/08/16 14:13 (Formatter Plus v4.8.8) */
DECLARE
   v_character   CHAR(1) :=&tmpVar;    --定义替换变量
BEGIN
   IF v_character = 'A'                --判断字符是否为'A'，如果不是，则跳到下一个ELSIF
   THEN
      DBMS_OUTPUT.put_line ('当前输出字符串：' || v_character);
   ELSIF v_character = 'B'             --判断字符是否为'B'，如果不是，则跳到下一个ELSIF
   THEN
      DBMS_OUTPUT.put_line ('当前输出字符串：' || v_character);
   ELSIF v_character = 'C'             --判断字符是否为'C'，如果不是，则跳到下一个ELSIF
   THEN
      DBMS_OUTPUT.put_line ('当前输出字符串：' || v_character);
   ELSIF v_character = 'D'             --判断字符是否为'D'，如果不是，则跳到ELSE语句
   THEN
      DBMS_OUTPUT.put_line ('当前输出字符串：' || v_character);
   ELSE
      DBMS_OUTPUT.put_line ('不是A-D之间的字符');
   END IF;
END;