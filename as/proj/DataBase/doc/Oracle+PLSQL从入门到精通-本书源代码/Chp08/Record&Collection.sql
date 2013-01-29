DECLARE
   --定义保存字段值的变量
   v_empno      NUMBER;
   v_ename      VARCHAR2 (20);
   v_job        VARCHAR2 (9);
   v_mgr        NUMBER (4);
   v_hiredate   DATE;
   v_sal        NUMBER (7, 2);
   v_comm       NUMBER (7, 2);
   v_deptno     NUMBER (2);
BEGIN
   --从emp表中取出字段值
   SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
     INTO v_empno, v_ename, v_job, v_mgr, v_hiredate, v_sal, v_comm, v_deptno
     FROM emp
    WHERE empno = :empno;
   --向emp_copy表中插入变量的值
   INSERT INTO emp_copy
               (empno, ename, job, mgr, hiredate, sal, comm,
                deptno
               )
        VALUES (v_empno, v_ename, v_job, v_mgr, v_hiredate, v_sal, v_comm,
                v_deptno
               );
EXCEPTION  --异常处理块
   WHEN OTHERS
   THEN
      NULL;
END;


DECLARE
   --定义记录类型
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
   --声明记录类型的变量
   emp_info t_emp;
BEGIN
   --从emp表中取出字段值赋给记录类型
   SELECT *
     INTO emp_info
     FROM emp
    WHERE empno = :empno;
   --向emp_copy表中插入记录类型的值
   INSERT INTO emp_copy VALUES emp_info;
EXCEPTION  --异常处理块
   WHEN OTHERS
   THEN
      NULL;
END;



DECLARE
   --声明记录类型
   TYPE emp_rec IS RECORD (
      dept_row   dept%ROWTYPE,   --声明来自dept表行的嵌套记录
      empno      NUMBER,         --员工编号
      ename      VARCHAR (20),   --员工名称
      job        VARCHAR (10),   --职位
      sal        NUMBER (7, 2)   --薪资
   );
   --声明记录类型的变量
   emp_info   emp_rec;
BEGIN
   NULL;
END;


DECLARE
   --声明记录类型
   TYPE emp_rec IS RECORD (
      dept_row   dept%ROWTYPE,   --声明来自dept表行的嵌套记录
      empno      NUMBER,         --员工编号
      ename      VARCHAR (20),   --员工名称
      job        VARCHAR (10),   --职位
      sal        NUMBER (7, 2)   --薪资
   );
   --声明记录类型的变量
   emp_info   emp_rec;
BEGIN
   NULL;
END;




DECLARE
   TYPE emp_rec IS RECORD (
      empname    VARCHAR (12)           := '李斯特',      --员工名称，初始值李斯特
      empno      NUMBER        NOT NULL DEFAULT 7369,     --员工编号，默认值7369
      hiredate   DATE                   DEFAULT SYSDATE,  --雇佣日期，默认值当前日期
      sal        NUMBER (7, 2)                            --员工薪资
   );
   --声明emp_rec类型的变量
   empinfo   emp_rec;
BEGIN
   --下面的语句为empinfo记录赋值。
   empinfo.empname:='施密斯';
   empinfo.empno:=7010;
   empinfo.hiredate:=TO_DATE('1982-01-01','YYYY-MM-DD');
   empinfo.sal:=5000;
   --下面的语句输出empinfo记录的值
   DBMS_OUTPUT.PUT_LINE('员工名称：'||empinfo.empname);
   DBMS_OUTPUT.PUT_LINE('员工编号：'||empinfo.empno);
   DBMS_OUTPUT.PUT_LINE('雇佣日期：'||TO_CHAR(empinfo.hiredate,'YYYY-MM-DD'));
   DBMS_OUTPUT.PUT_LINE('员工薪资：'||empinfo.sal);   
END;




DECLARE
   --定义记录类型
   TYPE emp_rec IS RECORD (
      empno   NUMBER,
      ename   VARCHAR2 (20)
   );
   --定义与emp_rec具有相同成员的记录类型
   TYPE emp_rec_dept IS RECORD (
      empno   NUMBER,
      ename   VARCHAR2 (20)
   );
   --声明记录类型的变量
   emp_info1   emp_rec;
   emp_info2   emp_rec;
   emp_info3   emp_rec_dept;
   --定义一个内嵌过程用来输出记录信息
   PROCEDURE printrec (empinfo emp_rec)
   AS
   BEGIN
      DBMS_OUTPUT.put_line ('员工编号：' || empinfo.empno);
      DBMS_OUTPUT.put_line ('员工名称：' || empinfo.ename);
   END;
