DECLARE
   --���屣���ֶ�ֵ�ı���
   v_empno      NUMBER;
   v_ename      VARCHAR2 (20);
   v_job        VARCHAR2 (9);
   v_mgr        NUMBER (4);
   v_hiredate   DATE;
   v_sal        NUMBER (7, 2);
   v_comm       NUMBER (7, 2);
   v_deptno     NUMBER (2);
BEGIN
   --��emp����ȡ���ֶ�ֵ
   SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
     INTO v_empno, v_ename, v_job, v_mgr, v_hiredate, v_sal, v_comm, v_deptno
     FROM emp
    WHERE empno = :empno;
   --��emp_copy���в��������ֵ
   INSERT INTO emp_copy
               (empno, ename, job, mgr, hiredate, sal, comm,
                deptno
               )
        VALUES (v_empno, v_ename, v_job, v_mgr, v_hiredate, v_sal, v_comm,
                v_deptno
               );
EXCEPTION  --�쳣�����
   WHEN OTHERS
   THEN
      NULL;
END;


DECLARE
   --�����¼����
   TYPE t_emp IS RECORD
   (
   v_empno      NUMBER,
   v_ename      VARCHAR2 (20),
   v_job        VARCHAR2 (9),
   v_mgr        NUMBER (4),
   v_hiredate   DATE,
   v_sal        NUMBER (7, 2),
   v_comm       NUMBER (7, 2),
   v_deptno     NUMBER (2)
   );
   --������¼���͵ı���
   emp_info t_emp;
BEGIN
   --��emp����ȡ���ֶ�ֵ������¼����
   SELECT *
     INTO emp_info
     FROM emp
    WHERE empno = :empno;
   --��emp_copy���в����¼���͵�ֵ
   INSERT INTO emp_copy VALUES emp_info;
EXCEPTION  --�쳣�����
   WHEN OTHERS
   THEN
      NULL;
END;



DECLARE
   --������¼����
   TYPE emp_rec IS RECORD (
      dept_row   dept%ROWTYPE,   --��������dept���е�Ƕ�׼�¼
      empno      NUMBER,         --Ա�����
      ename      VARCHAR (20),   --Ա������
      job        VARCHAR (10),   --ְλ
      sal        NUMBER (7, 2)   --н��
   );
   --������¼���͵ı���
   emp_info   emp_rec;
BEGIN
   NULL;
END;


DECLARE
   --������¼����
   TYPE emp_rec IS RECORD (
      dept_row   dept%ROWTYPE,   --��������dept���е�Ƕ�׼�¼
      empno      NUMBER,         --Ա�����
      ename      VARCHAR (20),   --Ա������
      job        VARCHAR (10),   --ְλ
      sal        NUMBER (7, 2)   --н��
   );
   --������¼���͵ı���
   emp_info   emp_rec;
BEGIN
   NULL;
END;




DECLARE
   TYPE emp_rec IS RECORD (
      empname    VARCHAR (12)           := '��˹��',      --Ա�����ƣ���ʼֵ��˹��
      empno      NUMBER        NOT NULL DEFAULT 7369,     --Ա����ţ�Ĭ��ֵ7369
      hiredate   DATE                   DEFAULT SYSDATE,  --��Ӷ���ڣ�Ĭ��ֵ��ǰ����
      sal        NUMBER (7, 2)                            --Ա��н��
   );
   --����emp_rec���͵ı���
   empinfo   emp_rec;
BEGIN
   --��������Ϊempinfo��¼��ֵ��
   empinfo.empname:='ʩ��˹';
   empinfo.empno:=7010;
   empinfo.hiredate:=TO_DATE('1982-01-01','YYYY-MM-DD');
   empinfo.sal:=5000;
   --�����������empinfo��¼��ֵ
   DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||empinfo.empname);
   DBMS_OUTPUT.PUT_LINE('Ա����ţ�'||empinfo.empno);
   DBMS_OUTPUT.PUT_LINE('��Ӷ���ڣ�'||TO_CHAR(empinfo.hiredate,'YYYY-MM-DD'));
   DBMS_OUTPUT.PUT_LINE('Ա��н�ʣ�'||empinfo.sal);   
