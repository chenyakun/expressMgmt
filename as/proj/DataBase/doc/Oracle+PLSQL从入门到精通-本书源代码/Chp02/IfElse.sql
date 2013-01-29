--��֧�ṹʾ������ʾΪԱ����н
DECLARE
 --�����н���ʳ���
 c_Manager CONSTANT NUMBER:=0.15;
 c_SalesMan CONSTANT NUMBER:=0.12;
 c_Clerk CONSTANT NUMBER:=0.10;
 --���幤�ֱ���
 v_Job VARCHAR(100);
BEGIN
 --��ѯָ��Ա�������Ա����Ϣ
 SELECT job INTO v_Job FROM scott.emp WHERE empno=&empNo1;
 --ִ�з�֧�ж�
 IF v_Job='CLERK' THEN
   UPDATE scott.emp SET SAL=SAL*(1+c_Clerk) WHERE empno=&empNo1;
 ELSIF v_Job='SALESMAN' THEN
   UPDATE scott.emp SET SAL=SAL*(1+c_SalesMan) WHERE empno=&empNo1;   
 ELSIF v_Job='MANAGER' THEN
   UPDATE scott.emp SET SAL=SAL*(1+c_Manager) WHERE empno=&empNo1;   
 END IF;
 --��ʾ�����Ϣ
 DBMS_OUTPUT.PUT_LINE('�Ѿ�ΪԱ��'||&empNo1||'�ɹ���н!');  
 EXCEPTION
 --����PL/SQLԤ�����쳣
 WHEN NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('û���ҵ�Ա������');
END; 