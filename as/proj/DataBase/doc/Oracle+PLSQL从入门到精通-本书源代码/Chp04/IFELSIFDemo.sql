/* Formatted on 2011/08/16 14:13 (Formatter Plus v4.8.8) */
/* Formatted on 2011/08/16 14:13 (Formatter Plus v4.8.8) */
DECLARE
   v_character   CHAR(1) :=&tmpVar;    --�����滻����
BEGIN
   IF v_character = 'A'                --�ж��ַ��Ƿ�Ϊ'A'��������ǣ���������һ��ELSIF
   THEN
      DBMS_OUTPUT.put_line ('��ǰ����ַ�����' || v_character);
   ELSIF v_character = 'B'             --�ж��ַ��Ƿ�Ϊ'B'��������ǣ���������һ��ELSIF
   THEN
      DBMS_OUTPUT.put_line ('��ǰ����ַ�����' || v_character);
   ELSIF v_character = 'C'             --�ж��ַ��Ƿ�Ϊ'C'��������ǣ���������һ��ELSIF
   THEN
      DBMS_OUTPUT.put_line ('��ǰ����ַ�����' || v_character);
   ELSIF v_character = 'D'             --�ж��ַ��Ƿ�Ϊ'D'��������ǣ�������ELSE���
   THEN
      DBMS_OUTPUT.put_line ('��ǰ����ַ�����' || v_character);
   ELSE
      DBMS_OUTPUT.put_line ('����A-D֮����ַ�');
   END IF;
END;