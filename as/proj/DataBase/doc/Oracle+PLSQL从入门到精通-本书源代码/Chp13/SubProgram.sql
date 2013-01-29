
CREATE OR REPLACE PROCEDURE newdept (
   p_deptno   dept.deptno%TYPE,    --���ű��
   p_dname    dept.dname%TYPE,     --��������
   p_loc      dept.loc%TYPE        --λ��
)
AS
   v_deptcount   NUMBER;           --�����Ƿ����Ա�����
BEGIN
   SELECT COUNT (*) INTO v_deptcount FROM dept
    WHERE deptno = p_deptno;       --��ѯ��dept�����Ƿ���ڲ��ű��
   IF v_deptcount > 0              --���������ͬ��Ա����¼
   THEN                            --�׳��쳣
      raise_application_error (-20002, '��������ͬ��Ա����¼');
   END IF;
   INSERT INTO dept(deptno, dname, loc)  
        VALUES (p_deptno, p_dname, p_loc);--�����¼
   COMMIT;                          --�ύ����
END;

SELECT * FROM dept;

BEGIN
   newdept(10,'�ɱ���','����');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('�����˴���'||SQLERRM);
END;

SELECT object_type ��������, object_name ��������, status ״̬
 FROM user_objects
 WHERE object_type IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
ORDER BY object_type, status, object_name;



CREATE OR REPLACE PROCEDURE newdept (
   p_deptno IN  NUMBER,    --���ű��
   p_dname  IN  VARCHAR2,     --��������
   p_loc    IN  VARCHAR2        --λ��
)
AS
   v_deptcount     NUMBER(4);           --�����Ƿ����Ա�����
   e_duplication_dept EXCEPTION;
BEGIN
   SELECT COUNT (*) INTO v_deptcount FROM dept
    WHERE deptno = p_deptno;       --��ѯ��dept�����Ƿ���ڲ��ű��
   IF v_deptcount > 0              --���������ͬ��Ա����¼
   THEN                            --�׳��쳣
      RAISE e_duplication_dept;
   END IF;
   INSERT INTO dept(deptno, dname, loc)  
        VALUES (p_deptno, p_dname, p_loc);--�����¼
   COMMIT;                          --�ύ����
EXCEPTION   
   WHEN e_duplication_dept THEN
      ROLLBACK;
      raise_application_error (-20002, '��������ͬ��Ա����¼');
END;

SHOW ERRORS;


SELECT * FROM emp;

CREATE OR REPLACE FUNCTION getraisedsalary (p_empno emp.empno%TYPE)
   RETURN NUMBER
IS
   v_job           emp.job%TYPE;            --ְλ����
   v_sal           emp.sal%TYPE;            --н�ʱ���
   v_salaryratio   NUMBER (10, 2);          --��н����
BEGIN
   --��ȡԱ�����е�н����Ϣ
   SELECT job, sal INTO v_job, v_sal FROM emp WHERE empno = p_empno;
   CASE v_job                               --���ݲ�ͬ��ְλ��ȡ��н����
      WHEN 'ְԱ' THEN
         v_salaryratio := 1.09;
      WHEN '������Ա' THEN
         v_salaryratio := 1.11;
      WHEN '����' THEN
         v_salaryratio := 1.18;
      ELSE
         v_salaryratio := 1;
   END CASE;
   IF v_salaryratio <> 1                    --����е�н�Ŀ���
   THEN
      RETURN ROUND(v_sal * v_salaryratio,2);         --���ص�н���н��
   ELSE
      RETURN v_sal;                         --���򲻷���н��
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 0;                             --���û�ҵ�ԭ����¼������0
END;


DECLARE
   v_raisedsal NUMBER(10,2);     --���屣���н��¼����ʱ�ļ�
BEGIN
   --���ú�����ȡ��н��ļ�¼
   DBMS_OUTPUT.PUT_LINE('7369Ա����н��¼��'||getraisedsalary(7369));
   v_raisedsal:=getraisedsalary(7521);
   DBMS_OUTPUT.PUT_LINE('7521Ա����н��¼��'||getraisedsalary(7521));   
