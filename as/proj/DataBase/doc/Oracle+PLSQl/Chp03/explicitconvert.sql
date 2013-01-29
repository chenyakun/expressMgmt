/* Formatted on 2011/08/14 17:53 (Formatter Plus v4.8.8) */
DECLARE
   v_startdate    DATE;                                            --起始日期
   v_enddate      DATE;                                            --结束日期
   v_resultdate   NUMBER;                                          --返回结果
BEGIN
   --起始日期，将字符串转换为日期
   v_startdate := TO_DATE ('2007-10-11', 'yyyy-MM-dd');
   v_enddate := TRUNC (SYSDATE);                                   --赋日期值
   v_resultdate := v_enddate - v_startdate;                        --进行日期转换
   --输出两者相差天数
   DBMS_OUTPUT.put_line (   ' 起始日期：'
                         || TO_CHAR (v_startdate, 'yyyy-MM-dd')
                         || CHR (13)
                         || CHR (10)
                         || ' 结束日期：'
                         || TO_CHAR (v_enddate, 'yyyy-MM-dd')
                         || CHR (13)
                         || CHR (10)
                         || ' 相差天数：'
                         || TO_CHAR (v_resultdate)
                        );
END;



DECLARE
   v_startdate    CHAR(10);                                            --起始日期
   v_enddate      CHAR(10);                                            --结束日期
   v_result       NUMBER(5);
BEGIN
   SELECT MIN(hiredate) INTO v_startdate FROM emp;                     --自动转换为字符型   
   SELECT TRUNC(SYSDATE) INTO v_enddate FROM dual;
   --输出两者相差天数
   DBMS_OUTPUT.put_line (   ' 起始日期：'
                         || v_startdate
                         || CHR (13)
                         || CHR (10)
                         || ' 结束日期：'
                         || v_enddate
                        );   
   v_startdate:='200';                                               --为字符串赋值
   v_enddate:='400';   
   v_result:=v_enddate-v_startdate;                                  --对字符串进行运算                  
END;  

 

   SELECT TO_CHAR(TRUNC(SYSDATE),'DDD')  FROM dual;
   SELECT TO_CHAR(MIN(hiredate),'DDD')  FROM emp;      

      