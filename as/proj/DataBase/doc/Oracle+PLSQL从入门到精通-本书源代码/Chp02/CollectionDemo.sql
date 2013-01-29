DECLARE 
  --����Ա������������
  TYPE Emp_Table IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER;
  EmpList Emp_Table;   --��������͵ı���
  --�����α�����
  CURSOR empcursor IS SELECT EName FROM emp;
BEGIN
  --����α�û�д�����α�
  IF NOT empcursor%ISOPEN THEN
     OPEN empcursor;
  END IF;
  --���α�������ȡ���е�Ա������
  FETCH empcursor BULK COLLECT INTO EmpList;
  --ʹ��FORѭ����ʾ���е�Ա������
  FOR i IN 1..EmpList.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||EmpList(i));
  END LOOP;
  CLOSE empcursor;   --�ر��α�
END;
/