END;

SELECT * FROM emp;


CREATE OR REPLACE PROCEDURE RaiseSalary(
              p_empno emp.empno%TYPE             --Ա����Ų���
              )
AS
   v_job emp.job%TYPE;                           --�ֲ���ְλ����
   v_sal emp.sal%TYPE;                           --�ֲ���н�ʱ���
BEGIN
   --��ѯԱ����Ϣ
   SELECT job,sal INTO v_job,v_sal FROM emp WHERE empno=p_empno;
   IF v_job<>'ְԱ' THEN                         --��ΪְԱ��н
      RETURN;                                    --�������ְԱ�����˳�
   ELSIF v_sal>3000 THEN                         --���ְԱн�ʴ���3000,���˳�
      RETURN;
   ELSE     
     --�������н�ʼ�¼
     UPDATE emp set sal=ROUND(sal*1.12,2) WHERE empno=v_empno;
   END IF; 
EXCEPTION
   WHEN NO_DATA_FOUND THEN                       --�쳣����
      DBMS_OUTPUT.PUT_LINE('û���ҵ�Ա����¼');     
END;              


/* Formatted on 2011/10/14 07:11 (Formatter Plus v4.8.8) */
SELECT object_name, created, last_ddl_time, status
  FROM user_objects
 WHERE object_type IN ('FUNCTION','PROCEDURE');
 
 
/* Formatted on 2011/10/14 07:41 (Formatter Plus v4.8.8) */
SELECT   line, text
    FROM user_source
   WHERE NAME = 'RAISESALARY'
ORDER BY line;


/* Formatted on 2011/10/14 07:41 (Formatter Plus v4.8.8) */
SELECT   line, POSITION, text
    FROM user_errors
   WHERE NAME = 'RAISESALARY'
ORDER BY SEQUENCE;




DROP FUNCTION getraisedsalary ;
DROP PROCEDURE NewDept;

SELECT * FROM dept;

CREATE OR REPLACE PROCEDURE insertdept( 
   p_deptno NUMBER,                                     --������ʽ����
   p_dname VARCHAR2,
   p_loc VARCHAR2
)
AS
   v_count NUMBER(10);
BEGIN
   SELECT COUNT(deptno) INTO v_count FROM dept WHERE deptno=p_deptno;
   IF v_count>1 THEN
      RAISE_APPLICATION_ERROR(-20001,'���ݿ��д�����ͬ���ƵĲ��ű�ţ�');
   END IF;
   INSERT INTO dept VALUES(p_deptno,p_dname,p_loc);    --�ڹ�������ʹ����ʽ����
   COMMIT;
END;

BEGIN
   insertdept('ABC','������','�¿���˹');
EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;


CREATE OR REPLACE PROCEDURE insertdept( 
   p_deptno IN NUMBER:=55,                             --������ʽ������������ֵ
   p_dname IN VARCHAR2,
   p_loc IN VARCHAR2
)
AS
   v_count NUMBER(10);
BEGIN
   --p_dname:='�г����Բ�';                            --���󣬲��ܶ�INģʽ�������и�ֵ
   SELECT COUNT(deptno) INTO v_count FROM dept WHERE deptno=p_deptno;
   IF v_count>1 THEN
      RAISE_APPLICATION_ERROR(-20001,'���ݿ��д�����ͬ���ƵĲ��ű�ţ�');
   END IF;
   INSERT INTO dept VALUES(p_deptno,p_dname,p_loc);    --�ڹ�������ʹ����ʽ����
   COMMIT;
END;


BEGIN
   insertdept(55,'���˲�','����');
END;


CREATE OR REPLACE PROCEDURE OutRaiseSalary(
    p_empno IN NUMBER,
    p_raisedSalary OUT NUMBER                     --����һ��Ա����н���н�ʵ��������
)
AS
    v_sal NUMBER(10,2);                           --���屾�ؾֲ�����
    v_job VARCHAR2(10);
