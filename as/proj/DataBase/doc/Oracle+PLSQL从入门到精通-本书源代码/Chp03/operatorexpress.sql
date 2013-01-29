/* Formatted on 2011/08/15 05:13 (Formatter Plus v4.8.8) */
DECLARE
   v_variable1           VARCHAR2 (200) := 'This is a '; --定义变量变赋初值
   v_variable2           VARCHAR2 (100);                 --定义变量
   v_result              VARCHAR2 (500);
   v_constant   CONSTANT VARCHAR2 (10)  := 'CONSTANT';   --定义常量赋常量值
BEGIN
   v_variable2 := 'VARIABLE';                            --使用操作数为变量赋值
   v_result := v_variable1 || v_constant;                --使用表达式为变量赋值
   DBMS_OUTPUT.put_line (v_result);                   --输出变量结果值
END;


/* Formatted on 2011/08/15 05:20 (Formatter Plus v4.8.8) */
DECLARE
   x   VARCHAR2 (8) := '你好，';       --定义字符串变量并赋初值
   y   VARCHAR2 (8) := '中国';
BEGIN
   DBMS_OUTPUT.put_line (x || y);  --输出字符串变量值
END;
/


/* Formatted on 2011/08/15 05:22 (Formatter Plus v4.8.8) */
DECLARE
   x   VARCHAR2 (8)  := '你好，';                    --定义字符串变量并赋初值
   y   VARCHAR2 (8)  := '中国';
   z   VARCHAR2 (10);                                        --未赋值则为NULL
BEGIN
   DBMS_OUTPUT.put_line (x || z || NULL || y);             --输出字符串变量值
END;
/


/* Formatted on 2011/08/15 05:33 (Formatter Plus v4.8.8) */
--定义一个输出布尔值的过程
CREATE OR REPLACE PROCEDURE print_boolean (NAME VARCHAR2, VALUE BOOLEAN)
IS
BEGIN
   IF VALUE IS NULL
   THEN
      DBMS_OUTPUT.put_line (NAME || ' = NULL');    --如果布尔值为NULL，结果为NULL
   ELSIF VALUE = TRUE
   THEN
      DBMS_OUTPUT.put_line (NAME || ' = TRUE');    --如果布尔值为TRUE，结果为TRUE
   ELSE
      DBMS_OUTPUT.put_line (NAME || ' = FALSE');   --如果布尔值为FALSE，结果为FALSE
   END IF;
END;
/


/* Formatted on 2011/08/15 05:40 (Formatter Plus v4.8.8) */
DECLARE
   x   BOOLEAN := TRUE;                --定义布尔变量并赋初值
   y   BOOLEAN := FALSE;
BEGIN
   print_boolean ('x', x);             --输出布尔变量的值
   print_boolean ('y', y);
   print_boolean ('x AND y', x AND y); --AND运算
   print_boolean ('NOT y', NOT y);     --NOT运算
   print_boolean ('x OR y', x OR y);   --OR运算
END;


/* Formatted on 2011/08/15 05:55 (Formatter Plus v4.8.8) */
DECLARE
   v_value   VARCHAR2 (200) := 'Johnson';     --定义并初始化变量
   letter    VARCHAR2 (1)   := 'm';
BEGIN
   --输出算述运算符结果
   print_boolean ('(2 + 2 =  4)', 2 + 2 = 4);
   print_boolean ('(2 + 2 <> 4)', 2 + 2 <> 4);
   print_boolean ('(1 < 2)', 1 < 2);
   print_boolean ('(1 > 2)', 1 > 2);
   print_boolean ('(1 <= 2)', 1 <= 2);
   print_boolean ('(1 >= 1)', 1 >= 1);
   --输出LIKE运算符结果
   IF v_value LIKE 'J%s_n'
   THEN
      DBMS_OUTPUT.put_line ('TRUE');
   ELSE
      DBMS_OUTPUT.put_line ('FALSE');
   END IF;
   --输出BETWEEN运算符结果
   print_boolean ('2 BETWEEN 1 AND 3', 2 BETWEEN 1 AND 3);
   print_boolean ('2 BETWEEN 2 AND 3', 2 BETWEEN 2 AND 3);
   --输出IN运算符结果
   print_boolean ('letter IN (''a'', ''b'', ''c'')',
                  letter IN ('a', 'b', 'c'));
   print_boolean ('letter IN (''z'', ''m'', ''y'', ''p'')',
                  letter IN ('z', 'm', 'y', 'p')
                 );
END;


/* Formatted on 2011/08/15 06:20 (Formatter Plus v4.8.8) */
DECLARE
   v_result   NUMBER;                           --定义保存结果值的变量
BEGIN 
   --v_result := 10 + 5 * 6 - 9 / 3;              --计算数学运算结果
   v_result:=(10+5)*6-9/3;
   DBMS_OUTPUT.put_line (TRUNC (v_result));  --输出结果
END;