END;




DECLARE
   --�����¼����
   TYPE emp_rec IS RECORD (
      empno   NUMBER,
      ename   VARCHAR2 (20)
   );
   --������emp_rec������ͬ��Ա�ļ�¼����
   TYPE emp_rec_dept IS RECORD (
      empno   NUMBER,
      ename   VARCHAR2 (20)
   );
   --������¼���͵ı���
   emp_info1   emp_rec;
   emp_info2   emp_rec;
   emp_info3   emp_rec_dept;
   --����һ����Ƕ�������������¼��Ϣ
   PROCEDURE printrec (empinfo emp_rec)
   AS
   BEGIN
      DBMS_OUTPUT.put_line ('Ա����ţ�' || empinfo.empno);
      DBMS_OUTPUT.put_line ('Ա�����ƣ�' || empinfo.ename);
   END;
BEGIN
   emp_info1.empno := 7890;    --Ϊemp_info1��¼��ֵ
   emp_info1.ename := '�Ŵ�ǧ';
   DBMS_OUTPUT.put_line ('emp_info1����Ϣ���£�');
   printrec (emp_info1);      --��ӡ��ֵ���emp_info1��¼
   emp_info2 := emp_info1;    --��emp_info1��¼����ֱ�Ӹ���emp_info2
   DBMS_OUTPUT.put_line ('emp_info2����Ϣ���£�');
   printrec (emp_info2);      --��ӡ��ֵ���emp_info2�ļ�¼
   emp_info3:=emp_info1;    --�������ִ��󣬲�ͬ��¼���͵ı��������໥��ֵ
END;

DESC dept;
DESC emp;


DECLARE
   --����һ����dept�������ͬ�еļ�¼
   TYPE dept_rec IS RECORD (
      deptno   NUMBER (10),
      dname    VARCHAR2 (30),
      loc      VARCHAR2 (30)
   );
   --�������dept��ļ�¼����
   dept_rec_db   dept%ROWTYPE;
   dept_info     dept_rec;
BEGIN
   --ʹ��SELECT���Ϊ��¼���͸�ֵ
   SELECT *
     INTO dept_rec_db
     FROM dept
    WHERE deptno = 20;
   --��%ROWTYPE����ļ�¼������׼��¼����
   dept_info := dept_rec_db;
END;


DECLARE
   TYPE emp_rec IS RECORD (
      empno   NUMBER (10),
      ename   VARCHAR2 (30),
      job     VARCHAR2 (30)
   );
   --������¼���͵ı���
   emp_info   emp_rec;
BEGIN
   --Ϊ��¼���͸�ֵ
   SELECT empno,
          ename,
          job
     INTO emp_info
     FROM emp
    WHERE empno = 7369;
    --�����¼���͵�ֵ
   DBMS_OUTPUT.put_line (   'Ա����ţ�'
                         || emp_info.empno
                         || CHR (13)
                         || 'Ա��������'
                         || emp_info.ename
                         || CHR (13)
                         || 'Ա��ְ��'
                         || emp_info.job
                        );
END;

desc dept;
INSERT INTO dept SELECT * FROM dept_copy;

select * from dept_copy;

SELECT * FROM dept;