BEGIN
    p_raisedSalary:=0;                            --��������ֵ
    SELECT sal,job INTO v_sal,v_job FROM emp WHERE empno=p_empno;   --��ѯԱ����Ϣ
    IF v_job='ְԱ' THEN                          --����ְԱ��н
       p_raisedSalary:=v_sal*1.12;                --��OUTģʽ�Ĳ������и�ֵ�ǺϷ���
       UPDATE emp SET sal=p_raisedSalary WHERE empno=p_empno;
    ELSE
       p_raisedSalary:=v_sal;                     --����ԭ����н��ֵ
    END IF;
EXCEPTION    
   WHEN NO_DATA_FOUND THEN                         --�쳣��������
     DBMS_OUTPUT.put_line('û���ҵ���Ա���ļ�¼');
END;    


SELECT * FROM emp;

DECLARE 
   v_raisedsalary NUMBER(10,2);            --����һ�������������ֵ
BEGIN
   v_raisedsalary:=100;                     --�����ֵ�ڴ��뵽OutRaiseSalary��ᱻ����
   OutRaiseSalary(7369,v_raisedsalary);     --���ú���
   DBMS_OUTPUT.put_line(v_raisedsalary); --��ʾ���������ֵ
END;


CREATE OR REPLACE PROCEDURE calcRaisedSalary(
         p_job IN VARCHAR2,
         p_salary IN OUT NUMBER                         --���������������
)
AS
  v_sal NUMBER(10,2);                               --����������н��ֵ
BEGIN
  if p_job='ְԱ' THEN                              --���ݲ�ͬ��job����н�ʵĵ���
     v_sal:=p_salary*1.12;
  ELSIF p_job='������Ա' THEN
     v_sal:=p_salary*1.18;
  ELSIF p_job='����' THEN
     v_sal:=p_salary*1.19;
  ELSE
     v_sal:=p_salary;
  END IF;
  p_salary:=v_sal;                                   --��������Ľ�����������������
END calcRaisedSalary;



DECLARE
   v_sal NUMBER(10,2);                 --н�ʱ���
   v_job VARCHAR2(10);                 --ְλ����
BEGIN
   SELECT sal,job INTO v_sal,v_job FROM emp WHERE empno=7369; --��ȡн�ʺ�ְλ��Ϣ
   calcRaisedSalary(v_job,v_sal);                             --�����н
   DBMS_OUTPUT.put_line('�����ĵ���нˮΪ��'||v_sal);    --��ȡ��н��Ľ��
END;   

DECLARE
   v_sal NUMBER(10,2);                 --н�ʱ���
   v_job VARCHAR2(10);                 --ְλ����
BEGIN   
   ....
   calcRaisedSalary(v_job,v_sal);                             --�����н
   ...   
END;   


CREATE OR REPLACE PROCEDURE calcRaisedSalaryWithTYPE(
         p_job IN emp.job%TYPE,
         p_salary IN OUT emp.sal%TYPE               --���������������
)
AS
  v_sal NUMBER(10,2);                               --����������н��ֵ
BEGIN
  if p_job='ְԱ' THEN                              --���ݲ�ͬ��job����н�ʵĵ���
     v_sal:=p_salary*1.12;
  ELSIF p_job='������Ա' THEN
     v_sal:=p_salary*1.18;
  ELSIF p_job='����' THEN
     v_sal:=p_salary*1.19;
  ELSE
     v_sal:=p_salary;
  END IF;
  p_salary:=v_sal;                                   --��������Ľ�����������������
END calcRaisedSalaryWithTYPE;



DECLARE
   v_sal NUMBER(8,2);                 --н�ʱ���
   v_job VARCHAR2(10);                 --ְλ����
BEGIN
   v_sal:=123294.45;
   v_job:='ְԱ';
   calcRaisedSalaryWithTYPE(v_job,v_sal);                             --�����н
   DBMS_OUTPUT.put_line('�����ĵ���нˮΪ��'||v_sal);    --��ȡ��н��Ľ��
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   



DECLARE
   v_sal NUMBER(8,2);                 --н�ʱ���
   v_job VARCHAR2(10);                 --ְλ����
