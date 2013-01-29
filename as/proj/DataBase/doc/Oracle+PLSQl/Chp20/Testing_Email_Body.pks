/* Formatted on 2011/11/16 06:21 (Formatter Plus v4.8.8) */
DECLARE
--****************
   mailhost   CONSTANT VARCHAR2 (30)       := 'smtp.21cn.com';  --�ʼ�����
   gp_auth_username    VARCHAR (30)        := 'abc123';        --�����֤�û��� 
   gp_auth_password    VARCHAR (30)        := '******';        --�����֤����
   psender             VARCHAR2 (128)      := 'abc123@21cn.com';--�ʼ������˵�ַ
   p_subject           VARCHAR2 (100)      := 'SUBJECT';        --�ʼ���������
   p_to                VARCHAR2 (100)      := 'abc123@21cn.com';--�ʼ������˵�ַ 
   p_mess              VARCHAR2 (100)      := 'This is a mail'; --�ʼ�����
--********************
   x_clf      CONSTANT VARCHAR2 (2):= CHR (13) || CHR (10);     --�س����з�
   mail_conn           UTL_SMTP.connection;                     --�����ʼ����Ӷ���
   x_str               VARCHAR2 (30000);                        --��ʱ����
   x_rec               VARCHAR2 (1000);
   n_1                 NUMBER;
   n_2                 NUMBER;
BEGIN
   mail_conn := UTL_SMTP.open_connection (mailhost);         --������
   UTL_SMTP.helo (mail_conn, mailhost);                      --ָ���ʼ�������
   UTL_SMTP.command (mail_conn, 'AUTH LOGIN');               --�����ʼ������������֤
   UTL_SMTP.command
                   (mail_conn,
                    demo_base64.encode (UTL_RAW.cast_to_raw (gp_auth_username))
                   );                                        --�ʼ���������֤�û���
   UTL_SMTP.command (mail_conn,
                     demo_base64.encode (UTL_RAW.cast_to_raw (gp_auth_password)
                                        )
                    );                                       --�ʼ���������֤����
   UTL_SMTP.mail (mail_conn, psender);                       --ָ���ʼ�������
   IF p_to IS NOT NULL
   THEN
      x_str := RTRIM (REPLACE (p_to, ',', ';'), ';') || ';'; --ʹ��ѭ���ķ�ʽ�ֽ����ռ��˵�ַ
      n_1 := 1;

      LOOP
         n_2 := INSTR (x_str, ';', n_1);                     --ѭ����ȡ��ǰ�ֺŵ�ַ  
         EXIT WHEN n_2 = 0;
         x_rec := SUBSTR (x_str, n_1, n_2 - n_1);            --��ȡ�ʼ���ַ
         UTL_SMTP.rcpt (mail_conn, x_rec);                   --�����ʵ�ַ�������ռ���
         n_1 := n_2 + 1;
      END LOOP;
      UTL_SMTP.open_data (mail_conn);                         --��ʼ�����ʼ�����
      UTL_SMTP.write_data (mail_conn, 'From: ' || psender || x_clf); --ָ�����ͷ�
      UTL_SMTP.write_data (mail_conn, 'To: ' || RTRIM (p_to, ';') || x_clf);--ָ�����շ�
      UTL_SMTP.write_raw_data (mail_conn,
                               UTL_RAW.cast_to_raw (   'Subject: '
                                                    || p_subject
                                                    || x_clf
                                                   )
                              );                               --ָ���ʼ�����
      UTL_SMTP.write_data (mail_conn, 'Mime-Version: 1.0' || x_clf);  --ָ��MIME�İ汾
      UTL_SMTP.write_data
         (mail_conn,
             'Content-Type: multipart/mixed; boundary="DMW.Boundary.605592468"'
          || x_clf
         );     --���Ͷಿ�����ݵ��ʼ���ָ���ָ��ķ��ţ�����Ĵ��뽫��ʼ��1���ָ�
      UTL_SMTP.write_data (mail_conn, '--DMW.Boundary.605592468' || x_clf);
      UTL_SMTP.write_data (mail_conn,
                           'Content-Type: text/plain;  charset=utf-8' || x_clf
                          );                              --���ʹ��ı��ʼ�   
                --ָ��MIME���ݱ����ߴ򿪣������ᵯ��һ�����Ϊ�ĶԻ���                  
      UTL_SMTP.write_data (mail_conn, 'Content-Disposition: inline;' || x_clf);
      UTL_SMTP.write_data (mail_conn,
                           'Content-Transfer-Encoding: 8bit' || x_clf
                          );                            --ָ����������ʽ
      UTL_SMTP.write_data (mail_conn, x_clf);           --д��س�����
      UTL_SMTP.write_raw_data (mail_conn,
                               UTL_RAW.cast_to_raw (p_mess || x_clf)
                              );                        --д���ʼ�����
      UTL_SMTP.write_data (mail_conn, '--DMW.Boundary.605592468--');--д����ֹ�ָ���
      UTL_SMTP.close_data (mail_conn);                  --���Ͳ��ر��ʼ�
      UTL_SMTP.quit (mail_conn);                        --�˳��������������
   END IF;
END;