/* Formatted on 2011/09/07 21:19 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );
   --����2����¼���͵ı���
   dept_row     dept%ROWTYPE;
   dept_norow   dept_rec;
BEGIN
   --Ϊ��¼���͸�ֵ
   dept_row.deptno := 70;
   dept_row.dname := '���̲�';
   dept_row.loc := '�Ϻ�';
   dept_norow.deptno := 80;
   dept_norow.dname := '���Բ�';
   dept_norow.loc := '����';
   --����%ROWTYPE����ļ�¼����������
   INSERT INTO dept
        VALUES dept_row;
   --������ͨ��¼������ֵ������
   INSERT INTO dept
        VALUES dept_norow;
   --�����ݿ��ύ�Ա�ĸ���
   COMMIT;
END;

SELECT * FROM dept;

/* Formatted on 2011/09/07 21:55 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (         --�����¼����
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );
   dept_info   dept_rec;            --�����¼���͵ı���
BEGIN
   SELECT *
     INTO dept_info
     FROM dept
    WHERE deptno = 80;              --ʹ��SELECT����ʼ����¼����
   dept_info.dname := '��Ϣ����'; --���¼�¼���͵�ֵ
   UPDATE dept
      SET ROW = dept_info
    WHERE deptno = dept_info.deptno;--��UPDATE��ʹ�ü�¼�������±�
END;



/* Formatted on 2011/09/08 06:32 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (                                   --�����¼����
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );

   dept_info        dept_rec;                             --�����¼���͵ı���
   dept_returning   dept%ROWTYPE;                 --�������ڷ��ؽ���ļ�¼����
BEGIN
   SELECT *
     INTO dept_info
     FROM dept
    WHERE deptno = 80;                          --ʹ��SELECT����ʼ����¼����

   dept_info.dname := '��Ϣ����';                         --���¼�¼���͵�ֵ

   UPDATE    dept
         SET ROW = dept_info
       WHERE deptno = dept_info.deptno          --��UPDATE��ʹ�ü�¼�������±�������Ӱ����е���¼
   RETURNING deptno,
             dname,
             loc
        INTO dept_returning;

   dept_info.deptno := 12;
   dept_info.dname := 'ά�޲�';

   INSERT INTO dept                             --�����µĲ��ű�ż�¼��������Ӱ����еļ�¼
        VALUES dept_info
     RETURNING deptno,
               dname,
               loc
          INTO dept_returning;

   DELETE FROM dept                            --ɾ�����еĲ��ţ�������Ӱ����еļ�¼
         WHERE deptno = dept_info.deptno
     RETURNING deptno,
               dname,
               loc
          INTO dept_returning;
END;


DESC emp;

/* Formatted on 2011/09/08 10:09 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (                            --���岿�ż�¼����
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );
   TYPE emp_rec IS RECORD (                             --����Ա����¼����          
      v_empno      NUMBER,
      v_ename      VARCHAR2 (20),
      v_job        VARCHAR2 (9),
      v_mgr        NUMBER (4),
      v_hiredate   DATE,
      v_sal        NUMBER (7, 2),
      v_comm       NUMBER (7, 2),
      v_dept_rec   dept_rec                             --����Ƕ�׵�Ա����¼
   );  
   emp_info    emp_rec;                                 --Ա����¼
   dept_info   dept_rec;                                --��ʱ���ż�¼
BEGIN
   SELECT *                                             --�����ݿ���ȡ��Ա�����ŵļ�¼
     INTO dept_info
     FROM dept
    WHERE deptno = (SELECT deptno
                      FROM emp
                     WHERE empno = 7369);
   emp_info.v_dept_rec:=dept_info;                       --��������Ϣ��¼����Ƕ�׵Ĳ��ż�¼
   SELECT empno, ename, job, mgr,                        --Ϊemp��ֵ
          hiredate, sal, comm
     INTO emp_info.v_empno, emp_info.v_ename, emp_info.v_job, emp_info.v_mgr,
          emp_info.v_hiredate, emp_info.v_sal, emp_info.v_comm
     FROM emp
    WHERE empno = 7369;
    --���Ƕ�׼�¼��Ա�����ڲ�����Ϣ
    DBMS_OUTPUT.PUT_LINE('Ա����������Ϊ��'||emp_info.v_dept_rec.dname);
END;


-- ��Ӷ������������
TYPE hiredate_idxt IS TABLE OF DATE INDEX BY PLS_INTEGER;
-- ���ű�ż���
TYPE deptno_idxt IS TABLE OF dept.deptno%TYPE NOT NULL
   INDEX BY PLS_INTEGER;
--��¼���͵�����������ṹ������PL/SQL�����д�������һ�����ظ���
TYPE emp_idxt IS TABLE OF emp%ROWTYPE
   INDEX BY NATURAL;
-- �ɲ������Ʊ�ʶ�Ĳ��ż�¼�ļ���
TYPE deptname_idxt IS TABLE OF dept%ROWTYPE
   INDEX BY dept.dname%TYPE;
-- ���弯�ϵļ���
TYPE private_collection_tt IS TABLE OF deptname_idxt
   INDEX BY VARCHAR2(100);
   
   
/* Formatted on 2011/09/08 21:06 (Formatter Plus v4.8.8) */
DECLARE
   TYPE idx_table IS TABLE OF VARCHAR (12)
      INDEX BY PLS_INTEGER;                    --��������������   
   v_emp   idx_table;                          --�������������
