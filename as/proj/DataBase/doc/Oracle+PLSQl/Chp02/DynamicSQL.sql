--��ѯԱ����Ϣ
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno FROM EMP WHERE empno=&EmpNo;
--����нˮ
UPDATE emp SET sal=sal*(1+1.2) WHERE empno=&EmpNo;
--ɾ��Ա��
DELETE FROM emp WHERE empno=&EmpNo;


--ʹ�ö�̬SQL���
DECLARE
  v_SQLStr VARCHAR2(200);  --����SQL���ı���
  v_Id INT;                --������ʱ�ֶ�ֵ�ı���
  v_Name VARCHAR(100);
BEGIN
  --��Ƕ�׿�����ɾ��Ҫ��������ʱ��
  BEGIN
  v_SQLStr:='DROP TABLE temptable';
  EXECUTE IMMEDIATE v_SQLStr;
  --��������쳣�����д���
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  --����DDL���������SQL
  v_SQLStr:='CREATE TABLE temptable (id INT NOT NULL PRIMARY KEY,tmpname VARCHAR2(100))';
  EXECUTE IMMEDIATE v_SQLStr;  --ִ�ж�̬���
  --���´�������ʱ���в�������
  v_SQLStr:='INSERT INTO temptable VALUES(10,''��ʱ����1'')';
  EXECUTE IMMEDIATE v_SQLStr;  --ִ�ж�̬���
  --������ʱ�����ݣ�����ʹ���˶�̬SQL������
  v_SQLStr:='SELECT * FROM temptable WHERE id=:tempId';
  --ִ�в���ȡ��̬����ѯ���
  EXECUTE IMMEDIATE v_SQLstr INTO v_Id,v_Name USING &1;
  --������е���Ϣ
  DBMS_OUTPUT.PUT_LINE(v_Id||' '||v_Name);
END;
/

