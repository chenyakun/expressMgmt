/* Formatted on 2011/08/17 20:47 (Formatter Plus v4.8.8) */
DECLARE
   v_total   INTEGER := 0;    --ѭ���ۼƻ�������
BEGIN
   FOR i IN 1 .. 3            --ʹ��FORѭ����ʼѭ������
   LOOP
      v_total := v_total + 1; --�����ۼ�
      DBMS_OUTPUT.put_line ('ѭ��������ֵ��' || i);
   END LOOP;
   --���ѭ�����ֵ
   DBMS_OUTPUT.put_line ('ѭ���ܼƣ�' || v_total);
END;


DECLARE
   v_total   INTEGER := 0;    --ѭ���ۼƻ�������
BEGIN
   FOR i IN REVERSE 1 .. 3    --ʹ��REVERSE�Ӹߵ��ͽ���ѭ��
   LOOP
      v_total := v_total + 1; --�����ۼ�
      DBMS_OUTPUT.put_line ('ѭ��������ֵ��' || i);
   END LOOP;
   --���ѭ�����ֵ
   DBMS_OUTPUT.put_line ('ѭ���ܼƣ�' || v_total);
END;



/* Formatted on 2011/08/17 23:19 (Formatter Plus v4.8.8) */
DECLARE
   v_counter   INTEGER := &counter;  --��ָ̬�����ޱ߽�ֵ����
BEGIN
   FOR i IN 1 .. v_counter           --��ѭ����ʹ�ñ�������߽�
   LOOP
      DBMS_OUTPUT.put_line ('ѭ��������' || i);
   END LOOP;
END;