BEGIN
   v_emp (1) := 'ʷ��˹';                      --�����Ϊ������ֵ
   v_emp (20) := '������';
   v_emp (40) := 'ʷ���';
   v_emp (-10) := '����';
   if v_emp.EXISTS(8) THEN
     DBMS_OUTPUT.PUT_LINE(v_emp(8));
    END IF;
--   EXCEPTION
--   WHEN OTHERS THEN
--     DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;



/* Formatted on 2011/09/08 21:38 (Formatter Plus v4.8.8) */
DECLARE
   --�����¼���͵���������dname��Ϊ����������
   --dname��VARCHAR2(14)����
   TYPE idx_dept_table IS TABLE OF dept%ROWTYPE
      INDEX BY dept.dname%TYPE;
   --������¼���͵ı���
   v_dept   idx_dept_table;
   --����һ���α꣬������ѯdept��
   CURSOR dept_cur
   IS
      SELECT *
        FROM dept;
BEGIN
   --ʹ���α�FORѭ�����α꣬��������
   FOR deptrow IN dept_cur
   LOOP 
      --Ϊ�������е�Ԫ�ظ�ֵ
      v_dept (deptrow.dname) := deptrow;
      --������ŵ�LOC����Ϣ
      DBMS_OUTPUT.put_line (v_dept (deptrow.dname).loc);
   END LOOP;
END;

SELECT * FROM dept;

/* Formatted on 2011/09/09 06:22 (Formatter Plus v4.8.8) */
DECLARE
   --������VARCHAR2��Ϊ��������������
   TYPE idx_deptno_table IS TABLE OF NUMBER (2)
      INDEX BY VARCHAR2 (20);
   --������¼���͵ı���
   v_deptno   idx_deptno_table;
BEGIN
   --Ϊ������ֵ
   v_deptno ('����') := 10;
   v_deptno ('�о���') := 20;
   v_deptno ('���۲�') := 30;
   --���������������
   DBMS_OUTPUT.put_line ('���۲����Ϊ��' || v_deptno ('���۲�'));
END;




/* Formatted on 2011/09/08 22:44 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_table IS TABLE OF dept%ROWTYPE;              --������ϢǶ�ױ�
   TYPE emp_name_table IS TABLE OF VARCHAR2 (20);         --Ա������Ƕ�ױ�
   TYPE deptno_table IS TABLE OF NUMBER (2);              --���ű��Ƕ�ױ�
   dept_info       dept_table;                            --����Ƕ�ױ����
   --��������ʼ��Ƕ�ױ����
   emp_name_info   emp_name_table := emp_name_table ('��С��', '��˹��');
   deptno_info     deptno_table   := deptno_table (20, 30, 40);
BEGIN
   NULL;
END;




/* Formatted on 2011/09/09 06:44 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emp_name_table IS TABLE OF VARCHAR2 (20);            --Ա������Ƕ�ױ�
   TYPE deptno_table IS TABLE OF NUMBER (2);                 --���ű��Ƕ�ױ�
   deptno_info     deptno_table;
   emp_name_info   emp_name_table := emp_name_table ('��С��', '��˹��');
BEGIN
   DBMS_OUTPUT.put_line ('Ա��1��' || emp_name_info (1)); --����Ƕ�ױ�Ԫ��
   DBMS_OUTPUT.put_line ('Ա��2��' || emp_name_info (2));
   IF deptno_info IS NULL                                 --�ж�Ƕ�ױ��Ƿ񱻳�ʼ��
   THEN
      deptno_info := deptno_table (NULL,NULL,NULL,NULL,NULL);
   END IF;
  -- deptno_info.EXTEND(5);                                --����Ԫ�صĸ���
   FOR i IN 1 .. 5                                       --ѭ������Ƕ�ױ�Ԫ������
   LOOP
      deptno_info (i) := i * 10;
   END LOOP;
   --��ʾ���Ÿ���
   DBMS_OUTPUT.put_line ('���Ÿ�����' || deptno_info.COUNT);
END;






DROP TYPE empname_type;

CREATE TYPE empname_type_02 IS TABLE OF VARCHAR2(20);



--1.����Ƕ�ױ�����
CREATE TYPE empname_type IS TABLE OF VARCHAR2(20);
/
--2.�������ݱ�ʱָ��Ƕ�ױ��У�ͬʱҪʹ��STORE ASָ��Ƕ�ױ�Ĵ洢��
CREATE TABLE dept_nested
(
   deptno NUMBER(2),                    --���ű��
   dname VARCHAR2(20),                  --��������
   emplist empname_type                 --����Ա���б�
) NESTED TABLE emplist STORE AS empname_table;
 


/* Formatted on 2011/09/09 11:19 (Formatter Plus v4.8.8) */
DECLARE
   emp_list   empname_type
         := empname_type ('ʷ��˹', '�ܿ�', '��', '˹����', '��ʲ', 'Сƽ');