BEGIN
   v_sal:=123294.45;
   v_job:='ְԱ';
   calcRaisedSalaryWithTYPE(p_job=>v_job,p_salary=>v_sal);                             --�����н
   DBMS_OUTPUT.put_line('�����ĵ���нˮΪ��'||v_sal);    --��ȡ��н��Ľ��
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   


DECLARE
   v_sal NUMBER(7,2);                 --н�ʱ���
   v_job VARCHAR2(10);                 --ְλ����
BEGIN
   v_sal:=1224.45;
   v_job:='ְԱ';
   calcRaisedSalaryWithTYPE(p_salary=>v_sal,p_job=>v_job);                             --�����н
   DBMS_OUTPUT.put_line('�����ĵ���нˮΪ��'||v_sal);    --��ȡ��н��Ľ��
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   



DECLARE
   v_sal NUMBER(7,2);                 --н�ʱ���
   v_job VARCHAR2(10);                 --ְλ����
BEGIN
   v_sal:=1224.45;
   v_job:='ְԱ';
   calcRaisedSalaryWithTYPE(p_salary=>v_sal,v_job);                             --�����н
   DBMS_OUTPUT.put_line('�����ĵ���нˮΪ��'||v_sal);    --��ȡ��н��Ľ��
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   




CREATE OR REPLACE PROCEDURE newdeptwithdefault (
   p_deptno   dept.deptno%TYPE DEFAULT 57,    --���ű��
   p_dname    dept.dname%TYPE:='����',     --��������
   p_loc      dept.loc%TYPE DEFAULT '����'        --λ��
)
AS
   v_deptcount   NUMBER;           --�����Ƿ����Ա�����
BEGIN
   SELECT COUNT (*) INTO v_deptcount FROM dept
    WHERE deptno = p_deptno;       --��ѯ��dept�����Ƿ���ڲ��ű��
   IF v_deptcount > 0              --���������ͬ��Ա����¼
   THEN                            --�׳��쳣
      raise_application_error (-20002, '��������ͬ��Ա����¼');
   END IF;
   INSERT INTO dept(deptno, dname, loc)  
        VALUES (p_deptno, p_dname, p_loc);--�����¼
END;

BEGIN
   newdeptwithdefault;       --��ָ���κβ�������ʹ���β�Ĭ��ֵ
END;

BEGIN
   newdeptwithdefault(58,'������');       --��ָ���κβ�������ʹ���β�Ĭ��ֵ
END;


BEGIN
   newdeptwithdefault(58,'������');       
END;

BEGIN
   newdeptwithdefault(p_deptno=>58,p_loc=>'�Ϻ�');       --��dnameʹ��Ĭ��ֵ
END;

SELECT * FROM dept;