BEGIN
   emp_info1.empno := 7890;    --为emp_info1记录赋值
   emp_info1.ename := '张大千';
   DBMS_OUTPUT.put_line ('emp_info1的信息如下：');
   printrec (emp_info1);      --打印赋值后的emp_info1记录
   emp_info2 := emp_info1;    --将emp_info1记录变量直接赋给emp_info2
   DBMS_OUTPUT.put_line ('emp_info2的信息如下：');
   printrec (emp_info2);      --打印赋值后的emp_info2的记录
   emp_info3:=emp_info1;    --此语句出现错误，不同记录类型的变量不能相互赋值
END;

DESC dept;
DESC emp;


DECLARE
   --定义一个与dept表具有相同列的记录
   TYPE dept_rec IS RECORD (
      deptno   NUMBER (10),
      dname    VARCHAR2 (30),
      loc      VARCHAR2 (30)
   );
   --定义基于dept表的记录类型
   dept_rec_db   dept%ROWTYPE;
   dept_info     dept_rec;
BEGIN
   --使用SELECT语句为记录类型赋值
   SELECT *
     INTO dept_rec_db
     FROM dept
    WHERE deptno = 20;
   --将%ROWTYPE定义的记录赋给标准记录变量
   dept_info := dept_rec_db;
END;


DECLARE
   TYPE emp_rec IS RECORD (
      empno   NUMBER (10),
      ename   VARCHAR2 (30),
      job     VARCHAR2 (30)
   );
   --声明记录类型的变量
   emp_info   emp_rec;
