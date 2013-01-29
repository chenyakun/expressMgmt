
CREATE OR REPLACE PROCEDURE newdept (
   p_deptno   dept.deptno%TYPE,    --部门编号
   p_dname    dept.dname%TYPE,     --部门名称
   p_loc      dept.loc%TYPE        --位置
)
AS
   v_deptcount   NUMBER;           --保存是否存在员工编号
BEGIN
   SELECT COUNT (*) INTO v_deptcount FROM dept
    WHERE deptno = p_deptno;       --查询在dept表中是否存在部门编号
   IF v_deptcount > 0              --如果存在相同的员工记录
   THEN                            --抛出异常
      raise_application_error (-20002, '出现了相同的员工记录');
   END IF;
   INSERT INTO dept(deptno, dname, loc)  
        VALUES (p_deptno, p_dname, p_loc);--插入记录
   COMMIT;                          --提交事务
END;

SELECT * FROM dept;

BEGIN
   newdept(10,'成本科','深圳');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('产生了错误：'||SQLERRM);
END;

SELECT object_type 对象类型, object_name 对象名称, status 状态
 FROM user_objects
 WHERE object_type IN ('PACKAGE', 'PACKAGE BODY', 'FUNCTION', 'PROCEDURE')
ORDER BY object_type, status, object_name;



CREATE OR REPLACE PROCEDURE newdept (
   p_deptno IN  NUMBER,    --部门编号
   p_dname  IN  VARCHAR2,     --部门名称
   p_loc    IN  VARCHAR2        --位置
)
AS
   v_deptcount     NUMBER(4);           --保存是否存在员工编号
   e_duplication_dept EXCEPTION;
BEGIN
   SELECT COUNT (*) INTO v_deptcount FROM dept
    WHERE deptno = p_deptno;       --查询在dept表中是否存在部门编号
   IF v_deptcount > 0              --如果存在相同的员工记录
   THEN                            --抛出异常
      RAISE e_duplication_dept;
   END IF;
   INSERT INTO dept(deptno, dname, loc)  
        VALUES (p_deptno, p_dname, p_loc);--插入记录
   COMMIT;                          --提交事务
EXCEPTION   
   WHEN e_duplication_dept THEN
      ROLLBACK;
      raise_application_error (-20002, '出现了相同的员工记录');
END;

SHOW ERRORS;


SELECT * FROM emp;

CREATE OR REPLACE FUNCTION getraisedsalary (p_empno emp.empno%TYPE)
   RETURN NUMBER
IS
   v_job           emp.job%TYPE;            --职位变量
   v_sal           emp.sal%TYPE;            --薪资变量
   v_salaryratio   NUMBER (10, 2);          --调薪比率
BEGIN
   --获取员工表中的薪资信息
   SELECT job, sal INTO v_job, v_sal FROM emp WHERE empno = p_empno;
   CASE v_job                               --根据不同的职位获取调薪比率
      WHEN '职员' THEN
         v_salaryratio := 1.09;
      WHEN '销售人员' THEN
         v_salaryratio := 1.11;
      WHEN '经理' THEN
         v_salaryratio := 1.18;
      ELSE
         v_salaryratio := 1;
   END CASE;
   IF v_salaryratio <> 1                    --如果有调薪的可能
   THEN
      RETURN ROUND(v_sal * v_salaryratio,2);         --返回调薪后的薪资
   ELSE
      RETURN v_sal;                         --否则不返回薪资
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 0;                             --如果没找到原工记录，返回0
END;


DECLARE
   v_raisedsal NUMBER(10,2);     --定义保存调薪记录的临时文件
BEGIN
   --调用函数获取调薪后的记录
   DBMS_OUTPUT.PUT_LINE('7369员工调薪记录：'||getraisedsalary(7369));
   v_raisedsal:=getraisedsalary(7521);
   DBMS_OUTPUT.PUT_LINE('7521员工调薪记录：'||getraisedsalary(7521));   
END;

SELECT * FROM emp;


CREATE OR REPLACE PROCEDURE RaiseSalary(
              p_empno emp.empno%TYPE             --员工编号参数
              )
