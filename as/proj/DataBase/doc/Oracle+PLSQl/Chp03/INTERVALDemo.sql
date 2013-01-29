/* Formatted on 2011/08/13 16:55 (Formatter Plus v4.8.8) */
DECLARE
   v_start      TIMESTAMP;                         --定义起始与结束时间戳类型
   v_end        TIMESTAMP;
   v_interval   INTERVAL YEAR TO MONTH;
   v_year       NUMBER;
   v_month      NUMBER;
BEGIN
   v_start := TO_TIMESTAMP ('2010-05-12', 'yyyy-MM-dd');  --赋指定的时间戳值
   v_end := CURRENT_TIMESTAMP;                            --赋当前的时间戳值
   v_interval := (v_end - v_start) YEAR TO MONTH;         --YEAR TO MONTH是INTERVAL表达式语法。
   v_year := EXTRACT (YEAR FROM v_interval);              --提取年份和月份
   v_month := EXTRACT (MONTH FROM v_interval);
   --输出当前的INTERVAL类型的值
   DBMS_OUTPUT.put_line ('当前的INTERVAL值为：' || v_interval);
   --输出年份与月份值
   DBMS_OUTPUT.put_line (   'INTERVAL年份为：'
                         || v_year
                         || CHR (13)
                         || CHR (10)
                         || 'INTERVAL月份为：'
                         || v_month
                        );
   v_interval := INTERVAL '01-03' YEAR TO MONTH;            --直接为INTERVAL赋值
   --输出INTERVAL的值
   DBMS_OUTPUT.put_line ('当前的INTERVAL值为：' || v_interval);
   v_interval := INTERVAL '01' YEAR;                        --直接为INTERVAL赋年份值
   DBMS_OUTPUT.put_line ('当前的INTERVAL值为：' || v_interval);
   --提取年份和月份
   v_year := EXTRACT (YEAR FROM v_interval);
   v_month := EXTRACT (MONTH FROM v_interval);
   --输出值
   DBMS_OUTPUT.put_line (   'INTERVAL年份为：'
                         || v_year
                         || CHR (13)
                         || CHR (10)
                         || 'INTERVAL月份为：'
                         || v_month
                        );
   v_interval := INTERVAL '03' MONTH;                      --直接为INTERVAL赋月份
   --输出月份值
   DBMS_OUTPUT.put_line ('当前的INTERVAL值为：' || v_interval);
END;
/