BEGIN
   --为记录类型赋值
   SELECT empno,
          ename,
          job
     INTO emp_info
     FROM emp
    WHERE empno = 7369;
    --输出记录类型的值
   DBMS_OUTPUT.put_line (   '员工编号：'
                         || emp_info.empno
                         || CHR (13)
                         || '员工姓名：'
                         || emp_info.ename
                         || CHR (13)
                         || '员工职别：'
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
   --定义2个记录类型的变量
   dept_row     dept%ROWTYPE;
   dept_norow   dept_rec;
BEGIN
   --为记录类型赋值
   dept_row.deptno := 70;
   dept_row.dname := '工程部';
   dept_row.loc := '上海';
   dept_norow.deptno := 80;
   dept_norow.dname := '电脑部';
   dept_norow.loc := '北京';
   --插入%ROWTYPE定义的记录变量到表中
   INSERT INTO dept
        VALUES dept_row;
   --插入普通记录变量的值到表中
   INSERT INTO dept
        VALUES dept_norow;
   --向数据库提交对表的更改
   COMMIT;
END;

SELECT * FROM dept;

/* Formatted on 2011/09/07 21:55 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (         --定义记录类型
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );
   dept_info   dept_rec;            --定义记录类型的变量
BEGIN
   SELECT *
     INTO dept_info
     FROM dept
    WHERE deptno = 80;              --使用SELECT语句初始化记录类型
   dept_info.dname := '信息管理部'; --更新记录类型的值
   UPDATE dept
      SET ROW = dept_info
    WHERE deptno = dept_info.deptno;--在UPDATE中使用记录变量更新表
END;



/* Formatted on 2011/09/08 06:32 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (                                   --定义记录类型
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );

   dept_info        dept_rec;                             --定义记录类型的变量
   dept_returning   dept%ROWTYPE;                 --定义用于返回结果的记录类型
BEGIN
   SELECT *
     INTO dept_info
     FROM dept
    WHERE deptno = 80;                          --使用SELECT语句初始化记录类型

   dept_info.dname := '信息管理部';                         --更新记录类型的值

   UPDATE    dept
         SET ROW = dept_info
       WHERE deptno = dept_info.deptno          --在UPDATE中使用记录变量更新表，返回受影响的行到记录
   RETURNING deptno,
             dname,
             loc
        INTO dept_returning;

   dept_info.deptno := 12;
   dept_info.dname := '维修部';

   INSERT INTO dept                             --插入新的部门编号记录，返回受影响的行的记录
        VALUES dept_info
     RETURNING deptno,
               dname,
               loc
          INTO dept_returning;

   DELETE FROM dept                            --删除现有的部门，返回受影响的行的记录
         WHERE deptno = dept_info.deptno
     RETURNING deptno,
               dname,
               loc
          INTO dept_returning;
END;


DESC emp;

/* Formatted on 2011/09/08 10:09 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_rec IS RECORD (                            --定义部门记录类型
      deptno   NUMBER (2),
      dname    VARCHAR2 (14),
      loc      VARCHAR2 (13)
   );
   TYPE emp_rec IS RECORD (                             --定义员工记录类型          
      v_empno      NUMBER,
      v_ename      VARCHAR2 (20),
      v_job        VARCHAR2 (9),
      v_mgr        NUMBER (4),
      v_hiredate   DATE,
      v_sal        NUMBER (7, 2),
      v_comm       NUMBER (7, 2),
      v_dept_rec   dept_rec                             --定义嵌套的员工记录
   );  
   emp_info    emp_rec;                                 --员工记录
   dept_info   dept_rec;                                --临时部门记录
BEGIN
   SELECT *                                             --从数据库中取出员工部门的记录
     INTO dept_info
     FROM dept
    WHERE deptno = (SELECT deptno
                      FROM emp
                     WHERE empno = 7369);
   emp_info.v_dept_rec:=dept_info;                       --将部门信息记录赋给嵌套的部门记录
   SELECT empno, ename, job, mgr,                        --为emp表赋值
          hiredate, sal, comm
     INTO emp_info.v_empno, emp_info.v_ename, emp_info.v_job, emp_info.v_mgr,
          emp_info.v_hiredate, emp_info.v_sal, emp_info.v_comm
     FROM emp
    WHERE empno = 7369;
    --输出嵌套记录的员工所在部门信息
    DBMS_OUTPUT.PUT_LINE('员工所属部门为：'||emp_info.v_dept_rec.dname);
END;


-- 雇佣日期索引表集合
TYPE hiredate_idxt IS TABLE OF DATE INDEX BY PLS_INTEGER;
-- 部门编号集合
TYPE deptno_idxt IS TABLE OF dept.deptno%TYPE NOT NULL
   INDEX BY PLS_INTEGER;
--记录类型的索引表，这个结构允许在PL/SQL程序中创建本的一个本地副本
TYPE emp_idxt IS TABLE OF emp%ROWTYPE
   INDEX BY NATURAL;
-- 由部门名称标识的部门记录的集合
TYPE deptname_idxt IS TABLE OF dept%ROWTYPE
   INDEX BY dept.dname%TYPE;
-- 定义集合的集合
TYPE private_collection_tt IS TABLE OF deptname_idxt
   INDEX BY VARCHAR2(100);
   
   
/* Formatted on 2011/09/08 21:06 (Formatter Plus v4.8.8) */
DECLARE
   TYPE idx_table IS TABLE OF VARCHAR (12)
      INDEX BY PLS_INTEGER;                    --定义索引表类型   
   v_emp   idx_table;                          --定义索引表变量
BEGIN
   v_emp (1) := '史密斯';                      --随机的为索引表赋值
   v_emp (20) := '克拉克';
   v_emp (40) := '史瑞克';
   v_emp (-10) := '杰瑞';
   if v_emp.EXISTS(8) THEN
     DBMS_OUTPUT.PUT_LINE(v_emp(8));
    END IF;
--   EXCEPTION
--   WHEN OTHERS THEN
--     DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;



/* Formatted on 2011/09/08 21:38 (Formatter Plus v4.8.8) */
DECLARE
   --定义记录类型的索引表，以dname作为索引键类型
   --dname是VARCHAR2(14)类型
   TYPE idx_dept_table IS TABLE OF dept%ROWTYPE
      INDEX BY dept.dname%TYPE;
   --声明记录类型的变量
   v_dept   idx_dept_table;
   --定义一个游标，用来查询dept表
   CURSOR dept_cur
   IS
      SELECT *
        FROM dept;
BEGIN
   --使用游标FOR循环打开游标，检索数据
   FOR deptrow IN dept_cur
   LOOP 
      --为索引表中的元素赋值
      v_dept (deptrow.dname) := deptrow;
      --输出部门的LOC列信息
      DBMS_OUTPUT.put_line (v_dept (deptrow.dname).loc);
   END LOOP;
END;

SELECT * FROM dept;

/* Formatted on 2011/09/09 06:22 (Formatter Plus v4.8.8) */
DECLARE
   --定义以VARCHAR2作为索引键的索引表
   TYPE idx_deptno_table IS TABLE OF NUMBER (2)
      INDEX BY VARCHAR2 (20);
   --声明记录类型的变量
   v_deptno   idx_deptno_table;
BEGIN
   --为索引表赋值
   v_deptno ('财务部') := 10;
   v_deptno ('研究部') := 20;
   v_deptno ('销售部') := 30;
   --引用索引表的内容
   DBMS_OUTPUT.put_line ('销售部编号为：' || v_deptno ('销售部'));
END;




/* Formatted on 2011/09/08 22:44 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_table IS TABLE OF dept%ROWTYPE;              --部门信息嵌套表
   TYPE emp_name_table IS TABLE OF VARCHAR2 (20);         --员工名称嵌套表
   TYPE deptno_table IS TABLE OF NUMBER (2);              --部门编号嵌套表
   dept_info       dept_table;                            --声明嵌套表变量
   --声明并初始化嵌套表变量
   emp_name_info   emp_name_table := emp_name_table ('张小三', '李斯特');
   deptno_info     deptno_table   := deptno_table (20, 30, 40);
BEGIN
   NULL;
END;




/* Formatted on 2011/09/09 06:44 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emp_name_table IS TABLE OF VARCHAR2 (20);            --员工名称嵌套表
   TYPE deptno_table IS TABLE OF NUMBER (2);                 --部门编号嵌套表
   deptno_info     deptno_table;
   emp_name_info   emp_name_table := emp_name_table ('张小三', '李斯特');
BEGIN
   DBMS_OUTPUT.put_line ('员工1：' || emp_name_info (1)); --访问嵌套表元素
   DBMS_OUTPUT.put_line ('员工2：' || emp_name_info (2));
   IF deptno_info IS NULL                                 --判断嵌套表是否被初始化
   THEN
      deptno_info := deptno_table (NULL,NULL,NULL,NULL,NULL);
   END IF;
  -- deptno_info.EXTEND(5);                                --扩充元素的个数
   FOR i IN 1 .. 5                                       --循环遍历嵌套表元数个数
   LOOP
      deptno_info (i) := i * 10;
   END LOOP;
   --显示部门个数
   DBMS_OUTPUT.put_line ('部门个数：' || deptno_info.COUNT);
END;






DROP TYPE empname_type;

CREATE TYPE empname_type_02 IS TABLE OF VARCHAR2(20);



--1.创建嵌套表类型
CREATE TYPE empname_type IS TABLE OF VARCHAR2(20);
/
--2.创建数据表时指定嵌套表列，同时要使用STORE AS指定嵌套表的存储表
CREATE TABLE dept_nested
(
   deptno NUMBER(2),                    --部门编号
   dname VARCHAR2(20),                  --部门名称
   emplist empname_type                 --部门员工列表
) NESTED TABLE emplist STORE AS empname_table;
 


/* Formatted on 2011/09/09 11:19 (Formatter Plus v4.8.8) */
DECLARE
   emp_list   empname_type
         := empname_type ('史密斯', '杰克', '马丁', '斯大林', '布什', '小平');
BEGIN
   --可以在INSERT语句中传入一个嵌套表实例
   INSERT INTO dept_nested
        VALUES (10, '国务院', emp_list);
   --也可以直接在INSERT语句中实例化嵌套表
   INSERT INTO dept_nested
        VALUES (20, '财务司', empname_type ('李林', '张杰', '马新', '蔡文'));
   --从数据库表中查询出嵌套表实例
   SELECT emplist INTO emp_list FROM dept_nested WHERE deptno=10;            
   --对嵌套表进行更新，然后使用UPDATE语句将嵌套表实例更新回数据库
   emp_list (1) := '少校';
   emp_list (2) := '大校';
   emp_list (3) := '中校';
   emp_list (4) := '学校';
   emp_list (5) := '无效';
   emp_list (6) := '药效';
   --使用更改过的emp_list更新嵌套表列
   UPDATE dept_nested
      SET emplist = emp_list
    WHERE deptno = 10;
END;


SELECT * FROM dept_nested;


/* Formatted on 2011/09/09 14:22 (Formatter Plus v4.8.8) */
DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);        --定义项目列表变长数组
   TYPE empno_type IS VARRAY (10) OF NUMBER (4);            --定义员工编号变长数组
   --声明变长数组类型的变量，并使用构造函数进行初始化
   project_list   projectlist := projectlist ('网站', 'ERP', 'CRM', 'CMS');
   empno_list     empno_type;                               --声明变长数组类型的变量
