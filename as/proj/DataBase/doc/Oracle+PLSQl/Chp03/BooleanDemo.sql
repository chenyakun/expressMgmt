/* Formatted on 2011/08/13 17:45 (Formatter Plus v4.8.8) */
DECLARE 
   v_condition   BOOLEAN;       --���岼�����ͱ���
BEGIN
   v_condition := TRUE;         --Ϊ����������ֵTRUE
 --v_condtion:='FALSE';         --���󣬲���ֵ���ܴ�����
   IF v_condition THEN          --�������ֵ����ΪTRUE�������
   DBMS_OUTPUT.put_line ('ֵΪTRUE');
   END IF;
END;