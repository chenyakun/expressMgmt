/* Formatted on 2011/08/18 23:36 (Formatter Plus v4.8.8) */
DECLARE
   done   BOOLEAN;
BEGIN
   FOR i IN 1 .. 50
   LOOP
      IF done
      THEN
         GOTO end_loop;
      END IF;
       --��ǩ����
      <<end_loop>>
      NULL;        --ʹ��NULLʲôҲ����
   END LOOP;
END;


/* Formatted on 2011/08/18 23:37 (Formatter Plus v4.8.8) */
DECLARE
   v_counter   INT := &counter;  --�����û��������ֵ
BEGIN
   IF v_counter > 5              --�������ֵ����5
   THEN
      DBMS_OUTPUT.put_line ('v_counter>5');  --�����Ϣ
   ELSE                          --����
      NULL;                      --��ռλ���������κ�����
   END IF;
END;