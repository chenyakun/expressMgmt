
CREATE OR REPLACE FUNCTION get_tablecount (table_name IN VARCHAR2)
   RETURN PLS_INTEGER
IS
   --定义动态SQL语句
   sql_query   VARCHAR2 (32767) := 'SELECT COUNT(*) FROM ' || table_name;
   l_return    PLS_INTEGER;              --保存返回值的变量
BEGIN
   EXECUTE IMMEDIATE sql_query
                INTO l_return;           --动态执行SQL并返回结果值
   RETURN l_return;                      --返回函数结果
END;



DECLARE
   v_count PLS_INTEGER;
BEGIN
   v_count:=get_tablecount('emp');
   DBMS_OUTPUT.put_line('emp表的行数：'||v_count);
   v_count:=get_tablecount('dept');
   DBMS_OUTPUT.put_line('dept表的行数：'||v_count);   
END;   


/* Formatted on 2011/10/28 14:12 (Formatter Plus v4.8.8) */
DECLARE
   cnt   NUMBER;
BEGIN
   ---查询要创建的表是否存在
   SELECT COUNT (*)
     INTO cnt
     FROM user_tables
    WHERE table_name = 'EMP_TESTING';
   ---如果存在则删除该表
   IF cnt > 0
   THEN
      DBMS_OUTPUT.put_line ('表存在不创建');
   ELSE
      DBMS_OUTPUT.put_line ('表不存在');

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
   ---查询要创建的表是否存在
   SELECT COUNT (*)
     INTO v_counter
     FROM user_tables
    WHERE table_name = 'EMP_TESTING';
   ---如果存在则删除该表
   IF v_counter > 0
   THEN
      DBMS_OUTPUT.put_line ('表存在不创建');
   ELSE
      DBMS_OUTPUT.put_line ('表不存在');
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
   ---查询要创建的表是否存在
   SELECT COUNT (*) INTO v_counter FROM user_tables
            WHERE table_name = 'EMP_TESTING';
   ---如果存在则删除该表
   IF v_counter > 0 THEN
      DBMS_OUTPUT.put_line ('表存在不创建');
   ELSE
      DBMS_OUTPUT.put_line ('表不存在');
      --如果不使用动态SQL，在这里会出现错误
     EXECUTE IMMEDIATE 'CREATE TABLE emp_testing  (
       emp_name            VARCHAR2(18)                    not null,
       hire_date           DATE                            not null,
       status              NUMBER(2),
       constraint PK_ENTRY_MODIFYSTATUS primary key (emp_name, hire_date)
    )';
      --实际上前面的表根本没有创建成功，该INSERT不能成功执行
     EXECUTE IMMEDIATE 'INSERT INTO emp_testing VALUES(''李进平'',TRUNC(SYSDATE)-5,1)';
     COMMIT;
   END IF;
   v_counter :=0;
END;


SELECT * FROM emp_testing;

/* Formatted on 2011/10/28 20:54 (Formatter Plus v4.8.8) */
DECLARE
   sql_statement   VARCHAR2 (100);
BEGIN
   --定义一个DDL语句，用来创建一个表
   sql_statement := 'CREATE TABLE ddl_demo(id NUMBER,amt NUMBER)';
   --执行动态SQL语句
   EXECUTE IMMEDIATE sql_statement;
   --定义一个DML语句，用来向表中插入一条记录
   sql_statement := 'INSERT INTO ddl_demo VALUES(1,100)';
   --执行动态SQL语句
   EXECUTE IMMEDIATE sql_statement;
END;



DECLARE
   plsql_block   VARCHAR2 (500);     --定义一个变量用来保存PL/SQL语句
BEGIN
   plsql_block:=                       --为动态PL/SQL语句赋值
       'DECLARE
          I  INTEGER:=10;
        BEGIN
          EXECUTE IMMEDIATE ''TRUNCATE TABLE ddl_demo'';
          FOR j IN 1..I LOOP
             INSERT INTO ddl_demo VALUES(j,j*100);
          END LOOP;
        END;';                       --语句结束时添加分号
    EXECUTE IMMEDIATE plsql_block;   --执行动态PL/SQL语句
    COMMIT;                          --提交事务
