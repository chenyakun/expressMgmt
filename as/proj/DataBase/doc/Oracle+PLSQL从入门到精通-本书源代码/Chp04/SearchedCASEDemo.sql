/* Formatted on 2011/08/16 16:51 (Formatter Plus v4.8.8) */
DECLARE
   v_sal     NUMBER (10, 2);          --���屣��нˮ�ı���
   v_empno   NUMBER (10)    := &empno;--������ѯ��Ա�����
BEGIN
   SELECT sal                         --��ȡԱ��н����Ϣ
     INTO v_sal
     FROM emp
    WHERE empno = v_empno;
   --ʹ������CASE��䣬�ж�Ա��н�ʼ���
   CASE
      WHEN v_sal BETWEEN 1000 AND 1500
      THEN
         DBMS_OUTPUT.put_line ('Ա�����𣺳���ְԱ');
      WHEN v_sal BETWEEN 1500 AND 3000
      THEN
         DBMS_OUTPUT.put_line ('Ա�������м�����');
      WHEN v_sal BETWEEN 3000 AND 5000
      THEN
         DBMS_OUTPUT.put_line ('Ա�����𣺸߼�����');
      ELSE
         DBMS_OUTPUT.put_line ('���ڼ���Χ֮��');
   END CASE;
END;
   
   
   