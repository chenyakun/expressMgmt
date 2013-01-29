
CREATE OR REPLACE FUNCTION get_tablecount (table_name IN VARCHAR2)
   RETURN PLS_INTEGER
IS
   --���嶯̬SQL���
   sql_query   VARCHAR2 (32767) := 'SELECT COUNT(*) FROM ' || table_name;
   l_return    PLS_INTEGER;              --���淵��ֵ�ı���
BEGIN
   EXECUTE IMMEDIATE sql_query
                INTO l_return;           --��ִ̬��SQL�����ؽ��ֵ
   RETURN l_return;                      --���غ������
END;



DECLARE
   v_count PLS_INTEGER;
BEGIN
   v_count:=get_tablecount('emp');
   DBMS_OUTPUT.put_line('emp���������'||v_count);
   v_count:=get_tablecount('dept');
   DBMS_OUTPUT.put_line('dept���������'||v_count);   
END;   


/* Formatted on 2011/10/28 14:12 (Formatter Plus v4.8.8) */
DECLARE
   cnt   NUMBER;
BEGIN
   ---��ѯҪ�����ı��Ƿ����
   SELECT COUNT (*)
     INTO cnt
     FROM user_tables
    WHERE table_name = 'EMP_TESTING';
   ---���������ɾ���ñ�
   IF cnt > 0
   THEN
      DBMS_OUTPUT.put_line ('����ڲ�����');
   ELSE
      DBMS_OUTPUT.put_line ('������');

      EXECUTE IMMEDIATE 'CREATE TABLE emp_testing  (
       emp_name            VARCHAR2(18)                    not null,
       hire_date           DATE                            not null,
       status              NUMBER(2),
       constraint PK_ENTRY_MODIFYSTATUS primary key (emp_name, hire_date)
    )';
   END IF;
   cnt := 0;
END;



DECLARE
   v_counter   NUMBER;
BEGIN
   ---��ѯҪ�����ı��Ƿ����
   SELECT COUNT (*)
     INTO v_counter
     FROM user_tables
    WHERE table_name = 'EMP_TESTING';
   ---���������ɾ���ñ�
   IF v_counter > 0
   THEN
      DBMS_OUTPUT.put_line ('����ڲ�����');
   ELSE
      DBMS_OUTPUT.put_line ('������');
      EXECUTE IMMEDIATE 'CREATE TABLE emp_testing  (
       emp_name            VARCHAR2(18)                    not null,
       hire_date           DATE                            not null,
       status              NUMBER(2),
       constraint PK_ENTRY_MODIFYSTATUS primary key (emp_name, hire_date)
    )';
   END IF;
   v_counter := 0;
END;



DECLARE
   v_counter   NUMBER;
BEGIN
   ---��ѯҪ�����ı��Ƿ����
   SELECT COUNT (*) INTO v_counter FROM user_tables
            WHERE table_name = 'EMP_TESTING';
   ---���������ɾ���ñ�
   IF v_counter > 0 THEN
      DBMS_OUTPUT.put_line ('����ڲ�����');
   ELSE
      DBMS_OUTPUT.put_line ('������');
      --�����ʹ�ö�̬SQL�����������ִ���
     EXECUTE IMMEDIATE 'CREATE TABLE emp_testing  (
       emp_name            VARCHAR2(18)                    not null,
       hire_date           DATE                            not null,
       status              NUMBER(2),
       constraint PK_ENTRY_MODIFYSTATUS primary key (emp_name, hire_date)
    )';
      --ʵ����ǰ��ı����û�д����ɹ�����INSERT���ܳɹ�ִ��
     EXECUTE IMMEDIATE 'INSERT INTO emp_testing VALUES(''���ƽ'',TRUNC(SYSDATE)-5,1)';
     COMMIT;
   END IF;
   v_counter :=0;
END;


SELECT * FROM emp_testing;

/* Formatted on 2011/10/28 20:54 (Formatter Plus v4.8.8) */
DECLARE
   sql_statement   VARCHAR2 (100);
BEGIN
   --����һ��DDL��䣬��������һ����
   sql_statement := 'CREATE TABLE ddl_demo(id NUMBER,amt NUMBER)';
   --ִ�ж�̬SQL���
   EXECUTE IMMEDIATE sql_statement;
   --����һ��DML��䣬��������в���һ����¼
   sql_statement := 'INSERT INTO ddl_demo VALUES(1,100)';
   --ִ�ж�̬SQL���
   EXECUTE IMMEDIATE sql_statement;
