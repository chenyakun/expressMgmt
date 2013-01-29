/* Formatted on 2011/08/13 14:15 (Formatter Plus v4.8.8) */
DECLARE
   v_timestamp           TIMESTAMP;                      --定义日期类型的变量
   v_timestampwithzone   TIMESTAMP WITH TIME ZONE;
BEGIN
   v_timestamp := SYSDATE;                           --为日期类型的变量赋初值
   v_timestampwithzone := SYSDATE;
   DBMS_OUTPUT.put_line (v_timestamp);                             --输出信息
   DBMS_OUTPUT.put_line (v_timestampwithzone);
END;


SELECT * FROM V$TIMEZONE_NAMES;

/* Formatted on 2011/08/13 14:40 (Formatter Plus v4.8.8) */
/* Formatted on 2011/08/13 14:41 (Formatter Plus v4.8.8) */
SELECT SESSIONTIMEZONE FROM DUAL;

