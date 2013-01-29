DECLARE
   v_name CHAR(2 BYTE);
   v_name2 CHAR(2 CHAR);
   v_name3 CHAR;
   v_name4 CHAR(20);
BEGIN
  v_name:='ab';       --正确，2个字节的字符串
  v_name:='中国';   --错误，大于2个字节 
  v_name2:='中国';    --正确，2个字符
  v_name3:=1;         --正确，单个字节
  v_name4:='This is string';  --为CHAR赋字符串值
  DBMS_OUTPUT.put_line(LENGTH(v_name4));--输出字符串长度
END;



DECLARE
  v_name VARCHAR2(25);
  v_name1 VARCHAR2(25 BYTE);
  v_name2 VARCHAR2(25 CHAR);   
  --v_name3 VARCHAR2;          --错误，必须要为VARCHAR2指定长度值
BEGIN
  v_name:='中华人民共和国';    --为变量赋值，并输出变量的长度
  DBMS_OUTPUT.put_line('v_name变量的长度为：'||LENGTH(v_name)||'字节');
  v_name1:='中华人民共和国';
  DBMS_OUTPUT.put_line('v_name1变量的长度为：'||LENGTH(v_name1)||'字节');  
  v_name2:='中华人民共和国';
  DBMS_OUTPUT.put_line('v_name1变量的长度为：'||LENGTH(v_name2)||'字节');    
END;     