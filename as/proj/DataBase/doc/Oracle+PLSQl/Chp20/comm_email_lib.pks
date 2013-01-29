CREATE OR REPLACE PACKAGE comm_email_lib
IS
   -- ����    : ADMIN
   -- �������� :
   -- ���� :  �������ʼ����ͳ���
   -- �������Ͷ���
   gp_encoding     VARCHAR2 (32)  := 'gb2312';    --�ʼ����ݱ����ʽ
   gp_skip_lines   NUMBER         := 1;        

   TYPE mail_connection IS RECORD (              --�ʼ����Ӽ�¼����ͬʱ�������ʼ�ʱ��ʹ��ID��ʶ��ͬ������
      ID           NUMBER,
      connection   UTL_SMTP.connection
   );
   --�ʼ����������ʼ������������֤����Ϣ���Լ���ǰ������ʼ���id��
   gp_mail_host    VARCHAR2 (100):= 'smtp.21cn.com';
   gp_auth_username VARCHAR2(100):='abc';
   gp_auth_password VARCHAR2(100):='******';
   gp_mail_id      NUMBER         := 1;
   FUNCTION htm_str (p_str IN VARCHAR2)
      RETURN VARCHAR2;                               --�����ַ���ΪHTML��ʽ���ַ���
   PROCEDURE wb_header (p_conn IN mail_connection);  --Excel������ͷ������д��
   PROCEDURE wb_footer (p_conn IN mail_connection);  --Excel������β������д��
   PROCEDURE ws_footer (p_conn IN mail_connection);  --Excel������β������д��
   FUNCTION get_db_inf (p_type VARCHAR2)             --��v$instance��ͼ�л�ȡ��ǰִ�еķ�������Ϣ
      RETURN VARCHAR2;
   FUNCTION SPLIT (p_str VARCHAR2, p_bs VARCHAR2, p_n NUMBER)  ----��ȡ��p_bsָ�����ŷָ��ĵ�p_n��λ�õ��ַ���
      RETURN VARCHAR2;
   FUNCTION split_cnt (p_str VARCHAR2, p_bs VARCHAR2)  --��ȡ��p_str��p_bsָ���ķ��ŷָ��ĸ���
      RETURN NUMBER;
   FUNCTION get_var (p_str VARCHAR2, p_n NUMBER)      --��ȡp_str�дӵ�1����p_n������ĸ�ĸ���
      RETURN VARCHAR2; 
   FUNCTION link_str (                                --�ַ������Ӻ������������д�����ַ������кϲ���
      p_tab     VARCHAR2 DEFAULT CHR (9),
      p_end     VARCHAR2 DEFAULT '',
      p_str1    VARCHAR2 DEFAULT '',
      p_str2    VARCHAR2 DEFAULT '',
      p_str3    VARCHAR2 DEFAULT '',
      p_str4    VARCHAR2 DEFAULT '',
      p_str5    VARCHAR2 DEFAULT '',
      p_str6    VARCHAR2 DEFAULT '',
      p_str7    VARCHAR2 DEFAULT '',
      p_str8    VARCHAR2 DEFAULT '',
      p_str9    VARCHAR2 DEFAULT '',
      p_str10   VARCHAR2 DEFAULT '',
      p_str11   VARCHAR2 DEFAULT '',
      p_str12   VARCHAR2 DEFAULT '',
      p_str13   VARCHAR2 DEFAULT '',
      p_str14   VARCHAR2 DEFAULT '',
      p_str15   VARCHAR2 DEFAULT '',
      p_str16   VARCHAR2 DEFAULT '',
      p_str17   VARCHAR2 DEFAULT '',
      p_str18   VARCHAR2 DEFAULT '',
      p_str19   VARCHAR2 DEFAULT '',
      p_str20   VARCHAR2 DEFAULT '',
      p_str21   VARCHAR2 DEFAULT '',
      p_str22   VARCHAR2 DEFAULT '',
      p_str23   VARCHAR2 DEFAULT '',
      p_str24   VARCHAR2 DEFAULT '',
      p_str25   VARCHAR2 DEFAULT '',
      p_str26   VARCHAR2 DEFAULT '',
      p_str27   VARCHAR2 DEFAULT '',
      p_str28   VARCHAR2 DEFAULT '',
      p_str29   VARCHAR2 DEFAULT '',
      p_str30   VARCHAR2 DEFAULT '',
      p_str31   VARCHAR2 DEFAULT '',
      p_str32   VARCHAR2 DEFAULT '',
      p_str33   VARCHAR2 DEFAULT '',
      p_str34   VARCHAR2 DEFAULT '',
      p_str35   VARCHAR2 DEFAULT '',
      p_str36   VARCHAR2 DEFAULT '',
      p_str37   VARCHAR2 DEFAULT '',
      p_str38   VARCHAR2 DEFAULT '',
      p_str39   VARCHAR2 DEFAULT '',
      p_str40   VARCHAR2 DEFAULT '',
      p_str41   VARCHAR2 DEFAULT '',
      p_str42   VARCHAR2 DEFAULT '',
      p_str43   VARCHAR2 DEFAULT '',
      p_str44   VARCHAR2 DEFAULT '',
      p_str45   VARCHAR2 DEFAULT '',
      p_str46   VARCHAR2 DEFAULT '',
      p_str47   VARCHAR2 DEFAULT '',
      p_str48   VARCHAR2 DEFAULT '',
      p_str49   VARCHAR2 DEFAULT '',
      p_str50   VARCHAR2 DEFAULT '',
      p_str51   VARCHAR2 DEFAULT '',
      p_str52   VARCHAR2 DEFAULT '',
      p_str53   VARCHAR2 DEFAULT '',
      p_str54   VARCHAR2 DEFAULT '',
      p_str55   VARCHAR2 DEFAULT '',
      p_str56   VARCHAR2 DEFAULT '',
      p_str57   VARCHAR2 DEFAULT '',
      p_str58   VARCHAR2 DEFAULT '',
      p_str59   VARCHAR2 DEFAULT ''
   )
      RETURN VARCHAR2;
   PROCEDURE xm_ws_row (                                   --Excel�������к�����������Ĳ���д��Excel��һ���С�
      p_conn    IN   mail_connection,
      p_str1         VARCHAR2 DEFAULT '',
      p_str2         VARCHAR2 DEFAULT '',
      p_str3         VARCHAR2 DEFAULT '',
      p_str4         VARCHAR2 DEFAULT '',
      p_str5         VARCHAR2 DEFAULT '',
      p_str6         VARCHAR2 DEFAULT '',
      p_str7         VARCHAR2 DEFAULT '',
      p_str8         VARCHAR2 DEFAULT '',
      p_str9         VARCHAR2 DEFAULT '',
      p_str10        VARCHAR2 DEFAULT '',
      p_str11        VARCHAR2 DEFAULT '',
      p_str12        VARCHAR2 DEFAULT '',
      p_str13        VARCHAR2 DEFAULT '',
      p_str14        VARCHAR2 DEFAULT '',
      p_str15        VARCHAR2 DEFAULT '',
      p_str16        VARCHAR2 DEFAULT '',
      p_str17        VARCHAR2 DEFAULT '',
      p_str18        VARCHAR2 DEFAULT '',
      p_str19        VARCHAR2 DEFAULT '',
      p_str20        VARCHAR2 DEFAULT '',
      p_str21        VARCHAR2 DEFAULT '',
      p_str22        VARCHAR2 DEFAULT '',
      p_str23        VARCHAR2 DEFAULT '',
      p_str24        VARCHAR2 DEFAULT '',
      p_str25        VARCHAR2 DEFAULT '',
      p_str26        VARCHAR2 DEFAULT '',
      p_str27        VARCHAR2 DEFAULT '',
      p_str28        VARCHAR2 DEFAULT '',
      p_str29        VARCHAR2 DEFAULT '',
      p_str30        VARCHAR2 DEFAULT '',
      p_str31        VARCHAR2 DEFAULT '',
      p_str32        VARCHAR2 DEFAULT '',
      p_str33        VARCHAR2 DEFAULT '',
      p_str34        VARCHAR2 DEFAULT '',
      p_str35        VARCHAR2 DEFAULT '',
      p_str36        VARCHAR2 DEFAULT '',
      p_str37        VARCHAR2 DEFAULT '',
      p_str38        VARCHAR2 DEFAULT '',
      p_str39        VARCHAR2 DEFAULT '',
      p_str40        VARCHAR2 DEFAULT '',
      p_str41        VARCHAR2 DEFAULT '',
      p_str42        VARCHAR2 DEFAULT '',
      p_str43        VARCHAR2 DEFAULT '',
      p_str44        VARCHAR2 DEFAULT '',
      p_str45        VARCHAR2 DEFAULT '',
      p_str46        VARCHAR2 DEFAULT '',
      p_str47        VARCHAR2 DEFAULT '',
      p_str48        VARCHAR2 DEFAULT '',
      p_str49        VARCHAR2 DEFAULT '',
      p_str50        VARCHAR2 DEFAULT '',
      p_str51        VARCHAR2 DEFAULT '',
      p_str52        VARCHAR2 DEFAULT '',
      p_str53        VARCHAR2 DEFAULT '',
      p_str54        VARCHAR2 DEFAULT '',
      p_str55        VARCHAR2 DEFAULT '',
      p_str56        VARCHAR2 DEFAULT '',
      p_str57        VARCHAR2 DEFAULT '',
      p_str58        VARCHAR2 DEFAULT '',
      p_str59        VARCHAR2 DEFAULT '',
      p_str60        VARCHAR2 DEFAULT '',
      p_str61        VARCHAR2 DEFAULT '',
      p_str62        VARCHAR2 DEFAULT '',
      p_str63        VARCHAR2 DEFAULT '',
      p_str64        VARCHAR2 DEFAULT '',
      p_str65        VARCHAR2 DEFAULT '',
      p_str66        VARCHAR2 DEFAULT '',
      p_str67        VARCHAR2 DEFAULT '',
      p_str68        VARCHAR2 DEFAULT '',
      p_str69        VARCHAR2 DEFAULT '',
      p_str70        VARCHAR2 DEFAULT '',
      p_str71        VARCHAR2 DEFAULT '',
      p_str72        VARCHAR2 DEFAULT '',
      p_str73        VARCHAR2 DEFAULT '',
      p_str74        VARCHAR2 DEFAULT '',
      p_str75        VARCHAR2 DEFAULT '',
      p_str76        VARCHAR2 DEFAULT '',
      p_str77        VARCHAR2 DEFAULT '',
      p_str78        VARCHAR2 DEFAULT '',
      p_str79        VARCHAR2 DEFAULT '',
      p_str80        VARCHAR2 DEFAULT '',
      p_str81        VARCHAR2 DEFAULT '',
      p_str82        VARCHAR2 DEFAULT '',
      p_str83        VARCHAR2 DEFAULT '',
      p_str84        VARCHAR2 DEFAULT '',
      p_str85        VARCHAR2 DEFAULT '',
      p_str86        VARCHAR2 DEFAULT '',
      p_str87        VARCHAR2 DEFAULT '',
      p_str88        VARCHAR2 DEFAULT '',
      p_str89        VARCHAR2 DEFAULT '',
      p_str90        VARCHAR2 DEFAULT '',
      p_str91        VARCHAR2 DEFAULT '',
      p_str92        VARCHAR2 DEFAULT '',
      p_str93        VARCHAR2 DEFAULT '',
      p_str94        VARCHAR2 DEFAULT '',
      p_str95        VARCHAR2 DEFAULT '',
      p_str96        VARCHAR2 DEFAULT '',
      p_str97        VARCHAR2 DEFAULT '',
      p_str98        VARCHAR2 DEFAULT '',
      p_str99        VARCHAR2 DEFAULT ''
   );
   PROCEDURE xm_ws_sql (                                  --��SQL����ִ�н��д�뵽Excel�����
      p_conn      IN   mail_connection,
      p_ws_name   IN   VARCHAR2,
      p_sql       IN   VARCHAR2,
      p_1              VARCHAR2 DEFAULT '',
      p_2              VARCHAR2 DEFAULT '',
      p_3              VARCHAR2 DEFAULT '',
      p_4              VARCHAR2 DEFAULT '',
      p_5              VARCHAR2 DEFAULT '',
      p_6              VARCHAR2 DEFAULT '',
      p_7              VARCHAR2 DEFAULT '',
      p_8              VARCHAR2 DEFAULT '',
      p_9              VARCHAR2 DEFAULT '',
      p_10             VARCHAR2 DEFAULT '',
      p_11             VARCHAR2 DEFAULT '',
      p_12             VARCHAR2 DEFAULT '',
      p_13             VARCHAR2 DEFAULT '',
      p_14             VARCHAR2 DEFAULT '',
      p_15             VARCHAR2 DEFAULT ''
   );
   FUNCTION check_type (p_value VARCHAR2)            --������ֻ��ַ�������
      RETURN VARCHAR2;
     --��������ռ�����Ϣ���зָ�󣬸���UTL_SMTP���ռ����б���
   PROCEDURE x_send (p_cnn IN OUT UTL_SMTP.connection, p_mail IN VARCHAR2);
     --д���ʼ���Ϣ�ı�����
   PROCEDURE xm_data (p_conn IN mail_connection, p_mess IN VARCHAR2);
    --д���ʼ���Ϣ����������
   PROCEDURE xm_worksheet (
      p_conn      IN   mail_connection,
      p_ws_name   IN   VARCHAR2 DEFAULT NULL
   );
    --����ʼ�����
   PROCEDURE xm_file (p_conn IN mail_connection, p_filename VARCHAR2);
   --���HTML��ʽ������
   PROCEDURE xm_html (p_conn IN mail_connection, p_html VARCHAR2);
   --��ʼ��UTL_SMTP���е����Ӷ����Ա�׼�������ʼ�
   FUNCTION xm_init (
      p_grp_name   IN   VARCHAR2,
      p_subject    IN   VARCHAR2 DEFAULT '',
      p_sender     IN   VARCHAR2 DEFAULT '',
      p_mailto     IN   VARCHAR2 DEFAULT '',
      p_mailcc     IN   VARCHAR2 DEFAULT '',
      p_mailbcc    IN   VARCHAR2 DEFAULT '',
      p_mailbody   IN   VARCHAR2 DEFAULT ''
   )
      RETURN mail_connection;    
   PROCEDURE xm_close (p_conn IN mail_connection);    --�����ʼ��ز����ʼ�����������
END comm_email_lib;
/
