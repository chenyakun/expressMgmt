/* Formatted on 2011/08/16 15:59 (Formatter Plus v4.8.8) */
DECLARE
   v_job     VARCHAR2 (30);             --���屣��CASEѡ�������ַ��ͱ���
   v_empno   NUMBER (4)    := &empno;   --����������ѯԱ����Ա�����
BEGIN
   SELECT job                           --��ȡѡ����v_job��ֵ
     INTO v_job
     FROM emp
    WHERE empno = v_empno;
   --��ָ����CASE��ѡ����Ϊv_job�����е�WHEN�Ӿ�����ͱ���ƥ��ΪVARCHAR2����
   CASE v_job 
      WHEN 'CLERK'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.15)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('Ϊ��ְͨԱ��н15%');
      WHEN 'ANALYST'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.18)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('Ϊ������Ա��н18%');
      WHEN 'MANAGER'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.20)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('Ϊ������Ա��н20%');
      WHEN 'SALESMAN'
      THEN
         UPDATE emp
            SET sal = sal * (1 + 0.22)
          WHERE empno = v_empno;

         DBMS_OUTPUT.put_line ('Ϊ������Ա��н22%');
      ELSE                  --ʹ��ELSE�����ʾ��Ϣ
         DBMS_OUTPUT.put_line ('Ա��ְ�����ڼ�н�����У�');
   END CASE;                --��ֹCASE����
END;