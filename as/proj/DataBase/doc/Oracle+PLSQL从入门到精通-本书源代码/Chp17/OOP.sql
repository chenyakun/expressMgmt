--����������͹淶employee_obj
CREATE OR REPLACE TYPE employee_obj AS OBJECT (
--���������������
empno         NUMBER(4),
ename         VARCHAR2(20),
job           VARCHAR2(20),
sal           NUMBER(10,2),
comm          NUMBER(10,2),
deptno        NUMBER(4),
--����������ͷ���
MEMBER PROCEDURE Change_sal(p_empno NUMBER,p_sal NUMBER),
MEMBER PROCEDURE Change_comm(p_empno NUMBER,p_comm NUMBER),
MEMBER PROCEDURE Change_deptno(p_empno NUMBER,p_deptno NUMBER),
MEMBER FUNCTION get_sal(p_empno NUMBER) RETURN NUMBER,
MEMBER FUNCTION get_comm(p_empno NUMBER) RETURN NUMBER,
MEMBER FUNCTION get_deptno(p_empno NUMBER) RETURN INTEGER
) NOT FINAL;      --ָ��������Ա��̳У����ָ��FINAL����ʾ�����޷����̳�


/* Formatted on 2011/10/31 06:53 (Formatter Plus v4.8.8) */
--�������������
CREATE OR REPLACE TYPE BODY employee_obj
AS
   MEMBER PROCEDURE change_sal (p_empno NUMBER, p_sal NUMBER)
   IS                          --��������Ա����������Ա��н��
   BEGIN
      UPDATE emp
         SET sal = p_sal
       WHERE empno = p_empno;
   END;
   MEMBER PROCEDURE change_comm (p_empno NUMBER, p_comm NUMBER)
   IS                         --��������Ա����������Ա�����
   BEGIN
      UPDATE emp
         SET comm = p_comm
       WHERE empno = p_empno;
   END;
   MEMBER PROCEDURE change_deptno (p_empno NUMBER, p_deptno NUMBER)
   IS                        --��������Ա����������Ա������
   BEGIN
      UPDATE emp
         SET deptno = p_deptno
       WHERE empno = p_empno;
   END;
   MEMBER FUNCTION get_sal (p_empno NUMBER)
      RETURN NUMBER
   IS                        --��������Ա��������ȡԱ��н��
      v_sal   NUMBER (10, 2);
   BEGIN
      SELECT sal
        INTO v_sal
        FROM emp
       WHERE empno = p_empno;
      RETURN v_sal;
   END;
   MEMBER FUNCTION get_comm (p_empno NUMBER)
      RETURN NUMBER
   IS                        --��������Ա��������ȡԱ�����
      v_comm   NUMBER (10, 2);
   BEGIN
      SELECT comm
        INTO v_comm
        FROM emp
       WHERE empno = p_empno;
      RETURN v_comm;
   END;
   MEMBER FUNCTION get_deptno (p_empno NUMBER)
      RETURN INTEGER
   IS                        --��������Ա��������ȡԱ������
      v_deptno   INT;
   BEGIN
      SELECT deptno
        INTO v_deptno
        FROM emp
       WHERE empno = p_empno;
      RETURN v_deptno;
   END;
END;







/* Formatted on 2011/10/31 09:23 (Formatter Plus v4.8.8) */
--����������͹淶employee_salobj
CREATE OR REPLACE TYPE employee_salobj AS OBJECT (
--���������������
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--����������ͷ���
   MEMBER PROCEDURE change_sal,
   MEMBER PROCEDURE change_comm,
   MEMBER PROCEDURE change_deptno,
   MEMBER FUNCTION get_sal
      RETURN NUMBER,
   MEMBER FUNCTION get_comm
      RETURN NUMBER,
   MEMBER FUNCTION get_deptno
      RETURN INTEGER
)
NOT FINAL;             --ָ��������Ա��̳У����ָ��FINAL����ʾ�����޷����̳�
----------------------------------------------------------------------------------
--����employee_salobj����������
CREATE OR REPLACE TYPE BODY employee_salobj
AS
   MEMBER PROCEDURE change_sal
   IS
   BEGIN
      SELF.sal := SELF.sal * 1.12;        --ʹ��SELF�ؼ���
   END;
   MEMBER PROCEDURE change_comm
   IS
   BEGIN
      comm := comm * 1.12;               --��ʹ��SELF�ؼ���
   END;
   MEMBER PROCEDURE change_deptno
   IS
   BEGIN
      SELF.deptno := 20;                 --ʹ��SELF�ؼ��ָ��Ĳ�������
   END;
   MEMBER FUNCTION get_sal
      RETURN NUMBER
   IS
   BEGIN
      RETURN sal;                        --����Ա��н��
   END;
   MEMBER FUNCTION get_comm
      RETURN NUMBER
   IS
   BEGIN
      RETURN SELF.comm;                  --����Ա�����
   END;
   MEMBER FUNCTION get_deptno
      RETURN INTEGER
   IS
   BEGIN
      RETURN SELF.deptno;               --����Ա�����ű��
   END;
