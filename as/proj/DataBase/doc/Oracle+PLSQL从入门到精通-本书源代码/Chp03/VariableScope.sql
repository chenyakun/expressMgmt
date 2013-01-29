<<outer>>
DECLARE
   v_empname VARCHAR2(20);          --定义外层块变量
BEGIN
   v_empname:='张三';               --为外层外的变量赋初值
   <<inner>>
   DECLARE
      v_empname VARCHAR2(20);       --定义与外层块同名的内层块的变量
   BEGIN
      v_empname:='李四';            --为内层块变量赋值
      --输出内层块的变量
      DBMS_OUTPUT.put_line('内层块的员工名称：'||v_empname);
      --在内层块中访问外层块的变量
      DBMS_OUTPUT.put_line('外层块的员工名称：'||outer.v_empname);
   END;
   DBMS_OUTPUT.put_line('outer员工名称：'||v_empname);  --在外层块中访问变量
END;   


SELECT * FROM EMP;