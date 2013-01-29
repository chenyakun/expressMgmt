/* Formatted on 2011/08/10 15:56 (Formatter Plus v4.8.8) */
DECLARE
   c_salary_rate   CONSTANT NUMBER (7, 2) := 0.25;  --�����н����ֵ
   v_salary                 NUMBER (7, 2);          --���屣��н�ʽ���ı���
BEGIN
   SELECT sal * (1 + c_salary_rate)                 --��ѯ���ݿ⣬���ؼ�н��Ľ��
     INTO v_salary
     FROM emp
    WHERE empno = &empno;
   --�����Ļ��Ϣ
   DBMS_OUTPUT.put_line ('��н���н�ʣ�' || v_salary);
END;