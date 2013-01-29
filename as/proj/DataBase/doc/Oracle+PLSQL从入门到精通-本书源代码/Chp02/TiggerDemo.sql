DROP TABLE Scott.RaiseSalaryLog;
--������
CREATE TABLE Scott.RaiseSalaryLog
(  
   EmpNo NUMBER(10) NOT NULL PRIMARY KEY,   --Ա�����
   RaisedDate DATE,                         --��н����
   OriginalSal NUMBER(10,2),                --��нǰн��
   RaisedSal NUMBER(10,2)                   --��н��н��
);

--���崥����
CREATE OR REPLACE TRIGGER Scott.RaiseSalaryChange
--����AFTER�����������EMP���SAL�еĸ���
AFTER UPDATE OF sal ON scott.emp
--��������м��𴥷���
FOR EACH ROW
--������
DECLARE
  v_RecCount INT;  --�����¼������
BEGIN
 --��ѯ����EMP��ĵ�ǰ�ѱ����µ�Ա���Ƿ���RAISESALARYLOG�д���
 SELECT COUNT(*) INTO v_RecCount FROM scott.RaiseSalaryLog WHERE EmpNo=:old.EmpNo;
 IF v_RecCount=0 THEN
    --��������ڣ�������µļ�¼
    INSERT INTO scott.RaiseSalaryLog VALUES(:old.EmpNo,SYSDATE,:old.sal,:new.sal);  
 ELSE
   --�����������¼�¼
    UPDATE scott.RaiseSalaryLog SET RaisedDate=SYSDATE,
    OriginalSal=:old.sal,RaisedSal=:new.sal WHERE EmpNo=:old.EmpNo;
 END IF;
  --������ִ�������ʾ������Ϣ
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


SELECT *FROM EMP;

SELECT * FROM Scott.RaiseSalaryLog;

UPDATE Scott.emp SET sal=sal*1.2 WHERE empno=7369;

commit;

