--PLS_INTEGERʹ��ʾ��
DECLARE
   v_num1 PLS_INTEGER:=2147483647;   
BEGIN
   --��Ϊv_num1+1ʱ��������������ᴥ���쳣
   v_num1:=v_num1+1-1;
   EXCEPTION
     WHEN OTHERS THEN
       --�����ORA-01426: �������
       DBMS_OUTPUT.put_line(SQLERRM);
END;  
--BINARY_INTEGERʹ��ʾ�� 
DECLARE
   v_num1 BINARY_INTEGER:=2147483647;
BEGIN   
   /*��Ϊv_num1+1ʱ�������������
     ��ʱv_num1�ᱻ����NUMBER���д������ᴥ���쳣
   */
   v_num1:=v_num1+1-1;
END;  
 
 
DECLARE
   v_num1 NUMBER:=-2147483647;
BEGIN
   v_num1:=v_num1-1;
   DBMS_OUTPUT.put_line(v_num1);
   EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.put_line(SQLERRM); 
 END;  