AS
   v_job emp.job%TYPE;                           --局部的职位变量
   v_sal emp.sal%TYPE;                           --局部的薪资变量
BEGIN
   --查询员工信息
   SELECT job,sal INTO v_job,v_sal FROM emp WHERE empno=p_empno;
   IF v_job<>'职员' THEN                         --仅为职员加薪
      RETURN;                                    --如果不是职员，则退出
   ELSIF v_sal>3000 THEN                         --如果职员薪资大于3000,则退出
      RETURN;
   ELSE     
     --否则更新薪资记录
     UPDATE emp set sal=ROUND(sal*1.12,2) WHERE empno=v_empno;
   END IF; 
EXCEPTION
   WHEN NO_DATA_FOUND THEN                       --异常处理
      DBMS_OUTPUT.PUT_LINE('没有找到员工记录');     
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
   p_deptno NUMBER,                                     --定义形式参数
   p_dname VARCHAR2,
   p_loc VARCHAR2
)
AS
   v_count NUMBER(10);
BEGIN
   SELECT COUNT(deptno) INTO v_count FROM dept WHERE deptno=p_deptno;
   IF v_count>1 THEN
      RAISE_APPLICATION_ERROR(-20001,'数据库中存在相同名称的部门编号！');
   END IF;
   INSERT INTO dept VALUES(p_deptno,p_dname,p_loc);    --在过程体中使用形式参数
   COMMIT;
END;

BEGIN
   insertdept('ABC','行政部','德克萨斯');
EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;


CREATE OR REPLACE PROCEDURE insertdept( 
   p_deptno IN NUMBER:=55,                             --定义形式参数，并赋初值
   p_dname IN VARCHAR2,
   p_loc IN VARCHAR2
)
AS
   v_count NUMBER(10);
BEGIN
   --p_dname:='市场策略部';                            --错误，不能对IN模式参数进行赋值
   SELECT COUNT(deptno) INTO v_count FROM dept WHERE deptno=p_deptno;
   IF v_count>1 THEN
      RAISE_APPLICATION_ERROR(-20001,'数据库中存在相同名称的部门编号！');
   END IF;
   INSERT INTO dept VALUES(p_deptno,p_dname,p_loc);    --在过程体中使用形式参数
   COMMIT;
END;


BEGIN
   insertdept(55,'勤运部','西北');
END;


CREATE OR REPLACE PROCEDURE OutRaiseSalary(
    p_empno IN NUMBER,
    p_raisedSalary OUT NUMBER                     --定义一个员工加薪后的薪资的输出变量
)
AS
    v_sal NUMBER(10,2);                           --定义本地局部变量
    v_job VARCHAR2(10);
BEGIN
    p_raisedSalary:=0;                            --变量赋初值
    SELECT sal,job INTO v_sal,v_job FROM emp WHERE empno=p_empno;   --查询员工信息
    IF v_job='职员' THEN                          --仅对职员加薪
       p_raisedSalary:=v_sal*1.12;                --对OUT模式的参数进行赋值是合法的
       UPDATE emp SET sal=p_raisedSalary WHERE empno=p_empno;
    ELSE
       p_raisedSalary:=v_sal;                     --否则赋原来的薪资值
    END IF;
EXCEPTION    
   WHEN NO_DATA_FOUND THEN                         --异常处理语句块
     DBMS_OUTPUT.put_line('没有找到该员工的记录');
END;    


SELECT * FROM emp;

DECLARE 
   v_raisedsalary NUMBER(10,2);            --定义一个变量保存输出值
BEGIN
   v_raisedsalary:=100;                     --这个赋值在传入到OutRaiseSalary后会被忽略
   OutRaiseSalary(7369,v_raisedsalary);     --调用函数
   DBMS_OUTPUT.put_line(v_raisedsalary); --显示输出参数的值
END;


CREATE OR REPLACE PROCEDURE calcRaisedSalary(
         p_job IN VARCHAR2,
         p_salary IN OUT NUMBER                         --定义输入输出参数
)
AS
  v_sal NUMBER(10,2);                               --保存调整后的薪资值
