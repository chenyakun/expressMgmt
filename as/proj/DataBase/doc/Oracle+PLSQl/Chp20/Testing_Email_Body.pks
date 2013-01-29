/* Formatted on 2011/11/16 06:21 (Formatter Plus v4.8.8) */
DECLARE
--****************
   mailhost   CONSTANT VARCHAR2 (30)       := 'smtp.21cn.com';  --邮件主机
   gp_auth_username    VARCHAR (30)        := 'abc123';        --身份验证用户名 
   gp_auth_password    VARCHAR (30)        := '******';        --身份验证密码
   psender             VARCHAR2 (128)      := 'abc123@21cn.com';--邮件发送人地址
   p_subject           VARCHAR2 (100)      := 'SUBJECT';        --邮件主题内容
   p_to                VARCHAR2 (100)      := 'abc123@21cn.com';--邮件接收人地址 
   p_mess              VARCHAR2 (100)      := 'This is a mail'; --邮件主体
--********************
   x_clf      CONSTANT VARCHAR2 (2):= CHR (13) || CHR (10);     --回车换行符
   mail_conn           UTL_SMTP.connection;                     --发送邮件连接对象
   x_str               VARCHAR2 (30000);                        --临时变量
   x_rec               VARCHAR2 (1000);
   n_1                 NUMBER;
   n_2                 NUMBER;
BEGIN
   mail_conn := UTL_SMTP.open_connection (mailhost);         --打开连接
   UTL_SMTP.helo (mail_conn, mailhost);                      --指定邮件发送域
   UTL_SMTP.command (mail_conn, 'AUTH LOGIN');               --进行邮件服务器身份验证
   UTL_SMTP.command
                   (mail_conn,
                    demo_base64.encode (UTL_RAW.cast_to_raw (gp_auth_username))
                   );                                        --邮件服务器验证用户名
   UTL_SMTP.command (mail_conn,
                     demo_base64.encode (UTL_RAW.cast_to_raw (gp_auth_password)
                                        )
                    );                                       --邮件服务器验证密码
   UTL_SMTP.mail (mail_conn, psender);                       --指定邮件发送人
   IF p_to IS NOT NULL
   THEN
      x_str := RTRIM (REPLACE (p_to, ',', ';'), ';') || ';'; --使用循环的方式分解多个收件人地址
      n_1 := 1;

      LOOP
         n_2 := INSTR (x_str, ';', n_1);                     --循环获取当前分号地址  
         EXIT WHEN n_2 = 0;
         x_rec := SUBSTR (x_str, n_1, n_2 - n_1);            --提取邮件地址
         UTL_SMTP.rcpt (mail_conn, x_rec);                   --将电邮地址作赋给收件人
         n_1 := n_2 + 1;
      END LOOP;
      UTL_SMTP.open_data (mail_conn);                         --开始发送邮件数据
      UTL_SMTP.write_data (mail_conn, 'From: ' || psender || x_clf); --指定发送方
      UTL_SMTP.write_data (mail_conn, 'To: ' || RTRIM (p_to, ';') || x_clf);--指定接收方
      UTL_SMTP.write_raw_data (mail_conn,
                               UTL_RAW.cast_to_raw (   'Subject: '
                                                    || p_subject
                                                    || x_clf
                                                   )
                              );                               --指定邮件主题
      UTL_SMTP.write_data (mail_conn, 'Mime-Version: 1.0' || x_clf);  --指定MIME的版本
      UTL_SMTP.write_data
         (mail_conn,
             'Content-Type: multipart/mixed; boundary="DMW.Boundary.605592468"'
          || x_clf
         );     --发送多部分内容的邮件，指定分隔的符号，下面的代码将开始第1个分隔
      UTL_SMTP.write_data (mail_conn, '--DMW.Boundary.605592468' || x_clf);
      UTL_SMTP.write_data (mail_conn,
                           'Content-Type: text/plain;  charset=utf-8' || x_clf
                          );                              --发送纯文本邮件   
                --指定MIME内容被在线打开，而不会弹出一个另存为的对话框                  
      UTL_SMTP.write_data (mail_conn, 'Content-Disposition: inline;' || x_clf);
      UTL_SMTP.write_data (mail_conn,
                           'Content-Transfer-Encoding: 8bit' || x_clf
                          );                            --指定传输编码格式
      UTL_SMTP.write_data (mail_conn, x_clf);           --写入回车内容
      UTL_SMTP.write_raw_data (mail_conn,
                               UTL_RAW.cast_to_raw (p_mess || x_clf)
                              );                        --写入邮件正文
      UTL_SMTP.write_data (mail_conn, '--DMW.Boundary.605592468--');--写入终止分隔符
      UTL_SMTP.close_data (mail_conn);                  --发送并关闭邮件
      UTL_SMTP.quit (mail_conn);                        --退出与服务器的连接
   END IF;
END;