END;



DECLARE
   plsql_block   VARCHAR2 (500);     --����һ��������������PL/SQL���
BEGIN
   plsql_block:=                       --Ϊ��̬PL/SQL��丳ֵ
       'DECLARE
          I  INTEGER:=10;
        BEGIN
          EXECUTE IMMEDIATE ''TRUNCATE TABLE ddl_demo'';
          FOR j IN 1..I LOOP
             INSERT INTO ddl_demo VALUES(j,j*100);
          END LOOP;
        END;';                       --������ʱ��ӷֺ�
    EXECUTE IMMEDIATE plsql_block;   --ִ�ж�̬PL/SQL���
    COMMIT;                          --�ύ����
END;

DROP TABLE emp_name_tab;

DECLARE
   sql_stmt  VARCHAR2(200);                               --����SQL���ı���
   TYPE id_table IS TABLE OF INTEGER;                     --����2��Ƕ�ױ�����
   TYPE name_table IS TABLE OF VARCHAR2(8);
   t_empno id_table:=id_table(9001,9002,9003,9004,9005);  --����Ƕ�ױ���������г�ʼ��
   t_empname name_table:=name_table('����','����','����','����','����');
   v_deptno  NUMBER(2):=30;
   v_loc VARCHAR(20):='�Ͼ�';
   emp_rec emp%ROWTYPE;
BEGIN 
   --Ϊ��¼���͸�ֵ����¼������Ϊ�󶨱�����ʧ��
   emp_rec.empno:=9001;
   emp_rec.ename:='����';
   emp_rec.hiredate:=TRUNC(SYSDATE);
   emp_rec.sal:=5000;
   --ʹ����ͨ�ı�����Ϊ�󶨱���
   sql_stmt:='UPDATE dept SET loc=:1 WHERE deptno=:2';
   EXECUTE IMMEDIATE sql_stmt USING v_loc,v_deptno;
   --����һ�������õ����ݱ�
   sql_stmt:='CREATE TABLE emp_name_tab(empno NUMBER,empname VARCHAR(20))';
   EXECUTE IMMEDIATE sql_stmt;
   --ʹ��Ƕ�ױ������ֵ��Ϊ�󶨱���
   sql_stmt:='INSERT INTO emp_name_tab VALUES(:1,:2)';
   FOR i IN t_empno.FIRST..t_empno.LAST LOOP
      EXECUTE IMMEDIATE sql_stmt USING t_empno(i),t_empname(i);
   END LOOP;
   --ʹ�ü�¼������ʾʧ��
   --sql_stmt:='INSERT INTO emp VALUES :1';
   --EXECUTE IMMEDIATE sql_stmt USING emp_rec;
END;

--����һ����������ݵĹ���
CREATE OR REPLACE PROCEDURE trunc_table(table_name IN VARCHAR2)
IS
  sql_stmt VARCHAR2(100);
BEGIN
   sql_stmt:='TRUNCATE TABLE '||table_name;        --ʹ��ƴ�����÷�������
   EXECUTE IMMEDIATE sql_stmt;                     --��ִ̬��SQL���
END; 

BEGIN
   trunc_table('emp_name_tab');                  
END;


SELECT * FROM emp WHERE empno=7369;

DECLARE
   v_empno NUMBER(4) :=7369;                      --����Ա���󶨱���
   v_percent NUMBER(4,2) := 0.12;                 --�����н���ʰ󶨱���
   v_salary  NUMBER(10,2);                        --���ر���
   sql_stmt  VARCHAR2(500);                       --����SQL���ı���
BEGIN
   --�������emp���sal�ֶ�ֵ�Ķ�̬SQL���
   sql_stmt:='UPDATE emp SET sal=sal*(1+:percent) '
             ||' WHERE empno=:empno RETURNING sal INTO :salary';
   EXECUTE IMMEDIATE sql_stmt USING v_percent, v_empno
      RETURNING INTO v_salary;                    --ʹ��RETURNING INTO�Ӿ��ȡ����ֵ
   DBMS_OUTPUT.put_line('������Ĺ���Ϊ��'||v_salary);
END;



