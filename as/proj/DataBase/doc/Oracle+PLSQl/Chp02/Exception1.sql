DECLARE
  v_Ename VARCHAR2(30);       --����Ա�����Ʊ������
BEGIN
  --��ѯ���е�Ա������
  SELECT ename INTO v_Ename FROM emp WHERE empno=&EmpNo;
  DBMS_OUTPUT.PUT_LINE('Ա������Ϊ��'||v_Ename);
  --�쳣����� 
  EXCEPTION
  --�쳣ɸѡ��
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('û���ҵ���¼!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('����δ�����쳣!');
END;