BEGIN
   DBMS_OUTPUT.put_line (project_list (3));              --输出第3个元素的值
   project_list.EXTEND;                                     --扩展到第5个元素
   project_list (5) := 'WORKFLOW';                          --为第5个元素赋值
   empno_list :=                                            --构造empno_list
      empno_type (7011, 7012, 7013, 7014, NULL, NULL, NULL, NULL, NULL, NULL);
   empno_list (9) := 8011;                                  --为第9个元素赋初值
   DBMS_OUTPUT.put_line (empno_list (9));                --输出第9个元素的值
END;



--创建一个变长数组的类型empname_varray_type，用来存储员工信息
CREATE OR REPLACE TYPE empname_varray_type IS VARRAY (20) OF VARCHAR2 (20);
/
CREATE TABLE dept_varray                  --创建部门数据表
(
   deptno NUMBER(2),                      --部门编号    
   dname VARCHAR2(20),                    --部门名称
   emplist empname_varray_type            --部门员工列表
);


/* Formatted on 2011/09/09 15:25 (Formatter Plus v4.8.8) */
DECLARE                                         --声明并初始化变长数组
   emp_list   empname_varray_type                          
                := empname_varray_type ('史密斯', '杰克', '汤姆', '丽沙', '简', '史太龙');
BEGIN
   INSERT INTO dept_varray
        VALUES (20, '维修组', emp_list);        --向表中插入变长数组数据
   INSERT INTO dept_varray                      --直接在INSERT语句中初始化变长数组数据
        VALUES (30, '机加工',
                empname_varray_type ('张三', '刘七', '赵五', '阿四', '阿五', '阿六'));
   SELECT emplist
     INTO emp_list
     FROM dept_varray
    WHERE deptno = 20;                          --使用SELECT语句从表中取出变长数组数据
   emp_list (1) := '杰克张';                    --更新变长数组数据的内容
   UPDATE dept_varray
      SET emplist = emp_list
    WHERE deptno = 20;                          --使用UPDATE语句更新变长数组数据
   DELETE FROM dept_varray
         WHERE deptno = 30;                     --删除记录并同时删除变长数组数据
