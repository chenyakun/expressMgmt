/*
 �ӳ�������OutPutString
 ����    ������ַ�������Ļ
 ����    ��StrVar--��������Ҫ������ַ����ı���
 ������  ��xxx
 �������ڣ�2011-x-0x
 �޶���ʷ�� 
*/
CREATE OR REPLACE PROCEDURE OutPutString(StrVar VARCHAR(50)
AS    
BEGIN
  DBMS_OUTPUT.PUT_LINE(StrVar);           --���������ֵ
END;
/