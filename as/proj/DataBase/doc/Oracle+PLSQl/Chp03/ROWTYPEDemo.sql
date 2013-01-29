
DECLARE
   v_emp   emp%ROWTYPE;                               --定义emp表的所有列类型
BEGIN
   SELECT *                               --查询emp表并将结果写入到v_emp记录中
     INTO v_emp
     FROM emp
    WHERE empno = &empno;

   --输出结果信息
   DBMS_OUTPUT.put_line (v_emp.empno || CHR (13) || CHR (10) || v_emp.ename);
END;

DESC emp;



DECLARE
   CURSOR emp_cursor                       --定义游标类型
   IS
      SELECT empno, ename, job, sal, hiredate
        FROM emp;
   --使用%ROWTYPE定义游标类型的变量
   v_emp   emp_cursor%ROWTYPE;
BEGIN
   OPEN emp_cursor;                        --打开游标
   --循环并提取游标数据
   LOOP
      FETCH emp_cursor
       INTO v_emp;
      --要注意游标移动到最尾部退出游标
      EXIT WHEN emp_cursor%NOTFOUND;
      --输出游标数据
      DBMS_OUTPUT.put_line (   v_emp.empno
                            || ' '
                            || v_emp.ename
                            || ' '
                            || v_emp.job
                            || ' '
                            || v_emp.sal
                            || ' '
                            || TO_CHAR (v_emp.hiredate, 'YYYY-MM-DD')
                           );
   END LOOP;
   --关闭游标
   CLOSE emp_cursor;
END;
/

/* Formatted on 2011/08/10 10:50 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp;

DECLARE
   v_emp emp%ROWTYPE;              --定义emp表列类型的记录
BEGIN
   v_emp.empno:=8000;              --为记录类型赋值
   v_emp.ename:='张三丰';
   v_emp.job:='掌门';
   v_emp.mgr:=7902;
   v_emp.hiredate:=date'2010-12-13';
   v_emp.sal:=8000;
   v_emp.deptno:=20;
   INSERT INTO emp VALUES v_emp;   --将记录类型插入到数据表
END;
/       
   