END;




/* Formatted on 2011/09/09 20:56 (Formatter Plus v4.8.8) */
DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --定义项目列表变长数组
   project_list   projectlist := projectlist ('网站', 'ERP', 'CRM', 'CMS');
BEGIN
   IF project_list.EXISTS (5)                          --判断一个不存在的元素值
   THEN                                                --如果存在，则输出元素值
      DBMS_OUTPUT.put_line ('元素存在，其值为：' || project_list (5));
   ELSE
      DBMS_OUTPUT.put_line ('元素不存在');          --如果不存在，显示元素不存在    
   END IF;
END;


DECLARE
   TYPE emp_name_table IS TABLE OF VARCHAR2 (20);            --员工名称嵌套表
   TYPE deptno_table IS TABLE OF NUMBER (2);                 --部门编号嵌套表
   deptno_info     deptno_table;
   emp_name_info   emp_name_table := emp_name_table ('张小三', '李斯特');
BEGIN
   deptno_info:=deptno_table();                              --构造一个不包含任何元素的嵌套表
   deptno_info.EXTEND(5);                                    --扩展5个元素
   DBMS_OUTPUT.PUT_LINE('deptno_info的元素个数为：'||deptno_info.COUNT);
   DBMS_OUTPUT.PUT_LINE('emp_name_info的元素个数为：'||emp_name_info.COUNT);   
END;   


DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --定义项目列表变长数组
   project_list   projectlist := projectlist ('网站', 'ERP', 'CRM', 'CMS');