END;

DROP TABLE emp_name_tab;

DECLARE
   sql_stmt  VARCHAR2(200);                               --保存SQL语句的变量
   TYPE id_table IS TABLE OF INTEGER;                     --定义2个嵌套表类型
   TYPE name_table IS TABLE OF VARCHAR2(8);
   t_empno id_table:=id_table(9001,9002,9003,9004,9005);  --定义嵌套表变量并进行初始化
   t_empname name_table:=name_table('张三','李四','王五','赵六','何七');
   v_deptno  NUMBER(2):=30;
   v_loc VARCHAR(20):='南京';
   emp_rec emp%ROWTYPE;
BEGIN 
   --为记录类型赋值，记录类型作为绑定变量将失败
   emp_rec.empno:=9001;
   emp_rec.ename:='西蒙';
   emp_rec.hiredate:=TRUNC(SYSDATE);
   emp_rec.sal:=5000;
   --使用普通的变量作为绑定变量
   sql_stmt:='UPDATE dept SET loc=:1 WHERE deptno=:2';
   EXECUTE IMMEDIATE sql_stmt USING v_loc,v_deptno;
   --创建一个测试用的数据表
   sql_stmt:='CREATE TABLE emp_name_tab(empno NUMBER,empname VARCHAR(20))';
   EXECUTE IMMEDIATE sql_stmt;
   --使用嵌套表变量的值作为绑定变量
   sql_stmt:='INSERT INTO emp_name_tab VALUES(:1,:2)';
   FOR i IN t_empno.FIRST..t_empno.LAST LOOP
      EXECUTE IMMEDIATE sql_stmt USING t_empno(i),t_empname(i);
   END LOOP;
   --使用记录类型提示失败
   --sql_stmt:='INSERT INTO emp VALUES :1';
   --EXECUTE IMMEDIATE sql_stmt USING emp_rec;
END;

--创建一个清除表内容的过程
CREATE OR REPLACE PROCEDURE trunc_table(table_name IN VARCHAR2)
IS
  sql_stmt VARCHAR2(100);
BEGIN
   sql_stmt:='TRUNCATE TABLE '||table_name;        --使用拼接设置方案对象
   EXECUTE IMMEDIATE sql_stmt;                     --动态执行SQL语句
END; 

BEGIN
   trunc_table('emp_name_tab');                  
END;


SELECT * FROM emp WHERE empno=7369;

DECLARE
   v_empno NUMBER(4) :=7369;                      --定义员工绑定变量
   v_percent NUMBER(4,2) := 0.12;                 --定义加薪比率绑定变量
   v_salary  NUMBER(10,2);                        --返回变量
   sql_stmt  VARCHAR2(500);                       --保存SQL语句的变量
BEGIN
   --定义更新emp表的sal字段值的动态SQL语句
   sql_stmt:='UPDATE emp SET sal=sal*(1+:percent) '
             ||' WHERE empno=:empno RETURNING sal INTO :salary';
   EXECUTE IMMEDIATE sql_stmt USING v_percent, v_empno
      RETURNING INTO v_salary;                    --使用RETURNING INTO子句获取返回值
   DBMS_OUTPUT.put_line('调整后的工资为：'||v_salary);
END;



DECLARE
   sql_stmt  VARCHAR2(100);           --保存动态SQL语句的变量
   v_deptno NUMBER(4) :=20;           --部门编号，用于绑定变量
   v_empno NUMBER(4):=7369;           --员工编号，用于绑定变量
   v_dname  VARCHAR2(20);             --部门名称，获取查询结果
   v_loc  VARCHAR2(20);               --部门位置，获取查询结果
   emp_row emp%ROWTYPE;               --保存结果的记录类型
