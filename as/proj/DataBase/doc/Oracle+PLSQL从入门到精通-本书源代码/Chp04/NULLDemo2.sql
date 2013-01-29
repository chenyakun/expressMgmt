/* Formatted on 2011/08/19 06:50 (Formatter Plus v4.8.8) */
DECLARE
   v_result   INT := 0;                                    --保存结果值的变量
BEGIN
   v_result := 16 / 0;                                            --故意被0除
   DBMS_OUTPUT.put_line (   '现在时间是:'
                         || TO_CHAR (SYSDATE, 'yyyy-MM-dd HH24:MI:SS')
                        );
EXCEPTION                                                     --异常处理语句块
   WHEN OTHERS
   THEN
      NULL;                                  --当触发任何异常时，什么也不做。
END;


/* Formatted on 2011/08/19 06:56 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE getleveledbom (bomlevel INT)
AS
BEGIN
   NULL;
END;