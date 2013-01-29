/* Formatted on 2011/11/17 06:12 (Formatter Plus v4.8.8) */
DECLARE
   conn   comm_email_lib.mail_connection;   --定义邮件连接返回值记录变量
BEGIN
   conn :=
      comm_email_lib.xm_init (NULL,
                              '来自X模块的邮件',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              '中文测试'
                             );              --初始化连接                            
   comm_email_lib.xm_file(conn,'test.html');                        --将一个HTML文件作为附件进行发送                      
   comm_email_lib.xm_data(conn,'<html><body>');                     --开始HTML邮件发送
   comm_email_lib.xm_data(conn,'<h1>邮件标题</h1><br>');            --写入HTML代码
   comm_email_lib.xm_data(conn,'<b>新浪网址</b><br>');
   comm_email_lib.xm_data(conn,'<a href="http://www.sina.com.cn/" target="_blank" class="toplink">新浪首页</a>'); 
   comm_email_lib.xm_data(conn,'</body></html>');     
   comm_email_lib.xm_close (conn);           --发送电子邮件并关闭连接    
END;



DECLARE
   conn   comm_email_lib.mail_connection;   --定义邮件连接返回值记录变量
BEGIN
   conn :=
      comm_email_lib.xm_init (NULL,
                              '来自X模块的邮件',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              'Cat_379@21cn.com',
                              '中文测试'
                             );              --初始化连接                            
   comm_email_lib.xm_file(conn,'scott_emp.xls');  --使用Excel文件附件                      
   --注释掉：comm_email_lib.wb_header(conn); --写入Excel工作薄头信息，xm_worksheet包含了对wb_header的调用
   --注释掉：comm_email_lib.xm_worksheet(conn,'员工信息');  --写入工作表
   --写入工作表表行内容,xm_ws_sql已经包含了xm_worksheet的调用
   comm_email_lib.xm_ws_sql(conn,'员工信息','SELECT * FROM scott.emp'); 
   --注释掉：comm_email_lib.ws_footer(conn); --写入工作表表尾，xm_close包含了对该过程的调用
   --注释掉：comm_email_lib.wb_footer(conn);   --写入工作薄尾部数据，xm_close包含了对该过程的调用
   comm_email_lib.xm_close (conn);   --发送电子邮件并关闭连接    
END;

SELECT ROWID,a.* FROM email_list a;


INSERT INTO email_list(group_name,description,subject,mto,mcc,mbcc,
             message,msender)
      VALUES('人事模块','人事相关信息','人事模块---邮件通知','abc@21cn.com,ccc@163.com',
             '','','人事数据变量，请查看附件','xxx@21cn.com');      
Commit;    

DECLARE
   conn   comm_email_lib.mail_connection;   --定义邮件连接返回值记录变量
BEGIN
   conn :=
      comm_email_lib.xm_init ('人事模块');         --初始化连接                            
   comm_email_lib.xm_file(conn,'scott_emp.xls');  --使用Excel文件附件                      
   comm_email_lib.xm_ws_sql(conn,'员工信息','SELECT * FROM scott.emp'); 
   comm_email_lib.xm_close (conn);   --发送电子邮件并关闭连接    
END;

