/* Formatted on 2011/09/23 15:35 (Formatter Plus v4.8.8) */
DECLARE
   emprow   emp%ROWTYPE;     --定义保存游标检索结果行的记录变量
   CURSOR emp_cur            --定义游标
   IS
      SELECT *
        FROM emp
       WHERE deptno IS NOT NULL;
BEGIN
   OPEN emp_cur;             --打开游标
   LOOP                      --循环检索游标
      FETCH emp_cur          --提取游标内容
       INTO emprow;
      --输出检索到的游标行的信息
      DBMS_OUTPUT.put_line (   '员工编号：'
                            || emprow.empno
                            || ' '
                            || '员工名称：'
                            || emprow.ename
                           );
      EXIT WHEN emp_cur%NOTFOUND;  --当游标数据检索完成退出循环
   END LOOP;   
   CLOSE emp_cur;           --关闭游标
END;


SELECT * FROM emp;

/* Formatted on 2011/09/24 13:39 (Formatter Plus v4.8.8) */
BEGIN
   UPDATE emp
      SET comm = comm * 1.12
    WHERE empno = 7369;              --更新员工编号为7369的员工信息       
   --使用隐式游标属性判断已更新的行数
   DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' 行被更新');
   --如果没有任何更新
   IF SQL%NOTFOUND
   THEN
      --显示未更新的信息
      DBMS_OUTPUT.put_line ('不能更新员工号为7369的员工!');
   END IF;
   --向数据库提交更改
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);  --如果出现异常，显示异常信息
END;



/* Formatted on 2011/09/24 14:27 (Formatter Plus v4.8.8) */
DECLARE
   CURSOR emp_cursor      --定义一个查询emp表中部门编号为20的游标 
   IS
      SELECT *
        FROM emp
       WHERE deptno = 20;
BEGIN
   NULL;
END;


DECLARE
   v_deptno NUMBER;
   CURSOR emp_cursor      --定义一个查询emp表中部门编号为20的游标 
   IS
      SELECT *
        FROM emp
       WHERE deptno = v_deptno;
BEGIN
   v_deptno:=20;
   OPEN emp_cursor;       --打开游标
   IF emp_cursor%ISOPEN THEN
      DBMS_OUTPUT.PUT_LINE('游标已经被打开');
   END IF;
END;


/* Formatted on 2011/09/24 15:15 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/24 15:17 (Formatter Plus v4.8.8) */
DECLARE
   CURSOR emp_cursor (p_deptno IN NUMBER)            --定义游标并指定游标参数
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   OPEN emp_cursor (20);
END;



/* Formatted on 2011/09/24 16:06 (Formatter Plus v4.8.8) */
DECLARE
   --声明游标并指定游标返回值类型
   CURSOR emp_cursor (p_deptno IN NUMBER) RETURN dept%ROWTYPE
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;  
BEGIN
   OPEN emp_cursor (20);   --打开游标
END;


DECLARE
   CURSOR emp_cursor (p_deptno IN NUMBER)            --定义游标并指定游标参数
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   IF NOT emp_cursor%ISOPEN THEN                    --如果游标还没有被打开
     OPEN emp_cursor (20);                          --打开游标
   END IF;
   IF emp_cursor%ISOPEN THEN                        --判断游标状态，显示状态信息
     DBMS_OUTPUT.PUT_LINE('游标已经被打开！');
   ELSE
     DBMS_OUTPUT.PUT_LINE('游标还没有被打开！');   
   END IF;   
END;


/* Formatted on 2011/09/24 18:37 (Formatter Plus v4.8.8) */
DECLARE
   emp_row   emp%ROWTYPE;                                --定义游标值存储变量
   CURSOR emp_cursor (p_deptno IN NUMBER)            --定义游标并指定游标参数
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   IF NOT emp_cursor%ISOPEN
   THEN                                                --如果游标还没有被打开
      OPEN emp_cursor (20);                                        --打开游标
   END IF;
   IF emp_cursor%FOUND IS NULL                        --在使用FETCH提取游标数据之前，值为NULL
   THEN
      DBMS_OUTPUT.put_line ('%FOUND属性为NULL');   --输出提示信息
   END IF;
   LOOP                                               --循环提取游标数据
      FETCH emp_cursor  
       INTO emp_row;                                  --使用FETCH语句提取游标数据
      --每循环一次判断%FOUND属性值，如果该值为False，表示提取完成，将退出循环。
      EXIT WHEN NOT emp_cursor%FOUND;
   END LOOP;
