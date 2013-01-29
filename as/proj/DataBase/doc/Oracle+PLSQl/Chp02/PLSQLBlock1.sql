DECLARE    --可选
 --定义部分
BEGIN      --必须
 --执行部分
EXCEPTION  --可选
 --异常处理部分  
END;       --必须



BEGIN
 DBMS_OUTPUT.PUT_LINE('这是最简单的PL/SQL语句块');
END;

BEGIN
 NULL;
END;