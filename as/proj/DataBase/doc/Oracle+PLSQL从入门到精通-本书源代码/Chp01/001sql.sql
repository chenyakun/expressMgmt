--����Ա����
CREATE TABLE Ա����
(
  --����Ա������
  ���� INT NOT NULL,
  �������� NVARCHAR2(20) NOT NULL,
  Ӣ������ VARCHAR2(20) NULL,
  ���� VARCHAR2(20) NULL, 
  ���� INT DEFAULT 18,
  ��ְ���� DATE NULL,
  ���ű�� INT NULL,
  --����Ա��������
  CONSTRAINT PK_Ա���� PRIMARY KEY(����)
);
--�������ű�
CREATE TABLE ���ű�
(
  --���岿�ű���
  ���ű�� INT NOT NULL,
  �������� NVARCHAR2(50) NULL,
  ���ž��� INT NOT NULL,
  �������� NVARCHAR2(200) NULL,
  ���� INT NOT NULL,
  --���岿�ű�����
  CONSTRAINT PK_���ű� PRIMARY KEY(���ű��)   
);
--ΪԱ��������������
ALTER TABLE Ա���� ADD (
  CONSTRAINT FK_���ű�� 
 FOREIGN KEY (���ű��) 
 REFERENCES ���ű� (���ű��));
 
--Ϊ���ű�����������
ALTER TABLE ���ű� ADD (
  CONSTRAINT FK_���ž��� 
 FOREIGN KEY (���ž���) 
 REFERENCES Ա���� (����)); 
 
--��������Ʋ��ľ������������κβ��� 
INSERT INTO Ա���� VALUES(100,'����','San Zhang','����',20,date'2011-01-01',null);
--�����ǲ���ְԱ
INSERT INTO Ա���� VALUES(101,'����','Li Si','����',20,date'2011-01-01',100);
--���ű�
INSERT INTO ���ű� VALUES(100,'����',100,'��Ʋ�',0); 
--���������ڲ���
UPDATE Ա���� SET ���ű��=100 WHERE ����=100;

COMMIT;



SELECT * FROM Ա���� WHERE ���ű��=100;


DECLARE
  --��PL/SQL�������ж������
  v_EmpNo INT:=102;
  v_ChsName NVARCHAR2(20):='����';
  v_EngName VARCHAR2(20):='Wang wu';
  v_AlsName VARCHAR2(20):='����';
  v_Age INT:=28;
  v_EnrDate DATE:=date'2011-04-01';
  v_DeptNo INT:=100;
BEGIN
  --�ȸ����Ѵ��ڵļ�¼
  UPDATE Ա���� SET ��������=v_ChsName,
                    Ӣ������=v_EngName,
                    ����=v_AlsName,
                    ����=v_Age,
                    ��ְ����=v_EnrDate,
                    ���ű��=v_DeptNo
              WHERE ����=v_EmpNo;
     DBMS_OUTPUT.PUT_LINE('Ա�����³ɹ�');                   
   --�ж����δ��������
   IF SQL%NOTFOUND THEN
     --����Ա�����в���Ա����¼
     INSERT INTO Ա���� 
     VALUES(v_EmpNo,v_ChsName,v_EngName,v_AlsName,
             v_Age,v_EnrDate,v_DeptNo);  
     DBMS_OUTPUT.PUT_LINE('Ա������ɹ�');             
   END IF;  
   --������
   EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('����Ա�������');  
END;      



--������Ļ�����ʾ
SET SERVEROUTPUT ON;
--��ʾ��ǰ������ʱ��
BEGIN
  DBMS_OUTPUT.PUT_LINE('���ڵ�����ʱ�䣺');
  --��ʾ��Ϣ������
  DBMS_OUTPUT.PUT('�����ǣ�');
  --��ʾ��Ϣ������
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'DAY'));
  DBMS_OUTPUT.PUT('����ʱ���ǣ� ');
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));  
END;