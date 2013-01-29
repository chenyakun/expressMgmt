
CREATE OR REPLACE TRIGGER t_verifysalary
   BEFORE UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW             --�м���Ĵ�����
   WHEN(new.sal>old.sal)    --����������
DECLARE
   v_sal   NUMBER;          --�����������
BEGIN
   IF UPDATING ('sal') THEN --ʹ������ν���ж��Ƿ���sal�б�����
      v_sal := :NEW.sal - :OLD.sal; --��¼���ʵĲ���
      DELETE FROM emp_history 
            WHERE empno = :OLD.empno;      --ɾ��emp_history�оɱ��¼
      INSERT INTO emp_history              --����в����µļ�¼
           VALUES (:OLD.empno, :OLD.ename, :OLD.job, :OLD.mgr, :OLD.hiredate,
                   :OLD.sal, :OLD.comm, :OLD.deptno);
      UPDATE emp_history                   --����н��ֵ
         SET sal = v_sal
       WHERE empno = :NEW.empno;
   END IF;
END;


DELETE FROM emp WHERE sal IS NULL;

UPDATE emp SET sal=sal*1.15 WHERE deptno=20;

SELECT * FROM emp WHERE deptno=20;

SELECT * FROM emp_history;

desc emp;

--����һ��emp_log��������¼��emp��ĸ���
CREATE TABLE emp_log(
   log_id NUMBER,              --��־�������ֶ�
   log_action VARCHAR2(100),   --�������Ϊ������������ɾ������� 
   log_date DATE,              --��־����
   empno NUMBER(4),            --Ա�����
   ename VARCHAR2(10),         --Ա������
   job VARCHAR2(18),           --ְ��
   mgr NUMBER(4),              --������
   hiredate DATE,              --��Ӷ���� 
   sal NUMBER(7,2),            --����
   comm NUMBER(7,2),           --��ɻ�ֺ�
   deptno NUMBER(2)            --���ű��
);
--����һ��AFTER�д�����
CREATE OR REPLACE TRIGGER t_emp_log
   AFTER INSERT OR DELETE OR UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW                                --�м���Ĵ�����
BEGIN
   IF INSERTING THEN                           --�ж��Ƿ���INSERT��䴥����
      INSERT INTO emp_log                      --��emp_log���в�����־��¼
      VALUES(
        emp_seq.NEXTVAL,
        'INSERT',SYSDATE,
        :new.empno,:new.ename,:new.job,
        :new.mgr,:new.hiredate,:new.sal,
        :new.comm,:new.deptno );
   ELSIF UPDATING THEN                         --�ж��Ƿ���UPDATE��䴥����
      INSERT INTO emp_log                      --���Ȳ���ɵļ�¼
      VALUES(
        emp_seq.NEXTVAL,
        'UPDATE_NEW',SYSDATE,
        :new.empno,:new.ename,:new.job,
        :new.mgr,:new.hiredate,:new.sal,
        :new.comm,:new.deptno );  
      INSERT INTO emp_log                      --Ȼ������µļ�¼
      VALUES(
        emp_seq.CURRVAL,
        'UPDATE_OLD',SYSDATE,
        :old.empno,:old.ename,:old.job,
        :old.mgr,:old.hiredate,:old.sal,
        :old.comm,:old.deptno );              
   ELSIF DELETING THEN                         --�����ɾ����¼
      INSERT INTO emp_log
      VALUES(
        emp_seq.NEXTVAL,
        'DELETE',SYSDATE,
        :old.empno,:old.ename,:old.job,
        :old.mgr,:old.hiredate,:old.sal,
        :old.comm,:old.deptno );         
   END IF;
END;


UPDATE emp SET sal=sal*1.12 WHERE deptno=10;


SELECT * FROM emp_log;



SELECT * from emp WHERE deptno=10;