/* Formatted on 2011/10/15 16:01 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emptabtyp IS TABLE OF emp%ROWTYPE;               --����Ƕ�ױ�����
   emp_tab   emptabtyp  := emptabtyp (NULL);             --����һ���հ׵�Ƕ�ױ����
   t1        NUMBER (5);                                 --���屣��ʱ�����ʱ����
   t2        NUMBER (5);
   t3        NUMBER (5);

   PROCEDURE get_time (t OUT NUMBER)                     --��ȡ��ǰʱ��
   IS
   BEGIN
      SELECT TO_CHAR (SYSDATE, 'SSSSS')                  --��ȡ����ҹ����ǰ������
        INTO t
        FROM DUAL;
      DBMS_OUTPUT.PUT_LINE(t);        
   END;
   PROCEDURE do_nothing1 (tab IN OUT emptabtyp)          --����һ���հ׵Ĺ��̣�����IN OUT����
   IS
   BEGIN
      NULL;
   END;

   PROCEDURE do_nothing2 (tab IN OUT NOCOPY emptabtyp)   --�ڲ�����ʹ��NOCOPY������ʾ
   IS
   BEGIN
      NULL;
   END;
BEGIN
   SELECT *
     INTO emp_tab (1)
     FROM emp
    WHERE empno = 7788;                                  --��ѯemp���е�Ա�������뵽emp_tab��1����¼
   emp_tab.EXTEND (900000, 1);                            --������1��Ԫ��N��
   get_time (t1);                                        --��ȡ��ǰʱ��
   do_nothing1 (emp_tab);                                --ִ�в���NOCOPY�Ĺ���
   get_time (t2);                                        --��ȡ��ǰʱ��
   do_nothing2 (emp_tab);                                --ִ�д�NOCOPY�Ĺ���
   get_time (t3);                                        --��ȡ��ǰʱ��
   DBMS_OUTPUT.put_line ('���������ѵ�ʱ��(��)');
   DBMS_OUTPUT.put_line ('--------------------');
   DBMS_OUTPUT.put_line ('����NOCOPY�ĵ���:' || TO_CHAR (t2 - t1));
   DBMS_OUTPUT.put_line ('��NOCOPY�ĵ���:' || TO_CHAR (t3 - t2));
END;
/




CREATE OR REPLACE FUNCTION getempdept(
        p_empno emp.empno%TYPE
) RETURN VARCHAR2                                 --����������Oracle���ݿ�����
AS
  v_dname dept.dname%TYPE;               
BEGIN
   SELECT b.dname INTO v_dname FROM emp a,dept b 
   WHERE a.deptno=b.deptno
   AND a.empno=p_empno;
   RETURN v_dname;                                --��ѯ���ݱ���ȡ��������
EXCEPTION 
   WHEN NO_DATA_FOUND THEN
      RETURN NULL;                                --������ֲ�ѯ�������ݣ�����NULL
END;        


SELECT empno Ա�����,getempdept(empno) Ա������ from emp;



CREATE OR REPLACE FUNCTION getraisedsalary_subprogram (p_empno emp.empno%TYPE)
   RETURN NUMBER
IS
   v_salaryratio   NUMBER (10, 2);             --��н����  
   v_sal           emp.sal%TYPE;            --н�ʱ���     
   --������Ƕ�Ӻ���������н�ʺ͵�н����  
   FUNCTION getratio(p_sal OUT NUMBER) RETURN NUMBER IS
      n_job           emp.job%TYPE;            --ְλ����
      n_salaryratio   NUMBER (10, 2);          --��н����       
   BEGIN
       --��ȡԱ�����е�н����Ϣ
       SELECT job, sal INTO n_job, p_sal FROM emp WHERE empno = p_empno;
       CASE n_job                               --���ݲ�ͬ��ְλ��ȡ��н����
          WHEN 'ְԱ' THEN
             n_salaryratio := 1.09;
          WHEN '������Ա' THEN
             n_salaryratio := 1.11;
          WHEN '����' THEN
             n_salaryratio := 1.18;
          ELSE
             n_salaryratio := 1;
       END CASE; 
       RETURN n_salaryratio;    
   END;        
BEGIN
   v_salaryratio:=getratio(v_sal);          --����Ƕ�׺�������ȡ��н���ʺ�Ա��н��
   IF v_salaryratio <> 1                    --����е�н�Ŀ���
   THEN
      RETURN ROUND(v_sal * v_salaryratio,2);         --���ص�н���н��
   ELSE
      RETURN v_sal;                         --���򲻷���н��
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 0;                             --���û�ҵ�ԭ����¼������0
END;



BEGIN
   --���ú�����ȡ��н��ļ�¼
   DBMS_OUTPUT.PUT_LINE('7369Ա����н��¼��'||getraisedsalary_subprogram(7369));
   DBMS_OUTPUT.PUT_LINE('7521Ա����н��¼��'||getraisedsalary_subprogram(7521));   
END;


DECLARE
   v_val BINARY_INTEGER:=5;
   PROCEDURE B(p_counter IN OUT BINARY_INTEGER);            --ǰ������Ƕ���ӳ���B
   PROCEDURE A(p_counter IN OUT BINARY_INTEGER) IS          --����Ƕ���ӳ���A
   BEGIN
      DBMS_OUTPUT.PUT_LINE('A('||p_counter||')');
      IF p_counter>0 THEN
         B(p_counter);                                      --��Ƕ���ӳ����е���B
         p_counter:=p_counter-1;
      END IF;
   END A;
   PROCEDURE B(p_counter IN OUT BINARY_INTEGER) IS          --����Ƕ���ӳ���B
   BEGIN
      DBMS_OUTPUT.PUT_LINE('B('||p_counter||')');
      p_counter:=p_counter-1;
      A(p_counter);                                          --��Ƕ���ӳ����е���A
   END B;
BEGIN
   B(v_val);                                                 --����Ƕ���ӳ���B
END;


DECLARE
    PROCEDURE GetSalary(p_empno IN NUMBER) IS                       --��һ�������Ĺ���
    BEGIN
      DBMS_OUTPUT.put_line('Ա�����Ϊ��'||p_empno);      
    END;
    PROCEDURE GetSalary(p_empname IN VARCHAR2) IS                    --���صĹ���
    BEGIN
      DBMS_OUTPUT.put_line('Ա������Ϊ��'||p_empname);
    END;
    PROCEDURE GETSalary(p_empno IN NUMBER,p_empname IN VARCHAR) IS   --���Ĺ���
    BEGIN
      DBMS_OUTPUT.put_line('Ա�����Ϊ��'||p_empno||' Ա������Ϊ��'||p_empname);
    END;       
BEGIN 
    GetSalary(7369);                                                 --�������ط�δ��
    GetSalary('ʷ��˹');
    GetSalary(7369,'ʷ��˹');        
END;   

SELECT * FROM emp;

CREATE TABLE emp_history AS SELECT * FROM emp WHERE 1=2;

SELECT * FROM emp_history;


DECLARE
   PROCEDURE TestAutonomous(p_empno NUMBER) AS
     PRAGMA AUTONOMOUS_TRANSACTION;         --���Ϊ��������
   BEGIN
     --���ڹ����������ε����������񱻹���
     INSERT INTO emp_history SELECT * FROM emp WHERE empno=p_empno;
     COMMIT;                                --�ύ�������񣬲�Ӱ��������
   END TestAutonomous;
BEGIN
   --������ʼִ��
   INSERT INTO emp_history(empno,ename,sal) VALUES(1011,'����',1000);
   TestAutonomous(7369);                    --��������𣬿�ʼ��������
   ROLLBACK;                                --�ع�������
END;


DECLARE
  v_result INTEGER;
  FUNCTION fac(n POSITIVE)
       RETURN INTEGER IS                       --�׳˵ķ��ؽ��
   BEGIN
      IF n=1 THEN                              --���n=1����ֹ����
         DBMS_OUTPUT.put('1!=1*0!');      
         RETURN 1;                         
      ELSE
       DBMS_OUTPUT.put(n||'!='||n||'*');
      RETURN n*fac(n-1);                      --������еݹ��������
      END IF;
   END fac; 
BEGIN
  v_result:= fac(10);                          --���ý׳˺���
  DBMS_OUTPUT.put_line('����ǣ�'||v_result); --����׳˽��
END;




/* Formatted on 2011/10/16 16:30 (Formatter Plus v4.8.8) */
DECLARE
    PROCEDURE find_staff (mgr_no NUMBER, tier NUMBER := 1)
    IS
       boss_name   VARCHAR2 (10);                  --�����ϰ������
       CURSOR c1 (boss_no NUMBER)                  --�����α�����ѯemp���е�ǰ����µ�Ա���б�
       IS
          SELECT empno, ename
            FROM emp
           WHERE mgr = boss_no;
    BEGIN
       SELECT ename INTO boss_name FROM emp
        WHERE empno = mgr_no;                      --��ȡ����������
       IF tier = 1                                 --���tierָ��1,��ʾ����㿪ʼ��ѯ
       THEN
          INSERT INTO staff                          
               VALUES (boss_name || ' ���ϰ� ');   --��Ϊ��1�����ϰ壬����Ĳ��Ǿ���
       END IF;
       FOR ee IN c1 (mgr_no)                       --ͨ���α�FORѭ����staff�����Ա����Ϣ
       LOOP
          INSERT INTO staff
               VALUES (   boss_name
                       || ' ���� '
                       || ee.ename
                       || ' �ڲ�� '
                       || TO_CHAR (tier));
          find_staff (ee.empno, tier + 1);        --���α��У��ݹ�����²��Ա���б�
       END LOOP;
       COMMIT;
    END find_staff;
