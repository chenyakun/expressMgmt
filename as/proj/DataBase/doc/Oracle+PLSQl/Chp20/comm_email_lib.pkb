/* Formatted on 2011/11/16 06:05 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PACKAGE BODY comm_email_lib
IS
   TYPE ta_value IS TABLE OF VARCHAR2 (2000)
      INDEX BY BINARY_INTEGER;

   xa_value          ta_value;
   x_seq             NUMBER       := 0;
   x_tab             VARCHAR2 (1) := CHR (9);
   x_clf             VARCHAR2 (2) := CHR (13) || CHR (10);
   x_enter           VARCHAR2 (1) := CHR (13);
   x_worksheet_cnt   NUMBER       := 0;

   FUNCTION htm_str (p_str IN VARCHAR2)
      RETURN VARCHAR2
   IS
      --key#20090316
      x_str   VARCHAR2 (32000);
      x_and   VARCHAR2 (1)     := CHR (38);
   BEGIN
      x_str :=
         REPLACE (REPLACE (REPLACE (REPLACE (p_str, x_and, x_and || 'amp;'),
                                    '<',
                                    x_and || 'lt;'
                                   ),
                           '>',
                           x_and || 'gt;'
                          ),
                  '"',
                  x_and || 'quot;'
                 );
      RETURN x_str;
   END htm_str;

   FUNCTION get_db_inf (p_type VARCHAR2)
      RETURN VARCHAR2
   IS
      x_var    VARCHAR2 (2000);
      x_type   VARCHAR2 (2000) := UPPER (p_type);

      CURSOR get_inf
      IS
         SELECT CASE x_type
                   WHEN 'NAME'
                      THEN instance_name
                   WHEN 'HOST'
                      THEN host_name
                   WHEN 'NAMEHOST'
                      THEN instance_name || '@' || host_name
                   WHEN 'VERSION'
                      THEN VERSION
                END
           FROM v$instance;
   BEGIN
      OPEN get_inf;

      FETCH get_inf
       INTO x_var;

      RETURN x_var;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN NULL;
   END get_db_inf;

   PROCEDURE wb_header (p_conn IN mail_connection)
   IS
   BEGIN
      IF xa_value IS NOT NULL       
      THEN
         xa_value.DELETE;             --先清空索引表
      END IF;
      x_seq := 1;                     --初始化索引表的索引序列号
      xa_value (x_seq) :=
                      '<?xml version="1.0" encoding="' || gp_encoding || '"?>';
      x_seq := x_seq + 1;             --依序写入工作薄表头信息
      xa_value (x_seq) := '<?mso-application progid="Excel.Sheet"?>';
      x_seq := x_seq + 1;
      xa_value (x_seq) :=
              '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"';
      x_seq := x_seq + 1;
      xa_value (x_seq) := 'xmlns:o="urn:schemas-microsoft-com:office:office"';
      x_seq := x_seq + 1;
      xa_value (x_seq) := 'xmlns:x="urn:schemas-microsoft-com:office:excel"';
      x_seq := x_seq + 1;
      xa_value (x_seq) :=
                     'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"';
      x_seq := x_seq + 1;
      xa_value (x_seq) := 'xmlns:html="http://www.w3.org/TR/REC-html40">';
      x_seq := x_seq + 1;
      xa_value (x_seq) :=
         '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<Version>12.00</Version>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '</DocumentProperties>';
      x_seq := x_seq + 1;
      xa_value (x_seq) :=
              '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<ProtectStructure>False</ProtectStructure>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<ProtectWindows>False</ProtectWindows>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '</ExcelWorkbook>';
      x_seq := x_seq + 1;
      FOR xi IN 1 .. xa_value.LAST
      LOOP
         xm_data (p_conn, xa_value (xi));           --使用xm_data将索引表中的内容写入到附件的流中
      END LOOP;
   END wb_header;

   PROCEDURE wb_footer (p_conn IN mail_connection)
   IS
   BEGIN
      IF xa_value IS NOT NULL
      THEN
         xa_value.DELETE;
      END IF;

      x_seq := 1;
      xa_value (x_seq) := '</Workbook>';

      FOR xi IN 1 .. xa_value.LAST
      LOOP
         xm_data (p_conn, xa_value (xi));
      END LOOP;
   END wb_footer;

   PROCEDURE ws_footer (p_conn IN mail_connection)
   IS
   BEGIN
      IF xa_value IS NOT NULL
      THEN
         xa_value.DELETE;               --清除索引表内容
      END IF;
      x_seq := 1;                       --初始化索引序列号
      xa_value (x_seq) := '</Table>';   --写入表结束标签
      x_seq := x_seq + 1;
      xa_value (x_seq) :=               --进行工作表选项设置
           '<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<PageSetup>'; --页面设置
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<Header x:Margin="0.3"/>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<Footer x:Margin="0.3"/>';
      x_seq := x_seq + 1;
      xa_value (x_seq) :=
         '<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '</PageSetup>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<Selected/>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<FreezePanes/>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<FrozenNoSplit/>';
      x_seq := x_seq + 1;
      xa_value (x_seq) :=                 --水平分割设置
                  '<SplitHorizontal>' || gp_skip_lines || '</SplitHorizontal>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<TopRowBottomPane>1</TopRowBottomPane>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<ActivePane>2</ActivePane>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<ProtectObjects>False</ProtectObjects>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '<ProtectScenarios>False</ProtectScenarios>';
      x_seq := x_seq + 1;
      xa_value (x_seq) := '</WorksheetOptions>';     --结束标签
      x_seq := x_seq + 1;
      xa_value (x_seq) := '</Worksheet>';            --工作表结束标签
      FOR xi IN 1 .. xa_value.LAST
      LOOP
         xm_data (p_conn, xa_value (xi));            --写入到邮件附件流中
      END LOOP;
   END ws_footer;

   FUNCTION link_str (
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
      RETURN VARCHAR2
   IS
      x_end     VARCHAR2 (8)     := p_end;
      x_str     VARCHAR2 (32000);
      x_split   VARCHAR2 (8)     := p_tab;
   BEGIN
      x_end := NVL (x_end, x_clf);
      x_str :=
            p_str1
         || x_split
         || p_str2
         || x_split
         || p_str3
         || x_split
         || p_str4
         || x_split
         || p_str5
         || x_split
         || p_str6
         || x_split
         || p_str7
         || x_split
         || p_str8
         || x_split
         || p_str9
         || x_split
         || p_str10
         || x_split
         || p_str11
         || x_split
         || p_str12
         || x_split
         || p_str13
         || x_split
         || p_str14
         || x_split
         || p_str15
         || x_split
         || p_str16
         || x_split
         || p_str17
         || x_split
         || p_str18
         || x_split
         || p_str19
         || x_split
         || p_str20
         || x_split
         || p_str21
         || x_split
         || p_str22
         || x_split
         || p_str23
         || x_split
         || p_str24
         || x_split
         || p_str25
         || x_split
         || p_str26
         || x_split
         || p_str27
         || x_split
         || p_str28
         || x_split
         || p_str29
         || x_split
         || p_str30
         || x_split
         || p_str31
         || x_split
         || p_str32
         || x_split
         || p_str33
         || x_split
         || p_str34
         || x_split
         || p_str35
         || x_split
         || p_str36
         || x_split
         || p_str37
         || x_split
         || p_str38
         || x_split
         || p_str39
         || x_split
         || p_str40
         || x_split
         || p_str41
         || x_split
         || p_str42
         || x_split
         || p_str43
         || x_split
         || p_str44
         || x_split
         || p_str45
         || x_split
         || p_str46
         || x_split
         || p_str47
         || x_split
         || p_str48
         || x_split
         || p_str49
         || x_split
         || p_str50
         || x_split
         || p_str51
         || x_split
         || p_str52
         || x_split
         || p_str53
         || x_split
         || p_str54
         || x_split
         || p_str55
         || x_split
         || p_str56
         || x_split
         || p_str57
         || x_split
         || p_str58
         || x_split
         || p_str59
         || x_split
         || x_end;
      RETURN x_str;
   END link_str;

   FUNCTION check_type (p_value VARCHAR2)
      RETURN VARCHAR2
   IS
      x_val    NUMBER;
      x_type   VARCHAR2 (32);
   BEGIN
      IF p_value IS NULL
      THEN
         x_type := 'String';
      END IF;

      BEGIN
         SELECT TO_NUMBER (p_value)
           INTO x_val
           FROM DUAL;

         x_type := 'Number';
      EXCEPTION
         WHEN OTHERS
         THEN
            x_type := 'String';
      END;

      RETURN x_type;
   END check_type;

   PROCEDURE x_send (p_cnn IN OUT UTL_SMTP.connection, p_mail IN VARCHAR2)
   IS
      x_mail   VARCHAR2 (32000);
      x_to     VARCHAR2 (240);
   BEGIN
      x_mail := p_mail;
      x_mail := REPLACE (REPLACE (x_mail, '&', ','), ';', ',');

      FOR xi IN 1 .. split_cnt (p_mail, ',')
      LOOP
         x_to := SPLIT (p_mail, ',', xi);

         IF x_to IS NOT NULL
         THEN
            BEGIN
               UTL_SMTP.rcpt (p_cnn, RTRIM(x_to));
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
            END;
         END IF;
      END LOOP;
   END;

   PROCEDURE xm_data (p_conn IN mail_connection, p_mess IN VARCHAR2)
   IS
      x_conn   mail_connection := p_conn;
   BEGIN
      UTL_SMTP.write_raw_data (x_conn.connection,
                               UTL_RAW.cast_to_raw (   CONVERT (p_mess,
                                                                'ZHS16GBK'
                                                               )
                                                    || x_clf
                                                   )
                              );
   END xm_data;

   PROCEDURE xm_ws_row (
      p_conn    IN   mail_connection,        --连接对象
      p_str1         VARCHAR2 DEFAULT '',    --单元格数据
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
   )
   IS
      x_cnt     NUMBER                  := 99;  --计数器
      x_type    VARCHAR2 (32);                  --单元格类型
      x_value   VARCHAR2 (2000);                --单元格值
      x_sql     VARCHAR2 (32000);               --临时SQL变量
      x_ai      DBMS_SQL.varchar2_table;    --DBMS_SQL中的索引表变量
   BEGIN
      IF x_worksheet_cnt = 0
      THEN 
         xm_worksheet (p_conn);                 --如果不存在工作表，则写入工作表头信息
      END IF;
      x_ai (1) := p_str1;                       --将传入的参数写入索引表中 
      x_ai (2) := p_str2;
      x_ai (3) := p_str3;
      x_ai (4) := p_str4;
      x_ai (5) := p_str5;
      x_ai (6) := p_str6;
      x_ai (7) := p_str7;
      x_ai (8) := p_str8;
      x_ai (9) := p_str9;
      x_ai (10) := p_str10;
      x_ai (11) := p_str11;
      x_ai (12) := p_str12;
      x_ai (13) := p_str13;
      x_ai (14) := p_str14;
      x_ai (15) := p_str15;
      x_ai (16) := p_str16;
      x_ai (17) := p_str17;
      x_ai (18) := p_str18;
      x_ai (19) := p_str19;
      x_ai (20) := p_str20;
      x_ai (21) := p_str21;
      x_ai (22) := p_str22;
      x_ai (23) := p_str23;
      x_ai (24) := p_str24;
      x_ai (25) := p_str25;
      x_ai (26) := p_str26;
      x_ai (27) := p_str27;
      x_ai (28) := p_str28;
      x_ai (29) := p_str29;
      x_ai (30) := p_str30;
      x_ai (31) := p_str31;
      x_ai (32) := p_str32;
      x_ai (33) := p_str33;
      x_ai (34) := p_str34;
      x_ai (35) := p_str35;
      x_ai (36) := p_str36;
      x_ai (37) := p_str37;
      x_ai (38) := p_str38;
      x_ai (39) := p_str39;
      x_ai (40) := p_str40;
      x_ai (41) := p_str41;
      x_ai (42) := p_str42;
      x_ai (43) := p_str43;
      x_ai (44) := p_str44;
      x_ai (45) := p_str45;
      x_ai (46) := p_str46;
      x_ai (47) := p_str47;
      x_ai (48) := p_str48;
      x_ai (49) := p_str49;
      x_ai (50) := p_str50;
      x_ai (51) := p_str51;
      x_ai (52) := p_str52;
      x_ai (53) := p_str53;
      x_ai (54) := p_str54;
      x_ai (55) := p_str55;
      x_ai (56) := p_str56;
      x_ai (57) := p_str57;
      x_ai (58) := p_str58;
      x_ai (59) := p_str59;
      x_ai (60) := p_str60;
      x_ai (61) := p_str61;
      x_ai (62) := p_str62;
      x_ai (63) := p_str63;
      x_ai (64) := p_str64;
      x_ai (65) := p_str65;
      x_ai (66) := p_str66;
      x_ai (67) := p_str67;
      x_ai (68) := p_str68;
      x_ai (69) := p_str69;
      x_ai (70) := p_str70;
      x_ai (71) := p_str71;
      x_ai (72) := p_str72;
      x_ai (73) := p_str73;
      x_ai (74) := p_str74;
      x_ai (75) := p_str75;
      x_ai (76) := p_str76;
      x_ai (77) := p_str77;
      x_ai (78) := p_str78;
      x_ai (79) := p_str79;
      x_ai (80) := p_str80;
      x_ai (81) := p_str81;
      x_ai (82) := p_str82;
      x_ai (83) := p_str83;
      x_ai (84) := p_str84;
      x_ai (85) := p_str85;
      x_ai (86) := p_str86;
      x_ai (87) := p_str87;
      x_ai (88) := p_str88;
      x_ai (89) := p_str89;
      x_ai (90) := p_str90;
      x_ai (91) := p_str91;
      x_ai (92) := p_str92;
      x_ai (93) := p_str93;
      x_ai (94) := p_str94;
      x_ai (95) := p_str95;
      x_ai (96) := p_str96;
      x_ai (97) := p_str97;
      x_ai (98) := p_str98;
      x_ai (99) := p_str99;
      xm_data (p_conn, '<Row>');           --首先写入行标识符
      FOR xi IN 1 .. x_cnt
      LOOP
         x_sql := 'select :xvx f1 from dual'; --将传入的参数转换为特定的格式
         EXECUTE IMMEDIATE x_sql
                      INTO x_value
                     USING x_ai (xi);      --执行动态SQL语句
         IF x_value IS NOT NULL            --如果值不为空
         THEN
            x_type := check_type (x_value);--调用check_type过程获取数据的类型
            xm_data (p_conn,               --写入单元格数据
                        '<Cell ss:Index="'
                     || xi
                     || '"><Data ss:Type="'
                     || x_type
                     || '">'
                     || htm_str (x_value)  --编码HTML字符串
                     || '</Data></Cell>'
                    );
         END IF;
      END LOOP;
      xm_data (p_conn, '</Row>');          --写入行结束符号
   END xm_ws_row;

   PROCEDURE xm_ws_sql (
      p_conn      IN   mail_connection,    --SMTP连接对象
      p_ws_name   IN   VARCHAR2,           --要写入的工作表名称
      p_sql       IN   VARCHAR2,           --SQL语句
      p_1              VARCHAR2 DEFAULT '',--查询参数，可选
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
   )
   IS
      x_cur       NUMBER;               --游标变量
      x_tbl       DBMS_SQL.desc_tab; --保存字段的索引表变量
      x_f_cnt     NUMBER;               --计数器
      x_sql       VARCHAR2 (32000);     --临时保存SQL语句的变量
      x_sql_h     VARCHAR2 (32000);
      x_l         VARCHAR2 (32000);
      x_ws_name   VARCHAR2 (32);        --工作表名称
      x_num       NUMBER;
   BEGIN
      x_cur := DBMS_SQL.open_cursor;    --打开并分析游标
      DBMS_SQL.parse (x_cur, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns (x_cur, x_f_cnt, x_tbl);--将所有字段保存到x_tbl索引表
      DBMS_SQL.close_cursor (x_cur);
      DELETE rpt_tmp WHERE batch = p_ws_name;   --删除索引表内容
      x_ws_name := NVL (p_ws_name, 'Sheet' || (x_worksheet_cnt + 1));
      --定义SQL语句，向rtp_temp表中插入表中包含的字段的记录作为Excel表头
      x_sql := 'INSERT INTO rpt_tmp(batch,seq_id';
      x_l := ') VALUES(''' || x_ws_name || ''',''0''';
      --循环x_tbl表中的记录，写入列信息，合并为插入语句
      FOR xi IN 1 .. x_f_cnt
      LOOP
         x_sql := x_sql || ',str' || xi;
         x_l :=
               x_l
            || ','''
            || LTRIM (RTRIM (NVL (x_tbl (xi).col_name, 'COL_' || xi), ''''),
                      ''''
                     )
            || '''';
      END LOOP;
      --合并x_sql和x_l两个字符串变量，形成一个完整的INSERT语句
      x_sql_h := x_sql || x_l || ')';
      DBMS_OUTPUT.put_line (x_sql_h);
      EXECUTE IMMEDIATE x_sql_h;    --插入Excel表头信息
      x_sql :=
            x_sql
         || ') select '''
         || x_ws_name
         || ''', rownum,xt.* from ('
         || p_sql
         || ') xt';
      x_num := split_cnt (p_sql, ':');   --获取:符号在p_sql中出现的次数
     --这一步主要是指定SQL语句的值的占位符，以便可以根据传入的多个参数作为查询条件
      IF x_num - 1 < 15
      THEN
         x_sql := x_sql || ' Where 1=1 ';

         FOR xi IN x_num .. 15
         LOOP
            x_sql := x_sql || ' and :pxxx___' || xi || ' is null';
         END LOOP;
      END IF;
      --查询并执行SQL语句，向rtp_temp表中插入数据
      EXECUTE IMMEDIATE x_sql
                  USING p_1,
                        p_2,
                        p_3,
                        p_4,
                        p_5,
                        p_6,
                        p_7,
                        p_8,
                        p_9,
                        p_10,
                        p_11,
                        p_12,
                        p_13,
                        p_14,
                        p_15;
      --写入工作表头信息
      xm_worksheet (p_conn, p_ws_name);
      --使用游标FOR循环查询rtp_tmp表，依次序将rpt_tmp表中的数据导入到Excel工作表
      FOR xr IN (SELECT   *
                     FROM rpt_tmp
                    WHERE batch = p_ws_name
                 ORDER BY seq_id)
      LOOP
         xm_ws_row (p_conn,
                    xr.str1,
                    xr.str2,
                    xr.str3,
                    xr.str4,
                    xr.str5,
                    xr.str6,
                    xr.str7,
                    xr.str8,
                    xr.str9,
                    xr.str10,
                    xr.str11,
                    xr.str12,
                    xr.str13,
                    xr.str14,
                    xr.str15,
                    xr.str16,
                    xr.str17,
                    xr.str18,
                    xr.str19,
                    xr.str20,
                    xr.str21,
                    xr.str22,
                    xr.str23,
                    xr.str24,
                    xr.str25,
                    xr.str26,
                    xr.str27,
                    xr.str28,
                    xr.str29,
                    xr.str30,
                    xr.str31,
                    xr.str32,
                    xr.str33,
                    xr.str34,
                    xr.str35,
                    xr.str36,
                    xr.str37,
                    xr.str38,
                    xr.str39,
                    xr.str40,
                    xr.str41,
                    xr.str42,
                    xr.str43,
                    xr.str44,
                    xr.str45,
                    xr.str46,
                    xr.str47,
                    xr.str48,
                    xr.str49,
                    xr.str50,
                    xr.str51,
                    xr.str52,
                    xr.str53,
                    xr.str54,
                    xr.str55,
                    xr.str56,
                    xr.str57,
                    xr.str58,
                    xr.str59,
                    xr.str60,
                    xr.str61,
                    xr.str62,
                    xr.str63,
                    xr.str64,
                    xr.str65,
                    xr.str66,
                    xr.str67,
                    xr.str68,
                    xr.str69,
                    xr.str70,
                    xr.str71,
                    xr.str72,
                    xr.str73,
                    xr.str74,
                    xr.str75,
                    xr.str76,
                    xr.str77,
                    xr.str78,
                    xr.str79,
                    xr.str80,
                    xr.str81,
                    xr.str82,
                    xr.str83,
                    xr.str84,
                    xr.str85,
                    xr.str86,
                    xr.str87,
                    xr.str88,
                    xr.str89,
                    xr.str90,
                    xr.str91,
                    xr.str92,
                    xr.str93,
                    xr.str94,
                    xr.str95,
                    xr.str96,
                    xr.str97,
                    xr.str98,
                    xr.str99
                   );
      END LOOP;
   END xm_ws_sql;

   PROCEDURE xm_file (p_conn IN mail_connection, p_filename VARCHAR2)
   IS
      x_conn   mail_connection := p_conn;
   BEGIN 
      IF x_worksheet_cnt > 0      --如果有Excel文件未结束，则写入结束信息
      THEN
         ws_footer (p_conn);
         wb_footer (p_conn);
      END IF;
      x_worksheet_cnt := 0;       --清空Excel文件的写入
      IF p_filename IS NOT NULL   --如果指定了附件文件名
      THEN
         UTL_SMTP.write_data (x_conn.connection,
                              '--DMW.Boundary.605592468' || x_clf
                             );    --写入结束分隔符
         UTL_SMTP.write_data       --开始一个新的MIME内容的写入
                          (x_conn.connection,
                              'Content-Type: application/octet-stream; name="'
                           || p_filename
                           || '"'
                           || x_clf
                          );
         UTL_SMTP.write_data (x_conn.connection,
                                 'Content-Disposition: attachment; filename="'
                              || p_filename
                              || '"'
                              || x_clf
                             );      --指定流式文件作为附件写入，并指定附件名称
         UTL_SMTP.write_data (x_conn.connection,
                              'Content-Transfer-Encoding: 8bit' || x_clf
                             );      --指定编码格式
         UTL_SMTP.write_data (x_conn.connection, x_clf); --开始写入附件内容
      END IF;
   END xm_file;

   PROCEDURE xm_html (p_conn IN mail_connection, p_html VARCHAR2)
   IS
      x_conn   mail_connection := p_conn;
   BEGIN
      IF x_worksheet_cnt > 0      --在写入之前，如果有Excel文件未结束，则结束Excel文件
      THEN
         ws_footer (p_conn);
         wb_footer (p_conn);
      END IF;
      x_worksheet_cnt := 0;       --清除该变量的值为0
      --写入结束标志
      UTL_SMTP.write_data (x_conn.connection,
                           '--DMW.Boundary.605592468' || x_clf
                          );
      --开始写入HTML格式的内容
      UTL_SMTP.write_data (x_conn.connection,
                           'Content-Type: text/html;' || x_clf
                          );
      UTL_SMTP.write_data (x_conn.connection, '');
      UTL_SMTP.write_data (x_conn.connection, p_html); --写入HTML格式的数据
      UTL_SMTP.write_data (x_conn.connection, x_clf);  --写入回车换行
   END xm_html;

   PROCEDURE xm_worksheet (
      p_conn      IN   mail_connection,
      p_ws_name   IN   VARCHAR2 DEFAULT NULL     --工作表名称   
   )
   IS
      x_msg       VARCHAR2 (32000);              --保存xml数据的变量
      x_ws_name   VARCHAR2 (240);                --工作表名称
   BEGIN
      IF x_worksheet_cnt = 0                     --如果还不存在任何工作表，则写入工作薄信息
      THEN
         wb_header (p_conn);
      ELSE
         ws_footer (p_conn);                     --如果已经存在了工作表，则写入工作表尾部信息
      END IF;
      x_worksheet_cnt := x_worksheet_cnt + 1;    --将工作表数量加1
      x_ws_name := NVL (p_ws_name, 'Sheet' || x_worksheet_cnt); --设置工作表名称
      x_msg := '<Worksheet ss:Name="' || x_ws_name || '">';--写入工作表名称
      xm_data (p_conn, x_msg);                   --写入工作表到附件流中
      x_msg := '<Table>';                        --开始表格行内容的编写
      xm_data (p_conn, x_msg);                   --写入工作表起始标签
   END xm_worksheet;

   FUNCTION xm_init (
      p_grp_name   IN   VARCHAR2,               --程序模块名称
      p_subject    IN   VARCHAR2 DEFAULT '',    --邮件主题 
      p_sender     IN   VARCHAR2 DEFAULT '',    --发件人地址
      p_mailto     IN   VARCHAR2 DEFAULT '',    --收件人地址列表
      p_mailcc     IN   VARCHAR2 DEFAULT '',    --抄送人地址列表
      p_mailbcc    IN   VARCHAR2 DEFAULT '',    --密件抄送地址列表
      p_mailbody   IN   VARCHAR2 DEFAULT ''     --邮件主体内容
   )
      RETURN mail_connection                    --返回mail_connection记录
   IS
      CURSOR get_email                          --定义游标查询email_list中的信息
      IS
         SELECT NVL (p_subject, cel.subject) subject,
                NVL (p_sender, cel.msender) msender,
                NVL (p_mailto, cel.mto) mto, NVL (p_mailcc, cel.mcc) mcc,
                NVL (p_mailbcc, cel.mbcc) mbcc,
                NVL (p_mailbody, cel.MESSAGE) MESSAGE
           FROM email_list cel
          WHERE cel.group_name = NVL (p_grp_name, 'DUMMY')
            AND (cel.disable_date IS NULL OR cel.disable_date > SYSDATE);
      --设置主题内容，get_db_inf获取数据库实例相关信息
      x_subject   VARCHAR2 (3000):= p_subject || '(' || get_db_inf ('namehost')
                             || ')';
      psender     VARCHAR2 (2000);        --保存收件人列表的变量
      mail_conn   mail_connection;        --保存返回值的变量
   BEGIN
      FOR xr IN get_email              --循环游标，以处理多个邮件内容的发送
      LOOP
         --指定收件人信息，包含当前数据库数例信息
         psender :=NVL (xr.msender, '数据库实例：' || get_db_inf ('name'));
         --指定邮件主题，包含了主机相关的信息
         x_subject := xr.subject || '(' || get_db_inf ('namehost') || ')';
         mail_conn.ID := gp_mail_id;      --由于可能包含多个邮件发送信息，使用该变量标识连接ID
         gp_mail_id := gp_mail_id + 1;    --递增连接ID
         --打开到邮件服务器的连接，并返回connection对象
         mail_conn.connection := UTL_SMTP.open_connection (gp_mail_host);
         --指定邮件发送服务器的域
         UTL_SMTP.helo (mail_conn.connection, gp_mail_host);
         --进行邮件服务器验证
         UTL_SMTP.command (mail_conn.connection, 'AUTH LOGIN');                                                         
         UTL_SMTP.command
                   (mail_conn.connection,
                    demo_base64.encode (UTL_RAW.cast_to_raw (gp_auth_username))
                   );
         UTL_SMTP.command
                    (mail_conn.connection,
                     demo_base64.encode (UTL_RAW.cast_to_raw (gp_auth_password)
                                        )
                    );
         UTL_SMTP.mail (mail_conn.connection, psender);
         --获取收件人列表
         IF xr.mto IS NOT NULL
         THEN
            x_send (mail_conn.connection, xr.mto);
         END IF;
         --获取抄送人列表
         IF xr.mcc IS NOT NULL
         THEN
            x_send (mail_conn.connection, xr.mcc);
         END IF;
         --获取密件抄送人列表
         IF xr.mbcc IS NOT NULL
         THEN
            x_send (mail_conn.connection, xr.mbcc);
         END IF;
         --准备邮件数据的写入
         UTL_SMTP.open_data (mail_conn.connection);
         --写入From信息，这里需要加入x_clf，即回车换行
         UTL_SMTP.write_data (mail_conn.connection,
                              'From: ' || psender || x_clf
                             );
         --写入To信息，这里需要加入x_clf，即回车换行
         IF xr.mto IS NOT NULL
         THEN
            UTL_SMTP.write_data (mail_conn.connection,
                                 'To: ' || RTRIM (xr.mto, ';') || x_clf
                                );
         END IF;
         --写入cc信息，这里需要加入x_clf，即回车换行
         IF LENGTH (xr.mcc) IS NOT NULL
         THEN
            UTL_SMTP.write_data (mail_conn.connection,
                                 'cc: ' || RTRIM (xr.mcc, ';') || x_clf
                                );
         END IF;
         --写入bcc信息，这里需要加入x_clf，即回车换行
         IF LENGTH (xr.mbcc) IS NOT NULL
         THEN
            UTL_SMTP.write_data (mail_conn.connection,
                                 'bcc: ' || RTRIM (xr.mbcc, ';') || x_clf
                                );
         END IF;
         --写入邮件主题信息
         UTL_SMTP.write_raw_data (mail_conn.connection,
                                  UTL_RAW.cast_to_raw (   'Subject: '
                                                       || x_subject
                                                       || x_clf
                                                      )
                                 );
         UTL_SMTP.write_data (mail_conn.connection,
                              'Mime-Version: 1.0' || x_clf
                             );
         UTL_SMTP.write_data
            (mail_conn.connection,
                'Content-Type: multipart/mixed; boundary="DMW.Boundary.605592468"'
             || x_clf
            );
         UTL_SMTP.write_data (mail_conn.connection,
                              '--DMW.Boundary.605592468' || x_clf
                             );
         UTL_SMTP.write_data (mail_conn.connection,
                                 'Content-Type: text/plain;  charset=utf-8'
                              || x_clf
                             );
         UTL_SMTP.write_data (mail_conn.connection,
                              'Content-Disposition: inline;' || x_clf
                             );
         UTL_SMTP.write_data (mail_conn.connection,
                              'Content-Transfer-Encoding: 8bit' || x_clf
                             );
         UTL_SMTP.write_data (mail_conn.connection, x_clf);
         UTL_SMTP.write_raw_data (mail_conn.connection,
                                  UTL_RAW.cast_to_raw (xr.MESSAGE || x_clf));
      END LOOP;
      x_worksheet_cnt := 0;
      RETURN mail_conn;
   END xm_init;

   PROCEDURE xm_close (p_conn IN mail_connection)
   IS
      x_conn   mail_connection := p_conn;  --当前的连接对象
   BEGIN
      IF x_worksheet_cnt > 0               --如果定义了Excel内容
      THEN
         ws_footer (p_conn);               --写入工作表结束信息
         wb_footer (p_conn);               --写入工作薄结束信息
      END IF;
      --输出结束分界符
      UTL_SMTP.write_data (x_conn.connection, '--DMW.Boundary.605592468--');
      UTL_SMTP.close_data (x_conn.connection); --发送邮件
      UTL_SMTP.quit (x_conn.connection);       --退出连接
   END xm_close;

-- Private type declarations
   FUNCTION SPLIT (p_str VARCHAR2, p_bs VARCHAR2, p_n NUMBER)  --获取以p_bs指定符号分隔的第p_n个位置的字符串
      RETURN VARCHAR2
   IS
      TYPE ttbl_c IS TABLE OF VARCHAR2 (1);

      tbl_c   ttbl_c;
      x_n     NUMBER;
      x_bs    VARCHAR2 (1);
      x_str   VARCHAR2 (32000);
      x_end   VARCHAR2 (32000);
   BEGIN
      IF LENGTH (p_bs) > 1 OR p_bs = ' '
      THEN
         tbl_c :=
            ttbl_c (',',
                    ';',
                    '.',
                    '@',
                    '#',
                    '|',
                    '<',
                    '>',
                    ':',
                    '[',
                    ']',
                    '{',
                    '}',
                    '$',
                    '%',
                    '*'
                   );

         FOR i IN 1 .. tbl_c.LAST
         LOOP
            IF INSTR (p_str, tbl_c (i)) = 0
            THEN
               x_bs := tbl_c (i);
               EXIT;
            END IF;
         END LOOP;

         x_str := REPLACE (p_str, p_bs, x_bs);
      ELSE
         x_bs := p_bs;
         x_str := p_str;
      END IF;

      x_str := RTRIM (x_str, x_bs) || x_bs;

      IF p_n < 0
      THEN
         x_n :=
              LENGTH (REGEXP_REPLACE (TRIM (x_str), '[^' || x_bs || ']', ''));
         x_n := ABS (x_n + 1 + p_n);
      ELSE
         x_n := p_n;
      END IF;

      x_n := GREATEST (1, x_n);
      x_end :=
         RTRIM (REGEXP_SUBSTR (x_str, '[^]' || x_bs || ']{0,}' || x_bs, 1,
                               x_n),
                x_bs
               );
      RETURN x_end;
   END SPLIT;

   FUNCTION split_cnt (p_str VARCHAR2, p_bs VARCHAR2)  --获取在p_str中p_bs指定的符号分隔的个数
      RETURN NUMBER
   IS
      TYPE ttbl_c IS TABLE OF VARCHAR2 (1);

      tbl_c   ttbl_c;
      x_n     NUMBER;
      x_bs    VARCHAR2 (1);
      x_str   VARCHAR2 (32000);
      x_end   VARCHAR2 (32000);
   BEGIN
      IF LENGTH (p_bs) > 1 OR p_bs = ' '
      THEN
         tbl_c :=
            ttbl_c (',',
                    ';',
                    '.',
                    '@',
                    '#',
                    '|',
                    '<',
                    '>',
                    ':',
                    '[',
                    ']',
                    '{',
                    '}',
                    '$',
                    '%',
                    '*'
                   );

         FOR i IN 1 .. tbl_c.LAST
         LOOP
            IF INSTR (p_str, tbl_c (i)) = 0
            THEN
               x_bs := tbl_c (i);
               EXIT;
            END IF;
         END LOOP;

         x_str := REPLACE (p_str, p_bs, x_bs);
      ELSE
         x_bs := p_bs;
         x_str := p_str;
      END IF;

      x_str := RTRIM (x_str, x_bs) || x_bs;
      x_n := LENGTH (REGEXP_REPLACE (TRIM (x_str), '[^' || x_bs || ']', ''));
      RETURN x_n;
   END split_cnt;

   FUNCTION get_var (p_str VARCHAR2, p_n NUMBER)   --获取字母字符
      RETURN VARCHAR2
   IS
      x_var   VARCHAR2 (240);
   BEGIN
      x_var := REGEXP_SUBSTR (p_str, ':[[:alpha:]]+[[:alnum:]_]{0,}', 1, p_n);
      RETURN x_var;
   END get_var;
BEGIN
   -- 包初始化
   NULL;
END comm_email_lib;