/* Formatted on 2011/10/23 15:12 (Formatter Plus v4.8.8) */
/* Formatted on 2011/10/23 15:39 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_verify_emptime
   BEFORE INSERT OR DELETE OR UPDATE
   ON emp
BEGIN
   IF DELETING                     --ʹ��ν���ж��Ƿ�ΪDELETING��������ɾ��ʱ���ж�
   THEN
      --�жϵ�ǰ����������
      IF    (TO_CHAR (SYSDATE, 'DAY') IN ('������', '������'))
         OR (TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:30' AND '18:00')
      THEN
         --�����쳣���������������񱻻ع���
         raise_application_error (-20001, '�����ڷǳ�ʱ����ڲ���emp��');
      END IF;
   END IF;
END;

DROP TABLE audit_table;


CREATE TABLE audit_table(   
   table_name VARCHAR2(20),    --ͳ�Ʊ�����
   ins_count INT,              --INSERT���ִ�д���
   udp_count INT,              --UPDATE���ִ�д���
   del_count INT,              --DELETE���ִ�д���
   start_time DATE,            --��ʼʱ��
   end_time DATE               --����ʱ��
);

/* Formatted on 2011/10/23 16:45 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_audit_emp
   AFTER INSERT OR UPDATE OR DELETE
   ON emp                                --��emp���ж���AFTER������
DECLARE
   v_temp   INT;                         --����һ����ʱ�ı�����ͳ�Ƽ�����
BEGIN
   SELECT COUNT (*)                      --��v_temp���в���EMP��ļ�¼����
     INTO v_temp
     FROM audit_table
    WHERE table_name = 'EMP';
   IF v_temp = 0
   THEN
      --��audit_table���в���һ����¼������Ǽ�¼��������Ϊ0��
      INSERT INTO audit_table  VALUES ('EMP', 0, 0, 0, SYSDATE, NULL);
   END IF;
   CASE                                  --ʹ��PL/SQL��CASE����ж�DML����
      WHEN INSERTING  THEN               --�����INSERT���ִ��
         UPDATE audit_table              --����ins_count�ֶ�
            SET ins_count = ins_count + 1,
                end_time = SYSDATE
          WHERE table_name = 'EMP';
      WHEN UPDATING THEN                 --�����UPDATE���ִ��
         UPDATE audit_table
            SET udp_count = udp_count + 1,--����udp_count�ֶ�
                end_time = SYSDATE
          WHERE table_name = 'EMP';
      WHEN DELETING THEN
         UPDATE audit_table                --�����DELETE���ִ��
            SET del_count = del_count + 1,--����del_count�ֶ�
                end_time = SYSDATE
          WHERE table_name = 'EMP';
   END CASE;
END;


CREATE OR REPLACE TRIGGER t_vsal_ref
   BEFORE UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   REFERENCING OLD AS emp_old NEW AS emp_new
   FOR EACH ROW             --�м���Ĵ�����
   WHEN(emp_new.sal>emp_old.sal)    --����������
DECLARE
   v_sal   NUMBER;          --�����������
BEGIN
   IF UPDATING ('sal') THEN --ʹ������ν���ж��Ƿ���sal�б�����
      v_sal := :emp_new.sal - :emp_old.sal; --��¼���ʵĲ���
      DELETE FROM emp_history 
            WHERE empno = :emp_old.empno;      --ɾ��emp_history�оɱ��¼
      INSERT INTO emp_history              --����в����µļ�¼
           VALUES (:emp_old.empno, :emp_old.ename, :emp_old.job, :emp_old.mgr, :emp_old.hiredate,
                   :emp_old.sal, :emp_old.comm, :emp_old.deptno);
      UPDATE emp_history                   --����н��ֵ
         SET sal = v_sal
       WHERE empno = :emp_new.empno;
   END IF;
END;


CREATE TABLE emp_data         --����Ա����¼���ݵĲ��Ա�
( 
    emp_id INT,               --�������ֶ�
    empno NUMBER,             --Ա�����
    ename VARCHAR2(20)        --Ա������
);
CREATE TABLE emp_data_his    --����Ա����¼���ݵ���ʷ���ݱ�
( 
    emp_id INT,               --�������ֶ�
    empno NUMBER,             --Ա�����
    ename VARCHAR2(20)        --Ա������
);


/* Formatted on 2011/10/23 21:04 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_emp_data
   BEFORE INSERT
   ON emp_data                  --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW                                               --�м���Ĵ�����
DECLARE
   emp_rec   emp_data%ROWTYPE;
 --  emp_rec_his emp_data_his%ROWTYPE;   
BEGIN
   SELECT emp_seq.NEXTVAL INTO :NEW.emp_id FROM DUAL; --��BEFORE��������NEW��ֵ
   --emp_rec:=:new;          --����ֱ�Ӷ�ν�ʼ�¼���м�¼����Ĳ���
   emp_rec.emp_id := :NEW.emp_id;
   emp_rec.empno := :NEW.empno;
   emp_rec.ename := :NEW.ename;
   INSERT INTO emp_data_his VALUES emp_rec;    --ʹ�ü�¼����Ĳ���
END;


INSERT INTO emp_data(empno,ename) VALUES(7369,'��ǿ');

SELECT * FROM emp_data;
SELECT * FROM emp_data_his;


TRUNCATE TABLE emp_data;
TRUNCATE TABLE emp_data_his;



CREATE OR REPLACE TRIGGER t_emp_comm
   BEFORE UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW             --�м���Ĵ�����
   WHEN(NEW.comm>OLD.comm)    --����������
DECLARE
   v_comm   NUMBER;          --�����������
BEGIN
   IF UPDATING ('comm') THEN --ʹ������ν���ж��Ƿ���comm�б�����
      v_comm := :NEW.comm - :OLD.comm; --��¼���ʵĲ���
      DELETE FROM emp_history 
            WHERE empno = :OLD.empno;      --ɾ��emp_history�оɱ��¼
      INSERT INTO emp_history              --����в����µļ�¼
           VALUES (:OLD.empno, :OLD.ename, :OLD.job, :OLD.mgr, :OLD.hiredate,
                   :OLD.sal, :OLD.comm, :OLD.deptno);
      UPDATE emp_history                   --����н��ֵ
         SET comm = v_comm
       WHERE empno = :NEW.empno;
   END IF;
END;


CREATE OR REPLACE TRIGGER t_comm_sal
   BEFORE UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW             --�м���Ĵ�����
BEGIN
   CASE 
   WHEN UPDATING('comm') THEN          --����Ƕ�comm�н��и���     
      IF :NEW.comm<:OLD.comm THEN      --Ҫ���µ�commֵҪ���ھɵ�commֵ
         RAISE_APPLICATION_ERROR(-20001,'�µ�commֵ����С�ھɵ�commֵ');
      END IF;
   WHEN UPDATING('sal') THEN           --����Ƕ�sal�н��и���
      IF :NEW.sal<:OLD.sal THEN        --Ҫ���µ�salֵҪ���ھɵ�salֵ
         RAISE_APPLICATION_ERROR(-20001,'�µ�salֵ����С�ھɵ�salֵ'); 
      END IF;
   END CASE;        
END;





CREATE OR REPLACE TRIGGER t_comm_sal
   BEFORE UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW             --�м���Ĵ�����
BEGIN
   CASE 
   WHEN UPDATING('comm') THEN          --����Ƕ�comm�н��и���     
      IF :NEW.comm<:OLD.comm THEN      --Ҫ���µ�commֵҪ���ھɵ�commֵ
         RAISE_APPLICATION_ERROR(-20001,'�µ�commֵ����С�ھɵ�commֵ');
      END IF;
   WHEN UPDATING('sal') THEN           --����Ƕ�sal�н��и���
      IF :NEW.sal<:OLD.sal THEN        --Ҫ���µ�salֵҪ���ھɵ�salֵ
         RAISE_APPLICATION_ERROR(-20001,'�µ�salֵ����С�ھɵ�salֵ'); 
      END IF;
   END CASE;        
END;

--����һ���������Զ����������ִ��˳��
CREATE TABLE trigger_data
(
   trigger_id  INT,
   tirgger_name VARCHAR2(100)
)
--������һ��������
CREATE OR REPLACE TRIGGER one_trigger
   BEFORE INSERT
   ON trigger_data
   FOR EACH ROW
BEGIN
   :NEW.trigger_id := :NEW.trigger_id + 1;
   DBMS_OUTPUT.put_line('������one_trigger');
END;
--�������1��������������ͬ������ͬ����ʱ���Ĵ�����
CREATE OR REPLACE TRIGGER two_trigger
   BEFORE INSERT
   ON trigger_data
   FOR EACH ROW
   FOLLOWS one_trigger          --�øô�������one_trigger���津��
BEGIN
   DBMS_OUTPUT.put_line('������two_trigger');
   IF :NEW.trigger_id > 1
   THEN
      :NEW.trigger_id := :NEW.trigger_id + 2;
   END IF;
END;


INSERT INTO trigger_data VALUES(1,'triggerdemo');

TRUNCATE TABLE trigger_data;

SELECT * FROM trigger_data;

/* Formatted on 2011/10/24 06:34 (Formatter Plus v4.8.8) */
SELECT referenced_name, referenced_type, dependency_type
  FROM user_dependencies
 WHERE NAME = 'TWO_TRIGGER' AND referenced_type = 'TRIGGER';
 
 
