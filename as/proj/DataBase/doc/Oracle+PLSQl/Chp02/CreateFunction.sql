CREATE OR REPLACE FUNCTION GetAddSalaryRatio(p_Job VARCHAR2)
RETURN NUMBER AS
  v_Result NUMBER(7,2);
BEGIN
 IF p_Job='CLERK' THEN                       --���ΪְԱ����н10%
   v_Result:=0.10;
 ELSIF p_Job='SALESMAN' THEN                 --���Ϊ����ְԱ����н12%
   v_Result:=0.12;    
 ELSIF p_Job='MANAGER' THEN                  --���Ϊ������н15%
   v_Result:=0.15;
 END IF;
 RETURN v_Result;   
END;


--ѭ���ṹʾ������ʾѭ��Ϊ����Ա����н
DECLARE
 v_Job VARCHAR(100);                         --����ְλ����
 v_EmpNo VARCHAR(20);                        --����Ա����ű���
 v_Ename VARCHAR(60);                        --����Ա�����Ʊ���
 v_Ratio NUMBER(7,2);
 CURSOR c_Emp IS SELECT job,empno,ename from Scott.emp FOR UPDATE;
BEGIN
 OPEN c_Emp;   --���α�
 LOOP          --ѭ���α�
   FETCH c_Emp INTO v_Job,v_EmpNo,v_Ename;   --��ȡ�α�����
   EXIT WHEN c_Emp%NOTFOUND;                 --��������ݿ���ȡ�˳��α�
   v_Ratio:=GetAddSalaryRatio(v_Job);        --���ú������õ���н��
   UPDATE scott.emp SET sal=sal*(1+v_Ratio) WHERE CURRENT OF c_Emp;        
 --��ʾ�����Ϣ
 DBMS_OUTPUT.PUT_LINE('�Ѿ�ΪԱ��'||v_EmpNo||':'||v_Ename||'�ɹ���н!'); 
 END LOOP;
 CLOSE c_Emp;                                --�ر��α� 
 EXCEPTION
 WHEN OTHERS THEN                            --����PL/SQLԤ�����쳣
   DBMS_OUTPUT.PUT_LINE('û���ҵ�Ա������');
END; 


ROLLBACK;