BEGIN
   DBMS_OUTPUT.put_line ('变长数组的上限值为：' || project_list.LIMIT);
   project_list.EXTEND(8);
   DBMS_OUTPUT.put_line ('变长数组的当前个数为：' || project_list.COUNT);   
END;



DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --定义项目列表变长数组
   project_list   projectlist := projectlist ('网站', 'ERP', 'CRM', 'CMS');
BEGIN
   DBMS_OUTPUT.put_line ('变长数组的上限值为：' || project_list.LIMIT);
   project_list.EXTEND(8);
   DBMS_OUTPUT.put_line ('变长数组的当前个数为：' || project_list.COUNT);   
END;


/* Formatted on 2011/09/10 20:00 (Formatter Plus v4.8.8) */
DECLARE
   TYPE projectlist IS VARRAY (50) OF VARCHAR2 (16);   --定义项目列表变长数组

   project_list   projectlist := projectlist ('网站', 'ERP', 'CRM', 'CMS');
BEGIN
   DBMS_OUTPUT.put_line ('project_list的第1个元素下标：' || project_list.FIRST
                        );                             --查看第1个元素的下标
   project_list.EXTEND (8);                            --扩展8个元素
   DBMS_OUTPUT.put_line (   'project_list的最后一个元素的下标：'
                         || project_list.LAST
                        );                             --查看最后1个元素的下标
END;



/* Formatted on 2011/09/10 20:46 (Formatter Plus v4.8.8) */
DECLARE
   TYPE idx_table IS TABLE OF VARCHAR (12)
      INDEX BY PLS_INTEGER;                                  --定义索引表类型
   v_emp   idx_table;                                        --定义索引表变量
   i       PLS_INTEGER;                                      --定义循环控制变量
BEGIN
   v_emp (1) := '史密斯';                                   --随机的为索引表赋值
   v_emp (20) := '克拉克';
   v_emp (40) := '史瑞克';
   v_emp (-10) := '杰瑞';
   --获取集合中第-10个元素的下一个值
   DBMS_OUTPUT.put_line ('第-10个元素的下一个值：' || v_emp (v_emp.NEXT (-10)));
   --获取集合中第40个元素的上一个值
   DBMS_OUTPUT.put_line ('第40个元素的上一个值：' || v_emp (v_emp.PRIOR (40)));
   i := v_emp.FIRST;                                        --定位到第1个元素的下标
   WHILE i IS NOT NULL                                      --开始循环直到下标为NULL
   LOOP                                                     --输出元素的值
      DBMS_OUTPUT.put_line ('v_emp(' || i || ')=' || v_emp (i));
      i := v_emp.NEXT (i);                                  --向下移动循环指针，指向下一个下标
   END LOOP;
END;



/* Formatted on 2011/09/10 21:35 (Formatter Plus v4.8.8) */
DECLARE
   TYPE courselist IS TABLE OF VARCHAR2 (10);                --定义嵌套表
   --定义课程嵌套表变量
   courses   courselist;
   i PLS_INTEGER;
BEGIN
   courses := courselist ('生物', '物理', '化学');           --初始化元素
   courses.DELETE (3);                                       --删除第3个元素
   courses.EXTEND;                                           --追加一个新的NULL元素
   courses (4) := '英语'; 
   courses.EXTEND(5,1);                                      --把第1个元素拷贝5份添加到末尾  
   i:=courses.FIRST; 
   WHILE i IS NOT NULL LOOP                                  --循环显示结果值
      DBMS_OUTPUT.PUT_LINE('courses('||i||')='||courses(i));
      i:=courses.NEXT(i);
   END LOOP;
END;


DECLARE
   TYPE courselist IS TABLE OF VARCHAR2 (10);                --定义嵌套表
   --定义课程嵌套表变量
   courses   courselist;
   i PLS_INTEGER;
BEGIN
   courses := courselist ('生物', '物理', '化学','音乐','数学','地理');--初始化元素
   courses.TRIM(2);                                             --删除集合末尾的2个元素
   DBMS_OUTPUT.PUT_LINE('当前的元素个数：'||courses.COUNT);  --显示元素个数
   courses.EXTEND;                                             --扩展1个元素   
   courses(courses.COUNT):='语文';                             --为最后1个元素赋值
   courses.TRIM;                                               --删除集合末尾的最后1个元素 
   i:=courses.FIRST; 
   WHILE i IS NOT NULL LOOP                                  --循环显示结果值
      DBMS_OUTPUT.PUT_LINE('courses('||i||')='||courses(i));
      i:=courses.NEXT(i);
   END LOOP;
