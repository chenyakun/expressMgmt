/* Formatted on 2011/08/14 06:42 (Formatter Plus v4.8.8) */
CREATE OR REPLACE FUNCTION selectallemployments
   RETURN sys_refcursor           --����һ������sys_refcursor�ĺ���
AS
   st_cursor   sys_refcursor;
BEGIN
   OPEN st_cursor FOR             --ʹ�øú�����ѯ���е�Ա����¼
      SELECT *
        FROM emp;
   --����ָ���α��ָ��
   RETURN st_cursor;
END;
/

/* Formatted on 2011/08/14 07:01 (Formatter Plus v4.8.8) */
DECLARE
   x       sys_refcursor;    --���������α����
   v_emp   emp%ROWTYPE;      --�����ȡ�α����ļ�¼����
BEGIN
   x := selectallemployments;--���ú�����ȡ�α�ָ��
   --ѭ�������α�ָ��
   LOOP
      FETCH x                --��ȡ�α�����
       INTO v_emp;
      --��û���ҵ��α��¼ʱ���˳�
      EXIT WHEN x%NOTFOUND;
      --�����¼��Ϣ
      DBMS_OUTPUT.put_line (   'Ա����ţ�'
                            || v_emp.empno
                            || '   Ա�����ƣ�'
                            || v_emp.ename
                           );
   END LOOP;
END;