BEGIN
   --������INSERT����д���һ��Ƕ�ױ�ʵ��
   INSERT INTO dept_nested
        VALUES (10, '����Ժ', emp_list);
   --Ҳ����ֱ����INSERT�����ʵ����Ƕ�ױ�
   INSERT INTO dept_nested
        VALUES (20, '����˾', empname_type ('����', '�Ž�', '����', '����'));
   --�����ݿ���в�ѯ��Ƕ�ױ�ʵ��
   SELECT emplist INTO emp_list FROM dept_nested WHERE deptno=10;            
   --��Ƕ�ױ���и��£�Ȼ��ʹ��UPDATE��佫Ƕ�ױ�ʵ�����»����ݿ�
   emp_list (1) := '��У';
   emp_list (2) := '��У';
   emp_list (3) := '��У';
   emp_list (4) := 'ѧУ';
   emp_list (5) := '��Ч';
   emp_list (6) := 'ҩЧ';
   --ʹ�ø��Ĺ���emp_list����Ƕ�ױ���
   UPDATE dept_nested
      SET emplist = emp_list
    WHERE deptno = 10;
END;


SELECT * FROM dept_nested;


/* Formatted on 2011/09/09 14:22 (Formatter Plus v4.8.8) */
DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);        --������Ŀ�б�䳤����
   TYPE empno_type IS VARRAY (10) OF NUMBER (4);            --����Ա����ű䳤����
   --�����䳤�������͵ı�������ʹ�ù��캯�����г�ʼ��
   project_list   projectlist := projectlist ('��վ', 'ERP', 'CRM', 'CMS');
   empno_list     empno_type;                               --�����䳤�������͵ı���
BEGIN
   DBMS_OUTPUT.put_line (project_list (3));              --�����3��Ԫ�ص�ֵ
   project_list.EXTEND;                                     --��չ����5��Ԫ��
   project_list (5) := 'WORKFLOW';                          --Ϊ��5��Ԫ�ظ�ֵ
   empno_list :=                                            --����empno_list
      empno_type (7011, 7012, 7013, 7014, NULL, NULL, NULL, NULL, NULL, NULL);
   empno_list (9) := 8011;                                  --Ϊ��9��Ԫ�ظ���ֵ
   DBMS_OUTPUT.put_line (empno_list (9));                --�����9��Ԫ�ص�ֵ
END;



--����һ���䳤���������empname_varray_type�������洢Ա����Ϣ
CREATE OR REPLACE TYPE empname_varray_type IS VARRAY (20) OF VARCHAR2 (20);
/
CREATE TABLE dept_varray                  --�����������ݱ�
(
   deptno NUMBER(2),                      --���ű��    
   dname VARCHAR2(20),                    --��������
   emplist empname_varray_type            --����Ա���б�
);


/* Formatted on 2011/09/09 15:25 (Formatter Plus v4.8.8) */
DECLARE                                         --��������ʼ���䳤����
   emp_list   empname_varray_type                          
                := empname_varray_type ('ʷ��˹', '�ܿ�', '��ķ', '��ɳ', '��', 'ʷ̫��');
