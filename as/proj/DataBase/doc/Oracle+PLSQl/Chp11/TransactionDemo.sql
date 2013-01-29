DECLARE
   dept_no   NUMBER (2) := 70;
BEGIN
   --��ʼ����
   INSERT INTO dept 
        VALUES (dept_no, '�г���', '����');               --���벿�ż�¼
   INSERT INTO emp                                        --����Ա����¼
        VALUES (7997, '����', '������Ա', NULL, TRUNC (SYSDATE), 5000,300, dept_no);
   --�ύ����
   COMMIT;
END;


DELETE FROM emp WHERE deptno=70;
DELETE FROM dept WHERE deptno=70;
COMMIT;

DECLARE
   dept_no   NUMBER (2) := 70;
BEGIN
   --��ʼ����
   INSERT INTO dept 
        VALUES (dept_no, '�г���', '����');               --���벿�ż�¼
   INSERT INTO dept 
        VALUES (dept_no, '���ڲ�', '�Ϻ�');               --������ͬ��ŵĲ��ż�¼        
   INSERT INTO emp                                        --����Ա����¼
        VALUES (7997, '����', '������Ա', NULL, TRUNC (SYSDATE), 5000,300, dept_no);
   --�ύ����
   COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN                            --�����쳣
     DBMS_OUTPUT.PUT_LINE(SQLERRM);                   --��ʾ�쳣��Ϣ
     ROLLBACK;                                           --�ع��쳣
END;


DECLARE
   dept_no   NUMBER (2) := 70;
BEGIN
   --��ʼ����
   INSERT INTO dept 
        VALUES (dept_no, '�г���', '����');               --���벿�ż�¼
   INSERT INTO dept 
        VALUES (dept_no, '���ڲ�', '�Ϻ�');               --������ͬ��ŵĲ��ż�¼        
   INSERT INTO emp                                        --����Ա����¼
        VALUES (7997, '����', '������Ա', NULL, TRUNC (SYSDATE), 5000,300, dept_no);
   --�ύ����
   COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN                            --�����쳣
     DBMS_OUTPUT.PUT_LINE(SQLERRM);                   --��ʾ�쳣��Ϣ
     ROLLBACK;                                           --�ع��쳣
END;


DECLARE
   dept_no   NUMBER (2) :=90;
BEGIN
   --��ʼ����
   SAVEPOINT A;
   INSERT INTO dept 
        VALUES (dept_no, '�г���', '����');               --���벿�ż�¼
   SAVEPOINT B;   
   INSERT INTO emp                                        --����Ա����¼
        VALUES (7997, '����', '������Ա', NULL, TRUNC (SYSDATE), 5000,300, dept_no);        
   SAVEPOINT C;                
   INSERT INTO dept 
        VALUES (dept_no, '���ڲ�', '�Ϻ�');               --������ͬ��ŵĲ��ż�¼
   --�ύ����
   COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN                            --�����쳣
     DBMS_OUTPUT.PUT_LINE(SQLERRM);                   --��ʾ�쳣��Ϣ
     ROLLBACK TO B;                                      --�ع��쳣
END;


SELECT * FROM dept;

DELETE FROM dept WHERE deptno=80;
COMMIT;



DECLARE
   v_1981 NUMBER(2);
   v_1982 NUMBER(2);
   v_1983 NUMBER(2);
BEGIN
   --SET TRANSACTION����������ĵ�1����䣬��˿�����COMMIT��ROLLBACK���档
   COMMIT;
   SET TRANSACTION READ ONLY NAME 'ͳ�������ְ����';     --ʹ��NAMEΪ��������
   --ʹ��SELECT���ִ�в�ѯ
   SELECT COUNT(empno) INTO v_1981 FROM emp WHERE TO_CHAR(hiredate,'YYYY')='1981';
   SELECT COUNT(empno) INTO v_1982 FROM emp WHERE TO_CHAR(hiredate,'YYYY')='1982';
   SELECT COUNT(empno) INTO v_1983 FROM emp WHERE TO_CHAR(hiredate,'YYYY')='1983';  
   COMMIT;  --��ֹֻ������
   DBMS_OUTPUT.PUT_LINE('1981����ְ������'||v_1981);   --��ʾͳ�ƵĽ��
   DBMS_OUTPUT.PUT_LINE('1982����ְ������'||v_1982);
   DBMS_OUTPUT.PUT_LINE('1983����ְ������'||v_1983);              
END;   


SELECT * FROM emp WHERE deptno=10 FOR UPDATE;
COMMIT;

SELECT * FROM emp WHERE deptno=10 FOR UPDATE NOWAIT;
COMMIT;