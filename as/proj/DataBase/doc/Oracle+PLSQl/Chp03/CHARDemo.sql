DECLARE
   v_name CHAR(2 BYTE);
   v_name2 CHAR(2 CHAR);
   v_name3 CHAR;
   v_name4 CHAR(20);
BEGIN
  v_name:='ab';       --��ȷ��2���ֽڵ��ַ���
  v_name:='�й�';   --���󣬴���2���ֽ� 
  v_name2:='�й�';    --��ȷ��2���ַ�
  v_name3:=1;         --��ȷ�������ֽ�
  v_name4:='This is string';  --ΪCHAR���ַ���ֵ
  DBMS_OUTPUT.put_line(LENGTH(v_name4));--����ַ�������
END;



DECLARE
  v_name VARCHAR2(25);
  v_name1 VARCHAR2(25 BYTE);
  v_name2 VARCHAR2(25 CHAR);   
  --v_name3 VARCHAR2;          --���󣬱���ҪΪVARCHAR2ָ������ֵ
BEGIN
  v_name:='�л����񹲺͹�';    --Ϊ������ֵ������������ĳ���
  DBMS_OUTPUT.put_line('v_name�����ĳ���Ϊ��'||LENGTH(v_name)||'�ֽ�');
  v_name1:='�л����񹲺͹�';
  DBMS_OUTPUT.put_line('v_name1�����ĳ���Ϊ��'||LENGTH(v_name1)||'�ֽ�');  
  v_name2:='�л����񹲺͹�';
  DBMS_OUTPUT.put_line('v_name1�����ĳ���Ϊ��'||LENGTH(v_name2)||'�ֽ�');    
END;     