DECLARE
   sql_stmt  VARCHAR2(100);           --���涯̬SQL���ı���
   v_deptno NUMBER(4) :=20;           --���ű�ţ����ڰ󶨱���
   v_empno NUMBER(4):=7369;           --Ա����ţ����ڰ󶨱���
   v_dname  VARCHAR2(20);             --�������ƣ���ȡ��ѯ���
   v_loc  VARCHAR2(20);               --����λ�ã���ȡ��ѯ���
   emp_row emp%ROWTYPE;               --�������ļ�¼����
BEGIN
   --��ѯdept��Ķ�̬SQL���
   sql_stmt:='SELECT dname,loc FROM dept WHERE deptno=:deptno';
   --ִ�ж�̬SQL��䲢��¼��ѯ���
   EXECUTE IMMEDIATE sql_stmt INTO v_dname,v_loc USING v_deptno ;
   --��ѯemp����ض�Ա����ŵļ�¼
   sql_stmt:='SELECT * FROM emp WHERE empno=:empno';
   --��emp���е��ض�������д��emp_row��¼��
   EXECUTE IMMEDIATE sql_stmt INTO emp_row USING v_empno;
   DBMS_OUTPUT.put_line('��ѯ�Ĳ�������Ϊ��'||v_dname);
   DBMS_OUTPUT.put_line('��ѯ��Ա�����Ϊ��'||emp_row.ename);   
END;





CREATE OR REPLACE PROCEDURE create_dept(
deptno IN OUT NUMBER,             --IN OUT������������ȡ�����deptnoֵ
dname IN VARCHAR2,                --��������
loc IN VARCHAR2                   --���ŵ�ַ
)AS
BEGIN
  --���deptnoû��ָ��ֵ
  IF deptno IS NULL THEN
     --��������ȡһ��ֵ
     SELECT deptno_seq.NEXTVAL INTO deptno FROM DUAL;
  END IF;
  --��dept���в����¼
  INSERT INTO dept VALUES(deptno,dname,loc);
END;

SELECT deptno_seq.NEXTVAL FROM dual;

/* Formatted on 2011/10/29 11:12 (Formatter Plus v4.8.8) */
DECLARE
   plsql_block   VARCHAR2 (500);
   v_deptno      NUMBER (2);
   v_dname       VARCHAR2 (14)  := '���粿';
   v_loc         VARCHAR2 (13)  := 'Ҳ��';
BEGIN
   plsql_block := 'BEGIN create_dept(:a,:b,:c);END;';
   --������ָ��������Ҫ��IN OUT����ģʽ
   EXECUTE IMMEDIATE plsql_block
               USING IN OUT v_deptno, v_dname, v_loc;
   DBMS_OUTPUT.put_line ('�½����ŵı��Ϊ��' || v_deptno);
END;



DECLARE
   TYPE emp_cur_type IS REF CURSOR;      --�����α�����
   emp_cur emp_cur_type;                 --�����α����
   v_deptno NUMBER(4) := '&deptno';      --���岿�ű�Ű󶨱���
   v_empno NUMBER(4);                                         
   v_ename VARCHAR2(25);
BEGIN
   OPEN emp_cur FOR                  --�򿪶�̬�α�
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   NULL;
END;


DECLARE
   TYPE emp_cur_type IS REF CURSOR;      --�����α�����
   emp_cur emp_cur_type;                 --�����α����
   v_deptno NUMBER(4) := '&deptno';      --���岿�ű�Ű󶨱���
   v_empno NUMBER(4);                                         
   v_ename VARCHAR2(25);
BEGIN
   OPEN emp_cur FOR                       --�򿪶�̬�α�
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   LOOP
      FETCH emp_cur INTO v_empno, v_ename; --ѭ����ȡ�α�����  
      EXIT WHEN emp_cur%NOTFOUND;          --û������ʱ�˳�ѭ��
      DBMS_OUTPUT.PUT_LINE ('Ա�����: '||v_empno);
      DBMS_OUTPUT.PUT_LINE ('Ա������:  '||v_ename);
   END LOOP;
END;


DECLARE
   TYPE emp_cur_type IS REF CURSOR;      --�����α�����
   emp_cur emp_cur_type;                 --�����α����
   v_deptno NUMBER(4) := '&deptno';      --���岿�ű�Ű󶨱���
   v_empno NUMBER(4);                                         
   v_ename VARCHAR2(25);
