DECLARE
  v_DeptName VARCHAR2(10);        --�����������
  v_LoopCounter BINARY_INTEGER;   --ʹ��PL/SQL���Ͷ����������
  --�����¼����
  TYPE t_Employee IS RECORD (EmpName VARCHAR2(20),EmpNo NUMBER(7),Job VARCHAR2(20));
  v_Employee t_Employee;          --�����¼���ͱ���
  TYPE csor IS REF CURSOR;        --�����α����
  v_date DATE NOT NULL DEFAULT SYSDATE;--���������ָ��Ĭ��ֵ
BEGIN
 NULL;
END;
/