DECLARE
  --�����¼����
  TYPE Emp_Info_Type IS RECORD
  (
    EmpName VARCHAR2(10),
    Job VARCHAR(9),
    Sal NUMBER(7,2)
  );
  --������¼���͵ı���
  EmpInfo emp_Info_Type;
BEGIN
  --��ѯ���ݲ����浽��¼������
  SELECT ename,job,sal INTO EmpInfo FROM emp WHERE empno=&EmpNo;
  --�����¼���ͱ����б����Ա����Ϣ
  DBMS_OUTPUT.PUT_LINE('Ա����ϢΪ��Ա��������'||EmpInfo.EmpName||
  ' ְλ��'||EmpInfo.Job||
  ' н�ʣ�'||EmpInfo.Sal); 
END;