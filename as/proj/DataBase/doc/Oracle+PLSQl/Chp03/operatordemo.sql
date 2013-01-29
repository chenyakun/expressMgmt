/* Formatted on 2011/08/14 22:26 (Formatter Plus v4.8.8) */
DECLARE
   v_sal      NUMBER;                                          --定义变量
   v_result   NUMBER;                           
BEGIN
   SELECT sal                                               --为变量赋值
     INTO v_sal
     FROM emp
    WHERE empno = &empno;
   v_result := v_sal * (1 + 1.5);                             --使用表达式赋值
END;