END;


DECLARE
   emp_row   emp%ROWTYPE;                                --定义游标值存储变量
   CURSOR emp_cursor (p_deptno IN NUMBER)            --定义游标并指定游标参数
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   OPEN emp_cursor (20);                                        --打开游标
   IF emp_cursor%NOTFOUND IS NULL                        --在使用FETCH提取游标数据之前，值为NULL
   THEN
      DBMS_OUTPUT.put_line ('%NOTFOUND属性为NULL');   --输出提示信息
   END IF;
   LOOP                                               --循环提取游标数据
      FETCH emp_cursor  
       INTO emp_row;                                  --使用FETCH语句提取游标数据
      --每循环一次判断%FOUND属性值，如果该值为False，表示提取完成，将退出循环。
      EXIT WHEN emp_cursor%NOTFOUND;
   END LOOP;
END;

DECLARE
   emp_row   emp%ROWTYPE;                                --定义游标值存储变量
   CURSOR emp_cursor (p_deptno IN NUMBER)            --定义游标并指定游标参数
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   OPEN emp_cursor (20);                                        --打开游标
   LOOP                                               --循环提取游标数据
      FETCH emp_cursor  
       INTO emp_row;                                  --使用FETCH语句提取游标数据
      --每循环一次判断%FOUND属性值，如果该值为False，表示提取完成，将退出循环。
      EXIT WHEN emp_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('当前已提取的行数为：'||emp_cursor%ROWCOUNT||' 行！');
   END LOOP;
   CLOSE emp_cursor;
END;


SELECT * FROM dept;

DECLARE
  deptno dept.deptno%TYPE;                   --定义保存游标数据的变量
  dname dept.dname%TYPE;
  loc dept.loc%TYPE;
  dept_row dept%ROWTYPE;                     --定义记录变量
  CURSOR dept_cur IS SELECT * FROM dept;     --定义游标
BEGIN
   OPEN dept_cur ;                           --打开游标
   LOOP      
      IF dept_cur%ROWCOUNT<=4 THEN           --判断如果当前提取的游标小于等于4行
        FETCH dept_cur  INTO dept_row;       --提取游标数据到记录类型中
        IF dept_cur%FOUND THEN               --如果FETCH到数据，则进行显示
        DBMS_OUTPUT.PUT_LINE(dept_row.deptno||' '||dept_row.dname||' '||dept_row.loc);
        END IF;
      ELSE
        FETCH dept_cur INTO deptno,dname,loc;--否则提取记录到变量列表中
        IF dept_cur%FOUND THEN               --如果提取到数据则进行显示
        DBMS_OUTPUT.PUT_LINE(deptno||' '||dname||' '||loc);
        END IF;        
      END IF;
      EXIT WHEN dept_cur%NOTFOUND;           --判断是否提取完成
   END LOOP;
   CLOSE dept_cur
END;


/* Formatted on 2011/09/24 21:08 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/24 21:10 (Formatter Plus v4.8.8) */
DECLARE
   TYPE depttab_type IS TABLE OF dept%ROWTYPE;    --定义dept行类型的嵌套表类型
   depttab   depttab_type;                        --定义嵌套表变量
   CURSOR deptcur IS SELECT * FROM dept;          --定义游标
BEGIN
   OPEN deptcur;
   FETCH deptcur BULK COLLECT INTO depttab;       --使用BULK COLLECT INTO子句批次插入
   CLOSE deptcur;                                 --关闭游标
   FOR i IN 1 .. depttab.COUNT                    --循环嵌套表变量中的数据
   LOOP
      DBMS_OUTPUT.put_line (   depttab (i).deptno
                            || ' '
                            || depttab (i).dname
                            || ' '
                            || depttab (i).loc
                           );
   END LOOP;
   CLOSE deptcur;                                --关闭游标
END;



DECLARE
   TYPE depttab_type IS TABLE OF dept%ROWTYPE;    --定义dept行类型的嵌套表类型
   depttab   depttab_type;                        --定义嵌套表变量
   CURSOR deptcur IS SELECT * FROM dept;          --定义游标
