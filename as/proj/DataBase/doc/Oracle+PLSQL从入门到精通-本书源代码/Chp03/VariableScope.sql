<<outer>>
DECLARE
   v_empname VARCHAR2(20);          --�����������
BEGIN
   v_empname:='����';               --Ϊ�����ı�������ֵ
   <<inner>>
   DECLARE
      v_empname VARCHAR2(20);       --����������ͬ�����ڲ��ı���
   BEGIN
      v_empname:='����';            --Ϊ�ڲ�������ֵ
      --����ڲ��ı���
      DBMS_OUTPUT.put_line('�ڲ���Ա�����ƣ�'||v_empname);
      --���ڲ���з�������ı���
      DBMS_OUTPUT.put_line('�����Ա�����ƣ�'||outer.v_empname);
   END;
   DBMS_OUTPUT.put_line('outerԱ�����ƣ�'||v_empname);  --�������з��ʱ���
END;   


SELECT * FROM EMP;