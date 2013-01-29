/*<TOAD_FILE_CHUNK>*/
/* Formatted on 2011/08/15 22:38 (Formatter Plus v4.8.8) */
DECLARE
   v_count   NUMBER (10) := 0;                               --�������������
   v_empno   NUMBER (4)  := 7888;                              --����Ա�����
BEGIN
   SELECT COUNT (1)                           --���Ȳ�ѯָ����Ա������Ƿ����
     INTO v_count
     FROM emp
    WHERE empno = v_empno;

   --ʹ��IF����жϣ����Ա����Ų����ڣ����Ϊ0
   IF v_count = 0
   THEN
      --��ִ��INSERT��䣬�����µ�Ա����¼
      INSERT INTO emp
                  (empno, ename, job, hiredate, sal, deptno
                  )
           VALUES (v_empno, '����', '����', TRUNC (SYSDATE), 1000, 20
                  );
   END IF;

   --�����ݿ��ύ����
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);                          --����쳣��Ϣ
END;
/

select * from emp;
DESC EMP;

/* Formatted on 2011/08/16 06:46 (Formatter Plus v4.8.8) */
DECLARE
   v_sal      NUMBER (7, 2);    --н�ʱ���
   v_deptno   NUMBER (2);       --���ű���
   v_job      VARCHAR2 (9);     --ְλ����
BEGIN
   --�����ݿ��в�ѯָ��Ա����ŵ���Ϣ
   SELECT deptno, v_job, sal
     INTO v_deptno, v_job, v_sal
     FROM emp
    WHERE empno = :empno;
   --������ű��Ϊ20��Ա��
   IF v_deptno = 20
   THEN
      --���ְ��ΪCLERK
      IF v_job = 'CLERK'
      THEN
         --��н0.12
         v_sal := v_sal * (1 + 0.12);
      --���ְ��ΪANALYST
      ELSIF v_job = 'ANALYST'
      THEN
         --��н0.19
         v_sal := v_sal * (1 + 0.19);
      END IF;
   --���򣬲�Ϊ20��Ա�����������н
   ELSE
      DBMS_OUTPUT.put_line ('�����ű��Ϊ20��Ա�����ܼ�н');
   END IF;
END;
/*<TOAD_FILE_CHUNK>*/

SELECT *
  FROM emp;

DELETE FROM emp
      WHERE empno = 7888;

COMMIT ;



DECLARE
   v_count   NUMBER (10) := 0;                               --�������������
   v_empno   NUMBER (4)  := 7888;                              --����Ա�����
BEGIN
   SELECT COUNT (1)                           --���Ȳ�ѯָ����Ա������Ƿ����
     INTO v_count
     FROM emp
    WHERE empno = v_empno;

   --ʹ��IF����жϣ����Ա����Ų����ڣ����Ϊ0
   IF v_count = 0
   THEN
      --��ִ��INSERT��䣬�����µ�Ա����¼
      INSERT INTO emp
                  (empno, ename, job, hiredate, sal, deptno
                  )
           VALUES (v_empno, '����', '����', TRUNC (SYSDATE), 1000, 20
                  );
   ELSE   --����ִ��UPDATE������Ա����¼
      UPDATE emp
         SET ename = '����',
             job = '����',
             hiredate = TRUNC (SYSDATE),
             sal = 1000,
             deptno = 20
       WHERE empno = v_empno;
   END IF;

   --�����ݿ��ύ����
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);                          --����쳣��Ϣ
END;
/