BEGIN
   --查询dept表的动态SQL语句
   sql_stmt:='SELECT dname,loc FROM dept WHERE deptno=:deptno';
   --执行动态SQL语句并记录查询结果
   EXECUTE IMMEDIATE sql_stmt INTO v_dname,v_loc USING v_deptno ;
   --查询emp表的特定员工编号的记录
   sql_stmt:='SELECT * FROM emp WHERE empno=:empno';
   --将emp表中的特定行内容写入emp_row记录中
   EXECUTE IMMEDIATE sql_stmt INTO emp_row USING v_empno;
   DBMS_OUTPUT.put_line('查询的部门名称为：'||v_dname);
   DBMS_OUTPUT.put_line('查询的员工编号为：'||emp_row.ename);   
END;





CREATE OR REPLACE PROCEDURE create_dept(
deptno IN OUT NUMBER,             --IN OUT变量，用来获取或输出deptno值
dname IN VARCHAR2,                --部门名称
loc IN VARCHAR2                   --部门地址
)AS
BEGIN
  --如果deptno没有指定值
  IF deptno IS NULL THEN
     --从序列中取一个值
     SELECT deptno_seq.NEXTVAL INTO deptno FROM DUAL;
  END IF;
  --向dept表中插入记录
  INSERT INTO dept VALUES(deptno,dname,loc);
END;

SELECT deptno_seq.NEXTVAL FROM dual;

/* Formatted on 2011/10/29 11:12 (Formatter Plus v4.8.8) */
DECLARE
   plsql_block   VARCHAR2 (500);
   v_deptno      NUMBER (2);
   v_dname       VARCHAR2 (14)  := '网络部';
   v_loc         VARCHAR2 (13)  := '也门';
BEGIN
   plsql_block := 'BEGIN create_dept(:a,:b,:c);END;';
   --在这里指定过程需要的IN OUT参数模式
   EXECUTE IMMEDIATE plsql_block
               USING IN OUT v_deptno, v_dname, v_loc;
   DBMS_OUTPUT.put_line ('新建部门的编号为：' || v_deptno);
END;



DECLARE
   TYPE emp_cur_type IS REF CURSOR;      --定义游标类型
   emp_cur emp_cur_type;                 --定义游标变量
   v_deptno NUMBER(4) := '&deptno';      --定义部门编号绑定变量
   v_empno NUMBER(4);                                         
   v_ename VARCHAR2(25);
BEGIN
   OPEN emp_cur FOR                  --打开动态游标
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   NULL;
END;


DECLARE
   TYPE emp_cur_type IS REF CURSOR;      --定义游标类型
   emp_cur emp_cur_type;                 --定义游标变量
   v_deptno NUMBER(4) := '&deptno';      --定义部门编号绑定变量
   v_empno NUMBER(4);                                         
   v_ename VARCHAR2(25);
BEGIN
   OPEN emp_cur FOR                       --打开动态游标
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   LOOP
      FETCH emp_cur INTO v_empno, v_ename; --循环提取游标数据  
      EXIT WHEN emp_cur%NOTFOUND;          --没有数据时退出循环
      DBMS_OUTPUT.PUT_LINE ('员工编号: '||v_empno);
      DBMS_OUTPUT.PUT_LINE ('员工名称:  '||v_ename);
   END LOOP;
END;


DECLARE
   TYPE emp_cur_type IS REF CURSOR;      --定义游标类型
   emp_cur emp_cur_type;                 --定义游标变量
   v_deptno NUMBER(4) := '&deptno';      --定义部门编号绑定变量
   v_empno NUMBER(4);                                         
   v_ename VARCHAR2(25);
BEGIN
   OPEN emp_cur FOR                       --打开动态游标
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   LOOP
      FETCH emp_cur INTO v_empno, v_ename; --循环提取游标数据  
      EXIT WHEN emp_cur%NOTFOUND;          --没有数据时退出循环
      DBMS_OUTPUT.PUT_LINE ('员工编号: '||v_empno);
      DBMS_OUTPUT.PUT_LINE ('员工名称:  '||v_ename);
   END LOOP;
   CLOSE emp_cur;                          --关闭游标变量
