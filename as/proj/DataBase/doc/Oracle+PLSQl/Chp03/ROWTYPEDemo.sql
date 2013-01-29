
DECLARE
   v_emp   emp%ROWTYPE;                               --����emp�������������
BEGIN
   SELECT *                               --��ѯemp�������д�뵽v_emp��¼��
     INTO v_emp
     FROM emp
    WHERE empno = &empno;

   --��������Ϣ
   DBMS_OUTPUT.put_line (v_emp.empno || CHR (13) || CHR (10) || v_emp.ename);
END;

DESC emp;



DECLARE
   CURSOR emp_cursor                       --�����α�����
   IS
      SELECT empno, ename, job, sal, hiredate
        FROM emp;
   --ʹ��%ROWTYPE�����α����͵ı���
   v_emp   emp_cursor%ROWTYPE;
BEGIN
   OPEN emp_cursor;                        --���α�
   --ѭ������ȡ�α�����
   LOOP
      FETCH emp_cursor
       INTO v_emp;
      --Ҫע���α��ƶ�����β���˳��α�
      EXIT WHEN emp_cursor%NOTFOUND;
      --����α�����
      DBMS_OUTPUT.put_line (   v_emp.empno
                            || ' '
                            || v_emp.ename
                            || ' '
                            || v_emp.job
                            || ' '
                            || v_emp.sal
                            || ' '
                            || TO_CHAR (v_emp.hiredate, 'YYYY-MM-DD')
                           );
   END LOOP;
   --�ر��α�
   CLOSE emp_cursor;
END;
/

/* Formatted on 2011/08/10 10:50 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp;

DECLARE
   v_emp emp%ROWTYPE;              --����emp�������͵ļ�¼
BEGIN
   v_emp.empno:=8000;              --Ϊ��¼���͸�ֵ
   v_emp.ename:='������';
   v_emp.job:='����';
   v_emp.mgr:=7902;
   v_emp.hiredate:=date'2010-12-13';
   v_emp.sal:=8000;
   v_emp.deptno:=20;
   INSERT INTO emp VALUES v_emp;   --����¼���Ͳ��뵽���ݱ�
END;
/       
   