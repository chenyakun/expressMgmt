/* Formatted on 2011/11/15 06:26 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE send_mail (
   as_sender     IN   VARCHAR2,                                   --�ʼ�������
   as_recp       IN   VARCHAR2,                                   --�ʼ�������
   as_subject    IN   VARCHAR2,                                     --�ʼ�����
   as_msg_body   IN   VARCHAR2
)                                                                   --�ʼ�����
IS
   ls_mailhost    VARCHAR2 (30)       := 'smtp.21cn.com';    -- �ʼ���������ַ
   lc_mail_conn   UTL_SMTP.connection;
   ls_subject     VARCHAR2 (100);
   ls_msg_body    VARCHAR2 (20000);
   ls_username    VARCHAR2 (256)      := 'username';           --�����û���
   ls_password    VARCHAR2 (256)      := '********';           --�����ʼ�����
BEGIN
   lc_mail_conn := UTL_SMTP.open_connection (ls_mailhost, 25); --���ӵ�������
   UTL_SMTP.helo (lc_mail_conn, ls_mailhost);
   UTL_SMTP.command (lc_mail_conn, 'AUTH LOGIN');              --�����ʼ���������֤
   UTL_SMTP.command (lc_mail_conn,
                     demo_base64.encode (UTL_RAW.cast_to_raw (ls_username))
                    );
   UTL_SMTP.command (lc_mail_conn,
                     demo_base64.encode (UTL_RAW.cast_to_raw (ls_password))
                    );
   ls_subject :=                                              --�ʼ�����
         'Subject: ['
      || UPPER (SYS_CONTEXT ('userenv', 'db_name'))
      || '] - '
      || as_subject;
   ls_msg_body := as_msg_body;                                --�ʼ�����
   UTL_SMTP.mail (lc_mail_conn, '<' || as_sender || '>');     --������
   UTL_SMTP.rcpt (lc_mail_conn, '<' || as_recp || '>');       --�ռ���
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
                              --����дsubject����֧�����ĵ�body���ݲ�֧������;
-- utl_smtp.write_data(lc_mail_conn, ls_msg_body); --����дsubject��֧������
   UTL_SMTP.close_data (lc_mail_conn);                        --�ر�
   UTL_SMTP.quit (lc_mail_conn);                              --�˳�����
EXCEPTION                                                     --�ʼ���������е��쳣����
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