END;




--����������͹淶employee_obj
CREATE OR REPLACE TYPE employee_property AS OBJECT (
--���������������
empno         NUMBER(4),
ename         VARCHAR2(20),
job           VARCHAR2(20),
sal           NUMBER(10,2),
comm          NUMBER(10,2),
deptno        NUMBER(4)
) NOT FINAL;   --�������Ϳ��Ա��̳�


/* Formatted on 2011/10/31 10:40 (Formatter Plus v4.8.8) */
DECLARE
   v_emp   employee_property;        --�����������
   v_sal   v_emp.sal%TYPE;           --���������������sal������ͬ��н�ʱ���
BEGIN
   --��ʼ���������ͣ�v_emp��һ�������ʵ��
   v_emp := employee_property (7890, '����', '������Ա', 5000, 200, 20);
   v_sal := v_emp.sal;               --Ϊ����������ʵ����ֵ
   --��ȡ�������͵����Խ�����ʾ
   DBMS_OUTPUT.put_line (v_emp.ename || ' ��н���ǣ�' || v_sal);
END;




--����������͹淶employee_salobj

CREATE OR REPLACE TYPE employee_method AS OBJECT (
--���������������
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--����������ͷ���
   MEMBER PROCEDURE change_sal,          --ʵ�����������Է��ʶ����������
   MEMBER FUNCTION get_sal RETURN NUMBER,   
   --��̬���������ܷ��ʶ���������ԣ�ֻ�ܷ��ʾ�̬����
   STATIC PROCEDURE change_deptno (empno NUMBER, deptno NUMBER), 
   STATIC FUNCTION get_sal (empno NUMBER) RETURN NUMBER
)
NOT FINAL;             --ָ��������Ա��̳У����ָ��FINAL����ʾ�����޷����̳�


CREATE OR REPLACE TYPE employee_method AS OBJECT (
--���������������
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--����������ͷ���
   MEMBER PROCEDURE change_sal,          --ʵ�����������Է��ʶ����������
   MEMBER FUNCTION get_sal RETURN NUMBER,   
   --��̬���������ܷ��ʶ���������ԣ�ֻ�ܷ��ʾ�̬����
   STATIC PROCEDURE change_deptno (p_empno NUMBER, p_deptno NUMBER), 
   STATIC FUNCTION get_sal (p_empno NUMBER) RETURN NUMBER
)
NOT FINAL;             --ָ��������Ա��̳У����ָ��FINAL����ʾ�����޷����̳�
----------------------------------------------------------------------------------
--����employee_method����������
CREATE OR REPLACE TYPE BODY employee_method
AS
   MEMBER PROCEDURE change_sal
   IS
   BEGIN
      SELF.sal := SELF.sal * 1.12;        --ʹ��SELF�ؼ���
   END;
   MEMBER FUNCTION get_sal
      RETURN NUMBER
   IS
   BEGIN
      RETURN sal;                        --����Ա��н��
   END;
   STATIC PROCEDURE change_deptno (p_empno NUMBER, p_deptno NUMBER)
   IS                                    --��������Ա����������Ա������
   BEGIN
      UPDATE emp
         SET deptno = p_deptno
       WHERE empno = p_empno;
   END;
   STATIC FUNCTION get_sal (p_empno NUMBER)
      RETURN NUMBER
   IS                                     --��������Ա��������ȡԱ��н��
      v_sal   NUMBER (10, 2);
   BEGIN
      SELECT sal
        INTO v_sal
        FROM emp
       WHERE empno = p_empno;
      RETURN v_sal;
   END; 
END;



DECLARE
   v_emp  employee_method;                    --����employee_method�������͵ı���
