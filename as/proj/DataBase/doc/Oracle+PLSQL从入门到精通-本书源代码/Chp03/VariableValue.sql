DECLARE
   v_counter INTEGER;          --����һ������
BEGIN
   v_counter:=0;               --Ϊ��������ֵ
   v_counter:=v_counter+1;     --û��Ϊ��������ʼֱֵ�Ӽ���
   DBMS_OUTPUT.put_line('δ��ֵ�ı���ʾ�������'||v_counter);
END;  


DECLARE
   v_salary NUMBER(7,2);
   v_rate NUMBER(7,2):=0.12;
   v_base_salary NUMBER(7,2):=1200;
BEGIN
   v_salary:=v_base_salary*(1+v_rate);  --ʹ�ñ��ʽΪ������ֵ
   DBMS_OUTPUT.put_line('Ա����н��ֵΪ��'||v_salary);       
END;


DECLARE 
   v_string VARCHAR2(200);
   v_hire_date DATE;
   v_bool BOOLEAN;                       --PL/SQL��������
BEGIN
   v_bool:=TRUE;                         --�������͸�ֵ
   v_hire_date:=to_date('2011-12-13','yyyy-mm-dd');  --ʹ�ú���Ϊ���ڸ�ֵ   
   v_hire_date:=SYSDATE;                --ʹ�����ں�����ֵ
   v_hire_date:=date'2011-12-14';       --ֱ�Ӹ���̬����ֵ    
   v_string:='This is a string';        --����̬�ַ���    
END;   
/



/* Formatted on 2011/08/09 21:55 (Formatter Plus v4.8.8) */
DECLARE
   v_empno      emp.empno%TYPE;                  --�������
   v_ename      emp.ename%TYPE;
   v_hiredate   emp.hiredate%TYPE;
BEGIN
   SELECT empno, ename, hiredate                 --��ѯ���ݿⲢΪ������ֵ
     INTO v_empno, v_ename, v_hiredate
     FROM emp
    WHERE empno = &empno;
   --�������������
   DBMS_OUTPUT.put_line ('Ա�����:' || v_empno);
   DBMS_OUTPUT.put_line ('Ա������:' || v_ename);
   DBMS_OUTPUT.put_line ('��Ӷ����:' || v_hiredate);
END;


DECLARE
   v_empno emp.empno%TYPE;    --ʹ��%TYPE����emp��empno�����͵ı���
   v_empno2 v_empno%TYPE;     --������v_empno��ͬ�ı���
   v_salary NUMBER(7,3) NOT NULL:=1350.5;  --����нˮ����
   v_othersalary v_salary%TYPE;
BEGIN
   NULL;
END;
/