BEGIN
  if p_job='职员' THEN                              --根据不同的job进行薪资的调整
     v_sal:=p_salary*1.12;
  ELSIF p_job='销售人员' THEN
     v_sal:=p_salary*1.18;
  ELSIF p_job='经理' THEN
     v_sal:=p_salary*1.19;
  ELSE
     v_sal:=p_salary;
  END IF;
  p_salary:=v_sal;                                   --将调整后的结果赋给输入输出参数
END calcRaisedSalary;



DECLARE
   v_sal NUMBER(10,2);                 --薪资变量
   v_job VARCHAR2(10);                 --职位变量
BEGIN
   SELECT sal,job INTO v_sal,v_job FROM emp WHERE empno=7369; --获取薪资和职位信息
   calcRaisedSalary(v_job,v_sal);                             --计算调薪
   DBMS_OUTPUT.put_line('计算后的调整薪水为：'||v_sal);    --获取调薪后的结果
END;   

DECLARE
   v_sal NUMBER(10,2);                 --薪资变量
   v_job VARCHAR2(10);                 --职位变量
BEGIN   
   ....
   calcRaisedSalary(v_job,v_sal);                             --计算调薪
   ...   
END;   


CREATE OR REPLACE PROCEDURE calcRaisedSalaryWithTYPE(
         p_job IN emp.job%TYPE,
         p_salary IN OUT emp.sal%TYPE               --定义输入输出参数
)
AS
  v_sal NUMBER(10,2);                               --保存调整后的薪资值
BEGIN
  if p_job='职员' THEN                              --根据不同的job进行薪资的调整
     v_sal:=p_salary*1.12;
  ELSIF p_job='销售人员' THEN
     v_sal:=p_salary*1.18;
  ELSIF p_job='经理' THEN
     v_sal:=p_salary*1.19;
  ELSE
     v_sal:=p_salary;
  END IF;
  p_salary:=v_sal;                                   --将调整后的结果赋给输入输出参数
END calcRaisedSalaryWithTYPE;



DECLARE
   v_sal NUMBER(8,2);                 --薪资变量
   v_job VARCHAR2(10);                 --职位变量
BEGIN
   v_sal:=123294.45;
   v_job:='职员';
   calcRaisedSalaryWithTYPE(v_job,v_sal);                             --计算调薪
   DBMS_OUTPUT.put_line('计算后的调整薪水为：'||v_sal);    --获取调薪后的结果
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   



DECLARE
   v_sal NUMBER(8,2);                 --薪资变量
   v_job VARCHAR2(10);                 --职位变量
BEGIN
   v_sal:=123294.45;
   v_job:='职员';
   calcRaisedSalaryWithTYPE(p_job=>v_job,p_salary=>v_sal);                             --计算调薪
   DBMS_OUTPUT.put_line('计算后的调整薪水为：'||v_sal);    --获取调薪后的结果
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   


DECLARE
   v_sal NUMBER(7,2);                 --薪资变量
   v_job VARCHAR2(10);                 --职位变量
BEGIN
   v_sal:=1224.45;
   v_job:='职员';
   calcRaisedSalaryWithTYPE(p_salary=>v_sal,p_job=>v_job);                             --计算调薪
   DBMS_OUTPUT.put_line('计算后的调整薪水为：'||v_sal);    --获取调薪后的结果
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   



DECLARE
   v_sal NUMBER(7,2);                 --薪资变量
   v_job VARCHAR2(10);                 --职位变量
BEGIN
   v_sal:=1224.45;
   v_job:='职员';
   calcRaisedSalaryWithTYPE(p_salary=>v_sal,v_job);                             --计算调薪
   DBMS_OUTPUT.put_line('计算后的调整薪水为：'||v_sal);    --获取调薪后的结果
EXCEPTION 
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line(SQLCODE||' '||SQLERRM);   
END;   




CREATE OR REPLACE PROCEDURE newdeptwithdefault (
   p_deptno   dept.deptno%TYPE DEFAULT 57,    --部门编号
   p_dname    dept.dname%TYPE:='管理部',     --部门名称
   p_loc      dept.loc%TYPE DEFAULT '江苏'        --位置
)
AS
   v_deptcount   NUMBER;           --保存是否存在员工编号
