/* Formatted on 2011/08/19 22:05 (Formatter Plus v4.8.8) */
DECLARE
   v_count   PLS_INTEGER := 1; --ѭ��������ֵ
BEGIN
   WHILE v_count <= 5          --ѭ��������С�ڵ���20
   LOOP
      --ѭ���������������
      DBMS_OUTPUT.put_line ('Whileѭ������ֵ: ' || v_count);
      v_count := v_count + 1;   --�������ֵ������ѭ��
   END LOOP;
END;