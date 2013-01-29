/* Formatted on 2011/08/15 05:13 (Formatter Plus v4.8.8) */
DECLARE
   v_variable1           VARCHAR2 (200) := 'This is a '; --��������丳��ֵ
   v_variable2           VARCHAR2 (100);                 --�������
   v_result              VARCHAR2 (500);
   v_constant   CONSTANT VARCHAR2 (10)  := 'CONSTANT';   --���峣��������ֵ
BEGIN
   v_variable2 := 'VARIABLE';                            --ʹ�ò�����Ϊ������ֵ
   v_result := v_variable1 || v_constant;                --ʹ�ñ��ʽΪ������ֵ
   DBMS_OUTPUT.put_line (v_result);                   --����������ֵ
END;


/* Formatted on 2011/08/15 05:20 (Formatter Plus v4.8.8) */
DECLARE
   x   VARCHAR2 (8) := '��ã�';       --�����ַ�������������ֵ
   y   VARCHAR2 (8) := '�й�';
BEGIN
   DBMS_OUTPUT.put_line (x || y);  --����ַ�������ֵ
END;
/


/* Formatted on 2011/08/15 05:22 (Formatter Plus v4.8.8) */
DECLARE
   x   VARCHAR2 (8)  := '��ã�';                    --�����ַ�������������ֵ
   y   VARCHAR2 (8)  := '�й�';
   z   VARCHAR2 (10);                                        --δ��ֵ��ΪNULL
BEGIN
   DBMS_OUTPUT.put_line (x || z || NULL || y);             --����ַ�������ֵ
END;
/


/* Formatted on 2011/08/15 05:33 (Formatter Plus v4.8.8) */
--����һ���������ֵ�Ĺ���
CREATE OR REPLACE PROCEDURE print_boolean (NAME VARCHAR2, VALUE BOOLEAN)
IS
BEGIN
   IF VALUE IS NULL
   THEN
      DBMS_OUTPUT.put_line (NAME || ' = NULL');    --�������ֵΪNULL�����ΪNULL
   ELSIF VALUE = TRUE
   THEN
      DBMS_OUTPUT.put_line (NAME || ' = TRUE');    --�������ֵΪTRUE�����ΪTRUE
   ELSE
      DBMS_OUTPUT.put_line (NAME || ' = FALSE');   --�������ֵΪFALSE�����ΪFALSE
   END IF;
END;
/


/* Formatted on 2011/08/15 05:40 (Formatter Plus v4.8.8) */
DECLARE
   x   BOOLEAN := TRUE;                --���岼������������ֵ
   y   BOOLEAN := FALSE;
BEGIN
   print_boolean ('x', x);             --�������������ֵ
   print_boolean ('y', y);
   print_boolean ('x AND y', x AND y); --AND����
   print_boolean ('NOT y', NOT y);     --NOT����
   print_boolean ('x OR y', x OR y);   --OR����
END;


/* Formatted on 2011/08/15 05:55 (Formatter Plus v4.8.8) */
DECLARE
   v_value   VARCHAR2 (200) := 'Johnson';     --���岢��ʼ������
   letter    VARCHAR2 (1)   := 'm';
BEGIN
   --���������������
   print_boolean ('(2 + 2 =  4)', 2 + 2 = 4);
   print_boolean ('(2 + 2 <> 4)', 2 + 2 <> 4);
   print_boolean ('(1 < 2)', 1 < 2);
   print_boolean ('(1 > 2)', 1 > 2);
   print_boolean ('(1 <= 2)', 1 <= 2);
   print_boolean ('(1 >= 1)', 1 >= 1);
   --���LIKE��������
   IF v_value LIKE 'J%s_n'
   THEN
      DBMS_OUTPUT.put_line ('TRUE');
   ELSE
      DBMS_OUTPUT.put_line ('FALSE');
   END IF;
   --���BETWEEN��������
   print_boolean ('2 BETWEEN 1 AND 3', 2 BETWEEN 1 AND 3);
   print_boolean ('2 BETWEEN 2 AND 3', 2 BETWEEN 2 AND 3);
   --���IN��������
   print_boolean ('letter IN (''a'', ''b'', ''c'')',
                  letter IN ('a', 'b', 'c'));
   print_boolean ('letter IN (''z'', ''m'', ''y'', ''p'')',
                  letter IN ('z', 'm', 'y', 'p')
                 );
END;


/* Formatted on 2011/08/15 06:20 (Formatter Plus v4.8.8) */
DECLARE
   v_result   NUMBER;                           --���屣����ֵ�ı���
BEGIN 
   --v_result := 10 + 5 * 6 - 9 / 3;              --������ѧ������
   v_result:=(10+5)*6-9/3;
   DBMS_OUTPUT.put_line (TRUNC (v_result));  --������
END;