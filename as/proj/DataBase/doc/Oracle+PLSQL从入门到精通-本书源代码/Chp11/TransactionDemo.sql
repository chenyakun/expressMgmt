DECLARE
   dept_no   NUMBER (2) := 70;
BEGIN
   --开始事务
   INSERT INTO dept 
        VALUES (dept_no, '市场部', '北京');               --插入部门记录
   INSERT INTO emp                                        --插入员工记录
        VALUES (7997, '威尔', '销售人员', NULL, TRUNC (SYSDATE), 5000,300, dept_no);
   --提交事务
   COMMIT;
END;


DELETE FROM emp WHERE deptno=70;
DELETE FROM dept WHERE deptno=70;
COMMIT;

DECLARE
   dept_no   NUMBER (2) := 70;
BEGIN
   --开始事务
   INSERT INTO dept 
        VALUES (dept_no, '市场部', '北京');               --插入部门记录
   INSERT INTO dept 
        VALUES (dept_no, '后勤部', '上海');               --插入相同编号的部门记录        
   INSERT INTO emp                                        --插入员工记录
        VALUES (7997, '威尔', '销售人员', NULL, TRUNC (SYSDATE), 5000,300, dept_no);
   --提交事务
   COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN                            --捕足异常
     DBMS_OUTPUT.PUT_LINE(SQLERRM);                   --显示异常消息
     ROLLBACK;                                           --回滚异常
END;


DECLARE
   dept_no   NUMBER (2) := 70;
BEGIN
   --开始事务
   INSERT INTO dept 
        VALUES (dept_no, '市场部', '北京');               --插入部门记录
   INSERT INTO dept 
        VALUES (dept_no, '后勤部', '上海');               --插入相同编号的部门记录        
   INSERT INTO emp                                        --插入员工记录
        VALUES (7997, '威尔', '销售人员', NULL, TRUNC (SYSDATE), 5000,300, dept_no);
   --提交事务
   COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN                            --捕足异常
     DBMS_OUTPUT.PUT_LINE(SQLERRM);                   --显示异常消息
     ROLLBACK;                                           --回滚异常
END;


DECLARE
   dept_no   NUMBER (2) :=90;
BEGIN
   --开始事务
   SAVEPOINT A;
   INSERT INTO dept 
        VALUES (dept_no, '市场部', '北京');               --插入部门记录
   SAVEPOINT B;   
   INSERT INTO emp                                        --插入员工记录
        VALUES (7997, '威尔', '销售人员', NULL, TRUNC (SYSDATE), 5000,300, dept_no);        
   SAVEPOINT C;                
   INSERT INTO dept 
        VALUES (dept_no, '后勤部', '上海');               --插入相同编号的部门记录
   --提交事务
   COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN                            --捕足异常
     DBMS_OUTPUT.PUT_LINE(SQLERRM);                   --显示异常消息
     ROLLBACK TO B;                                      --回滚异常
END;


SELECT * FROM dept;

DELETE FROM dept WHERE deptno=80;
COMMIT;



DECLARE
   v_1981 NUMBER(2);
   v_1982 NUMBER(2);
   v_1983 NUMBER(2);
BEGIN
   --SET TRANSACTION必须在事务的第1条语句，因此可以在COMMIT或ROLLBACK后面。
   COMMIT;
   SET TRANSACTION READ ONLY NAME '统计年度入职数据';     --使用NAME为事务命名
   --使用SELECT语句执行查询
   SELECT COUNT(empno) INTO v_1981 FROM emp WHERE TO_CHAR(hiredate,'YYYY')='1981';
   SELECT COUNT(empno) INTO v_1982 FROM emp WHERE TO_CHAR(hiredate,'YYYY')='1982';
   SELECT COUNT(empno) INTO v_1983 FROM emp WHERE TO_CHAR(hiredate,'YYYY')='1983';  
   COMMIT;  --终止只读事务
   DBMS_OUTPUT.PUT_LINE('1981年入职人数：'||v_1981);   --显示统计的结果
   DBMS_OUTPUT.PUT_LINE('1982年入职人数：'||v_1982);
   DBMS_OUTPUT.PUT_LINE('1983年入职人数：'||v_1983);              
END;   


SELECT * FROM emp WHERE deptno=10 FOR UPDATE;
COMMIT;

SELECT * FROM emp WHERE deptno=10 FOR UPDATE NOWAIT;
COMMIT;