BEGIN
   v_emp:=employee_method(7999,5000,200,20);   --ʵ����employee_method��������v_emp�Ƕ���ʵ��
   v_emp.change_sal;                           --���ö���ʵ����������MEMBER����
   DBMS_OUTPUT.put_line('Ա�����Ϊ��'||v_emp.empno||' ��н��Ϊ��'||v_emp.get_sal);   
   --����Ĵ������STATIC��������emp����Ա�����Ϊ7369�Ĳ��ű��Ϊ20.
   employee_method.change_deptno(7369,20);
   --����Ĵ����ȡemp����Ա�����Ϊ7369��Ա��н�ʡ�
  DBMS_OUTPUT.put_line('Ա�����Ϊ7369��н��Ϊ��'||employee_method.get_sal(7369)); 
END;   


--����������͹淶
CREATE OR REPLACE TYPE salary_obj AS OBJECT (
percent        NUMBER(10,4),       --�����������
sal          NUMBER(10,2),
--�Զ��幹�캯��
CONSTRUCTOR FUNCTION salary_obj(p_sal NUMBER) RETURN SELF AS RESULT)
INSTANTIABLE         --��ʵ��������
FINAL;               --�����Լ̳�
/
--�������������
CREATE OR REPLACE TYPE BODY salary_obj
AS
   --ʵ�����صĹ��캯��
   CONSTRUCTOR FUNCTION salary_obj (p_sal NUMBER)
      RETURN SELF AS RESULT
   AS
   BEGIN
      SELF.sal := p_sal;          --��������ֵ
      SELF.PERCENT := 1.12;       --Ϊ����ָ����ֵ
      RETURN;
   END;
END;
/


/* Formatted on 2011/10/31 23:58 (Formatter Plus v4.8.8) */
DECLARE
   v_salobj1   salary_obj;
   v_salobj2   salary_obj;                 --�����������
BEGIN
   v_salobj1 := salary_obj (1.12, 3000);   --ʹ��Ĭ�Ϲ��캯��
   v_salobj2 := salary_obj (2000);         --ʹ���Զ��幹�캯��
END;



--����һ������淶���ù淶�а���MAP����
CREATE OR REPLACE TYPE employee_map AS OBJECT (
--���������������
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
   MAP MEMBER FUNCTION convert RETURN REAL    --����һ��MAP����
)
NOT FINAL;            
--����һ�����������壬ʵ��MAP����
CREATE OR REPLACE TYPE BODY employee_map AS
  MAP MEMBER FUNCTION convert RETURN REAL  IS   --����һ��MAP����
  BEGIN
     RETURN sal+comm;                           --���ر������͵�ֵ
  END;
END;         

--����employee_map���͵Ķ����
CREATE TABLE emp_map_tab OF employee_map;
--�������в���Ա��н����Ϣ����
INSERT INTO emp_map_tab VALUES(7123,3000,200,20);
INSERT INTO emp_map_tab VALUES(7124,2000,800,20);
INSERT INTO emp_map_tab VALUES(7125,5000,800,20);
INSERT INTO emp_map_tab VALUES(7129,3000,400,20);

SELECT VALUE(r) val,r.sal+r.comm FROM emp_map_tab r ORDER BY 1;




--����һ������淶���ù淶�а���ORDER����
CREATE OR REPLACE TYPE employee_order AS OBJECT (
--���������������
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
   ORDER MEMBER FUNCTION match(r employee_order) RETURN INTEGER    --����һ��ORDER����
)
NOT FINAL; 
--����һ�����������壬ʵ��ORDER����
CREATE OR REPLACE TYPE BODY employee_order AS
  ORDER MEMBER FUNCTION match(r employee_order) RETURN INTEGER  IS   
  BEGIN
     IF ((SELF.sal+SELF.comm)<(r.sal+r.comm)) THEN
        RETURN -1;      --��Ϊ�κθ���
     ELSIF ((SELF.sal+SELF.comm)>(r.sal+r.comm)) THEN
        RETURN 1;       --��Ϊ�κ�����
     ELSE 
        RETURN 0;      --��������Ϊ0
     END IF;
  END match;
END;   


DECLARE
   emp1 employee_order:=employee_order(7112,3000,200,20);    --����Ա��1
   emp2 employee_order:=employee_order(7113,3800,100,20);    --����Ա��2
