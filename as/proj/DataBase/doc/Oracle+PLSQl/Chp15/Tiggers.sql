
CREATE OR REPLACE TRIGGER t_verifysalary
   BEFORE UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW             --行级别的触发器
   WHEN(new.sal>old.sal)    --触发器条件
DECLARE
   v_sal   NUMBER;          --语句块的声明区
BEGIN
   IF UPDATING ('sal') THEN --使用条件谓词判断是否是sal列被更新
      v_sal := :NEW.sal - :OLD.sal; --记录工资的差异
      DELETE FROM emp_history 
            WHERE empno = :OLD.empno;      --删除emp_history中旧表记录
      INSERT INTO emp_history              --向表中插入新的记录
           VALUES (:OLD.empno, :OLD.ename, :OLD.job, :OLD.mgr, :OLD.hiredate,
                   :OLD.sal, :OLD.comm, :OLD.deptno);
      UPDATE emp_history                   --更新薪资值
         SET sal = v_sal
       WHERE empno = :NEW.empno;
   END IF;
END;


DELETE FROM emp WHERE sal IS NULL;

UPDATE emp SET sal=sal*1.15 WHERE deptno=20;

SELECT * FROM emp WHERE deptno=20;

SELECT * FROM emp_history;

desc emp;

--创建一个emp_log表用来记录对emp表的更改
CREATE TABLE emp_log(
   log_id NUMBER,              --日志自增长字段
   log_action VARCHAR2(100),   --表更改行为，比如新增或删除或更改 
   log_date DATE,              --日志日期
   empno NUMBER(4),            --员工编号
   ename VARCHAR2(10),         --员工名称
   job VARCHAR2(18),           --职别
   mgr NUMBER(4),              --管理者
   hiredate DATE,              --雇佣日期 
   sal NUMBER(7,2),            --工资
   comm NUMBER(7,2),           --提成或分红
   deptno NUMBER(2)            --部门编号
);
--创建一个AFTER行触发器
CREATE OR REPLACE TRIGGER t_emp_log
   AFTER INSERT OR DELETE OR UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW                                --行级别的触发器