/* Formatted on 2011/10/24 06:57 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_emp_maxsal
   BEFORE UPDATE OF sal
   ON emp                       --��UPDATE������salֵ֮ǰ����
   FOR EACH ROW                 --�м���Ĵ�����
DECLARE
   v_maxsal   NUMBER;           --�������н��ֵ�ı���
BEGIN
   SELECT MAX (sal)            
     INTO v_maxsal
     FROM emp;                  --��ȡemp�����н��ֵ
   UPDATE emp
      SET sal = v_maxsal - 100  --����Ա��7369��н��ֵ
    WHERE empno = 7369;
END;


UPDATE emp SET sal=sal*1.12 WHERE deptno=20;



CREATE OR REPLACE TRIGGER t_emp_comm
   BEFORE UPDATE ON emp     --���������õı�����Լ������������ʹ����Ķ���
   FOR EACH ROW             --�м���Ĵ�����
   WHEN(NEW.comm>OLD.comm)    --����������
DECLARE   
   v_comm   NUMBER;          --�����������
   PRAGMA AUTONOMOUS_TRANSACTION; --��������      
BEGIN
   IF UPDATING ('comm') THEN --ʹ������ν���ж��Ƿ���comm�б�����
      v_comm := :NEW.comm - :OLD.comm; --��¼���ʵĲ���
      DELETE FROM emp_history 
            WHERE empno = :OLD.empno;      --ɾ��emp_history�оɱ��¼
      INSERT INTO emp_history              --����в����µļ�¼
           VALUES (:OLD.empno, :OLD.ename, :OLD.job, :OLD.mgr, :OLD.hiredate,
                   :OLD.sal, :OLD.comm, :OLD.deptno);
      UPDATE emp_history                   --����н��ֵ
         SET comm = v_comm
       WHERE empno = :NEW.empno;
   END IF;
   COMMIT;                                 --�ύ������������
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;                            --�����κ�����ع���������
END;


SELECT * FROM emp WHERE deptno=20;


--������ͼemp_dept��ͼ
CREATE OR REPLACE VIEW scott.emp_dept (empno,
                                       ename,
                                       job,
                                       mgr,
                                       hiredate,
                                       sal,
                                       comm,
                                       deptno,
                                       dname,
                                       loc
                                      )
AS
   SELECT emp.empno, emp.ename, emp.job, emp.mgr, emp.hiredate, emp.sal,
          emp.comm, emp.deptno, dept.dname, dept.loc
     FROM dept, emp
    WHERE ((dept.deptno = emp.deptno));
    
    
    
/* Formatted on 2011/10/25 06:43 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_dept_emp
   INSTEAD OF INSERT ON emp_dept      --����ͼemp_dept�ϴ���INSTEAD OF������
   REFERENCING NEW AS n               --ָ��ν�ʱ���
   FOR EACH ROW                       --�м�������
DECLARE
   v_counter   INT;                   --������ͳ�Ʊ���
BEGIN
   SELECT COUNT (*)
     INTO v_counter
     FROM dept
    WHERE deptno = :n.deptno;         --�ж���dept�����Ƿ������Ӧ�ļ�¼   
   IF v_counter = 0                   --��������ڸ�dept��¼
   THEN
      INSERT INTO dept VALUES (:n.deptno, :n.dname, :n.loc);   --��dept���в����µĲ��ż�¼
   END IF;
   SELECT COUNT (*)                   --�ж�emp�����Ƿ����Ա����¼
     INTO v_counter
     FROM emp
    WHERE empno = :n.empno;
   IF v_counter = 0                   --��������ڣ�����emp���в���Ա����¼
   THEN
      INSERT INTO emp
                  (empno, ename, job, mgr, hiredate, sal,
                   comm, deptno
                  )
           VALUES (:n.empno, :n.ename, :n.job, :n.mgr, :n.hiredate, :n.sal,
                   :n.comm, :n.deptno
                  );
   END IF;
END;


SELECT * FROM dept;

SELECT * FROM emp_dept;



/* Formatted on 2011/10/25 07:09 (Formatter Plus v4.8.8) */
INSERT INTO emp_dept
            (empno, ename, job, mgr, hiredate, sal, comm, deptno,
             dname, loc
            )
     VALUES (8000, '��̫��', '��ְ', NULL, TRUNC (SYSDATE), 5000, 300, 80,
             '����', '��ɽ'
            );
            
            
            
