--ѭ���ṹʾ������ʾѭ��Ϊ����Ա����н
DECLARE
 --�����н���ʳ���
 c_Manager CONSTANT NUMBER:=0.15;
 c_SalesMan CONSTANT NUMBER:=0.12;
 c_Clerk CONSTANT NUMBER:=0.10;
 v_Job VARCHAR(100);                         --����ְλ����
 v_EmpNo VARCHAR(20);                        --����Ա����ű���
 v_Ename VARCHAR(60);                        --����Ա�����Ʊ���
 CURSOR c_Emp IS SELECT job,empno,ename from Scott.emp FOR UPDATE;
BEGIN
 OPEN c_Emp;   --���α�
 LOOP          --ѭ���α�
   FETCH c_Emp INTO v_Job,v_EmpNo,v_Ename;   --��ȡ�α�����
   EXIT WHEN c_Emp%NOTFOUND;                 --��������ݿ���ȡ�˳��α�
 IF v_Job='CLERK' THEN                       --���ΪְԱ����н10%
   UPDATE scott.emp SET SAL=SAL*(1+c_Clerk) WHERE CURRENT OF c_Emp;
 ELSIF v_Job='SALESMAN' THEN                 --���Ϊ����ְԱ����н12%
   UPDATE scott.emp SET SAL=SAL*(1+c_SalesMan) WHERE CURRENT OF c_Emp; 
 ELSIF v_Job='MANAGER' THEN                  --���Ϊ������н15%
   UPDATE scott.emp SET SAL=SAL*(1+c_Manager) WHERE CURRENT OF c_Emp;  
 END IF;
 --��ʾ�����Ϣ
 DBMS_OUTPUT.PUT_LINE('�Ѿ�ΪԱ��'||v_EmpNo||':'||v_Ename||'�ɹ���н!'); 
 END LOOP;
 CLOSE c_Emp;                --�ر��α� 
 EXCEPTION
 WHEN NO_DATA_FOUND THEN     --����PL/SQLԤ�����쳣
   DBMS_OUTPUT.PUT_LINE('û���ҵ�Ա������');
END; 