BEGIN
  find_staff(7839);                           --��ѯ7839�Ĺ����µ�Ա�����б�Ͳ�νṹ
END;


CREATE TABLE staff(emplist VARCHAR2(1000));



SELECT * FROM staff;

SELECT * FROM emp;
truncate table staff;


CREATE OR REPLACE PROCEDURE TestDependence AS
BEGIN
   --��emp������������
   INSERT INTO emp(empno,ename,sal) VALUES(1011,'����',1000);
   TestSubProg(7369);                   
   ROLLBACK;                               
END;
--����һ�����̵��ã�������emp_history���������
CREATE OR REPLACE PROCEDURE TestSubProg(p_empno NUMBER) AS
 BEGIN
     INSERT INTO emp_history SELECT * FROM emp WHERE empno=p_empno;
 END TestSubProg;
 
 SELECT name,type FROM user_dependencies WHERE referenced_name='EMP';
 
 
EXEC deptree_fill('TABLE','SCOTT','EMP');

/* Formatted on 2011/10/16 21:47 (Formatter Plus v4.8.8) */
SELECT nested_level, NAME, TYPE
  FROM deptree
 WHERE TYPE IN ('PROCEDURE', 'FUNCTION');
 
 
 /* Formatted on 2011/10/16 22:04 (Formatter Plus v4.8.8) */
 