BEGIN
   SELECT COUNT (*) INTO v_deptcount FROM dept
    WHERE deptno = p_deptno;       --查询在dept表中是否存在部门编号
   IF v_deptcount > 0              --如果存在相同的员工记录
   THEN                            --抛出异常
      raise_application_error (-20002, '出现了相同的员工记录');
   END IF;
   INSERT INTO dept(deptno, dname, loc)  
        VALUES (p_deptno, p_dname, p_loc);--插入记录
END;

BEGIN
   newdeptwithdefault;       --不指定任何参数，将使用形参默认值
END;

BEGIN
   newdeptwithdefault(58,'事务组');       --不指定任何参数，将使用形参默认值
END;


BEGIN
   newdeptwithdefault(58,'事务组');       
END;

BEGIN
   newdeptwithdefault(p_deptno=>58,p_loc=>'南海');       --让dname使用默认值
END;

SELECT * FROM dept;


/* Formatted on 2011/10/15 16:01 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emptabtyp IS TABLE OF emp%ROWTYPE;               --定义嵌套表类型
   emp_tab   emptabtyp  := emptabtyp (NULL);             --定义一个空白的嵌套表变量
   t1        NUMBER (5);                                 --定义保存时间的临时变量
   t2        NUMBER (5);
   t3        NUMBER (5);

   PROCEDURE get_time (t OUT NUMBER)                     --获取当前时间
   IS
   BEGIN
      SELECT TO_CHAR (SYSDATE, 'SSSSS')                  --获取从午夜到当前的秒数
        INTO t
        FROM DUAL;
      DBMS_OUTPUT.PUT_LINE(t);        
   END;
   PROCEDURE do_nothing1 (tab IN OUT emptabtyp)          --定义一个空白的过程，具有IN OUT参数
   IS
   BEGIN
      NULL;
   END;

   PROCEDURE do_nothing2 (tab IN OUT NOCOPY emptabtyp)   --在参数中使用NOCOPY编译提示
   IS
   BEGIN
      NULL;
   END;
BEGIN
   SELECT *
     INTO emp_tab (1)
     FROM emp
    WHERE empno = 7788;                                  --查询emp表中的员工，插入到emp_tab第1个记录
   emp_tab.EXTEND (900000, 1);                            --拷贝第1个元素N次
   get_time (t1);                                        --获取当前时间
   do_nothing1 (emp_tab);                                --执行不带NOCOPY的过程
   get_time (t2);                                        --获取当前时间
   do_nothing2 (emp_tab);                                --执行带NOCOPY的过程
   get_time (t3);                                        --获取当前时间
   DBMS_OUTPUT.put_line ('调用所花费的时间(秒)');
   DBMS_OUTPUT.put_line ('--------------------');
   DBMS_OUTPUT.put_line ('不带NOCOPY的调用:' || TO_CHAR (t2 - t1));
   DBMS_OUTPUT.put_line ('带NOCOPY的调用:' || TO_CHAR (t3 - t2));
END;
/




CREATE OR REPLACE FUNCTION getempdept(
        p_empno emp.empno%TYPE
) RETURN VARCHAR2                                 --参数必须是Oracle数据库类型
AS
  v_dname dept.dname%TYPE;               
BEGIN
   SELECT b.dname INTO v_dname FROM emp a,dept b 
   WHERE a.deptno=b.deptno
   AND a.empno=p_empno;
   RETURN v_dname;                                --查询数据表，获取部门名称
EXCEPTION 
   WHEN NO_DATA_FOUND THEN
      RETURN NULL;                                --如果出现查询不到数据，返回NULL
END;        


SELECT empno 员工编号,getempdept(empno) 员工名称 from emp;



CREATE OR REPLACE FUNCTION getraisedsalary_subprogram (p_empno emp.empno%TYPE)
   RETURN NUMBER
IS
   v_salaryratio   NUMBER (10, 2);             --调薪比率  
   v_sal           emp.sal%TYPE;            --薪资变量     
   --定义内嵌子函数，返回薪资和调薪比率  
   FUNCTION getratio(p_sal OUT NUMBER) RETURN NUMBER IS
      n_job           emp.job%TYPE;            --职位变量
      n_salaryratio   NUMBER (10, 2);          --调薪比率       
   BEGIN
       --获取员工表中的薪资信息
       SELECT job, sal INTO n_job, p_sal FROM emp WHERE empno = p_empno;
       CASE n_job                               --根据不同的职位获取调薪比率
          WHEN '职员' THEN
             n_salaryratio := 1.09;
          WHEN '销售人员' THEN
             n_salaryratio := 1.11;
          WHEN '经理' THEN
             n_salaryratio := 1.18;
          ELSE
             n_salaryratio := 1;
       END CASE; 
       RETURN n_salaryratio;    
   END;        
BEGIN
   v_salaryratio:=getratio(v_sal);          --调用嵌套函数，获取调薪比率和员工薪资
   IF v_salaryratio <> 1                    --如果有调薪的可能
   THEN
      RETURN ROUND(v_sal * v_salaryratio,2);         --返回调薪后的薪资
   ELSE
      RETURN v_sal;                         --否则不返回薪资
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 0;                             --如果没找到原工记录，返回0
END;



BEGIN
   --调用函数获取调薪后的记录
   DBMS_OUTPUT.PUT_LINE('7369员工调薪记录：'||getraisedsalary_subprogram(7369));
   DBMS_OUTPUT.PUT_LINE('7521员工调薪记录：'||getraisedsalary_subprogram(7521));   
END;


DECLARE
   v_val BINARY_INTEGER:=5;
   PROCEDURE B(p_counter IN OUT BINARY_INTEGER);            --前向声明嵌套子程序B
   PROCEDURE A(p_counter IN OUT BINARY_INTEGER) IS          --声明嵌套子程序A
   BEGIN
      DBMS_OUTPUT.PUT_LINE('A('||p_counter||')');
      IF p_counter>0 THEN
         B(p_counter);                                      --在嵌套子程序中调用B
         p_counter:=p_counter-1;
      END IF;
   END A;
   PROCEDURE B(p_counter IN OUT BINARY_INTEGER) IS          --声明嵌套子程序B
   BEGIN
      DBMS_OUTPUT.PUT_LINE('B('||p_counter||')');
      p_counter:=p_counter-1;
      A(p_counter);                                          --在嵌套子程序中调用A
   END B;
BEGIN
   B(v_val);                                                 --调用嵌套子程序B
END;


DECLARE
    PROCEDURE GetSalary(p_empno IN NUMBER) IS                       --带一个参数的过程
    BEGIN
      DBMS_OUTPUT.put_line('员工编号为：'||p_empno);      
    END;
    PROCEDURE GetSalary(p_empname IN VARCHAR2) IS                    --重载的过程
    BEGIN
      DBMS_OUTPUT.put_line('员工名称为：'||p_empname);
    END;
    PROCEDURE GETSalary(p_empno IN NUMBER,p_empname IN VARCHAR) IS   --生的过程
    BEGIN
      DBMS_OUTPUT.put_line('员工编号为：'||p_empno||' 员工名称为：'||p_empname);
    END;       
BEGIN 
    GetSalary(7369);                                                 --调用重载方未予
    GetSalary('史密斯');
    GetSalary(7369,'史密斯');        
END;   

SELECT * FROM emp;

CREATE TABLE emp_history AS SELECT * FROM emp WHERE 1=2;

SELECT * FROM emp_history;


DECLARE
   PROCEDURE TestAutonomous(p_empno NUMBER) AS
     PRAGMA AUTONOMOUS_TRANSACTION;         --标记为自治事务
   BEGIN
     --现在过程中是自治的事务，主事务被挂起
     INSERT INTO emp_history SELECT * FROM emp WHERE empno=p_empno;
     COMMIT;                                --提交自治事务，不影响主事务
   END TestAutonomous;
BEGIN
   --主事务开始执行
   INSERT INTO emp_history(empno,ename,sal) VALUES(1011,'测试',1000);
   TestAutonomous(7369);                    --主事务挂起，开始自治事务
   ROLLBACK;                                --回滚主事务
END;


DECLARE
  v_result INTEGER;
  FUNCTION fac(n POSITIVE)
       RETURN INTEGER IS                       --阶乘的返回结果
   BEGIN
      IF n=1 THEN                              --如果n=1则终止条件
         DBMS_OUTPUT.put('1!=1*0!');      
         RETURN 1;                         
      ELSE
       DBMS_OUTPUT.put(n||'!='||n||'*');
      RETURN n*fac(n-1);                      --否则进行递归调用自身
      END IF;
   END fac; 
BEGIN
  v_result:= fac(10);                          --调用阶乘函数
  DBMS_OUTPUT.put_line('结果是：'||v_result); --输出阶乘结果
END;




/* Formatted on 2011/10/16 16:30 (Formatter Plus v4.8.8) */
DECLARE
    PROCEDURE find_staff (mgr_no NUMBER, tier NUMBER := 1)
    IS
       boss_name   VARCHAR2 (10);                  --定义老板的名称
       CURSOR c1 (boss_no NUMBER)                  --定义游标来查询emp表中当前编号下的员工列表
       IS
          SELECT empno, ename
            FROM emp
           WHERE mgr = boss_no;
    BEGIN
       SELECT ename INTO boss_name FROM emp
        WHERE empno = mgr_no;                      --获取管理者名称
       IF tier = 1                                 --如果tier指定1,表示从最顶层开始查询
       THEN
          INSERT INTO staff                          
               VALUES (boss_name || ' 是老板 ');   --因为第1层是老板，下面的才是经理
       END IF;
       FOR ee IN c1 (mgr_no)                       --通过游标FOR循环向staff表插入员工信息
       LOOP
          INSERT INTO staff
               VALUES (   boss_name
                       || ' 管理 '
                       || ee.ename
                       || ' 在层次 '
                       || TO_CHAR (tier));
          find_staff (ee.empno, tier + 1);        --在游标中，递归调用下层的员工列表
       END LOOP;
       COMMIT;
    END find_staff;