CREATE OR REPLACE TRIGGER t_dept_emp_update
   INSTEAD OF UPDATE ON emp_dept      --����ͼemp_dept�ϴ���INSTEAD OF������
   REFERENCING NEW AS n OLD AS o      --ָ��ν�ʱ���
   FOR EACH ROW                       --�м�������
DECLARE
   v_counter   INT;                   --������ͳ�Ʊ���
BEGIN
   SELECT COUNT (*)
     INTO v_counter
     FROM dept
    WHERE deptno = :o.deptno;           --�ж���dept�����Ƿ������Ӧ�ļ�¼   
   IF v_counter >0                      --������ڣ������dept��
   THEN
      UPDATE dept SET dname=:n.dname,loc=:n.loc WHERE deptno=:o.deptno;
   END IF;
   SELECT COUNT (*)                    --�ж�emp�����Ƿ����Ա����¼
     INTO v_counter
     FROM emp
    WHERE empno = :n.empno;
   IF v_counter > 0                    --������ڣ������emp��
   THEN
      UPDATE emp SET ename=:n.ename,job=:n.job,mgr=:n.mgr, hiredate=:n.hiredate,sal=:n.sal,
                   comm=:n.comm, deptno=:n.deptno WHERE empno=:o.empno;        
   END IF;
