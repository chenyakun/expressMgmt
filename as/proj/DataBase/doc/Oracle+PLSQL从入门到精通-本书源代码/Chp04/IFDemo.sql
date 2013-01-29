/*<TOAD_FILE_CHUNK>*/
/* Formatted on 2011/08/15 22:38 (Formatter Plus v4.8.8) */
DECLARE
   v_count   NUMBER (10) := 0;                               --定义计数器变量
   v_empno   NUMBER (4)  := 7888;                              --定义员工编号
BEGIN
   SELECT COUNT (1)                           --首先查询指定的员工编号是否存在
     INTO v_count
     FROM emp
    WHERE empno = v_empno;

   --使用IF语句判断，如果员工编号不存在，结果为0
   IF v_count = 0
   THEN
      --则执行INSERT语句，插入新的员工记录
      INSERT INTO emp
                  (empno, ename, job, hiredate, sal, deptno
                  )
           VALUES (v_empno, '张三', '经理', TRUNC (SYSDATE), 1000, 20
                  );
   END IF;

   --向数据库提交更改
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);                          --输出异常信息
END;
/

select * from emp;
DESC EMP;

/* Formatted on 2011/08/16 06:46 (Formatter Plus v4.8.8) */
DECLARE
   v_sal      NUMBER (7, 2);    --薪资变量
   v_deptno   NUMBER (2);       --部门变量
   v_job      VARCHAR2 (9);     --职位变量
BEGIN
   --从数据库中查询指定员工编号的信息
   SELECT deptno, v_job, sal
     INTO v_deptno, v_job, v_sal
     FROM emp
    WHERE empno = :empno;
   --如果部门编号为20的员工
   IF v_deptno = 20
   THEN
      --如果职别为CLERK
      IF v_job = 'CLERK'
      THEN
         --加薪0.12
         v_sal := v_sal * (1 + 0.12);
      --如果职别为ANALYST
      ELSIF v_job = 'ANALYST'
      THEN
         --加薪0.19
         v_sal := v_sal * (1 + 0.19);
      END IF;
   --否则，不为20的员工将不允许加薪
   ELSE
      DBMS_OUTPUT.put_line ('仅部门编号为20的员工才能加薪');
   END IF;
END;
/*<TOAD_FILE_CHUNK>*/

SELECT *
  FROM emp;

DELETE FROM emp
      WHERE empno = 7888;

COMMIT ;



DECLARE
   v_count   NUMBER (10) := 0;                               --定义计数器变量
   v_empno   NUMBER (4)  := 7888;                              --定义员工编号
BEGIN
   SELECT COUNT (1)                           --首先查询指定的员工编号是否存在
     INTO v_count
     FROM emp
    WHERE empno = v_empno;

   --使用IF语句判断，如果员工编号不存在，结果为0
   IF v_count = 0
   THEN
      --则执行INSERT语句，插入新的员工记录
      INSERT INTO emp
                  (empno, ename, job, hiredate, sal, deptno
                  )
           VALUES (v_empno, '张三', '经理', TRUNC (SYSDATE), 1000, 20
                  );
   ELSE   --否则，执行UPDATE语句更新员工记录
      UPDATE emp
         SET ename = '张三',
             job = '经理',
             hiredate = TRUNC (SYSDATE),
             sal = 1000,
             deptno = 20
       WHERE empno = v_empno;
   END IF;

   --向数据库提交更改
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);                          --输出异常信息
END;
/