BEGIN
   OPEN deptcur;
   FETCH deptcur BULK COLLECT INTO depttab;       --使用BULK COLLECT INTO子句批次插入
   CLOSE deptcur;                                 --关闭游标
   FOR i IN 1 .. depttab.COUNT                    --循环嵌套表变量中的数据
   LOOP
      DBMS_OUTPUT.put_line (   depttab (i).deptno
                            || ' '
                            || depttab (i).dname
                            || ' '
                            || depttab (i).loc
                           );
   END LOOP;
   CLOSE deptcur;                                --关闭游标
END;



/* Formatted on 2011/09/25 09:48 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_type IS VARRAY (4) OF dept%ROWTYPE;    --定义变长数组类型
   depttab   dept_type;                             --定义变长数组变量
   CURSOR dept_cursor                               --定义打开dept的游标
   IS
      SELECT *
        FROM dept;
   v_rows    INT       := 4;                        --使用LIMIT限制的行数
   v_count   INT       := 0;                        --保存游标提取过的行数
BEGIN
   OPEN dept_cursor;                                --打开游标
   LOOP                                             --循环提取游标
      --每次提取4行数据到变长数组中
      FETCH dept_cursor BULK COLLECT INTO depttab LIMIT v_rows;
      EXIT WHEN dept_cursor%NOTFOUND;               --没有游标数据时退出   
      DBMS_OUTPUT.put('部门名称：');             --输出部门名称
      --循环提取变长数组数据，因为变长数组只能存放4个元素，因此不能越界读取
      FOR i IN 1 .. (dept_cursor%ROWCOUNT - v_count) 
      LOOP
         DBMS_OUTPUT.put (depttab (i).dname || ' '); --输出部门名称
      END LOOP;
      DBMS_OUTPUT.new_line;                      --输出新行
      v_count := dept_cursor%ROWCOUNT;              --为v_count赋新的值
   END LOOP;
   CLOSE dept_cursor;                               --关闭游标
END;



DECLARE
   dept_row dept%ROWTYPE;                      --定义游标结果记录变量
   CURSOR dept_cursor IS SELECT * FROM dept;   --定义游标变量
BEGIN 
   OPEN dept_cursor;                           --打开游标
   LOOP                                        --简单循环
      FETCH dept_cursor INTO dept_row;         --提取游标数据
      EXIT WHEN dept_cursor%NOTFOUND;          --退出循环的控制语句
      DBMS_OUTPUT.PUT_LINE('部门名称：'||dept_row.dname);
   END LOOP;
   CLOSE dept_cursor;                          --关闭游标
END;   


DECLARE
   dept_row dept%ROWTYPE;                      --定义游标结果记录变量
   CURSOR dept_cursor IS SELECT * FROM dept;   --定义游标变量
BEGIN 
   OPEN dept_cursor;                           --打开游标
   FETCH dept_cursor INTO dept_row;            --提取游标数据   
   WHILE dept_cursor%FOUND  LOOP                 
      DBMS_OUTPUT.PUT_LINE('部门名称：'||dept_row.dname);
      FETCH dept_cursor INTO dept_row;         --提取游标数据         
   END LOOP;
   CLOSE dept_cursor;                          --关闭游标
END;   



DECLARE
   CURSOR dept_cursor IS SELECT * FROM dept;   --定义游标变量
BEGIN 
   FOR dept_row IN dept_cursor LOOP            --在游标FOR循环中检索数据
     DBMS_OUTPUT.PUT_LINE('部门名称：'||dept_row.dname);
   END LOOP;
END;   


BEGIN 
   FOR dept_row IN (SELECT * FROM dept) LOOP    --在游标FOR循环中检索数据
     DBMS_OUTPUT.PUT_LINE('部门名称：'||dept_row.dname);
   END LOOP;
END;   


 DECLARE
   dept_row dept%ROWTYPE;                      --定义游标结果记录变量
   CURSOR dept_cursor IS SELECT * FROM dept FOR UPDATE deptno,dname;   --定义游标变量
BEGIN 
   OPEN dept_cursor;                           --打开游标
   FETCH dept_cursor INTO dept_row;            --提取游标数据   
   WHILE dept_cursor%FOUND  LOOP                 
      DBMS_OUTPUT.PUT_LINE('部门名称：'||dept_row.dname);
      FETCH dept_cursor INTO dept_row;         --提取游标数据         
   END LOOP;
   CLOSE dept_cursor;                          --关闭游标
END;   



/* Formatted on 2011/09/25 17:02 (Formatter Plus v4.8.8) */
DECLARE
   CURSOR emp_cursor (p_deptno IN NUMBER)
   IS
      SELECT  *
            FROM emp
           WHERE deptno = p_deptno
      FOR UPDATE;                              --使用FOR UPDATE子句添加互斥锁