BEGIN
   OPEN emp_cur FOR                       --�򿪶�̬�α�
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   LOOP
      FETCH emp_cur INTO v_empno, v_ename; --ѭ����ȡ�α�����  
      EXIT WHEN emp_cur%NOTFOUND;          --û������ʱ�˳�ѭ��
      DBMS_OUTPUT.PUT_LINE ('Ա�����: '||v_empno);
      DBMS_OUTPUT.PUT_LINE ('Ա������:  '||v_ename);
   END LOOP;
   CLOSE emp_cur;                          --�ر��α����
EXCEPTION
   WHEN OTHERS THEN   
      IF emp_cur%FOUND THEN               --��������쳣���α����δ�ر�
         CLOSE emp_cur;                   --�ر��α�
      END IF;   
      DBMS_OUTPUT.PUT_LINE ('ERROR: '||
         SUBSTR(SQLERRM, 1, 200));         
END;


DECLARE
   --�������������ͣ����������DML����з��صĽ��
   TYPE ename_table_type IS TABLE OF VARCHAR2(25) INDEX BY BINARY_INTEGER;
   TYPE sal_table_type IS TABLE OF NUMBER(10,2) INDEX BY BINARY_INTEGER;   
   ename_tab ename_table_type;
   sal_tab sal_table_type;
   v_deptno NUMBER(4) :=20;                             --���岿�Ű󶨱���
   v_percent NUMBER(4,2) := 0.12;                       --�����н���ʰ󶨱���
   sql_stmt  VARCHAR2(500);                             --����SQL���ı���
BEGIN
   --�������emp���sal�ֶ�ֵ�Ķ�̬SQL���
   sql_stmt:='UPDATE emp SET sal=sal*(1+:percent) '
             ||' WHERE deptno=:deptno RETURNING ename,sal INTO :ename,:salary';
   EXECUTE IMMEDIATE sql_stmt USING v_percent, v_deptno
      RETURNING BULK COLLECT INTO ename_tab,sal_tab;   --ʹ��RETURNING BULK COLLECT INTO�Ӿ��ȡ����ֵ
   FOR i IN 1..ename_tab.COUNT LOOP                    --������صĽ��ֵ 
      DBMS_OUTPUT.put_line('Ա��'||ename_tab(i)||'��н���н�ʣ�'||sal_tab(i));
   END LOOP;
END;


DECLARE
   TYPE ename_table_type IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
   TYPE empno_table_type IS TABLE OF NUMBER(24) INDEX BY BINARY_INTEGER; 
   ename_tab ename_table_type;              --���屣����з���ֵ��������
   empno_tab empno_table_type;  
   v_deptno NUMBER(4) := '&deptno';          --���岿�ű�Ű󶨱���
   sql_stmt VARCHAR2(500);
BEGIN
   --������в�ѯ��SQL���
   sql_stmt:='SELECT empno, ename FROM emp '||'WHERE deptno = :1';
   EXECUTE IMMEDIATE sql_stmt 
   BULK COLLECT INTO empno_tab,ename_tab               --�������뵽������
   USING v_deptno;   
   FOR i IN 1..ename_tab.COUNT LOOP                    --������صĽ��ֵ 
      DBMS_OUTPUT.put_line('Ա�����'||empno_tab(i)
                                         ||'Ա�����ƣ�'||ename_tab(i));
   END LOOP;          
END;



DECLARE
   TYPE ename_table_type IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
   TYPE empno_table_type IS TABLE OF NUMBER(24) INDEX BY BINARY_INTEGER;
   TYPE emp_cur_type IS REF CURSOR;         --�����α�����    
   ename_tab ename_table_type;              --���屣����з���ֵ��������
   empno_tab empno_table_type;  
   emp_cur emp_cur_type;                    --�����α����
   v_deptno NUMBER(4) := '&deptno';         --���岿�ű�Ű󶨱���
BEGIN
   OPEN emp_cur FOR                         --�򿪶�̬�α�
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   FETCH emp_cur BULK COLLECT INTO empno_tab, ename_tab; --������ȡ�α�����  
   CLOSE emp_cur;                                        --�ر��α����
   FOR i IN 1..ename_tab.COUNT LOOP                      --������صĽ��ֵ 
      DBMS_OUTPUT.put_line('Ա�����'||empno_tab(i)
                                         ||'Ա�����ƣ�'||ename_tab(i));
   END LOOP;       
END;

SELECT * FROM emp;