ALTER TABLE emp_history DROP COLUMN emp_desc;
ALTER TABLE emp_history ADD emp_desc VARCHAR2(200) NULL; 
SELECT object_name, object_type, status
  FROM user_objects
 WHERE object_name in ('TESTDEPENDENCE','TESTSUBPROG');
 
 
 
 
 ALTER TABLE emp_history DROP COLUMN emp_desc;
 ALTER PROCEDURE testdependence COMPILE;
 ALTER PROCEDURE testsubprog COMPILE; 
 
 CREATE OR REPLACE PROCEDURE find_staff (mgr_no NUMBER, tier NUMBER := 1)
  AUTHID CURRENT_USER
 IS
   boss_name   VARCHAR2 (10);                  --�����ϰ������
   CURSOR c1 (boss_no NUMBER)                  --�����α�����ѯemp���е�ǰ����µ�Ա���б�
   IS
      SELECT empno, ename
        FROM emp
       WHERE mgr = boss_no;
BEGIN
   SELECT ename INTO boss_name FROM emp
    WHERE empno = mgr_no;                      --��ȡ����������
   IF tier = 1                                 --���tierָ��1,��ʾ����㿪ʼ��ѯ
   THEN
      INSERT INTO staff                          
           VALUES (boss_name || ' ���ϰ� ');   --��Ϊ��1�����ϰ壬����Ĳ��Ǿ���
   END IF;
   FOR ee IN c1 (mgr_no)                       --ͨ���α�FORѭ����staff�����Ա����Ϣ
   LOOP
      INSERT INTO staff
           VALUES (   boss_name
                   || ' ���� '
                   || ee.ename
                   || ' �ڲ�� '
                   || TO_CHAR (tier));
      find_staff (ee.empno, tier + 1);        --���α��У��ݹ�����²��Ա���б�
   END LOOP;
   COMMIT;
END find_staff; 
 

 
 
 
CREATE USER userb IDENTIFIED BY userb;                 --�����û�userb������ҲΪuserb
GRANT RESOURCE,CONNECT TO userb;                       --Ϊuserb�����ɫ
GRANT EXECUTE ON find_staff TO userb;                  --ʹ��userb����ִ��find_staff
DROP USER userb;


GRANT EXECUTE ON find_staff TO userb;






 
 
 
 
 
 
 
 
 