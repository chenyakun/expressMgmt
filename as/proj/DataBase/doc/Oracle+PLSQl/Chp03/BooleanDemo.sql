/* Formatted on 2011/08/13 17:45 (Formatter Plus v4.8.8) */
DECLARE 
   v_condition   BOOLEAN;       --定义布尔类型变量
BEGIN
   v_condition := TRUE;         --为变量赋布尔值TRUE
 --v_condtion:='FALSE';         --错误，布尔值不能带引号
   IF v_condition THEN          --如果布尔值条件为TRUE，则输出
   DBMS_OUTPUT.put_line ('值为TRUE');
   END IF;
END;