BEGIN
   --��Ա��1��2���бȽϣ���ȡ���ؽ��
   IF emp1>emp2 THEN
      DBMS_OUTPUT.put_line('Ա��1��н�ʼ���ɱ�Ա��2��');
   ELSIF emp1<emp2 THEN
      DBMS_OUTPUT.put_line('Ա��1��н�ʼ���ɱ�Ա��2С��');
   ELSE
      DBMS_OUTPUT.put_line('Ա��1��н�ʼ������Ա��2��ȣ�');
   END IF;
END;




--����employee_order���͵Ķ����
CREATE TABLE emp_order_tab OF employee_order;
--�������в���Ա��н����Ϣ����
INSERT INTO emp_order_tab VALUES(7123,3000,200,20);
INSERT INTO emp_order_tab VALUES(7124,2000,800,20);
INSERT INTO emp_order_tab VALUES(7125,5000,800,20);
INSERT INTO emp_order_tab VALUES(7129,3000,400,20);
SELECT VALUE(r) val,r.sal+r.comm FROM emp_order_tab r ORDER BY 1;

--�����ж����



DECLARE
   o_emp   employee_order;                             --�������ʵ������ʼ״̬��ΪNULL
BEGIN
   o_emp := employee_order (7123, 3000, 200, 20);      --ʹ�ù��캯����������
   DBMS_OUTPUT.put_line (   'Ա�����Ϊ��'
                         || o_emp.empno
                         || '��н�ʺ����Ϊ��'
                         || (o_emp.sal + o_emp.comm)
                        );
END;



DECLARE
   
--ʹ�ö���������Ϊ���̵���ʽ����
CREATE OR REPLACE PROCEDURE changesalary(p_emp IN employee_order) 
AS
BEGIN
   IF p_emp IS NOT NULL THEN         --������������Ѿ���ʵ����
     --����emp��
     UPDATE emp SET sal=p_emp.sal,comm=p_emp.comm WHERE empno=p_emp.empno;
   END IF;
END changesalary;
--ʹ�ö���������Ϊ�����Ĵ��봫������
CREATE OR REPLACE FUNCTION getsalary(p_emp IN OUT employee_order) RETURN NUMBER
AS
BEGIN
   IF p_emp IS NOT NULL THEN                      --�����������û�б�ʵ����
      p_emp:=employee_order(7125,5000,800,20);    --ʵ������������
   END IF;
   RETURN p_emp.sal+p_emp.comm;                   --���ض������͵�н�ʺ���ɻ���
END;




DECLARE
   o_emp  employee_order;
BEGIN
   o_emp.empno:=7301;   --���󣺸ö���ʵ����û�б���ʼ���ͽ����˸�ֵ
END;


/* Formatted on 2011/11/01 15:45 (Formatter Plus v4.8.8) */
DECLARE
   o_emp   employee_order := 
              employee_order (NULL, NULL, NULL, NULL); --��ʼ����������
BEGIN
   o_emp.empno := 7301;                                --Ϊ�������͸�ֵ
   o_emp.sal := 5000;
   o_emp.comm := 300;
   o_emp.deptno := 20;
END;

--employee_method�������͵�ʵ�������뾲̬�����б�
CREATE OR REPLACE TYPE employee_method AS OBJECT (
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--����������ͷ���
   MEMBER PROCEDURE change_sal,            --ʵ�����������Է��ʶ����������
   MEMBER FUNCTION get_sal RETURN NUMBER,   
   --��̬���������ܷ��ʶ���������ԣ�ֻ�ܷ��ʾ�̬����
   STATIC PROCEDURE change_deptno (empno NUMBER, deptno NUMBER), 
   STATIC FUNCTION get_sal (empno NUMBER) RETURN NUMBER
)
NOT FINAL;    
--��ʾ����employee_method��ʵ�������뾲̬����
DECLARE
   o_emp employee_method:=employee_method(7369,5000,800,20);
   v_sal NUMBER(10,2); 
BEGIN
   v_sal:=o_emp.get_sal;                       --���ö���ʵ������
   DBMS_OUTPUT.put_line('����ʵ������Ĺ���Ϊ��'||v_sal);
   v_sal:=employee_method.get_sal(o_emp.empno); --���þ�̬����
   DBMS_OUTPUT.put_line('�������ͼ���Ĺ���Ϊ��'||v_sal);   
END;




DROP TYPE APPS.ADDRESS_TYPE;


--�����ַ�������͹淶
CREATE OR REPLACE TYPE address_type
        AS OBJECT
