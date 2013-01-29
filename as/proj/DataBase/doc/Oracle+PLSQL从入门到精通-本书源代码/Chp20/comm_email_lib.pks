CREATE OR REPLACE PACKAGE comm_email_lib
IS
   -- 作者    : ADMIN
   -- 创建日期 :
   -- 功能 :  公共的邮件发送程序
   -- 公共类型定义
   gp_encoding     VARCHAR2 (32)  := 'gb2312';    --邮件内容编码格式
   gp_skip_lines   NUMBER         := 1;        

   TYPE mail_connection IS RECORD (              --邮件连接记录，当同时处理多个邮件时，使用ID标识不同的连接
      ID           NUMBER,
      connection   UTL_SMTP.connection
   );
   --邮件服务器和邮件服务器身份验证的信息，以及当前处理的邮件的id号
   gp_mail_host    VARCHAR2 (100):= 'smtp.21cn.com';
   gp_auth_username VARCHAR2(100):='abc';
   gp_auth_password VARCHAR2(100):='******';
   gp_mail_id      NUMBER         := 1;
   FUNCTION htm_str (p_str IN VARCHAR2)
      RETURN VARCHAR2;                               --编码字符串为HTML格式的字符串
   PROCEDURE wb_header (p_conn IN mail_connection);  --Excel工作表头部内容写入
   PROCEDURE wb_footer (p_conn IN mail_connection);  --Excel工作表尾部内容写入
   PROCEDURE ws_footer (p_conn IN mail_connection);  --Excel工作薄尾部内容写入
   FUNCTION get_db_inf (p_type VARCHAR2)             --从v$instance视图中获取当前执行的服务器信息
      RETURN VARCHAR2;
   FUNCTION SPLIT (p_str VARCHAR2, p_bs VARCHAR2, p_n NUMBER)  ----获取以p_bs指定符号分隔的第p_n个位置的字符串
      RETURN VARCHAR2;
   FUNCTION split_cnt (p_str VARCHAR2, p_bs VARCHAR2)  --获取在p_str中p_bs指定的符号分隔的个数
      RETURN NUMBER;
   FUNCTION get_var (p_str VARCHAR2, p_n NUMBER)      --获取p_str中从第1个到p_n个的字母的个数
      RETURN VARCHAR2; 
   FUNCTION link_str (                                --字符串连接函数，将参数中传入的字符串进行合并。
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
   PROCEDURE xm_ws_row (                                   --Excel工作表行函数，将传入的参数写入Excel的一行中。
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
   PROCEDURE xm_ws_sql (                                  --将SQL语句的执行结果写入到Excel表格行
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
   FUNCTION check_type (p_value VARCHAR2)            --检查数字或字符串类型
      RETURN VARCHAR2;
     --将传入的收件人信息进行分割后，赋给UTL_SMTP的收件人列表中
   PROCEDURE x_send (p_cnn IN OUT UTL_SMTP.connection, p_mail IN VARCHAR2);
     --写入邮件消息文本内容
   PROCEDURE xm_data (p_conn IN mail_connection, p_mess IN VARCHAR2);
    --写入邮件消息工作薄内容
   PROCEDURE xm_worksheet (
      p_conn      IN   mail_connection,
      p_ws_name   IN   VARCHAR2 DEFAULT NULL
   );
    --添加邮件附件
   PROCEDURE xm_file (p_conn IN mail_connection, p_filename VARCHAR2);
   --添加HTML格式的内容
   PROCEDURE xm_html (p_conn IN mail_connection, p_html VARCHAR2);
   --初始化UTL_SMTP包中的连接对象以便准备发送邮件
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
   PROCEDURE xm_close (p_conn IN mail_connection);    --发送邮件关并闭邮件服务器连接
END comm_email_lib;
/