BEGIN
   FOR emp_row IN emp_cursor (20)              --使用游标FOR循环检索游标
   LOOP
      UPDATE emp                      
         SET comm = comm * 1.12
       WHERE CURRENT OF emp_cursor;            --使用WHERE CURRENT OF更新游标数据
   END LOOP;
   COMMIT;                                     --提交更改
END;


DECLARE
   CURSOR emp_cursor (p_empno IN NUMBER)
   IS
      SELECT  *
            FROM emp
           WHERE empno = p_empno 
      FOR UPDATE;                              --使用FOR UPDATE子句添加互斥锁
BEGIN
   FOR emp_row IN emp_cursor (7369)              --使用游标FOR循环检索游标
   LOOP
    DELETE FROM emp
       WHERE CURRENT OF emp_cursor;            --使用WHERE CURRENT OF删除游标数据
   END LOOP;
END;








/* Formatted on 2011/09/25 21:03 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --定义游标变量类型
   emp_cur   emp_type;                                   --声明游标变量
   emp_row   emp%ROWTYPE;                                --定义游标结果值变量
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp;                   --打开游标
   LOOP
      FETCH emp_cur INTO emp_row;                        --循环提取游标数据
      EXIT WHEN emp_cur%NOTFOUND;                        --循环退出检测
      DBMS_OUTPUT.put_line ('员工名称：' || emp_row.ename);
   END LOOP;
END;




DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;      --定义游标类型
   TYPE gen_type IS REF CURSOR;                         
   emp_cur emp_type;                                   --声明游标变量
   gen_cur gen_type;
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;
END;   
   


DECLARE
    gen_type SYS_REFCURSOR;
BEGIN
END;    


DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --定义游标类型
   emp_cur emp_type;                                     --声明游标变量
   emp_row emp%ROWTYPE;
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;  
   FOR emp_row IN emp_cur LOOP
      DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename);
   END LOOP;
   CLOSE emp_cur;
END;   


DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --定义游标类型
   emp_cur emp_curtype;                                  --声明游标类型的变量
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp;                   --打开游标,查询emp所有列
   OPEN emp_cur FOR SELECT empno FROM emp;               --打开游标,查询emp表empno列 
   OPEN emp_cur FOR SELECT deptno FROM dept;             --打开游标,查询dept表deptno列
END;


DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --定义游标类型
   emp_cur emp_type;                                     --声明游标变量
   emp_row emp%ROWTYPE;
BEGIN
   IF NOT emp_cur%ISOPEN THEN                            --如果游标变量没有打开
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;   --打开游标变量
   END IF;
   LOOP
     FETCH emp_cur INTO emp_row;                         --提取游标变量
     EXIT WHEN emp_cur%NOTFOUND;                         --如果提取完成则退出循环
     DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename
                         ||' 员工职位：'||emp_row.job);  --输出员工信息
   END LOOP;
END;   



DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --定义游标类型
   emp_cur emp_type;                                     --声明游标变量
   emp_row emp%ROWTYPE;
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;   --打开游标
   FETCH emp_cur INTO emp_row;                           --提取游标
   WHILE emp_cur%FOUND LOOP                              --循环提取游标
     DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename);
     FETCH emp_cur INTO emp_row;       
   END LOOP;
   CLOSE emp_cur;                                        --关闭游标
END;   


DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --定义游标类型
   emp_cur emp_curtype;                                  --声明游标类型的变量
   emp_row emp%ROWTYPE;
BEGIN   
   FETCH emp_cur INTO emp_row;
END;


DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --定义游标类型
   emp_cur1 emp_curtype;                                 --声明游标类型的变量
   emp_cur2 emp_curtype;
   emp_row emp%ROWTYPE;                                  --定义保存游标数据的记录类型
BEGIN   
   OPEN emp_cur1 FOR SELECT * FROM emp WHERE deptno=20;  --打开第1个游标
   FETCH emp_cur1 INTO emp_row;                          --提取并显示游标信息
   DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename||' 部门编号：'||emp_row.deptno);
   FETCH emp_cur2 INTO emp_row;                          --提取第2个游标变量将引发异常
EXCEPTION
   WHEN INVALID_CURSOR THEN                              --异常处理
      emp_cur2:=emp_cur1;                                --将emp_cur1指向的查询区域赋给emp_cur2
      FETCH emp_cur2 INTO emp_row;                       --现在emp_cur1与emp_cur2指向相同的查询
      DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename||' 部门编号：'||emp_row.deptno);
      OPEN emp_cur2 FOR SELECT * FROM emp WHERE deptno=30; --重新打开emp_cur2游标变量，利用相同的查询区域
      FETCH emp_cur1 INTO emp_row;                         --由于emp_cur1与emp_cur2共享相同的查询区域，因此结果相同
      DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename||' 部门编号：'||emp_row.deptno);      
END;



DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --定义游标类型
   emp_cur emp_curtype;                                  --声明游标类型的变量
   emp_row emp%ROWTYPE;                                  --声明游标数据结果类型
   dept_row dept%ROWTYPE;                               
BEGIN   
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;   --打开游标变量
   FETCH emp_cur INTO dept_row;                          --提取到一个不匹配的类型中
EXCEPTION
   WHEN ROWTYPE_MISMATCH THEN                            --处理ROWTYPE_MISMATCH异常
     FETCH emp_cur INTO emp_row;                         --再次提取游标变量数据，输出结果
     DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename||' 部门编号：'||emp_row.deptno);       
END;



DECLARE
   emp_cur SYS_REFCURSOR;                               --定义弱类型游标变量
   emp_row emp%ROWTYPE;
   dept_row dept%ROWTYPE;
BEGIN   
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;  --打开游标数据
   FETCH emp_cur INTO dept_row;
EXCEPTION
   WHEN ROWTYPE_MISMATCH THEN                           --处理ROWTYPE_MISMATCH异常
     FETCH emp_cur INTO emp_row;                        --重新提取并输出异常结果
     DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename||' 部门编号：'||emp_row.deptno);       
END;





--创建包规范
CREATE OR REPLACE PACKAGE emp_data_action AS
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;         --定义强类型游标类型
   --定义使游标变量的子程序  
   PROCEDURE getempbydeptno(emp_cur IN OUT emp_type,p_deptno NUMBER); 
END emp_data_action;

--实现包体
CREATE OR REPLACE PACKAGE BODY emp_data_action AS
   --创建在包规范中定义的过程   
   PROCEDURE getempbydeptno(emp_cur IN OUT emp_type,p_deptno NUMBER) IS
     emp_row emp%ROWTYPE;
   BEGIN
     OPEN emp_cur FOR SELECT * from emp WHERE deptno=p_deptno;  --打开游标变量
     LOOP
       FETCH emp_cur INTO emp_row;                              --提取数据
       EXIT WHEN emp_cur%NOTFOUND;
       --输出游标数据
       DBMS_OUTPUT.PUT_LINE('员工名称：'||emp_row.ename||' 部门编号：'||emp_row.deptno);
     END LOOP;
     CLOSE emp_cur;
   END;
END emp_data_action;



/* Formatted on 2011/09/26 16:55 (Formatter Plus v4.8.8) */
DECLARE
   emp_cursors   emp_data_action.emp_type;         --定义在包中定义的游标类型
BEGIN
   emp_data_action.getempbydeptno (emp_cursors, 20);   --调用在包中定义的过程
END;



--创建包规范
CREATE OR REPLACE PACKAGE emp_data_action_err AS
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;         --定义强类型游标类型
   emp_cur emp_type;
   --定义使游标变量的子程序  
   PROCEDURE getempbydeptno(emp_cur IN OUT emp_type,p_deptno NUMBER);   
END emp_data_action_err;



DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --定义游标类型
   emp_cur emp_curtype;                                  --声明游标类型的变量
BEGIN   
   FOR emp_row IN emp_cur LOOP
      DBMS_OUTPUT.PUT_LINE(emp_row.ename);
   END LOOP;
END;