(street_addr1  VARCHAR2(25),   --�ֵ���ַ1
 street_addr2  VARCHAR2(25),   --�ֵ���ַ2
 city          VARCHAR2(30),   --����
 state         VARCHAR2(20),    --ʡ��
 zip_code      NUMBER,         --��������
 --��Ա���������ص�ַ�ַ���
 MEMBER FUNCTION toString RETURN VARCHAR2,
 --MAP�����ṩ��ַ�ȽϺ���
 MAP MEMBER FUNCTION mapping_function RETURN VARCHAR2
 )

--�����ַ���������壬ʵ�ֳ�Ա������MAP����
CREATE OR REPLACE TYPE BODY address_type
AS
   MEMBER FUNCTION tostring
      RETURN VARCHAR2                    --����ַ����ת��Ϊ�ַ���ʽ��ʾ
   IS
   BEGIN
      IF (street_addr2 IS NOT NULL)
      THEN
         RETURN    street_addr1
                || CHR (10)
                || street_addr2
                || CHR (10)
                || city
                || ','
                || state
                || ' '
                || zip_code;
      ELSE
         RETURN street_addr1 || CHR (10) || city || ',' || state || ' '
                || zip_code;
      END IF;
   END;
   MAP MEMBER FUNCTION mapping_function    --�����ַ����MAP������ʵ�֣�����VARCHAR2����
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    TO_CHAR (NVL (zip_code, 0), 'fm00000')
             || LPAD (NVL (city, ''), 30)
             || LPAD (NVL (street_addr1, ''), 25)
             || LPAD (NVL (street_addr2, ''), 25);
   END;
END;
/




--����һ������淶���ù淶�а���ORDER����
CREATE OR REPLACE TYPE employee_addr AS OBJECT (
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
   addr     address_type,
 MEMBER FUNCTION get_emp_info RETURN VARCHAR2   
)
NOT FINAL; 
--������������壬ʵ��get_emp_info����
CREATE OR REPLACE TYPE BODY employee_addr
AS
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2                    --����Ա������ϸ��Ϣ
   IS
   BEGIN
      RETURN 'Ա��'||SELF.empno||'�ĵ�ַΪ��'||SELF.addr.toString;
   END;
END;



DECLARE
   o_address address_type;
   o_emp employee_addr; 
BEGIN
   o_address:=address_type('����һ��','����','����','DG',523343);
   o_emp:=employee_addr(7369,5000,800,20,o_address); 
   DBMS_OUTPUT.put_line('Ա����ϢΪ'||o_emp.get_emp_info);
END;




CREATE OR REPLACE TYPE person_obj AS OBJECT (
   person_name        VARCHAR (20),   --��Ա����
   gender      VARCHAR2 (10),          --��Ա�Ա�
   birthdate   DATE,                  --��������
   address     VARCHAR2 (50),         --��ͥסַ
   MEMBER FUNCTION get_info
      RETURN VARCHAR2                 --����Ա����Ϣ
)
NOT FINAL;                            --��Ա������Ա��̳�
CREATE OR REPLACE TYPE BODY person_obj    --������
AS
   MEMBER FUNCTION get_info
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN '������' || person_name || ',��ͥסַ��' || address;
   END;
END;


/* Formatted on 2011/11/02 07:12 (Formatter Plus v4.8.8) */

--��������ʹ��UNDER����person_obj�м̳�
CREATE OR REPLACE TYPE  employee_personobj UNDER person_obj (
   empno   NUMBER (6),
   sal     NUMBER (10, 2),
   job     VARCHAR2 (10),
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2
);
CREATE OR REPLACE TYPE BODY employee_personobj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --�ڶ����������п���ֱ�ӷ����ڸ������ж��������
      RETURN 'Ա����ţ�'||SELF.empno||' Ա�����ƣ�'||SELF.person_name||' ְλ��'||SELF.job;
   END;
END;


 

DECLARE
   o_emp employee_personobj;         --����Ա���������͵ı���
