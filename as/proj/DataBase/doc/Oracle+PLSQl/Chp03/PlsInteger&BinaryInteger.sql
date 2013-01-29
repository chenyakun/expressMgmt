--PLS_INTEGER使用示例
DECLARE
   v_num1 PLS_INTEGER:=2147483647;   
BEGIN
   --当为v_num1+1时，产生了溢出，会触发异常
   v_num1:=v_num1+1-1;
   EXCEPTION
     WHEN OTHERS THEN
       --输出：ORA-01426: 数字溢出
       DBMS_OUTPUT.put_line(SQLERRM);
END;  
--BINARY_INTEGER使用示例 
DECLARE
   v_num1 BINARY_INTEGER:=2147483647;
BEGIN   
   /*当为v_num1+1时，产生了溢出，
     此时v_num1会被当作NUMBER进行处理，不会触发异常
   */
   v_num1:=v_num1+1-1;
END;  
 
 
DECLARE
   v_num1 NUMBER:=-2147483647;
BEGIN
   v_num1:=v_num1-1;
   DBMS_OUTPUT.put_line(v_num1);
   EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.put_line(SQLERRM); 
 END;  