BEGIN
  find_staff(7839);                           --查询7839的管理下的员工的列表和层次结构
END;


CREATE TABLE staff(emplist VARCHAR2(1000));



SELECT * FROM staff;

SELECT * FROM emp;
truncate table staff;


CREATE OR REPLACE PROCEDURE TestDependence AS
BEGIN
   --向emp表插入测试数据
   INSERT INTO emp(empno,ename,sal) VALUES(1011,'测试',1000);
   TestSubProg(7369);                   
   ROLLBACK;                               
END;
--被另一个过程调用，用来向emp_history表插入数据
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
   boss_name   VARCHAR2 (10);                  --定义老板的名称
   CURSOR c1 (boss_no NUMBER)                  --定义游标来查询emp表中当前编号下的员工列表
   IS
      SELECT empno, ename
        FROM emp
       WHERE mgr = boss_no;
BEGIN
   SELECT ename INTO boss_name FROM emp
    WHERE empno = mgr_no;                      --获取管理者名称
   IF tier = 1                                 --如果tier指定1,表示从最顶层开始查询
   THEN
      INSERT INTO staff                          
           VALUES (boss_name || ' 是老板 ');   --因为第1层是老板，下面的才是经理
   END IF;
   FOR ee IN c1 (mgr_no)                       --通过游标FOR循环向staff表插入员工信息
   LOOP
      INSERT INTO staff
           VALUES (   boss_name
                   || ' 管理 '
                   || ee.ename
                   || ' 在层次 '
                   || TO_CHAR (tier));
      find_staff (ee.empno, tier + 1);        --在游标中，递归调用下层的员工列表
   END LOOP;
   COMMIT;
END find_staff; 
 

 
 
 
CREATE USER userb IDENTIFIED BY userb;                 --创建用户userb，密码也为userb
GRANT RESOURCE,CONNECT TO userb;                       --为userb分配角色
GRANT EXECUTE ON find_staff TO userb;                  --使得userb可以执行find_staff
DROP USER userb;


GRANT EXECUTE ON find_staff TO userb;






 
 
 
 
 
 
 
 
 