BEGIN
   --ʹ�ù��캯��ʵ����Ա������
   o_emp:=employee_personobj('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '����',7981,5000,'Programmer');
   DBMS_OUTPUT.put_line(o_emp.get_info);          --������������Ա��Ϣ
   DBMS_OUTPUT.put_line(o_emp.get_emp_info);      --���Ա�������е�Ա����Ϣ
END;   



--��������ʹ��UNDER����person_obj�м̳�
CREATE OR REPLACE TYPE  employee_personobj UNDER person_obj (
   empno   NUMBER (6),
   sal     NUMBER (10, 2),
   job     VARCHAR2 (10),
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2
   --�������ط���
   OVERRIDING MEMBER MEMBER FUNCTION get_info RETURN VARCHAR2    
);
CREATE OR REPLACE TYPE BODY employee_personobj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --�ڶ����������п���ֱ�ӷ����ڸ������ж��������
      RETURN 'Ա����ţ�'||SELF.empno||' Ա�����ƣ�'||SELF.person_name||' ְλ��'||SELF.job;
   END;
   --ʵ�����ط���
   OVERRIDING MEMBER MEMBER FUNCTION get_info RETURN VARCHAR2 AS
   BEGIN
      RETURN 'Ա����ţ�'||SELF.empno||' Ա�����ƣ�'||SELF.person_name||' ְλ��'||SELF.job; 
   END;          
END;




--��������ʹ��UNDER����person_obj�м̳�
CREATE OR REPLACE TYPE  employee_personobj UNDER person_obj (
   empno   NUMBER (6),
   sal     NUMBER (10, 2),
   job     VARCHAR2 (10),
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2,
   --�������ط���
   OVERRIDING MEMBER FUNCTION get_info RETURN VARCHAR2    
);
CREATE OR REPLACE TYPE BODY employee_personobj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --�ڶ����������п���ֱ�ӷ����ڸ������ж��������
      RETURN 'Ա����ţ�'||SELF.empno||' Ա�����ƣ�'||SELF.person_name||' ְλ��'||SELF.job;
   END;
   --ʵ�����ط���
   OVERRIDING MEMBER FUNCTION get_info RETURN VARCHAR2 AS
   BEGIN
      RETURN 'Ա����ţ�'||SELF.empno||' Ա�����ƣ�'||SELF.person_name||' ְλ��'||SELF.job; 
   END;          
END;


DECLARE
   o_emp employee_personobj;         --����Ա���������͵ı���
BEGIN
   --ʹ�ù��캯��ʵ����Ա������
   o_emp:=employee_personobj('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '����',7981,5000,'Programmer');
   DBMS_OUTPUT.put_line(o_emp.get_info);          --������������Ա��Ϣ
END;   


emp_addr_table;

CREATE TABLE emp_obj_table OF employee_personobj;


INSERT INTO emp_obj_table VALUES('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '����',7981,5000,'Programmer');
                             
SELECT * FROM emp_obj_table;

/* Formatted on 2011/11/03 05:45 (Formatter Plus v4.8.8) */


CREATE TABLE emp_addr_table OF employee_addr;
INSERT INTO emp_addr_table
     VALUES (7369, 5000, 800, 20,
             address_type ('����һ��', '����', '����', 'DG', 523343));

SELECT * FROM emp_addr_table;


DECLARE
   o_emp employee_personobj;                   --����Ա���������͵ı���
BEGIN
   --ʹ�ù��캯��ʵ����Ա������
   o_emp:=employee_personobj('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '����',7981,5000,'Programmer');
   INSERT INTO emp_obj_table VALUES(o_emp);    --���뵽�������                            
END;                             


INSERT INTO emp_obj_table VALUES (employee_personobj('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '����',7981,5000,'Programmer'));
                             
                             
SELECT person_name,job FROM emp_obj_table;        

 SELECT VALUE(e) from emp_obj_table e;    
 
 
 DECLARE
    o_emp employee_personobj;   --����һ���������͵ı���
 BEGIN
    --ʹ��SELECT INTO��佫VALUE�������صĶ���ʵ�����뵽�������͵ı���
    SELECT VALUE(e) INTO o_emp FROM emp_obj_table e WHERE e.person_name='��С��';
    --����������͵�����ֵ
    DBMS_OUTPUT.put_line(o_emp.person_name||'��ְλ�ǣ�'||o_emp.job);
 END;       
 
 
 
INSERT INTO emp_obj_table VALUES (employee_personobj('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '����',7981,5000,'Programmer'));
INSERT INTO emp_obj_table VALUES (employee_personobj('��С��','M',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '��̩',7981,5000,'running'));                                       
                             
/* Formatted on 2011/11/03 06:35 (Formatter Plus v4.8.8) */
DECLARE
   o_emp   employee_personobj;     --����������͵ı���
   CURSOR all_emp
   IS
      SELECT VALUE (e) AS emp
        FROM emp_obj_table e;      --����һ���α꣬������ѯ��������
BEGIN
   FOR each_emp IN all_emp         --ʹ���α�FORѭ�������α�����
   LOOP
      o_emp := each_emp.emp;       --��ȡ�α��ѯ�Ķ���ʵ��
      --�������ʵ����Ϣ
      DBMS_OUTPUT.put_line (o_emp.person_name || ' ��ְλ�ǣ�' || o_emp.job);
   END LOOP;
END;


 DECLARE
    o_emp REF employee_personobj;   --����REF���͵ı���
 BEGIN
    --ʹ��REF������ȡ�������͵Ķ���
    SELECT REF(e) INTO o_emp FROM emp_obj_table e WHERE e.person_name='��С��';
 END;       
 
 
 
/* Formatted on 2011/11/03 12:21 (Formatter Plus v4.8.8) */
UPDATE emp_obj_table empobj
   SET empobj.gender = 'M'
 WHERE empobj.person_name = '��С��';
 
 
 UPDATE emp_obj_table empobj
  SET empobj=employee_personobj('��С��','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '��̩',7981,7000,'Testing')
  WHERE person_name='��С��';                            
  
  
  DECLARE
     empref REF employee_personobj;     
  BEGIN
     SELECT REF(empobj) INTO empref FROM emp_obj_table empobj WHERE e.person_name='��С��';
  END;
  
  SELECT REF(e2) FROM emp_obj_table e2;
  
  
/* Formatted on 2011/11/03 14:05 (Formatter Plus v4.8.8) */
DECLARE
   emp_ref   REF employee_personobj;               --�������ö�������
BEGIN
   SELECT REF(e1)
     INTO emp_ref
     FROM emp_obj_table e1
    WHERE person_name = '��С��';                  --�Ӷ�����л�ȡ����С�޵Ķ�������
   UPDATE emp_obj_table emp_obj
      SET emp_obj =employee_personobj('��С��',
                  'F',TO_DATE ('1985-08-01', 'YYYY-MM-DD'),
                  '����',7981, 7000, 'developer')                                
      WHERE REF (emp_obj) = emp_ref;
END;                                             --ʹ��UPDATE������emp_obj_table������С�޵ļ�¼


  SELECT * FROM emp_obj_table e2;
  
  
  
  DELETE FROM emp_obj_table WHERE person_name='��С��';
  
  
DECLARE
   emp_ref   REF employee_personobj;               --�������ö�������
BEGIN
   SELECT REF(e1)
     INTO emp_ref
     FROM emp_obj_table e1
    WHERE person_name = '��С��';                  --�Ӷ�����л�ȡ����С�޵Ķ�������
      DELETE FROM emp_obj_table emp_obj                           
      WHERE REF (emp_obj) = emp_ref;
END;                                             --ʹ��DELETE���ɾ��emp_obj_table������С�޵ļ�¼  

SELECT * FROM emp;


--�������ϵ��emp��ƥ���еĶ�������
CREATE OR REPLACE TYPE emp_tbl_obj AS OBJECT (
empno    NUMBER (6),
ename    VARCHAR2(10),
job      VARCHAR2(18),
mgr      NUMBER(4),
hiredate DATE,
sal      NUMBER(7,2),
comm     NUMBER(7,2),
deptno   NUMBER(2),
MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2
)
INSTANTIABLE NOT FINAL;
/
--�������������
CREATE OR REPLACE TYPE BODY emp_tbl_obj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --�ڶ����������п���ֱ�ӷ����ڸ������ж��������
      RETURN 'Ա����ţ�'||SELF.empno||' Ա�����ƣ�'||SELF.ename||' ְλ��'||SELF.job;
   END; 
END;
/

/* Formatted on 2011/11/04 07:39 (Formatter Plus v4.8.8) */
--����emp_view�����
CREATE VIEW emp_view
   OF emp_tbl_obj
   WITH OBJECT IDENTIFIER (empno)
AS
   SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
     FROM emp e;
/


DECLARE
  o_emp emp_tbl_obj;          --����������͵ı���
BEGIN
  --��ѯ��������
  SELECT VALUE(e) INTO o_emp FROM emp_view e WHERE empno=7369;
  --����������͵�����
  DBMS_OUTPUT.put_line('Ա��'||o_emp.ename||' ��н��Ϊ��'||o_emp.sal);
  DBMS_OUTPUT.put_line(o_emp.get_emp_info);  --���ö������͵ĳ�Ա����
END;  