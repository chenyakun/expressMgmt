/* Formatted on 2011/08/14 22:26 (Formatter Plus v4.8.8) */
DECLARE
   v_sal      NUMBER;                                          --�������
   v_result   NUMBER;                           
BEGIN
   SELECT sal                                               --Ϊ������ֵ
     INTO v_sal
     FROM emp
    WHERE empno = &empno;
   v_result := v_sal * (1 + 1.5);                             --ʹ�ñ��ʽ��ֵ
END;