EXCEPTION
   WHEN OTHERS THEN   
      IF emp_cur%FOUND THEN               --如果出现异常，游标变量未关闭
         CLOSE emp_cur;                   --关闭游标
      END IF;   
      DBMS_OUTPUT.PUT_LINE ('ERROR: '||
         SUBSTR(SQLERRM, 1, 200));         
END;


DECLARE
   --定义索引表类型，用来保存从DML语句中返回的结果
   TYPE ename_table_type IS TABLE OF VARCHAR2(25) INDEX BY BINARY_INTEGER;
   TYPE sal_table_type IS TABLE OF NUMBER(10,2) INDEX BY BINARY_INTEGER;   
   ename_tab ename_table_type;
   sal_tab sal_table_type;
   v_deptno NUMBER(4) :=20;                             --定义部门绑定变量
   v_percent NUMBER(4,2) := 0.12;                       --定义加薪比率绑定变量
   sql_stmt  VARCHAR2(500);                             --保存SQL语句的变量
BEGIN
   --定义更新emp表的sal字段值的动态SQL语句
   sql_stmt:='UPDATE emp SET sal=sal*(1+:percent) '
             ||' WHERE deptno=:deptno RETURNING ename,sal INTO :ename,:salary';
   EXECUTE IMMEDIATE sql_stmt USING v_percent, v_deptno
      RETURNING BULK COLLECT INTO ename_tab,sal_tab;   --使用RETURNING BULK COLLECT INTO子句获取返回值
   FOR i IN 1..ename_tab.COUNT LOOP                    --输出返回的结果值 
      DBMS_OUTPUT.put_line('员工'||ename_tab(i)||'调薪后的薪资：'||sal_tab(i));
   END LOOP;
END;


DECLARE
   TYPE ename_table_type IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
   TYPE empno_table_type IS TABLE OF NUMBER(24) INDEX BY BINARY_INTEGER; 
   ename_tab ename_table_type;              --定义保存多行返回值的索引表
   empno_tab empno_table_type;  
   v_deptno NUMBER(4) := '&deptno';          --定义部门编号绑定变量
   sql_stmt VARCHAR2(500);
BEGIN
   --定义多行查询的SQL语句
   sql_stmt:='SELECT empno, ename FROM emp '||'WHERE deptno = :1';
   EXECUTE IMMEDIATE sql_stmt 
   BULK COLLECT INTO empno_tab,ename_tab               --批量插入到索引表
   USING v_deptno;   
   FOR i IN 1..ename_tab.COUNT LOOP                    --输出返回的结果值 
      DBMS_OUTPUT.put_line('员工编号'||empno_tab(i)
                                         ||'员工名称：'||ename_tab(i));
   END LOOP;          
END;



DECLARE
   TYPE ename_table_type IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
   TYPE empno_table_type IS TABLE OF NUMBER(24) INDEX BY BINARY_INTEGER;
   TYPE emp_cur_type IS REF CURSOR;         --定义游标类型    
   ename_tab ename_table_type;              --定义保存多行返回值的索引表
   empno_tab empno_table_type;  
   emp_cur emp_cur_type;                    --定义游标变量
   v_deptno NUMBER(4) := '&deptno';         --定义部门编号绑定变量
BEGIN
   OPEN emp_cur FOR                         --打开动态游标
      'SELECT empno, ename FROM emp '||
      'WHERE deptno = :1'
   USING v_deptno;
   FETCH emp_cur BULK COLLECT INTO empno_tab, ename_tab; --批量提取游标数据  
   CLOSE emp_cur;                                        --关闭游标变量
   FOR i IN 1..ename_tab.COUNT LOOP                      --输出返回的结果值 
      DBMS_OUTPUT.put_line('员工编号'||empno_tab(i)
                                         ||'员工名称：'||ename_tab(i));
   END LOOP;       
END;

SELECT * FROM emp;