END;


DECLARE
   TYPE courselist IS TABLE OF VARCHAR2 (10);                --定义嵌套表
   --定义课程嵌套表变量
   courses   courselist;
   i PLS_INTEGER;
BEGIN
   courses := courselist ('生物', '物理', '化学','音乐','数学','地理');--初始化元素
   courses.DELETE(2);                                             --删除第2个元素
   DBMS_OUTPUT.PUT_LINE('当前的元素个数：'||courses.COUNT);    --显示元素个数
   courses.EXTEND;                                                --扩展1个元素  
   DBMS_OUTPUT.PUT_LINE('当前的元素个数：'||courses.COUNT);    --显示元素个数    
   courses(courses.LAST):='语文';                                 --为最后1个元素赋值
   courses.DELETE(4,courses.COUNT);                               --删除集合末尾的最后1个元素 
   i:=courses.FIRST; 
   WHILE i IS NOT NULL LOOP                                        --循环显示结果值
      DBMS_OUTPUT.PUT_LINE('courses('||i||')='||courses(i));
      i:=courses.NEXT(i);
   END LOOP;
END;



DECLARE
   TYPE numlist IS TABLE OF NUMBER;
   nums numlist;          --一个空的嵌套表
BEGIN
   nums(1):=1;        --未构造就使用表元素，将触发：ORA-06531:引用未初始化的收集
   nums:=numlist(1,2);--初始化嵌套表
   nums(NULL):=3;     --使用NULL索引键，将触发：ORA-06502:PL/SQL:数字或值错误:NULL索引表键值
   nums(0):=3;        --访问不存在的下标，将触发：ORA-06532:下标超出限制
   nums(3):=3;        --下标超过最大元素个数，将触发：ORA-06532:下标超出限制
   nums.DELETE(1);    --删除第1个元素
   IF nums(1)=1 THEN
      NULL;
       --因为第1个元素已被删除，再访问将触发：ORA-01403: 未找到任何数据
   END IF;
END;


DECLARE
   TYPE dept_type IS VARRAY (20) OF NUMBER;  --定义嵌套表变量  
   depts dept_type:=dept_type (10, 30, 70);  --实例化嵌套表，分配3个元素
BEGIN
   FOR i IN depts.FIRST..depts.LAST          --循环嵌套表元素 
   LOOP
      DELETE FROM emp
            WHERE deptno = depts (i);       --向SQL引擎发送SQL命令执行SQL操作
   END LOOP;
END;


/* Formatted on 2011/09/11 14:26 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_type IS VARRAY (20) OF NUMBER;                  --定义嵌套表变量
   depts   dept_type := dept_type (10, 30, 70);   --实例化嵌套表，分配3个元素   
BEGIN
   FORALL i IN depts.FIRST .. depts.LAST                     --循环嵌套表元素
      DELETE FROM emp
            WHERE deptno = depts (i);       --向SQL引擎发送SQL命令执行SQL操作
   FOR i IN 1..depts.COUNT LOOP  
   DBMS_OUTPUT.put_line (   '部门编号'
                         || depts (i)
                         || '的删除操作受影响的行为：'
                         || SQL%BULK_ROWCOUNT (i)
                        );
   END LOOP;
END;


/* Formatted on 2011/09/11 15:15 (Formatter Plus v4.8.8) */
DECLARE
   TYPE numtab IS TABLE OF emp.empno%TYPE;     --员工编号嵌套表
   TYPE nametab IS TABLE OF emp.ename%TYPE;    --员工名称嵌套表
   nums    numtab;                             --定义嵌套表变量，不需要初始化        
   names   nametab;
BEGIN
   SELECT empno, ename
   BULK COLLECT INTO nums, names
     FROM emp;                                --从emp表中查出员工编号和名称，批量插入到集合
   FOR i IN 1 .. nums.COUNT                   --循环显示集合内容
   LOOP
      DBMS_OUTPUT.put ('num(' || i || ')=' || nums (i)||'   ');
      DBMS_OUTPUT.put_line ('names(' || i || ')=' || names (i));      
   END LOOP;
END;