/* Formatted on 2011/11/17 06:12 (Formatter Plus v4.8.8) */
DECLARE
   conn   comm_email_lib.mail_connection;   --�����ʼ����ӷ���ֵ��¼����
BEGIN
   conn :=
      comm_email_lib.xm_init (NULL,
                              '����Xģ����ʼ�',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              '���Ĳ���'
                             );              --��ʼ������                            
   comm_email_lib.xm_file(conn,'test.html');                        --��һ��HTML�ļ���Ϊ�������з���                      
   comm_email_lib.xm_data(conn,'<html><body>');                     --��ʼHTML�ʼ�����
   comm_email_lib.xm_data(conn,'<h1>�ʼ�����</h1><br>');            --д��HTML����
   comm_email_lib.xm_data(conn,'<b>������ַ</b><br>');
   comm_email_lib.xm_data(conn,'<a href="http://www.sina.com.cn/" target="_blank" class="toplink">������ҳ</a>'); 
   comm_email_lib.xm_data(conn,'</body></html>');     
   comm_email_lib.xm_close (conn);           --���͵����ʼ����ر�����    
END;



DECLARE
   conn   comm_email_lib.mail_connection;   --�����ʼ����ӷ���ֵ��¼����
BEGIN
   conn :=
      comm_email_lib.xm_init (NULL,
                              '����Xģ����ʼ�',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              '���Ĳ���'
                             );              --��ʼ������                            
   comm_email_lib.xm_file(conn,'scott_emp.xls');  --ʹ��Excel�ļ�����                      
   --ע�͵���comm_email_lib.wb_header(conn); --д��Excel������ͷ��Ϣ��xm_worksheet�����˶�wb_header�ĵ���
   --ע�͵���comm_email_lib.xm_worksheet(conn,'Ա����Ϣ');  --д�빤����
   --д�빤�����������,xm_ws_sql�Ѿ�������xm_worksheet�ĵ���
   comm_email_lib.xm_ws_sql(conn,'Ա����Ϣ','SELECT * FROM scott.emp'); 
   --ע�͵���comm_email_lib.ws_footer(conn); --д�빤�����β��xm_close�����˶Ըù��̵ĵ���
   --ע�͵���comm_email_lib.wb_footer(conn);   --д�빤����β�����ݣ�xm_close�����˶Ըù��̵ĵ���
   comm_email_lib.xm_close (conn);   --���͵����ʼ����ر�����    
END;

SELECT ROWID,a.* FROM email_list a;


INSERT INTO email_list(group_name,description,subject,mto,mcc,mbcc,
             message,msender)
      VALUES('����ģ��','���������Ϣ','����ģ��---�ʼ�֪ͨ','abc@21cn.com,ccc@163.com',
             '','','�������ݱ�������鿴����','xxx@21cn.com');      
Commit;    

DECLARE
   conn   comm_email_lib.mail_connection;   --�����ʼ����ӷ���ֵ��¼����
BEGIN
   conn :=
      comm_email_lib.xm_init ('����ģ��');         --��ʼ������                            
   comm_email_lib.xm_file(conn,'scott_emp.xls');  --ʹ��Excel�ļ�����                      
   comm_email_lib.xm_ws_sql(conn,'Ա����Ϣ','SELECT * FROM scott.emp'); 
   comm_email_lib.xm_close (conn);   --���͵����ʼ����ر�����    
END;

