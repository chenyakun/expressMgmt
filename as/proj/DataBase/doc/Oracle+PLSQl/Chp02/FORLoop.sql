--输出屏幕消息
SET SERVEROUTPUT ON;
--打印九九乘法口决表
DECLARE
  v_Number1 NUMBER(3);  --外层循环变量
  v_Number2 NUMBER(3);  --内存循环变量
BEGIN  
  FOR v_Number1 IN 1..9 --开始外层循环
  LOOP
    --进行内存循环
    FOR v_Number2 IN 1..v_Number1
    LOOP
      --打印口决内容
      DBMS_OUTPUT.PUT(v_Number1||'*'||v_Number2||'='||v_Number1*v_Number2||'   ');
    END LOOP; 
    --输出换行  
    DBMS_OUTPUT.PUT_LINE('');
  END LOOP;
END;
/