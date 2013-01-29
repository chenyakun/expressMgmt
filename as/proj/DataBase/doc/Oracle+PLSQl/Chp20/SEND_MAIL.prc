/* Formatted on 2011/11/15 06:26 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE send_mail (
   as_sender     IN   VARCHAR2,                                   --邮件发送者
   as_recp       IN   VARCHAR2,                                   --邮件接收者
   as_subject    IN   VARCHAR2,                                     --邮件标题
   as_msg_body   IN   VARCHAR2
)                                                                   --邮件内容
IS
   ls_mailhost    VARCHAR2 (30)       := 'smtp.21cn.com';    -- 邮件服务器地址
   lc_mail_conn   UTL_SMTP.connection;
   ls_subject     VARCHAR2 (100);
   ls_msg_body    VARCHAR2 (20000);
   ls_username    VARCHAR2 (256)      := 'username';           --输入用户名
   ls_password    VARCHAR2 (256)      := '********';           --输入邮件密码
BEGIN
   lc_mail_conn := UTL_SMTP.open_connection (ls_mailhost, 25); --连接到服务器
   UTL_SMTP.helo (lc_mail_conn, ls_mailhost);
   UTL_SMTP.command (lc_mail_conn, 'AUTH LOGIN');              --进行邮件服务器验证
   UTL_SMTP.command (lc_mail_conn,
                     demo_base64.encode (UTL_RAW.cast_to_raw (ls_username))
                    );
   UTL_SMTP.command (lc_mail_conn,
                     demo_base64.encode (UTL_RAW.cast_to_raw (ls_password))
                    );
   ls_subject :=                                              --邮件主题
         'Subject: ['
      || UPPER (SYS_CONTEXT ('userenv', 'db_name'))
      || '] - '
      || as_subject;
   ls_msg_body := as_msg_body;                                --邮件内容
   UTL_SMTP.mail (lc_mail_conn, '<' || as_sender || '>');     --发件人
   UTL_SMTP.rcpt (lc_mail_conn, '<' || as_recp || '>');       --收件人
   UTL_SMTP.open_data (lc_mail_conn);
   ls_msg_body :=
         'From: '
      || as_sender
      || CHR (13)
      || CHR (10)
      || 'To: '
      || as_recp
      || CHR (13)
      || CHR (10)
      || ls_subject
      || CHR (13)
      || CHR (10)
      || CHR (13)
      || CHR (10)
      || ls_msg_body;
   UTL_SMTP.write_raw_data (lc_mail_conn, UTL_RAW.cast_to_raw (ls_msg_body));
                              --这样写subject可以支持中文但body内容不支持中文;
-- utl_smtp.write_data(lc_mail_conn, ls_msg_body); --这样写subject不支持中文
   UTL_SMTP.close_data (lc_mail_conn);                        --关闭
   UTL_SMTP.quit (lc_mail_conn);                              --退出连接
EXCEPTION                                                     --邮件传输过程中的异常处理
   WHEN UTL_SMTP.invalid_operation
   THEN
      DBMS_OUTPUT.put_line ('invalid operation');
   WHEN UTL_SMTP.transient_error
   THEN
      DBMS_OUTPUT.put_line ('transient error');
   WHEN UTL_SMTP.permanent_error
   THEN
      DBMS_OUTPUT.put_line ('permanent error');
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('others');
END send_mail;