/* Formatted on 2011/08/13 14:15 (Formatter Plus v4.8.8) */
DECLARE
   v_timestamp           TIMESTAMP;                      --�����������͵ı���
   v_timestampwithzone   TIMESTAMP WITH TIME ZONE;
BEGIN
   v_timestamp := SYSDATE;                           --Ϊ�������͵ı�������ֵ
   v_timestampwithzone := SYSDATE;
   DBMS_OUTPUT.put_line (v_timestamp);                             --�����Ϣ
   DBMS_OUTPUT.put_line (v_timestampwithzone);
END;


SELECT * FROM V$TIMEZONE_NAMES;

/* Formatted on 2011/08/13 14:40 (Formatter Plus v4.8.8) */
/* Formatted on 2011/08/13 14:41 (Formatter Plus v4.8.8) */
SELECT SESSIONTIMEZONE FROM DUAL;