BEGIN
   IF INSERTING THEN                           --判断是否是INSERT语句触发的
      INSERT INTO emp_log                      --向emp_log表中插入日志记录
      VALUES(
        emp_seq.NEXTVAL,
        'INSERT',SYSDATE,
        :new.empno,:new.ename,:new.job,
        :new.mgr,:new.hiredate,:new.sal,
        :new.comm,:new.deptno );
   ELSIF UPDATING THEN                         --判断是否是UPDATE语句触发的
      INSERT INTO emp_log                      --首先插入旧的记录
      VALUES(
        emp_seq.NEXTVAL,
        'UPDATE_NEW',SYSDATE,
        :new.empno,:new.ename,:new.job,
        :new.mgr,:new.hiredate,:new.sal,
        :new.comm,:new.deptno );  
      INSERT INTO emp_log                      --然后插入新的记录
      VALUES(
        emp_seq.CURRVAL,
        'UPDATE_OLD',SYSDATE,
        :old.empno,:old.ename,:old.job,
        :old.mgr,:old.hiredate,:old.sal,
        :old.comm,:old.deptno );              
   ELSIF DELETING THEN                         --如果是删除记录
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
   IF DELETING                     --使用谓词判断是否为DELETING操作，仅删除时才判断
   THEN
      --判断当前操作的日期
      IF    (TO_CHAR (SYSDATE, 'DAY') IN ('星期六', '星期日'))
         OR (TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:30' AND '18:00')
      THEN
         --触发异常，将导致整个事务被回滚。
         raise_application_error (-20001, '不能在非常时间段内操纵emp表');
      END IF;
   END IF;
END;

DROP TABLE audit_table;


CREATE TABLE audit_table(   
   table_name VARCHAR2(20),    --统计表名称
   ins_count INT,              --INSERT语句执行次数
   udp_count INT,              --UPDATE语句执行次数
   del_count INT,              --DELETE语句执行次数
   start_time DATE,            --开始时间
   end_time DATE               --结束时间
);

/* Formatted on 2011/10/23 16:45 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_audit_emp
   AFTER INSERT OR UPDATE OR DELETE
   ON emp                                --在emp表中定义AFTER触发器
DECLARE
   v_temp   INT;                         --定义一个临时的变量来统计记条数
BEGIN
   SELECT COUNT (*)                      --向v_temp表中插入EMP表的记录条数
     INTO v_temp
     FROM audit_table
    WHERE table_name = 'EMP';
   IF v_temp = 0
   THEN
      --向audit_table表中插入一条记录，将审记记录数量保留为0。
      INSERT INTO audit_table  VALUES ('EMP', 0, 0, 0, SYSDATE, NULL);
   END IF;
   CASE                                  --使用PL/SQL的CASE语句判断DML类型
      WHEN INSERTING  THEN               --如果是INSERT语句执行
         UPDATE audit_table              --更新ins_count字段
            SET ins_count = ins_count + 1,
                end_time = SYSDATE
          WHERE table_name = 'EMP';
      WHEN UPDATING THEN                 --如果是UPDATE语句执行
         UPDATE audit_table
            SET udp_count = udp_count + 1,--更新udp_count字段
                end_time = SYSDATE
          WHERE table_name = 'EMP';
      WHEN DELETING THEN
         UPDATE audit_table                --如果是DELETE语句执行
            SET del_count = del_count + 1,--更新del_count字段
                end_time = SYSDATE
          WHERE table_name = 'EMP';
   END CASE;
END;


CREATE OR REPLACE TRIGGER t_vsal_ref
   BEFORE UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   REFERENCING OLD AS emp_old NEW AS emp_new
   FOR EACH ROW             --行级别的触发器
   WHEN(emp_new.sal>emp_old.sal)    --触发器条件
DECLARE
   v_sal   NUMBER;          --语句块的声明区
BEGIN
   IF UPDATING ('sal') THEN --使用条件谓词判断是否是sal列被更新
      v_sal := :emp_new.sal - :emp_old.sal; --记录工资的差异
      DELETE FROM emp_history 
            WHERE empno = :emp_old.empno;      --删除emp_history中旧表记录
      INSERT INTO emp_history              --向表中插入新的记录
           VALUES (:emp_old.empno, :emp_old.ename, :emp_old.job, :emp_old.mgr, :emp_old.hiredate,
                   :emp_old.sal, :emp_old.comm, :emp_old.deptno);
      UPDATE emp_history                   --更新薪资值
         SET sal = v_sal
       WHERE empno = :emp_new.empno;
   END IF;
END;


CREATE TABLE emp_data         --保存员工记录数据的测试表
( 
    emp_id INT,               --自增长字段
    empno NUMBER,             --员工编号
    ename VARCHAR2(20)        --员工名称
);
CREATE TABLE emp_data_his    --保存员工记录数据的历史备份表
( 
    emp_id INT,               --自增长字段
    empno NUMBER,             --员工编号
    ename VARCHAR2(20)        --员工名称
);


/* Formatted on 2011/10/23 21:04 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_emp_data
   BEFORE INSERT
   ON emp_data                  --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW                                               --行级别的触发器
DECLARE
   emp_rec   emp_data%ROWTYPE;
 --  emp_rec_his emp_data_his%ROWTYPE;   
BEGIN
   SELECT emp_seq.NEXTVAL INTO :NEW.emp_id FROM DUAL; --对BEFORE触发器的NEW赋值
   --emp_rec:=:new;          --不能直接对谓词记录进行记录级别的操作
   emp_rec.emp_id := :NEW.emp_id;
   emp_rec.empno := :NEW.empno;
   emp_rec.ename := :NEW.ename;
   INSERT INTO emp_data_his VALUES emp_rec;    --使用记录级别的操作
END;


INSERT INTO emp_data(empno,ename) VALUES(7369,'李强');

SELECT * FROM emp_data;
SELECT * FROM emp_data_his;


TRUNCATE TABLE emp_data;
TRUNCATE TABLE emp_data_his;



CREATE OR REPLACE TRIGGER t_emp_comm
   BEFORE UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW             --行级别的触发器
   WHEN(NEW.comm>OLD.comm)    --触发器条件
DECLARE
   v_comm   NUMBER;          --语句块的声明区
BEGIN
   IF UPDATING ('comm') THEN --使用条件谓词判断是否是comm列被更新
      v_comm := :NEW.comm - :OLD.comm; --记录工资的差异
      DELETE FROM emp_history 
            WHERE empno = :OLD.empno;      --删除emp_history中旧表记录
      INSERT INTO emp_history              --向表中插入新的记录
           VALUES (:OLD.empno, :OLD.ename, :OLD.job, :OLD.mgr, :OLD.hiredate,
                   :OLD.sal, :OLD.comm, :OLD.deptno);
      UPDATE emp_history                   --更新薪资值
         SET comm = v_comm
       WHERE empno = :NEW.empno;
   END IF;
END;


CREATE OR REPLACE TRIGGER t_comm_sal
   BEFORE UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW             --行级别的触发器
BEGIN
   CASE 
   WHEN UPDATING('comm') THEN          --如果是对comm列进行更新     
      IF :NEW.comm<:OLD.comm THEN      --要求新的comm值要大于旧的comm值
         RAISE_APPLICATION_ERROR(-20001,'新的comm值不能小于旧的comm值');
      END IF;
   WHEN UPDATING('sal') THEN           --如果是对sal列进行更新
      IF :NEW.sal<:OLD.sal THEN        --要求新的sal值要大于旧的sal值
         RAISE_APPLICATION_ERROR(-20001,'新的sal值不能小于旧的sal值'); 
      END IF;
   END CASE;        
END;





CREATE OR REPLACE TRIGGER t_comm_sal
   BEFORE UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW             --行级别的触发器
BEGIN
   CASE 
   WHEN UPDATING('comm') THEN          --如果是对comm列进行更新     
      IF :NEW.comm<:OLD.comm THEN      --要求新的comm值要大于旧的comm值
         RAISE_APPLICATION_ERROR(-20001,'新的comm值不能小于旧的comm值');
      END IF;
   WHEN UPDATING('sal') THEN           --如果是对sal列进行更新
      IF :NEW.sal<:OLD.sal THEN        --要求新的sal值要大于旧的sal值
         RAISE_APPLICATION_ERROR(-20001,'新的sal值不能小于旧的sal值'); 
      END IF;
   END CASE;        
END;

--创建一个表来测试多个触发器的执行顺序
CREATE TABLE trigger_data
(
   trigger_id  INT,
   tirgger_name VARCHAR2(100)
)
--创建第一个触发器
CREATE OR REPLACE TRIGGER one_trigger
   BEFORE INSERT
   ON trigger_data
   FOR EACH ROW
BEGIN
   :NEW.trigger_id := :NEW.trigger_id + 1;
   DBMS_OUTPUT.put_line('触发了one_trigger');
END;
--创建与第1个触发器具有相同类型相同触发时机的触发器
CREATE OR REPLACE TRIGGER two_trigger
   BEFORE INSERT
   ON trigger_data
   FOR EACH ROW
   FOLLOWS one_trigger          --让该触发器在one_trigger后面触发
BEGIN
   DBMS_OUTPUT.put_line('触发了two_trigger');
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
   ON emp                       --在UPDATE语句更新sal值之前触发
   FOR EACH ROW                 --行级别的触发器
DECLARE
   v_maxsal   NUMBER;           --保存最大薪资值的变量
BEGIN
   SELECT MAX (sal)            
     INTO v_maxsal
     FROM emp;                  --获取emp表最大薪资值
   UPDATE emp
      SET sal = v_maxsal - 100  --更新员工7369的薪资值
    WHERE empno = 7369;
END;


UPDATE emp SET sal=sal*1.12 WHERE deptno=20;



CREATE OR REPLACE TRIGGER t_emp_comm
   BEFORE UPDATE ON emp     --触发器作用的表对象以及触发的条件和触发的动作
   FOR EACH ROW             --行级别的触发器
   WHEN(NEW.comm>OLD.comm)    --触发器条件
DECLARE   
   v_comm   NUMBER;          --语句块的声明区
   PRAGMA AUTONOMOUS_TRANSACTION; --自治事务      
BEGIN
   IF UPDATING ('comm') THEN --使用条件谓词判断是否是comm列被更新
      v_comm := :NEW.comm - :OLD.comm; --记录工资的差异
      DELETE FROM emp_history 
            WHERE empno = :OLD.empno;      --删除emp_history中旧表记录
      INSERT INTO emp_history              --向表中插入新的记录
           VALUES (:OLD.empno, :OLD.ename, :OLD.job, :OLD.mgr, :OLD.hiredate,
                   :OLD.sal, :OLD.comm, :OLD.deptno);
      UPDATE emp_history                   --更新薪资值
         SET comm = v_comm
       WHERE empno = :NEW.empno;
   END IF;
   COMMIT;                                 --提交结束自治事务
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;                            --发生任何异外回滚自治事务
END;


SELECT * FROM emp WHERE deptno=20;


--创建视图emp_dept视图
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
   INSTEAD OF INSERT ON emp_dept      --在视图emp_dept上创建INSTEAD OF触发器
   REFERENCING NEW AS n               --指定谓词别名
   FOR EACH ROW                       --行级触发器
DECLARE
   v_counter   INT;                   --计数器统计变量
BEGIN
   SELECT COUNT (*)
     INTO v_counter
     FROM dept
    WHERE deptno = :n.deptno;         --判断在dept表中是否存在相应的记录   
   IF v_counter = 0                   --如果不存在该dept记录
   THEN
      INSERT INTO dept VALUES (:n.deptno, :n.dname, :n.loc);   --向dept表中插入新的部门记录
   END IF;
   SELECT COUNT (*)                   --判断emp表中是否存在员工记录
     INTO v_counter
     FROM emp
    WHERE empno = :n.empno;
   IF v_counter = 0                   --如果不存在，则向emp表中插入员工记录
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
     VALUES (8000, '龙太郎', '神职', NULL, TRUNC (SYSDATE), 5000, 300, 80,
             '神庙', '龙山'
            );
            
            
            
CREATE OR REPLACE TRIGGER t_dept_emp_update
   INSTEAD OF UPDATE ON emp_dept      --在视图emp_dept上创建INSTEAD OF触发器
   REFERENCING NEW AS n OLD AS o      --指定谓词别名
   FOR EACH ROW                       --行级触发器
DECLARE
   v_counter   INT;                   --计数器统计变量
BEGIN
   SELECT COUNT (*)
     INTO v_counter
     FROM dept
    WHERE deptno = :o.deptno;           --判断在dept表中是否存在相应的记录   
   IF v_counter >0                      --如果存在，则更新dept表
   THEN
      UPDATE dept SET dname=:n.dname,loc=:n.loc WHERE deptno=:o.deptno;
   END IF;
   SELECT COUNT (*)                    --判断emp表中是否存在员工记录
     INTO v_counter
     FROM emp
    WHERE empno = :n.empno;
   IF v_counter > 0                    --如果存在，则更新emp表
   THEN
      UPDATE emp SET ename=:n.ename,job=:n.job,mgr=:n.mgr, hiredate=:n.hiredate,sal=:n.sal,
                   comm=:n.comm, deptno=:n.deptno WHERE empno=:o.empno;        
   END IF;
END;            



CREATE OR REPLACE TRIGGER t_dept_emp_delete
   INSTEAD OF DELETE ON emp_dept       --在视图emp_dept上创建INSTEAD OF触发器
   REFERENCING  OLD AS o               --指定谓词别名
   FOR EACH ROW                        --行级触发器
BEGIN
   DELETE FROM emp WHERE empno=:o.empno;        --删除emp表
   DELETE FROM dept WHERE deptno=:o.deptno;     --删除dept表
END;   



SELECT * FROM emp_dept WHERE empno=8000;

DELETE FROM emp_dept WHERE empno=8000;



CREATE OR REPLACE TRIGGER t_emp_dept
   INSTEAD OF UPDATE OR INSERT OR DELETE ON emp_dept   
   REFERENCING NEW AS n OLD AS o      --指定谓词别名
   FOR EACH ROW                       --行级触发器
DECLARE
   v_counter   INT;                   --计数器统计变量
BEGIN
   SELECT COUNT (*)
     INTO v_counter
     FROM dept
    WHERE deptno = :o.deptno;           --判断在dept表中是否存在相应的记录   
   IF v_counter >0                      --如果存在，则更新dept表
   THEN
      CASE 
      WHEN UPDATING THEN
         UPDATE dept SET dname=:n.dname,loc=:n.loc WHERE deptno=:o.deptno;
      WHEN INSERTING THEN
         INSERT INTO dept VALUES (:n.deptno, :n.dname, :n.loc); 
      WHEN DELETING THEN
         DELETE FROM dept WHERE deptno=:o.deptno;     --删除dept表      
      END CASE;
   END IF;
   SELECT COUNT (*)                    --判断emp表中是否存在员工记录
     INTO v_counter
     FROM emp
    WHERE empno = :n.empno;
   IF v_counter > 0                    --如果存在，则更新emp表
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

--创建用于嵌套表的对象类型
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
--创建嵌套表类型
CREATE OR REPLACE TYPE emp_tab_type AS TABLE OF emp_obj;
--创建嵌套表视图，MULTISET必须与CAST一起使用
CREATE OR REPLACE VIEW dept_emp_view AS
   SELECT deptno,dname,loc,
   CAST(MULTISET(SELECT * FROM emp WHERE deptno=dept.deptno) AS emp_tab_type) emplst
   FROM dept;
   
SELECT * FROM dept_emp_view  where deptno=10;




/* Formatted on 2011/10/26 06:35 (Formatter Plus v4.8.8) */
INSERT INTO TABLE (SELECT emplst
                     FROM dept_emp_view
                    WHERE deptno = 10)
     VALUES (8003, '四爷', '皇上', NULL, SYSDATE, 5000, 500, 10);
     
     
/* Formatted on 2011/10/26 06:50 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER dept_emp_innerview
   INSTEAD OF INSERT
   ON NESTED TABLE emplst OF dept_emp_view                       --创建嵌套表替代触发器
BEGIN
   INSERT INTO emp                                             --插入子表记录
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
    obj_owner VARCHAR2(30),   --所有者
    obj_name  VARCHAR2(30),   --对象名称
    obj_type  VARCHAR2(20),   --对象类型
    obj_user VARCHAR2(30),    --创建用户
    created_date DATE     --创建日期
)

/* Formatted on 2011/10/26 07:55 (Formatter Plus v4.8.8) */
CREATE OR REPLACE TRIGGER t_created_log
   AFTER CREATE ON scott.SCHEMA                  --在soctt方案下创建对象后触发
BEGIN
   --插入日志记录
   INSERT INTO scott.created_log(obj_owner, obj_name,
                obj_type, obj_user, created_date
               )
        VALUES (SYS.dictionary_obj_owner, SYS.dictionary_obj_name,
                SYS.dictionary_obj_type, SYS.login_user, SYSDATE
               );
END;



DROP TRIGGER t_created_log;


--以DBA身份登录，创建下面的登录记录表
CREATE TABLE log_db_table
(
   username VARCHAR2(20),
   logon_time DATE,
   logoff_time DATE,
   address VARCHAR2(20) 
);
--以soctt身份登录，创建下面的登录记录表
CREATE TABLE log_user_table
(
   username VARCHAR2(20),
   logon_time DATE,
   logoff_time DATE,
   address VARCHAR2(20) 
);
--以DBA身份登录，创建DATABASE级别的LOGON事件触发器
CREATE OR REPLACE TRIGGER t_db_logon
AFTER LOGON ON DATABASE
BEGIN
  INSERT INTO log_db_table(username,logon_time,address)
              VALUES(ora_login_user,SYSDATE,ora_client_ip_address);
END;
--以scott身份登录，创建如下的SCHEMA级别的LOGON事件触发器
CREATE OR REPLACE TRIGGER t_user_logon
AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO log_user_table(username,logon_time,address)
              VALUES(ora_login_user,SYSDATE,ora_client_ip_address);
END;


--以DBA身份进入系统，创建临时表
CREATE TABLE event_table(
   sys_event VARCHAR2(30),
   event_time DATE
);
--在DBA级别创建如下的2个触发器
CREATE OR REPLACE TRIGGER t_startup
AFTER STARTUP ON DATABASE       --STARTUP只能是AFTER
BEGIN
   INSERT INTO event_table VALUES(ora_sysevent,SYSDATE);
END;
/
CREATE OR REPLACE TRIGGER t_startup
BEFORE SHUTDOWN ON DATABASE       --SHUTDOWN只能是BEFORE
BEGIN
   INSERT INTO event_table VALUES(ora_sysevent,SYSDATE);
END;
/

CREATE OR REPLACE TRIGGER preserve_app_cols
   AFTER ALTER ON SCHEMA
DECLARE
   --获取一个表中所有列的游标
   CURSOR curs_get_columns (cp_owner VARCHAR2, cp_table VARCHAR2)
   IS
      SELECT column_name
        FROM all_tab_columns
       WHERE owner = cp_owner AND table_name = cp_table;
BEGIN
   -- 如果正使用的是ALTER TABLE语句修改表
   IF ora_dict_obj_type = 'TABLE'
   THEN
      -- 循环表中的每一列
      FOR v_column_rec IN curs_get_columns (
                             ora_dict_obj_owner,
                             ora_dict_obj_name
                          )
      LOOP
         --判断当前的列名正在被修改
         IF ORA_IS_ALTER_COLUMN (v_column_rec.column_name)
         THEN
            IF v_column_rec.column_name='EMPNO' THEN
               RAISE_APPLICATION_ERROR (
                  -20003,
                  '不能对empno字段进行修改'
               );
            END IF; 
         END IF; 
      END LOOP;
   END IF;
END;

/* Formatted on 2011/10/27 07:33 (Formatter Plus v4.8.8) */
ALTER TABLE scott.emp MODIFY(empno NUMBER(8))


--错误日志记录表
CREATE TABLE servererror_log(
   error_time DATE,
   username  VARCHAR2(30),
   instance NUMBER,
   db_name VARCHAR2(50),
   error_stack VARCHAR2(2000)
);
--创建错误触发器，在出现数据库错误时触发。
CREATE OR REPLACE TRIGGER t_logerrors
   AFTER SERVERERROR ON DATABASE
BEGIN
   INSERT INTO servererror_log
        VALUES (SYSDATE, login_user, instance_num, database_name,
                DBMS_UTILITY.format_error_stack);
END;



select privilege from dba_sys_privs where grantee='SCOTT'  
