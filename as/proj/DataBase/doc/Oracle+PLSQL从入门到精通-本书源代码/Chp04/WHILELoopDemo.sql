/* Formatted on 2011/08/17 09:11 (Formatter Plus v4.8.8) */
DECLARE
   counter   NUMBER := 1;          --�������������
BEGIN
   WHILE (counter < 10)            --�ж�ѭ��������Ϊcounter<10
   LOOP
      DBMS_OUTPUT.put_line ('������ [' || counter || '].');    
      IF counter >= 1              --���ѭ�����������ڵ���1
      THEN
         counter := counter + 1;   --��ѭ����������1
      END IF;
   END LOOP;
END;
/


