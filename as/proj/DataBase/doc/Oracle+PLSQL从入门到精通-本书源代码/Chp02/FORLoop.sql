--�����Ļ��Ϣ
SET SERVEROUTPUT ON;
--��ӡ�žų˷��ھ���
DECLARE
  v_Number1 NUMBER(3);  --���ѭ������
  v_Number2 NUMBER(3);  --�ڴ�ѭ������
BEGIN  
  FOR v_Number1 IN 1..9 --��ʼ���ѭ��
  LOOP
    --�����ڴ�ѭ��
    FOR v_Number2 IN 1..v_Number1
    LOOP
      --��ӡ�ھ�����
      DBMS_OUTPUT.PUT(v_Number1||'*'||v_Number2||'='||v_Number1*v_Number2||'   ');
    END LOOP; 
    --�������  
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
END;
/