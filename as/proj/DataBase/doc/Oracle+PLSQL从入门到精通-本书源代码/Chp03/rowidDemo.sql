/* Formatted on 2011/08/11 20:58 (Formatter Plus v4.8.8) */
DECLARE
   v_empname      ROWID;                                --����ROWID���͵ı���
   v_othersname   VARCHAR (18);               --������������ROWID���ַ�������
BEGIN
   SELECT ROWID                               --��ѯ����ȡROWID��ֵ
     INTO v_empname
     FROM emp
    WHERE empno = &empno;
   --���ROWIDֵ
   DBMS_OUTPUT.put_line (v_empname);
   v_othersname := ROWIDTOCHAR (v_empname);    --ת��ROWIDΪ�ַ���ֵ
   DBMS_OUTPUT.put_line (v_othersname);
END;
/


SELECT ROWIDTOCHAR(ROWID),ename,empno from emp;