BEGIN
   INSERT INTO dept_varray
        VALUES (20, 'ά����', emp_list);        --����в���䳤��������
   INSERT INTO dept_varray                      --ֱ����INSERT����г�ʼ���䳤��������
        VALUES (30, '���ӹ�',
                empname_varray_type ('����', '����', '����', '����', '����', '����'));
   SELECT emplist
     INTO emp_list
     FROM dept_varray
    WHERE deptno = 20;                          --ʹ��SELECT���ӱ���ȡ���䳤��������
   emp_list (1) := '�ܿ���';                    --���±䳤�������ݵ�����
   UPDATE dept_varray
      SET emplist = emp_list
    WHERE deptno = 20;                          --ʹ��UPDATE�����±䳤��������
   DELETE FROM dept_varray
         WHERE deptno = 30;                     --ɾ����¼��ͬʱɾ���䳤��������
END;




/* Formatted on 2011/09/09 20:56 (Formatter Plus v4.8.8) */
DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --������Ŀ�б�䳤����
   project_list   projectlist := projectlist ('��վ', 'ERP', 'CRM', 'CMS');
BEGIN
   IF project_list.EXISTS (5)                          --�ж�һ�������ڵ�Ԫ��ֵ
   THEN                                                --������ڣ������Ԫ��ֵ
      DBMS_OUTPUT.put_line ('Ԫ�ش��ڣ���ֵΪ��' || project_list (5));
   ELSE
      DBMS_OUTPUT.put_line ('Ԫ�ز�����');          --��������ڣ���ʾԪ�ز�����    
   END IF;
END;


DECLARE
   TYPE emp_name_table IS TABLE OF VARCHAR2 (20);            --Ա������Ƕ�ױ�
   TYPE deptno_table IS TABLE OF NUMBER (2);                 --���ű��Ƕ�ױ�
   deptno_info     deptno_table;
   emp_name_info   emp_name_table := emp_name_table ('��С��', '��˹��');
BEGIN
   deptno_info:=deptno_table();                              --����һ���������κ�Ԫ�ص�Ƕ�ױ�
   deptno_info.EXTEND(5);                                    --��չ5��Ԫ��
   DBMS_OUTPUT.PUT_LINE('deptno_info��Ԫ�ظ���Ϊ��'||deptno_info.COUNT);
   DBMS_OUTPUT.PUT_LINE('emp_name_info��Ԫ�ظ���Ϊ��'||emp_name_info.COUNT);   
END;   


DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --������Ŀ�б�䳤����
   project_list   projectlist := projectlist ('��վ', 'ERP', 'CRM', 'CMS');
BEGIN
   DBMS_OUTPUT.put_line ('�䳤���������ֵΪ��' || project_list.LIMIT);
   project_list.EXTEND(8);
   DBMS_OUTPUT.put_line ('�䳤����ĵ�ǰ����Ϊ��' || project_list.COUNT);   
END;



DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --������Ŀ�б�䳤����
   project_list   projectlist := projectlist ('��վ', 'ERP', 'CRM', 'CMS');
BEGIN
   DBMS_OUTPUT.put_line ('�䳤���������ֵΪ��' || project_list.LIMIT);
   project_list.EXTEND(8);
   DBMS_OUTPUT.put_line ('�䳤����ĵ�ǰ����Ϊ��' || project_list.COUNT);   
END;


/* Formatted on 2011/09/10 20:00 (Formatter Plus v4.8.8) */
DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --������Ŀ�б�䳤����

   project_list   projectlist := projectlist ('��վ', 'ERP', 'CRM', 'CMS');
BEGIN
   DBMS_OUTPUT.put_line ('project_list�ĵ�1��Ԫ���±꣺' || project_list.FIRST
                        );                             --�鿴��1��Ԫ�ص��±�
   project_list.EXTEND (8);                            --��չ8��Ԫ��
   DBMS_OUTPUT.put_line (   'project_list�����һ��Ԫ�ص��±꣺'
                         || project_list.LAST
                        );                             --�鿴���1��Ԫ�ص��±�
END;



