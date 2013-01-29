DECLARE
   v_num1 NUMBER:=3.1415926;           --结果：3.1415926
   v_num2 NUMBER(3):=3.1415926;        --四舍五入等于3
 --v_num2_1 NUMBER(3):=3145.1415926;   --错误，精度太高：ORA-06502:PL/SQL:数字或值错误:数值精度太高   
   v_num3 NUMBER(4,3):=3.1415926;      --结果：3.142
 --v_num3_1 NUMBER(4,3):=314.123;      --错误，精度太高：ORA-06502:PL/SQL:数字或值错误:数值精度太高   
   v_num4 NUMBER(8,3):=31415.9267;     --四舍五入2位小数，结果为：31415.927
   v_num5 NUMBER(4,-3):=3145611.789;   --由于为负3,要小数点左侧进行舍入3位结果为31000
   v_num5_1 NUMBER(4,-3):=314.567895;  --舍入后的结果为0
   v_num6 NUMBER(4,-1):=31451;         --舍入后结果31450  
 --v_num6_1 NUMBER(4,-1):=3145123;     --错误，精度太高：ORA-06502:PL/SQL:数字或值错误:数值精度太高   
BEGIN
  DBMS_OUTPUT.put_line('v_num1:='||v_num1);
  DBMS_OUTPUT.put_line('v_num2:='||v_num2);
  DBMS_OUTPUT.put_line('v_num3:='||v_num3);
  DBMS_OUTPUT.put_line('v_num4:='||v_num4);      
  DBMS_OUTPUT.put_line('v_num5:='||v_num5);    
  DBMS_OUTPUT.put_line('v_num5_1:='||v_num5_1);  
  DBMS_OUTPUT.put_line('v_num6:='||v_num6);          
END;  
/