END;            



CREATE OR REPLACE TRIGGER t_dept_emp_delete
   INSTEAD OF DELETE ON emp_dept       --����ͼemp_dept�ϴ���INSTEAD OF������
   REFERENCING  OLD AS o               --ָ��ν�ʱ���
   FOR EACH ROW                        --�м�������
BEGIN
   DELETE FROM emp WHERE empno=:o.empno;        --ɾ��emp��
   DELETE FROM dept WHERE deptno=:o.deptno;     --ɾ��dept��
END;   



SELECT * FROM emp_dept WHERE empno=8000;

DELETE FROM emp_dept WHERE empno=8000;



CREATE OR REPLACE TRIGGER t_emp_dept
   INSTEAD OF UPDATE OR INSERT OR DELETE ON emp_dept   
   REFERENCING NEW AS n OLD AS o      --ָ��ν�ʱ���
   FOR EACH ROW                       --�м�������
DECLARE
   v_counter   INT;                   --������ͳ�Ʊ���
BEGIN
   SELECT COUNT (*)
     INTO v_counter
     FROM dept
    WHERE deptno = :o.deptno;           --�ж���dept�����Ƿ������Ӧ�ļ�¼   
   IF v_counter >0                      --������ڣ������dept��
   THEN
      CASE 
      WHEN UPDATING THEN
         UPDATE dept SET dname=:n.dname,loc=:n.loc WHERE deptno=:o.deptno;
      WHEN INSERTING THEN
         INSERT INTO dept VALUES (:n.deptno, :n.dname, :n.loc); 
      WHEN DELETING THEN
         DELETE FROM dept WHERE deptno=:o.deptno;     --ɾ��dept��      
      END CASE;
   END IF;
   SELECT COUNT (*)                    --�ж�emp�����Ƿ����Ա����¼
     INTO v_counter
     FROM emp
    WHERE empno = :n.empno;
   IF v_counter > 0                    --������ڣ������emp��
   THEN
      CASE 
      WHEN UPDATING THEN
         UPDATE emp SET ename=:n.ename,job=:n.job,mgr=:n.mgr, hiredate=:n.hiredate,sal=:n.sal,
                   comm=:n.comm, deptno=:n.deptno WHERE empno=:o.empno;    
      WHEN INSERTING THEN
         INSERT INTO emp
                  (empno, ename, job, mgr, hiredate, sal,
                   comm, deptno
                  )
           VALUES (:n.empno, :n.ename, :n.job, :n.mgr, :n.hiredate, :n.sal,
                   :n.comm, :n.deptno
                  );
      WHEN DELETING THEN
         DELETE FROM emp WHERE empno=:o.empno;   
      END CASE;       
   END IF;