DECLARE
   --定义索引表类型，用来保存从DML语句中返回的结果
   TYPE ename_table_type IS TABLE OF VARCHAR2(25) INDEX BY BINARY_INTEGER;
   TYPE sal_table_type IS TABLE OF NUMBER(10,2) INDEX BY BINARY_INTEGER;   
   TYPE empno_table_type IS TABLE OF NUMBER(4);         --定义嵌套表类型，用于批量输入员工编号  
   ename_tab ename_table_type;
   sal_tab sal_table_type;
   empno_tab empno_table_type;
   v_deptno NUMBER(4) :=20;                             --定义部门绑定变量
   v_percent NUMBER(4,2) := 0.12;                       --定义加薪比率绑定变量
   sql_stmt  VARCHAR2(500);                             --保存SQL语句的变量
BEGIN
   empno_tab:=empno_table_type(7369,7499,7521,7566);    --初始化嵌套表
     --定义更新emp表的sal字段值的动态SQL语句
   sql_stmt:='UPDATE emp SET sal=sal*(1+:percent) '
             ||' WHERE empno=:empno RETURNING ename,sal INTO :ename,:salary';
   FORALL i IN 1..empno_tab.COUNT                        --使用FORALL语句批量输入参数
      EXECUTE IMMEDIATE sql_stmt USING v_percent, empno_tab(i)  --这里使用来自嵌套表的参数
      RETURNING BULK COLLECT INTO ename_tab,sal_tab;   --使用RETURNING BULK COLLECT INTO子句获取返回值
   FOR i IN 1..ename_tab.COUNT LOOP                    --输出返回的结果值 
      DBMS_OUTPUT.put_line('员工'||ename_tab(i)||'调薪后的薪资：'||sal_tab(i));
   END LOOP;
END;


/* Formatted on 2011/10/30 09:18 (Formatter Plus v4.8.8) */
DECLARE
   col_in     VARCHAR2(10):='sal';    --列名
   start_in   DATE;        --起始日期
   end_in     DATE;        --结束日期
   val_in     NUMBER;      --输入参数值
   plsql_str    VARCHAR2 (32767)
      :=    '
         BEGIN
             UPDATE emp SET '
             || col_in
             || ' = :val
            WHERE hiredate BETWEEN :lodate AND :hidate
            AND :val IS NOT NULL;
        END;
        '; --动态PLSQL语句
BEGIN
   --执行动态SQL语句，为重复的val_in传入多次作为绑定变量
   EXECUTE IMMEDIATE dml_str
               USING val_in,start_in,end_in;
END;



/* Formatted on 2011/10/30 09:56 (Formatter Plus v4.8.8) */
/* Formatted on 2011/10/30 09:56 (Formatter Plus v4.8.8) */
--定义一个删除任何数据库对象的通用的过程
CREATE OR REPLACE PROCEDURE drop_obj (kind IN VARCHAR2, NAME IN VARCHAR2)
AUTHID CURRENT_USER       --定义调用者权限
AS
BEGIN
   EXECUTE IMMEDIATE 'DROP ' || kind || ' ' || NAME;
EXCEPTION
WHEN OTHERS THEN
   RAISE;   
END;


/* Formatted on 2011/10/30 11:06 (Formatter Plus v4.8.8) */
DECLARE
   v_null   CHAR (1);                      --在运行时该变量自动被设置为NULL值
BEGIN
   EXECUTE IMMEDIATE 'UPDATE emp SET comm=:x'
               USING v_null;                                     --传入NULL值
END;



CREATE OR REPLACE PROCEDURE ddl_execution (ddl_string IN VARCHAR2)
   AUTHID CURRENT_USER IS            --使用调用者权限
BEGIN
   EXECUTE IMMEDIATE ddl_string;     --执行动态SQL语句
EXCEPTION
   WHEN OTHERS                       --捕捉错误  
   THEN
      DBMS_OUTPUT.PUT_LINE (      --显示错误消息
         '动态SQL语句错误：' || DBMS_UTILITY.FORMAT_ERROR_STACK);
      DBMS_OUTPUT.PUT_LINE (      --显示当前执行的SQL语句
         '   执行的SQL语句为： "' || ddl_string || '"');
      RAISE;
END ddl_execution;



EXEC ddl_execution('alter table emp_test add emp_sal number NULL');