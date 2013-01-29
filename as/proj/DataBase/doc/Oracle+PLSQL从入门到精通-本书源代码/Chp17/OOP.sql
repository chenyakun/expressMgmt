--定义对象类型规范employee_obj
CREATE OR REPLACE TYPE employee_obj AS OBJECT (
--定义对象类型属性
empno         NUMBER(4),
ename         VARCHAR2(20),
job           VARCHAR2(20),
sal           NUMBER(10,2),
comm          NUMBER(10,2),
deptno        NUMBER(4),
--定义对象类型方法
MEMBER PROCEDURE Change_sal(p_empno NUMBER,p_sal NUMBER),
MEMBER PROCEDURE Change_comm(p_empno NUMBER,p_comm NUMBER),
MEMBER PROCEDURE Change_deptno(p_empno NUMBER,p_deptno NUMBER),
MEMBER FUNCTION get_sal(p_empno NUMBER) RETURN NUMBER,
MEMBER FUNCTION get_comm(p_empno NUMBER) RETURN NUMBER,
MEMBER FUNCTION get_deptno(p_empno NUMBER) RETURN INTEGER
) NOT FINAL;      --指定该类可以被继承，如果指定FINAL，表示该类无法被继承


/* Formatted on 2011/10/31 06:53 (Formatter Plus v4.8.8) */
--定义对象类型体
CREATE OR REPLACE TYPE BODY employee_obj
AS
   MEMBER PROCEDURE change_sal (p_empno NUMBER, p_sal NUMBER)
   IS                          --定义对象成员方法，更改员工薪资
   BEGIN
      UPDATE emp
         SET sal = p_sal
       WHERE empno = p_empno;
   END;
   MEMBER PROCEDURE change_comm (p_empno NUMBER, p_comm NUMBER)
   IS                         --定义对象成员方法，更改员工提成
   BEGIN
      UPDATE emp
         SET comm = p_comm
       WHERE empno = p_empno;
   END;
   MEMBER PROCEDURE change_deptno (p_empno NUMBER, p_deptno NUMBER)
   IS                        --定义对象成员方法，更改员工部门
   BEGIN
      UPDATE emp
         SET deptno = p_deptno
       WHERE empno = p_empno;
   END;
   MEMBER FUNCTION get_sal (p_empno NUMBER)
      RETURN NUMBER
   IS                        --定义对象成员方法，获取员工薪资
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
   IS                        --定义对象成员方法，获取员工提成
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
   IS                        --定义对象成员方法，获取员工部门
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
--定义对象类型规范employee_salobj
CREATE OR REPLACE TYPE employee_salobj AS OBJECT (
--定义对象类型属性
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--定义对象类型方法
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
NOT FINAL;             --指定该类可以被继承，如果指定FINAL，表示该类无法被继承
----------------------------------------------------------------------------------
--定义employee_salobj对象类型体
CREATE OR REPLACE TYPE BODY employee_salobj
AS
   MEMBER PROCEDURE change_sal
   IS
   BEGIN
      SELF.sal := SELF.sal * 1.12;        --使用SELF关键字
   END;
   MEMBER PROCEDURE change_comm
   IS
   BEGIN
      comm := comm * 1.12;               --不使用SELF关键字
   END;
   MEMBER PROCEDURE change_deptno
   IS
   BEGIN
      SELF.deptno := 20;                 --使用SELF关键字更改部门名称
   END;
   MEMBER FUNCTION get_sal
      RETURN NUMBER
   IS
   BEGIN
      RETURN sal;                        --返回员工薪资
   END;
   MEMBER FUNCTION get_comm
      RETURN NUMBER
   IS
   BEGIN
      RETURN SELF.comm;                  --返回员工提成
   END;
   MEMBER FUNCTION get_deptno
      RETURN INTEGER
   IS
   BEGIN
      RETURN SELF.deptno;               --返回员工部门编号
   END;
END;




--定义对象类型规范employee_obj
CREATE OR REPLACE TYPE employee_property AS OBJECT (
--定义对象类型属性
empno         NUMBER(4),
ename         VARCHAR2(20),
job           VARCHAR2(20),
sal           NUMBER(10,2),
comm          NUMBER(10,2),
deptno        NUMBER(4)
) NOT FINAL;   --对象类型可以被继承


/* Formatted on 2011/10/31 10:40 (Formatter Plus v4.8.8) */
DECLARE
   v_emp   employee_property;        --定义对象类型
   v_sal   v_emp.sal%TYPE;           --定义对象类型中与sal类型相同的薪资变量
BEGIN
   --初始化对象类型，v_emp是一个对象的实例
   v_emp := employee_property (7890, '赵五', '销售人员', 5000, 200, 20);
   v_sal := v_emp.sal;               --为变量赋对象实例的值
   --获取对象类型的属性进行显示
   DBMS_OUTPUT.put_line (v_emp.ename || ' 的薪资是：' || v_sal);
END;




--定义对象类型规范employee_salobj

CREATE OR REPLACE TYPE employee_method AS OBJECT (
--定义对象类型属性
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--定义对象类型方法
   MEMBER PROCEDURE change_sal,          --实例方法，可以访问对象本身的属性
   MEMBER FUNCTION get_sal RETURN NUMBER,   
   --静态方法，不能访问对象本身的属性，只能访问静态数据
   STATIC PROCEDURE change_deptno (empno NUMBER, deptno NUMBER), 
   STATIC FUNCTION get_sal (empno NUMBER) RETURN NUMBER
)
NOT FINAL;             --指定该类可以被继承，如果指定FINAL，表示该类无法被继承


CREATE OR REPLACE TYPE employee_method AS OBJECT (
--定义对象类型属性
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--定义对象类型方法
   MEMBER PROCEDURE change_sal,          --实例方法，可以访问对象本身的属性
   MEMBER FUNCTION get_sal RETURN NUMBER,   
   --静态方法，不能访问对象本身的属性，只能访问静态数据
   STATIC PROCEDURE change_deptno (p_empno NUMBER, p_deptno NUMBER), 
   STATIC FUNCTION get_sal (p_empno NUMBER) RETURN NUMBER
)
NOT FINAL;             --指定该类可以被继承，如果指定FINAL，表示该类无法被继承
----------------------------------------------------------------------------------
--定义employee_method对象类型体
CREATE OR REPLACE TYPE BODY employee_method
AS
   MEMBER PROCEDURE change_sal
   IS
   BEGIN
      SELF.sal := SELF.sal * 1.12;        --使用SELF关键字
   END;
   MEMBER FUNCTION get_sal
      RETURN NUMBER
   IS
   BEGIN
      RETURN sal;                        --返回员工薪资
   END;
   STATIC PROCEDURE change_deptno (p_empno NUMBER, p_deptno NUMBER)
   IS                                    --定义对象成员方法，更改员工部门
   BEGIN
      UPDATE emp
         SET deptno = p_deptno
       WHERE empno = p_empno;
   END;
   STATIC FUNCTION get_sal (p_empno NUMBER)
      RETURN NUMBER
   IS                                     --定义对象成员方法，获取员工薪资
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
   v_emp  employee_method;                    --定义employee_method对象类型的变量
BEGIN
   v_emp:=employee_method(7999,5000,200,20);   --实例化employee_method对象，现在v_emp是对象实例
   v_emp.change_sal;                           --设用对象实例方法，即MEMBER方法
   DBMS_OUTPUT.put_line('员工编号为：'||v_emp.empno||' 的薪资为：'||v_emp.get_sal);   
   --下面的代码调用STATIC方法更新emp表中员工编号为7369的部门编号为20.
   employee_method.change_deptno(7369,20);
   --下面的代码获取emp表中员工编号为7369的员工薪资。
  DBMS_OUTPUT.put_line('员工编号为7369的薪资为：'||employee_method.get_sal(7369)); 
END;   


--定义对象类型规范
CREATE OR REPLACE TYPE salary_obj AS OBJECT (
percent        NUMBER(10,4),       --定义对象属性
sal          NUMBER(10,2),
--自定义构造函数
CONSTRUCTOR FUNCTION salary_obj(p_sal NUMBER) RETURN SELF AS RESULT)
INSTANTIABLE         --可实例化对象
FINAL;               --不可以继承
/
--定义对象类型体
CREATE OR REPLACE TYPE BODY salary_obj
AS
   --实现重载的构造函数
   CONSTRUCTOR FUNCTION salary_obj (p_sal NUMBER)
      RETURN SELF AS RESULT
   AS
   BEGIN
      SELF.sal := p_sal;          --设置属性值
      SELF.PERCENT := 1.12;       --为属性指定初值
      RETURN;
   END;
END;
/


/* Formatted on 2011/10/31 23:58 (Formatter Plus v4.8.8) */
DECLARE
   v_salobj1   salary_obj;
   v_salobj2   salary_obj;                 --定义对象类型
BEGIN
   v_salobj1 := salary_obj (1.12, 3000);   --使用默认构造函数
   v_salobj2 := salary_obj (2000);         --使用自定义构造函数
END;



--定义一个对象规范，该规范中包含MAP方法
CREATE OR REPLACE TYPE employee_map AS OBJECT (
--定义对象类型属性
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
   MAP MEMBER FUNCTION convert RETURN REAL    --定义一个MAP方法
)
NOT FINAL;            
--定义一个对象类型体，实现MAP函数
CREATE OR REPLACE TYPE BODY employee_map AS
  MAP MEMBER FUNCTION convert RETURN REAL  IS   --定义一个MAP方法
  BEGIN
     RETURN sal+comm;                           --返回标量类型的值
  END;
END;         

--创建employee_map类型的对象表
CREATE TABLE emp_map_tab OF employee_map;
--向对象表中插入员工薪资信息对象。
INSERT INTO emp_map_tab VALUES(7123,3000,200,20);
INSERT INTO emp_map_tab VALUES(7124,2000,800,20);
INSERT INTO emp_map_tab VALUES(7125,5000,800,20);
INSERT INTO emp_map_tab VALUES(7129,3000,400,20);

SELECT VALUE(r) val,r.sal+r.comm FROM emp_map_tab r ORDER BY 1;




--定义一个对象规范，该规范中包含ORDER方法
CREATE OR REPLACE TYPE employee_order AS OBJECT (
--定义对象类型属性
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
   ORDER MEMBER FUNCTION match(r employee_order) RETURN INTEGER    --定义一个ORDER方法
)
NOT FINAL; 
--定义一个对象类型体，实现ORDER函数
CREATE OR REPLACE TYPE BODY employee_order AS
  ORDER MEMBER FUNCTION match(r employee_order) RETURN INTEGER  IS   
  BEGIN
     IF ((SELF.sal+SELF.comm)<(r.sal+r.comm)) THEN
        RETURN -1;      --可为任何负数
     ELSIF ((SELF.sal+SELF.comm)>(r.sal+r.comm)) THEN
        RETURN 1;       --可为任何正数
     ELSE 
        RETURN 0;      --如果相等则为0
     END IF;
  END match;
END;   


DECLARE
   emp1 employee_order:=employee_order(7112,3000,200,20);    --定义员工1
   emp2 employee_order:=employee_order(7113,3800,100,20);    --定义员工2
BEGIN
   --对员工1和2进行比较，获取返回结果
   IF emp1>emp2 THEN
      DBMS_OUTPUT.put_line('员工1的薪资加提成比员工2大！');
   ELSIF emp1<emp2 THEN
      DBMS_OUTPUT.put_line('员工1的薪资加提成比员工2小！');
   ELSE
      DBMS_OUTPUT.put_line('员工1的薪资加提成与员工2相等！');
   END IF;
END;




--创建employee_order类型的对象表
CREATE TABLE emp_order_tab OF employee_order;
--向对象表中插入员工薪资信息对象。
INSERT INTO emp_order_tab VALUES(7123,3000,200,20);
INSERT INTO emp_order_tab VALUES(7124,2000,800,20);
INSERT INTO emp_order_tab VALUES(7125,5000,800,20);
INSERT INTO emp_order_tab VALUES(7129,3000,400,20);
SELECT VALUE(r) val,r.sal+r.comm FROM emp_order_tab r ORDER BY 1;

--方法中定义的



DECLARE
   o_emp   employee_order;                             --定义对象实例，初始状态下为NULL
BEGIN
   o_emp := employee_order (7123, 3000, 200, 20);      --使用构造函数声明对象
   DBMS_OUTPUT.put_line (   '员工编号为：'
                         || o_emp.empno
                         || '的薪资和提成为：'
                         || (o_emp.sal + o_emp.comm)
                        );
END;



DECLARE
   
--使用对象类型作为过程的形式参数
CREATE OR REPLACE PROCEDURE changesalary(p_emp IN employee_order) 
AS
BEGIN
   IF p_emp IS NOT NULL THEN         --如果对象类型已经被实例化
     --更新emp表
     UPDATE emp SET sal=p_emp.sal,comm=p_emp.comm WHERE empno=p_emp.empno;
   END IF;
END changesalary;
--使用对象类型作为函数的传入传出参数
CREATE OR REPLACE FUNCTION getsalary(p_emp IN OUT employee_order) RETURN NUMBER
AS
BEGIN
   IF p_emp IS NOT NULL THEN                      --如果对象类型没有被实例化
      p_emp:=employee_order(7125,5000,800,20);    --实例化对象类型
   END IF;
   RETURN p_emp.sal+p_emp.comm;                   --返回对象类型的薪资和提成汇总
END;




DECLARE
   o_emp  employee_order;
BEGIN
   o_emp.empno:=7301;   --错误：该对象实例还没有被初始化就进行了赋值
END;


/* Formatted on 2011/11/01 15:45 (Formatter Plus v4.8.8) */
DECLARE
   o_emp   employee_order := 
              employee_order (NULL, NULL, NULL, NULL); --初始化对象类型
BEGIN
   o_emp.empno := 7301;                                --为对象类型赋值
   o_emp.sal := 5000;
   o_emp.comm := 300;
   o_emp.deptno := 20;
END;

--employee_method对象类型的实例方法与静态方法列表
CREATE OR REPLACE TYPE employee_method AS OBJECT (
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
--定义对象类型方法
   MEMBER PROCEDURE change_sal,            --实例方法，可以访问对象本身的属性
   MEMBER FUNCTION get_sal RETURN NUMBER,   
   --静态方法，不能访问对象本身的属性，只能访问静态数据
   STATIC PROCEDURE change_deptno (empno NUMBER, deptno NUMBER), 
   STATIC FUNCTION get_sal (empno NUMBER) RETURN NUMBER
)
NOT FINAL;    
--演示调用employee_method的实例方法与静态方法
DECLARE
   o_emp employee_method:=employee_method(7369,5000,800,20);
   v_sal NUMBER(10,2); 
BEGIN
   v_sal:=o_emp.get_sal;                       --调用对象实例方法
   DBMS_OUTPUT.put_line('对象实例级别的工资为：'||v_sal);
   v_sal:=employee_method.get_sal(o_emp.empno); --调用静态方法
   DBMS_OUTPUT.put_line('对象类型级别的工资为：'||v_sal);   
END;




DROP TYPE APPS.ADDRESS_TYPE;


--定义地址对象类型规范
CREATE OR REPLACE TYPE address_type
        AS OBJECT
(street_addr1  VARCHAR2(25),   --街道地址1
 street_addr2  VARCHAR2(25),   --街道地址2
 city          VARCHAR2(30),   --城市
 state         VARCHAR2(20),    --省份
 zip_code      NUMBER,         --邮政编码
 --成员方法，返回地址字符串
 MEMBER FUNCTION toString RETURN VARCHAR2,
 --MAP方法提供地址比较函数
 MAP MEMBER FUNCTION mapping_function RETURN VARCHAR2
 )

--定义地址对象类型体，实现成员方法与MAP函数
CREATE OR REPLACE TYPE BODY address_type
AS
   MEMBER FUNCTION tostring
      RETURN VARCHAR2                    --将地址属性转换为字符形式显示
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
   MAP MEMBER FUNCTION mapping_function    --定义地址对象MAP函数的实现，返回VARCHAR2类型
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




--定义一个对象规范，该规范中包含ORDER方法
CREATE OR REPLACE TYPE employee_addr AS OBJECT (
   empno    NUMBER (4),
   sal      NUMBER (10, 2),
   comm     NUMBER (10, 2),
   deptno   NUMBER (4),
   addr     address_type,
 MEMBER FUNCTION get_emp_info RETURN VARCHAR2   
)
NOT FINAL; 
--定义对象类型体，实现get_emp_info方法
CREATE OR REPLACE TYPE BODY employee_addr
AS
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2                    --返回员工的详细信息
   IS
   BEGIN
      RETURN '员工'||SELF.empno||'的地址为：'||SELF.addr.toString;
   END;
END;



DECLARE
   o_address address_type;
   o_emp employee_addr; 
BEGIN
   o_address:=address_type('玉兰一街','二巷','深圳','DG',523343);
   o_emp:=employee_addr(7369,5000,800,20,o_address); 
   DBMS_OUTPUT.put_line('员工信息为'||o_emp.get_emp_info);
END;




CREATE OR REPLACE TYPE person_obj AS OBJECT (
   person_name        VARCHAR (20),   --人员姓名
   gender      VARCHAR2 (10),          --人员性别
   birthdate   DATE,                  --出生日期
   address     VARCHAR2 (50),         --家庭住址
   MEMBER FUNCTION get_info
      RETURN VARCHAR2                 --返回员工信息
)
NOT FINAL;                            --人员对象可以被继承
CREATE OR REPLACE TYPE BODY person_obj    --对象体
AS
   MEMBER FUNCTION get_info
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN '姓名：' || person_name || ',家庭住址：' || address;
   END;
END;


/* Formatted on 2011/11/02 07:12 (Formatter Plus v4.8.8) */

--对象类型使用UNDER语句从person_obj中继承
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
      --在对象类型体中可以直接访问在父对象中定义的属性
      RETURN '员工编号：'||SELF.empno||' 员工名称：'||SELF.person_name||' 职位：'||SELF.job;
   END;
END;


 

DECLARE
   o_emp employee_personobj;         --定义员工对象类型的变量
BEGIN
   --使用构造函数实例化员工对象
   o_emp:=employee_personobj('张小五','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中信',7981,5000,'Programmer');
   DBMS_OUTPUT.put_line(o_emp.get_info);          --输出父对象的人员信息
   DBMS_OUTPUT.put_line(o_emp.get_emp_info);      --输出员工对象中的员工信息
END;   



--对象类型使用UNDER语句从person_obj中继承
CREATE OR REPLACE TYPE  employee_personobj UNDER person_obj (
   empno   NUMBER (6),
   sal     NUMBER (10, 2),
   job     VARCHAR2 (10),
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2
   --定义重载方法
   OVERRIDING MEMBER MEMBER FUNCTION get_info RETURN VARCHAR2    
);
CREATE OR REPLACE TYPE BODY employee_personobj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --在对象类型体中可以直接访问在父对象中定义的属性
      RETURN '员工编号：'||SELF.empno||' 员工名称：'||SELF.person_name||' 职位：'||SELF.job;
   END;
   --实现重载方法
   OVERRIDING MEMBER MEMBER FUNCTION get_info RETURN VARCHAR2 AS
   BEGIN
      RETURN '员工编号：'||SELF.empno||' 员工名称：'||SELF.person_name||' 职位：'||SELF.job; 
   END;          
END;




--对象类型使用UNDER语句从person_obj中继承
CREATE OR REPLACE TYPE  employee_personobj UNDER person_obj (
   empno   NUMBER (6),
   sal     NUMBER (10, 2),
   job     VARCHAR2 (10),
   MEMBER FUNCTION get_emp_info
      RETURN VARCHAR2,
   --定义重载方法
   OVERRIDING MEMBER FUNCTION get_info RETURN VARCHAR2    
);
CREATE OR REPLACE TYPE BODY employee_personobj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --在对象类型体中可以直接访问在父对象中定义的属性
      RETURN '员工编号：'||SELF.empno||' 员工名称：'||SELF.person_name||' 职位：'||SELF.job;
   END;
   --实现重载方法
   OVERRIDING MEMBER FUNCTION get_info RETURN VARCHAR2 AS
   BEGIN
      RETURN '员工编号：'||SELF.empno||' 员工名称：'||SELF.person_name||' 职位：'||SELF.job; 
   END;          
END;


DECLARE
   o_emp employee_personobj;         --定义员工对象类型的变量
BEGIN
   --使用构造函数实例化员工对象
   o_emp:=employee_personobj('张小五','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中信',7981,5000,'Programmer');
   DBMS_OUTPUT.put_line(o_emp.get_info);          --输出父对象的人员信息
END;   


emp_addr_table;

CREATE TABLE emp_obj_table OF employee_personobj;


INSERT INTO emp_obj_table VALUES('张小五','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中信',7981,5000,'Programmer');
                             
SELECT * FROM emp_obj_table;

/* Formatted on 2011/11/03 05:45 (Formatter Plus v4.8.8) */


CREATE TABLE emp_addr_table OF employee_addr;
INSERT INTO emp_addr_table
     VALUES (7369, 5000, 800, 20,
             address_type ('玉兰一街', '二巷', '深圳', 'DG', 523343));

SELECT * FROM emp_addr_table;


DECLARE
   o_emp employee_personobj;                   --定义员工对象类型的变量
BEGIN
   --使用构造函数实例化员工对象
   o_emp:=employee_personobj('张小五','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中信',7981,5000,'Programmer');
   INSERT INTO emp_obj_table VALUES(o_emp);    --插入到对象表中                            
END;                             


INSERT INTO emp_obj_table VALUES (employee_personobj('张小五','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中信',7981,5000,'Programmer'));
                             
                             
SELECT person_name,job FROM emp_obj_table;        

 SELECT VALUE(e) from emp_obj_table e;    
 
 
 DECLARE
    o_emp employee_personobj;   --定义一个对象类型的变量
 BEGIN
    --使用SELECT INTO语句将VALUE函数返回的对象实例插入到对象类型的变量
    SELECT VALUE(e) INTO o_emp FROM emp_obj_table e WHERE e.person_name='张小五';
    --输出对象类型的属性值
    DBMS_OUTPUT.put_line(o_emp.person_name||'的职位是：'||o_emp.job);
 END;       
 
 
 
INSERT INTO emp_obj_table VALUES (employee_personobj('张小五','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中信',7981,5000,'Programmer'));
INSERT INTO emp_obj_table VALUES (employee_personobj('刘小艳','M',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '中泰',7981,5000,'running'));                                       
                             
/* Formatted on 2011/11/03 06:35 (Formatter Plus v4.8.8) */
DECLARE
   o_emp   employee_personobj;     --定义对象类型的变量
   CURSOR all_emp
   IS
      SELECT VALUE (e) AS emp
        FROM emp_obj_table e;      --定义一个游标，用来查询多行数据
BEGIN
   FOR each_emp IN all_emp         --使用游标FOR循环检索游标数据
   LOOP
      o_emp := each_emp.emp;       --获取游标查询的对象实例
      --输出对象实例信息
      DBMS_OUTPUT.put_line (o_emp.person_name || ' 的职位是：' || o_emp.job);
   END LOOP;
END;


 DECLARE
    o_emp REF employee_personobj;   --定义REF类型的变量
 BEGIN
    --使用REF函数获取引用类型的对象
    SELECT REF(e) INTO o_emp FROM emp_obj_table e WHERE e.person_name='张小五';
 END;       
 
 
 
/* Formatted on 2011/11/03 12:21 (Formatter Plus v4.8.8) */
UPDATE emp_obj_table empobj
   SET empobj.gender = 'M'
 WHERE empobj.person_name = '张小五';
 
 
 UPDATE emp_obj_table empobj
  SET empobj=employee_personobj('李小七','F',
                             TO_DATE('1983-01-01','YYYY-MM-DD'),
                             '众泰',7981,7000,'Testing')
  WHERE person_name='张小五';                            
  
  
  DECLARE
     empref REF employee_personobj;     
  BEGIN
     SELECT REF(empobj) INTO empref FROM emp_obj_table empobj WHERE e.person_name='刘小艳';
  END;
  
  SELECT REF(e2) FROM emp_obj_table e2;
  
  
/* Formatted on 2011/11/03 14:05 (Formatter Plus v4.8.8) */
DECLARE
   emp_ref   REF employee_personobj;               --定义引用对象类型
BEGIN
   SELECT REF(e1)
     INTO emp_ref
     FROM emp_obj_table e1
    WHERE person_name = '刘小艳';                  --从对象表中获取对刘小艳的对象引用
   UPDATE emp_obj_table emp_obj
      SET emp_obj =employee_personobj('何小凤',
                  'F',TO_DATE ('1985-08-01', 'YYYY-MM-DD'),
                  '本甜',7981, 7000, 'developer')                                
      WHERE REF (emp_obj) = emp_ref;
END;                                             --使用UPDATE语句更新emp_obj_table表中刘小艳的记录


  SELECT * FROM emp_obj_table e2;
  
  
  
  DELETE FROM emp_obj_table WHERE person_name='张小五';
  
  
DECLARE
   emp_ref   REF employee_personobj;               --定义引用对象类型
BEGIN
   SELECT REF(e1)
     INTO emp_ref
     FROM emp_obj_table e1
    WHERE person_name = '刘小艳';                  --从对象表中获取对刘小艳的对象引用
      DELETE FROM emp_obj_table emp_obj                           
      WHERE REF (emp_obj) = emp_ref;
END;                                             --使用DELETE语句删除emp_obj_table表中刘小艳的记录  

SELECT * FROM emp;


--定义与关系表emp相匹配列的对象类型
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
--定义对象类型体
CREATE OR REPLACE TYPE BODY emp_tbl_obj AS
   MEMBER FUNCTION get_emp_info  RETURN VARCHAR2 IS
   BEGIN
      --在对象类型体中可以直接访问在父对象中定义的属性
      RETURN '员工编号：'||SELF.empno||' 员工名称：'||SELF.ename||' 职位：'||SELF.job;
   END; 
END;
/

/* Formatted on 2011/11/04 07:39 (Formatter Plus v4.8.8) */
--创建emp_view对象表
CREATE VIEW emp_view
   OF emp_tbl_obj
   WITH OBJECT IDENTIFIER (empno)
AS
   SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
     FROM emp e;
/


DECLARE
  o_emp emp_tbl_obj;          --定义对象类型的变量
BEGIN
  --查询对象类型
  SELECT VALUE(e) INTO o_emp FROM emp_view e WHERE empno=7369;
  --输出对象类型的属性
  DBMS_OUTPUT.put_line('员工'||o_emp.ename||' 的薪资为：'||o_emp.sal);
  DBMS_OUTPUT.put_line(o_emp.get_emp_info);  --调用对象类型的成员方法
END;  