END;            


SELECT * FROM emp;

--��������Ƕ�ױ�Ķ�������
CREATE OR REPLACE TYPE emp_obj AS OBJECT(
   empno NUMBER(4),
   ename VARCHAR2(10),
   job VARCHAR2(10),
   mgr NUMBER(4),
   hiredate DATE,
   sal NUMBER(7,2),
   comm NUMBER(7,2),
   deptno NUMBER(2)
);
--����Ƕ�ױ�����
CREATE OR REPLACE TYPE emp_tab_type AS TABLE OF emp_obj;
--����Ƕ�ױ���ͼ��MULTISET������CASTһ��ʹ��
CREATE OR REPLACE VIEW dept_emp_view AS
   SELECT deptno,dname,loc,
   CAST(MULTISET(SELECT * FROM emp WHERE deptno=dept.deptno) AS emp_tab_type) emplst
   FROM dept;
   
SELECT * FROM dept_emp_view  where deptno=10;




/* Formatted on 2011/10/26 06:35 (Formatter Plus v4.8.8) */
INSERT INTO TABLE (SELECT emplst
                     FROM dept_emp_view
                    WHERE deptno = 10)
     VALUES (8003, '��ү', '����', NULL, SYSDATE, 5000, 500, 10);
     
     
/* Formatted on 2011/10/26 06:50 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER dept_emp_innerview
   INSTEAD OF INSERT
   ON NESTED TABLE emplst OF dept_emp_view                       --����Ƕ�ױ����������
BEGIN
   INSERT INTO emp                                             --�����ӱ��¼
               (deptno, empno, ename, job, mgr,
                hiredate, sal, comm
               )
        VALUES (:PARENT.deptno, :NEW.empno, :NEW.ename, :NEW.job, :NEW.mgr,
                :NEW.hiredate, :NEW.sal, :NEW.comm
               );
END;

DROP TABLE created_log
CREATE TABLE created_log
(
    obj_owner VARCHAR2(30),   --������
    obj_name  VARCHAR2(30),   --��������
    obj_type  VARCHAR2(20),   --��������
    obj_user VARCHAR2(30),    --�����û�
    created_date DATE     --��������
)

/* Formatted on 2011/10/26 07:55 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_created_log
   AFTER CREATE ON scott.SCHEMA                  --��soctt�����´�������󴥷�
BEGIN
   --������־��¼
   INSERT INTO scott.created_log(obj_owner, obj_name,
                obj_type, obj_user, created_date
               )
        VALUES (SYS.dictionary_obj_owner, SYS.dictionary_obj_name,
                SYS.dictionary_obj_type, SYS.login_user, SYSDATE
               );
END;



DROP TRIGGER t_created_log;


--��DBA��ݵ�¼����������ĵ�¼��¼��
CREATE TABLE log_db_table
(
   username VARCHAR2(20),
   logon_time DATE,
   logoff_time DATE,
   address VARCHAR2(20) 
);
--��soctt��ݵ�¼����������ĵ�¼��¼��
CREATE TABLE log_user_table
(
   username VARCHAR2(20),
   logon_time DATE,
   logoff_time DATE,
   address VARCHAR2(20) 
);
--��DBA��ݵ�¼������DATABASE�����LOGON�¼�������
CREATE OR REPLACE TRIGGER t_db_logon
AFTER LOGON ON DATABASE
BEGIN
  INSERT INTO log_db_table(username,logon_time,address)
              VALUES(ora_login_user,SYSDATE,ora_client_ip_address);
END;
--��scott��ݵ�¼���������µ�SCHEMA�����LOGON�¼�������
CREATE OR REPLACE TRIGGER t_user_logon
AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO log_user_table(username,logon_time,address)
              VALUES(ora_login_user,SYSDATE,ora_client_ip_address);
END;


--��DBA��ݽ���ϵͳ��������ʱ��
CREATE TABLE event_table(
   sys_event VARCHAR2(30),
   event_time DATE
);
--��DBA���𴴽����µ�2��������
CREATE OR REPLACE TRIGGER t_startup
AFTER STARTUP ON DATABASE       --STARTUPֻ����AFTER
BEGIN
   INSERT INTO event_table VALUES(ora_sysevent,SYSDATE);
END;
/
CREATE OR REPLACE TRIGGER t_startup
BEFORE SHUTDOWN ON DATABASE       --SHUTDOWNֻ����BEFORE
BEGIN
   INSERT INTO event_table VALUES(ora_sysevent,SYSDATE);
END;
/

CREATE OR REPLACE TRIGGER preserve_app_cols
   AFTER ALTER ON SCHEMA
DECLARE
   --��ȡһ�����������е��α�
   CURSOR curs_get_columns (cp_owner VARCHAR2, cp_table VARCHAR2)
   IS
      SELECT column_name
        FROM all_tab_columns
       WHERE owner = cp_owner AND table_name = cp_table;
BEGIN
   -- �����ʹ�õ���ALTER TABLE����޸ı�
   IF ora_dict_obj_type = 'TABLE'
   THEN
      -- ѭ�����е�ÿһ��
      FOR v_column_rec IN curs_get_columns (
                             ora_dict_obj_owner,
                             ora_dict_obj_name
                          )
      LOOP
         --�жϵ�ǰ���������ڱ��޸�
         IF ORA_IS_ALTER_COLUMN (v_column_rec.column_name)
         THEN
            IF v_column_rec.column_name='EMPNO' THEN
               RAISE_APPLICATION_ERROR (
                  -20003,
                  '���ܶ�empno�ֶν����޸�'
               );
            END IF; 
         END IF; 
      END LOOP;
   END IF;
END;

/* Formatted on 2011/10/27 07:33 (Formatter Plus v4.8.8) */
ALTER TABLE scott.emp MODIFY(empno NUMBER(8))


--������־��¼��
CREATE TABLE servererror_log(
   error_time DATE,
   username  VARCHAR2(30),
   instance NUMBER,
   db_name VARCHAR2(50),
   error_stack VARCHAR2(2000)
);
--�������󴥷������ڳ������ݿ����ʱ������
CREATE OR REPLACE TRIGGER t_logerrors
   AFTER SERVERERROR ON DATABASE
BEGIN
   INSERT INTO servererror_log
        VALUES (SYSDATE, login_user, instance_num, database_name,
                DBMS_UTILITY.format_error_stack);
END;



select privilege from dba_sys_privs where grantee='SCOTT'  