DECLARE
   --�������������ͣ����������DML����з��صĽ��
   TYPE ename_table_type IS TABLE OF VARCHAR2(25) INDEX BY BINARY_INTEGER;
   TYPE sal_table_type IS TABLE OF NUMBER(10,2) INDEX BY BINARY_INTEGER;   
   TYPE empno_table_type IS TABLE OF NUMBER(4);         --����Ƕ�ױ����ͣ�������������Ա�����  
   ename_tab ename_table_type;
   sal_tab sal_table_type;
   empno_tab empno_table_type;
   v_deptno NUMBER(4) :=20;                             --���岿�Ű󶨱���
   v_percent NUMBER(4,2) := 0.12;                       --�����н���ʰ󶨱���
   sql_stmt  VARCHAR2(500);                             --����SQL���ı���
BEGIN
   empno_tab:=empno_table_type(7369,7499,7521,7566);    --��ʼ��Ƕ�ױ�
     --�������emp���sal�ֶ�ֵ�Ķ�̬SQL���
   sql_stmt:='UPDATE emp SET sal=sal*(1+:percent) '
             ||' WHERE empno=:empno RETURNING ename,sal INTO :ename,:salary';
   FORALL i IN 1..empno_tab.COUNT                        --ʹ��FORALL��������������
      EXECUTE IMMEDIATE sql_stmt USING v_percent, empno_tab(i)  --����ʹ������Ƕ�ױ�Ĳ���
      RETURNING BULK COLLECT INTO ename_tab,sal_tab;   --ʹ��RETURNING BULK COLLECT INTO�Ӿ��ȡ����ֵ
   FOR i IN 1..ename_tab.COUNT LOOP                    --������صĽ��ֵ 
      DBMS_OUTPUT.put_line('Ա��'||ename_tab(i)||'��н���н�ʣ�'||sal_tab(i));
   END LOOP;
END;


/* Formatted on 2011/10/30 09:18 (Formatter Plus v4.8.8) */
DECLARE
   col_in     VARCHAR2(10):='sal';    --����
   start_in   DATE;        --��ʼ����
   end_in     DATE;        --��������
   val_in     NUMBER;      --�������ֵ
   plsql_str    VARCHAR2 (32767)
      :=    '
         BEGIN
             UPDATE emp SET '
             || col_in
             || ' = :val
            WHERE hiredate BETWEEN :lodate AND :hidate
            AND :val IS NOT NULL;
        END;
        '; --��̬PLSQL���
BEGIN
   --ִ�ж�̬SQL��䣬Ϊ�ظ���val_in��������Ϊ�󶨱���
   EXECUTE IMMEDIATE dml_str
               USING val_in,start_in,end_in;
END;



/* Formatted on 2011/10/30 09:56 (Formatter Plus v4.8.8) */
/* Formatted on 2011/10/30 09:56 (Formatter Plus v4.8.8) */
--����һ��ɾ���κ����ݿ�����ͨ�õĹ���
CREATE OR REPLACE PROCEDURE drop_obj (kind IN VARCHAR2, NAME IN VARCHAR2)
AUTHID CURRENT_USER       --���������Ȩ��
AS
BEGIN
   EXECUTE IMMEDIATE 'DROP ' || kind || ' ' || NAME;
EXCEPTION
WHEN OTHERS THEN
   RAISE;   
END;


/* Formatted on 2011/10/30 11:06 (Formatter Plus v4.8.8) */
DECLARE
   v_null   CHAR (1);                      --������ʱ�ñ����Զ�������ΪNULLֵ
BEGIN
   EXECUTE IMMEDIATE 'UPDATE emp SET comm=:x'
               USING v_null;                                     --����NULLֵ
END;



CREATE OR REPLACE PROCEDURE ddl_execution (ddl_string IN VARCHAR2)
   AUTHID CURRENT_USER IS            --ʹ�õ�����Ȩ��
BEGIN
   EXECUTE IMMEDIATE ddl_string;     --ִ�ж�̬SQL���
EXCEPTION
   WHEN OTHERS                       --��׽����  
   THEN
      DBMS_OUTPUT.PUT_LINE (      --��ʾ������Ϣ
         '��̬SQL������' || DBMS_UTILITY.FORMAT_ERROR_STACK);
      DBMS_OUTPUT.PUT_LINE (      --��ʾ��ǰִ�е�SQL���
         '   ִ�е�SQL���Ϊ�� "' || ddl_string || '"');
      RAISE;
END ddl_execution;



EXEC ddl_execution('alter table emp_test add emp_sal number NULL');