/* Formatted on 2011/09/10 20:46 (Formatter Plus v4.8.8) */
DECLARE
   TYPE idx_table IS TABLE OF VARCHAR (12)
      INDEX BY PLS_INTEGER;                                  --��������������
   v_emp   idx_table;                                        --�������������
   i       PLS_INTEGER;                                      --����ѭ�����Ʊ���
BEGIN
   v_emp (1) := 'ʷ��˹';                                   --�����Ϊ������ֵ
   v_emp (20) := '������';
   v_emp (40) := 'ʷ���';
   v_emp (-10) := '����';
   --��ȡ�����е�-10��Ԫ�ص���һ��ֵ
   DBMS_OUTPUT.put_line ('��-10��Ԫ�ص���һ��ֵ��' || v_emp (v_emp.NEXT (-10)));
   --��ȡ�����е�40��Ԫ�ص���һ��ֵ
   DBMS_OUTPUT.put_line ('��40��Ԫ�ص���һ��ֵ��' || v_emp (v_emp.PRIOR (40)));
   i := v_emp.FIRST;                                        --��λ����1��Ԫ�ص��±�
   WHILE i IS NOT NULL                                      --��ʼѭ��ֱ���±�ΪNULL
   LOOP                                                     --���Ԫ�ص�ֵ
      DBMS_OUTPUT.put_line ('v_emp(' || i || ')=' || v_emp (i));
      i := v_emp.NEXT (i);                                  --�����ƶ�ѭ��ָ�룬ָ����һ���±�
   END LOOP;
END;



/* Formatted on 2011/09/10 21:35 (Formatter Plus v4.8.8) */
DECLARE
   TYPE courselist IS TABLE OF VARCHAR2 (10);                --����Ƕ�ױ�
   --����γ�Ƕ�ױ����
   courses   courselist;
   i PLS_INTEGER;
BEGIN
   courses := courselist ('����', '����', '��ѧ');           --��ʼ��Ԫ��
   courses.DELETE (3);                                       --ɾ����3��Ԫ��
   courses.EXTEND;                                           --׷��һ���µ�NULLԪ��
   courses (4) := 'Ӣ��'; 
   courses.EXTEND(5,1);                                      --�ѵ�1��Ԫ�ؿ���5����ӵ�ĩβ  
   i:=courses.FIRST; 
   WHILE i IS NOT NULL LOOP                                  --ѭ����ʾ���ֵ
      DBMS_OUTPUT.PUT_LINE('courses('||i||')='||courses(i));
      i:=courses.NEXT(i);
   END LOOP;
END;


DECLARE
   TYPE courselist IS TABLE OF VARCHAR2 (10);                --����Ƕ�ױ�
   --����γ�Ƕ�ױ����
   courses   courselist;
   i PLS_INTEGER;
BEGIN
   courses := courselist ('����', '����', '��ѧ','����','��ѧ','����');--��ʼ��Ԫ��
   courses.TRIM(2);                                             --ɾ������ĩβ��2��Ԫ��
   DBMS_OUTPUT.PUT_LINE('��ǰ��Ԫ�ظ�����'||courses.COUNT);  --��ʾԪ�ظ���
   courses.EXTEND;                                             --��չ1��Ԫ��   
   courses(courses.COUNT):='����';                             --Ϊ���1��Ԫ�ظ�ֵ
   courses.TRIM;                                               --ɾ������ĩβ�����1��Ԫ�� 
   i:=courses.FIRST; 
   WHILE i IS NOT NULL LOOP                                  --ѭ����ʾ���ֵ
      DBMS_OUTPUT.PUT_LINE('courses('||i||')='||courses(i));
      i:=courses.NEXT(i);
   END LOOP;
END;


DECLARE
   TYPE courselist IS TABLE OF VARCHAR2 (10);                --����Ƕ�ױ�
   --����γ�Ƕ�ױ����
   courses   courselist;
   i PLS_INTEGER;
