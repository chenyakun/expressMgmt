DECLARE
   v_num1 NUMBER:=3.1415926;           --�����3.1415926
   v_num2 NUMBER(3):=3.1415926;        --�����������3
 --v_num2_1 NUMBER(3):=3145.1415926;   --���󣬾���̫�ߣ�ORA-06502:PL/SQL:���ֻ�ֵ����:��ֵ����̫��   
   v_num3 NUMBER(4,3):=3.1415926;      --�����3.142
 --v_num3_1 NUMBER(4,3):=314.123;      --���󣬾���̫�ߣ�ORA-06502:PL/SQL:���ֻ�ֵ����:��ֵ����̫��   
   v_num4 NUMBER(8,3):=31415.9267;     --��������2λС�������Ϊ��31415.927
   v_num5 NUMBER(4,-3):=3145611.789;   --����Ϊ��3,ҪС��������������3λ���Ϊ31000
   v_num5_1 NUMBER(4,-3):=314.567895;  --�����Ľ��Ϊ0
   v_num6 NUMBER(4,-1):=31451;         --�������31450  
 --v_num6_1 NUMBER(4,-1):=3145123;     --���󣬾���̫�ߣ�ORA-06502:PL/SQL:���ֻ�ֵ����:��ֵ����̫��   
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


