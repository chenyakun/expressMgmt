DECLARE
  p  VARCHAR2(30);                  --定义输出字符串变量
  n  PLS_INTEGER := 37;             --定义要判断的数字
BEGIN
  FOR j in 2..ROUND(SQRT(n)) LOOP   --外层循环
    IF n MOD j = 0 THEN             --判断是否为一个素数
      p := ' 不是素数';              --初始化P的值
      GOTO print_now;                --跳转到print_now标签位置
    END IF;
  END LOOP;
  p := ' 是一个素数';
  --跳转到标签位置 
  <<print_now>>
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(n) || p);
END;
/


--DECLARE
--  done  BOOLEAN;
--BEGIN
--  FOR i IN 1..50 LOOP
--    IF done THEN
--       GOTO end_loop;
--    END IF;
--    <<end_loop>>
--  END LOOP;
--END;


/* Formatted on 2011/08/18 23:18 (Formatter Plus v4.8.8) */
DECLARE
   v_counter   INT := 0;   --定义循环计数器变量
BEGIN  
   <<outer>>               --定义标签
   v_counter := v_counter + 1;
   DBMS_OUTPUT.put_line ('循环计数器：' || v_counter);
   --判断计数器条件
   IF v_counter < 5
   THEN
      GOTO OUTER;           --向上跳转到标签位置
   END IF;
END;