BEGIN
   courses := courselist ('����', '����', '��ѧ','����','��ѧ','����');--��ʼ��Ԫ��
   courses.DELETE(2);                                             --ɾ����2��Ԫ��
   DBMS_OUTPUT.PUT_LINE('��ǰ��Ԫ�ظ�����'||courses.COUNT);    --��ʾԪ�ظ���
   courses.EXTEND;                                                --��չ1��Ԫ��  
   DBMS_OUTPUT.PUT_LINE('��ǰ��Ԫ�ظ�����'||courses.COUNT);    --��ʾԪ�ظ���    
   courses(courses.LAST):='����';                                 --Ϊ���1��Ԫ�ظ�ֵ
   courses.DELETE(4,courses.COUNT);                               --ɾ������ĩβ�����1��Ԫ�� 
   i:=courses.FIRST; 
   WHILE i IS NOT NULL LOOP                                        --ѭ����ʾ���ֵ
      DBMS_OUTPUT.PUT_LINE('courses('||i||')='||courses(i));
      i:=courses.NEXT(i);
   END LOOP;
END;



DECLARE
   TYPE numlist IS TABLE OF NUMBER;
   nums numlist;          --һ���յ�Ƕ�ױ�
BEGIN
   nums(1):=1;        --δ�����ʹ�ñ�Ԫ�أ���������ORA-06531:����δ��ʼ�����ռ�
   nums:=numlist(1,2);--��ʼ��Ƕ�ױ�
   nums(NULL):=3;     --ʹ��NULL����������������ORA-06502:PL/SQL:���ֻ�ֵ����:NULL�������ֵ
   nums(0):=3;        --���ʲ����ڵ��±꣬��������ORA-06532:�±곬������
   nums(3):=3;        --�±곬�����Ԫ�ظ�������������ORA-06532:�±곬������
   nums.DELETE(1);    --ɾ����1��Ԫ��
   IF nums(1)=1 THEN
      NULL;
       --��Ϊ��1��Ԫ���ѱ�ɾ�����ٷ��ʽ�������ORA-01403: δ�ҵ��κ�����
   END IF;
END;


DECLARE
   TYPE dept_type IS VARRAY (20) OF NUMBER;  --����Ƕ�ױ����  
   depts dept_type:=dept_type (10, 30, 70);  --ʵ����Ƕ�ױ�����3��Ԫ��
BEGIN
   FOR i IN depts.FIRST..depts.LAST          --ѭ��Ƕ�ױ�Ԫ�� 
   LOOP
      DELETE FROM emp
            WHERE deptno = depts (i);       --��SQL���淢��SQL����ִ��SQL����
   END LOOP;
END;


/* Formatted on 2011/09/11 14:26 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_type IS VARRAY (20) OF NUMBER;                  --����Ƕ�ױ����
   depts   dept_type := dept_type (10, 30, 70);   --ʵ����Ƕ�ױ�����3��Ԫ��   
BEGIN
   FORALL i IN depts.FIRST .. depts.LAST                     --ѭ��Ƕ�ױ�Ԫ��
      DELETE FROM emp
            WHERE deptno = depts (i);       --��SQL���淢��SQL����ִ��SQL����
   FOR i IN 1..depts.COUNT LOOP  
   DBMS_OUTPUT.put_line (   '���ű��'
                         || depts (i)
                         || '��ɾ��������Ӱ�����Ϊ��'
                         || SQL%BULK_ROWCOUNT (i)
                        );
   END LOOP;
END;


/* Formatted on 2011/09/11 15:15 (Formatter Plus v4.8.8) */
DECLARE
   TYPE numtab IS TABLE OF emp.empno%TYPE;     --Ա�����Ƕ�ױ�
   TYPE nametab IS TABLE OF emp.ename%TYPE;    --Ա������Ƕ�ױ�
   nums    numtab;                             --����Ƕ�ױ����������Ҫ��ʼ��        
   names   nametab;
BEGIN
   SELECT empno, ename
   BULK COLLECT INTO nums, names
     FROM emp;                                --��emp���в��Ա����ź����ƣ��������뵽����
   FOR i IN 1 .. nums.COUNT                   --ѭ����ʾ��������
   LOOP
      DBMS_OUTPUT.put ('num(' || i || ')=' || nums (i)||'   ');
      DBMS_OUTPUT.put_line ('names(' || i || ')=' || names (i));      
   END LOOP;
END;