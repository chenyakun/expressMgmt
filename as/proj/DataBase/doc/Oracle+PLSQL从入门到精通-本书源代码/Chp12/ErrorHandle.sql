--编译时的错误处理
DECLARE
   v_count NUMBER;
BEGIN
   --由于emp001表并不存在，因此PL/SQL引擎将产生编译时错误
   SELECT COUNT(*) INTO v_count FROM emp001;
   DBMS_OUTPUT.PUT_LINE('员工人数为：'||v_count);
END;   


DECLARE
   x NUMBER:=&x;  --使用参数化的数值
   y NUMBER:=&y;
   z NUMBER;  
BEGIN
   z:=x+y;        --两个数相加       
   DBMS_OUTPUT.PUT_LINE('x+y='||z);      
   z:=x/y;        --两个数相除
   DBMS_OUTPUT.PUT_LINE('x/y='||z);   
END;   



DECLARE
   x NUMBER:=&x;  --使用参数化的数值
   y NUMBER:=&y;
   z NUMBER;  
BEGIN
   z:=x+y;        --两个数相加       
   DBMS_OUTPUT.PUT_LINE('x+y='||z);
   IF y<>0 THEN      
   z:=x/y;        --两个数相除
   DBMS_OUTPUT.PUT_LINE('x/y='||z);
   END IF;   
END;   


DECLARE
   x NUMBER:=&x;  --使用参数化的数值
   y NUMBER:=&y;
   z NUMBER;  
BEGIN
   z:=x+y;        --两个数相加       
   DBMS_OUTPUT.PUT_LINE('x+y='||z);     
   z:=x/y;        --两个数相除
   DBMS_OUTPUT.PUT_LINE('x/y='||z);
EXCEPTION         --异常处理语句块
   WHEN ZERO_DIVIDE THEN   --处理被0除异常
     DBMS_OUTPUT.PUT_LINE('被除数不能为0');   
END;   

SELECT * FROM emp;

/* Formatted on 2011/10/09 18:15 (Formatter Plus v4.8.8) */
DECLARE
   e_duplicate_name   EXCEPTION;                      --定义异常
   v_ename              emp.ename%TYPE;                 --保存姓名的变量
   v_newname            emp.ename%TYPE   := '史密斯';   --新插入的员工名称  
BEGIN
   --查询员工编号为7369的姓名
   SELECT ename
     INTO v_ename
     FROM emp
    WHERE empno = 7369;
   --确保插入的姓名没有重复
   IF v_ename = v_newname
   THEN
      RAISE e_duplicate_name;                 --如果产生异常，触发e_duplicate_name异常
   END IF;
   --如果没有异常，则执行插入语句
   INSERT INTO emp
        VALUES (7881, v_newname, '职员', NULL, TRUNC (SYSDATE), 2000, 200, 20);
EXCEPTION                                     --异常处理语句块
   WHEN e_duplicate_name                      --处理异常      
   THEN
      DBMS_OUTPUT.put_line ('不能插入重复的员工名称');
END;

DECLARE
   e_duplicate_name     EXCEPTION;                      --定义异常
   v_ename              emp.ename%TYPE;                 --保存姓名的变量
   v_newname            emp.ename%TYPE   := '史密斯';   --新插入的员工名称  
BEGIN
   --查询员工编号为7369的姓名
   SELECT ename
     INTO v_ename
     FROM emp
    WHERE empno = 7369;
   --确保插入的姓名没有重复
   IF v_ename = v_newname
   THEN
      RAISE e_duplicate_name;                 --如果产生异常，触发e_duplicate_name异常
   END IF;
   --如果没有异常，则执行插入语句
   INSERT INTO emp
        VALUES (7881, v_newname, '职员', NULL, TRUNC (SYSDATE), 2000, 200, 20);
EXCEPTION                                     --异常处理语句块
   WHEN e_duplicate_name   THEN
      DBMS_OUTPUT.put_line ('不能插入重复的员工名称');
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('异常编码：'||SQLCODE||' 异常信息：'||SQLERRM);      
END;




/* Formatted on 2011/10/10 00:09 (Formatter Plus v4.8.8) */
DECLARE
   v_tmpstr   VARCHAR2 (10);    --定义一个字符串变量
BEGIN
   v_tmpstr := '这是临时句子';  --赋一个超过其类型长度的字符串
EXCEPTION
   WHEN VALUE_ERROR             -- 捕捉VALUE_ERROR错误
   THEN
      DBMS_OUTPUT.put_line ( '出现了VALUE_ERROR错误'
                            || ' 错误编号：'
                            || SQLCODE
                            || ' 错误名称：'
                            || SQLERRM
                           );    --显示错误编号和错误消息
END;


DECLARE
   e_nodeptno EXCEPTION;   --定义自定义异常
BEGIN
   NULL;
END;



DECLARE
   e_userdefinedexception   EXCEPTION;
   e_userdefinedexception   EXCEPTION;
BEGIN
   RAISE e_userdefinedexception;
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;


DECLARE
   e_userdefinedexception   EXCEPTION;          --定义外层外异常
BEGIN
   DECLARE
      e_userdefinedexception   EXCEPTION;       --在内存块中定义相同的异常
   BEGIN
      RAISE e_userdefinedexception;             --触发内存块中的异常
   END;
   RAISE e_userdefinedexception;                --触发外层块中的异常
EXCEPTION
   WHEN OTHERS THEN                             --捕获并处理外层块中的异常
      DBMS_OUTPUT.put_line ('出现了错误'
                            || ' 错误编号：'
                            || SQLCODE
                            || ' 错误名称：'
                            || SQLERRM
                           );    --显示错误编号和错误消息      
END;


DECLARE
   e_outerexception   EXCEPTION;          --定义外层外异常
BEGIN
   DECLARE
      e_innerexception   EXCEPTION;       --在内存块中定义相同的异常
   BEGIN
      RAISE e_innerexception;              --触发内存块中的异常
      RAISE e_outerexception;              --在内存块中触发在外层块中定义的异常
   END;
   RAISE e_outerexception;                  --触发外层块中的异常
   --RAISE e_innerexception;                --在外层块中触发内存块中的异常是非法的
EXCEPTION
   WHEN OTHERS THEN                             --捕获并处理外层块中的异常
      DBMS_OUTPUT.put_line ('出现了错误'
                            || ' 错误编号：'
                            || SQLCODE
                            || ' 错误名称：'
                            || SQLERRM
                           );    --显示错误编号和错误消息      
END;


DECLARE
   e_userdefinedexception   EXCEPTION;          --定义外层外异常
BEGIN
   DECLARE
      e_userdefinedexception   EXCEPTION;       --覆盖了外层块中的异常
   BEGIN
      RAISE e_userdefinedexception;             --触发内存块中的异常
   END;
EXCEPTION
   WHEN e_userdefinedexception THEN              --此时并不能捕获取该异常
      DBMS_OUTPUT.put_line ('出现了错误'
                            || ' 错误编号：'
                            || SQLCODE
                            || ' 错误名称：'
                            || SQLERRM
                           );    --显示错误编号和错误消息    
   WHEN OTHERS THEN                              --以其他异常被传递
      NULL;                             
END;


/* Formatted on 2011/10/10 11:44 (Formatter Plus v4.8.8) */
DECLARE
   e_missingnull   EXCEPTION;                          --先声明一个异常
   PRAGMA EXCEPTION_INIT (e_missingnull, -1400);       --将该异常与-1400进行关联
BEGIN
   INSERT INTO emp(empno)VALUES (NULL);                --向emp表中不为空的列empno插入NULL值
   COMMIT;                                             --如果执行成功则使用COMMIT提交
EXCEPTION
   WHEN e_missingnull THEN                             --如果失败则捕捉到命名的异常
      DBMS_OUTPUT.put_line ('触发了ORA-1400错误！'||SQLERRM);
      ROLLBACK;
END;
/


/* Formatted on 2011/10/10 14:52 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE registeremployee (
   p_empno    IN   emp.empno%TYPE,                  --员工编号
   p_ename    IN   emp.ename%TYPE,                  --员工名称
   p_sal      IN   emp.sal%TYPE,                    --员工薪资
   p_deptno   IN   emp.deptno%TYPE                  --部门编号
)
AS
   v_empcount   NUMBER;                             
BEGIN
   IF p_empno IS NULL                               --如果员工编号为NULL则触发错误
   THEN
      raise_application_error (-20000, '员工编号不能为空');  --触发应用程序异常
   ELSE
      SELECT COUNT (*)
        INTO v_empcount
        FROM emp
       WHERE empno = p_empno;                       --判断员工编号是否存在
      IF v_empcount > 0                             --如果员工编号已存在
      THEN
         raise_application_error (-20001,
                                  '员工编号为：' || p_empno
                                  || '的员工已存在！'
                                 );                  --触发应用程序异常
      END IF;
   END IF;
   IF p_deptno IS NULL                              --如果部门编号为NULL
   THEN
      raise_application_error (-20002, '部门编号不能为空');  --触发应用程序异常
   END IF;
   INSERT INTO emp                                  --向emp表中插入员工记录
               (empno, ename, sal, deptno
               )
        VALUES (p_empno, p_ename, p_sal, p_deptno
               );
EXCEPTION
   WHEN OTHERS THEN                                 --捕捉应用程序异常
      raise_application_error (-20003,
                                  '插入数据时出现错误！异常编码：'
                               || SQLCODE
                               || ' 异常描述 '
                               || SQLERRM
                              );
END;



BEGIN
   RegisterEmployee(7369,'李明',2000,NULL);
END;



/* Formatted on 2011/10/10 15:51 (Formatter Plus v4.8.8) */
DECLARE
   e_nocomm   EXCEPTION;                     --自定义的异常
   v_comm     NUMBER (10, 2);                --临时保存提成数据的变量
   v_empno    NUMBER (4)     := &empno;      --从绑定参数中获取员工信息
BEGIN
   SELECT comm INTO v_comm FROM emp WHERE empno = v_empno;  --查询并获取员工提成
   IF v_comm IS NULL                         --如果没有提成
   THEN 
      RAISE e_nocomm;                        --触发异常
   END IF;
EXCEPTION
   WHEN e_nocomm THEN                        --处理自定义异常
      DBMS_OUTPUT.put_line ('选择的员工没有提成！');
   WHEN NO_DATA_FOUND THEN                    --处理预定义异常
      DBMS_OUTPUT.put_line ('没有找到任何数据');     
   WHEN OTHERS THEN                    --处理预定义异常
      DBMS_OUTPUT.put_line ('任何其他未处理的异常');          
END;


DECLARE
   e_nocomm   EXCEPTION;                     --自定义的异常
   v_comm     NUMBER (10, 2);                --临时保存提成数据的变量
   v_empno    NUMBER (4)     := &empno;      --从绑定参数中获取员工信息
BEGIN
   SELECT comm INTO v_comm FROM emp WHERE empno = v_empno;  --查询并获取员工提成
   IF v_comm IS NULL                         --如果没有提成
   THEN 
      RAISE e_nocomm;                        --触发异常
   END IF;
EXCEPTION
   WHEN OTHERS THEN                            --OTHERS必须单独出现
      DBMS_OUTPUT.put_line ('错误编码：'||SQLCODE||' 错误消息：'||SQLERRM(100));          
END;



DECLARE
   e_outerexception   EXCEPTION;  
   e_innerexception   EXCEPTION;     
   e_threeexception   EXCEPTION;                 
BEGIN
   BEGIN
      RAISE e_innerexception;
      RAISE e_outerexception;
      RAISE e_threeexception;                  
   EXCEPTION  
      WHEN  e_innerexception THEN
         --异常处理代码          
   END;        
EXCEPTION
   WHEN e_outerexception THEN                     
      --异常处理代码   
END;




BEGIN
   DECLARE
     v_ename VARCHAR2(2):='ABC';
   BEGIN
     DBMS_OUTPUT.PUT_LINE(v_ename);
   EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('产生了异常');
   END;
EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('错误编号：'
                          ||SQLCODE||' 错误消息：'
                          ||SQLERRM);   
END;   


DECLARE
   e_outerexception   EXCEPTION;  
   e_innerexception   EXCEPTION;     
   e_threeexception   EXCEPTION;                 
BEGIN
   BEGIN
      RAISE e_innerexception;
      RAISE e_outerexception;
      RAISE e_threeexception;                  
   EXCEPTION  
      WHEN  e_innerexception THEN
         RAISE e_outerexception;
      WHEN e_outerexception THEN
         --异常处理代码         
      WHEN OTHERS THEN
         --异常处理代码              
   END;        
EXCEPTION
   WHEN e_outerexception THEN                     
      --异常处理代码   
END;


SELECT * FROM emp;

DECLARE
   e_nocomm   EXCEPTION;                     --自定义的异常
   v_comm     NUMBER (10, 2);                --临时保存提成数据的变量
   v_empno    NUMBER (4)     := &empno;      --从绑定参数中获取员工信息
BEGIN
   SELECT comm INTO v_comm FROM emp WHERE empno = v_empno;  --查询并获取员工提成
   IF v_comm IS NULL                         --如果没有提成
   THEN 
      RAISE e_nocomm;                        --触发异常
   END IF;
EXCEPTION
   WHEN OTHERS THEN                            --OTHERS必须单独出现
      DBMS_OUTPUT.put_line ('错误编码：'||SQLCODE||' 错误消息：'||SQLERRM(100));  
      RAISE;                                   --重新抛出异常              
END;





DECLARE
   e_duplicate_name     EXCEPTION;                      --定义异常
   v_ename              emp.ename%TYPE;                 --保存姓名的变量
   v_newname            emp.ename%TYPE   := '史密斯';   --新插入的员工名称  
BEGIN   
   BEGIN                                                --在嵌套块中处理异常
   SELECT ename INTO v_ename FROM emp WHERE empno = 7369;
   IF v_ename = v_newname
   THEN
      RAISE e_duplicate_name;                 --如果产生异常，触发e_duplicate_name异常
   END IF;
   EXCEPTION
       WHEN e_duplicate_name  THEN
          v_newname:='刘大夏';
   END;
   --如果没有异常，则执行插入语句
   INSERT INTO emp VALUES (7881, v_newname, '职员', NULL, TRUNC (SYSDATE), 2000, 200, 20);
EXCEPTION                                     --异常处理语句块
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('异常编码：'||SQLCODE||' 异常信息：'||SQLERRM);      
END;


DECLARE
   v_empno1 NUMBER(4):=&empno1;                            --定义员工查询条件变量
   v_empno2 NUMBER(4):=&empno2;
   v_empno3 NUMBER(4):=&empno3;   
   v_sal1 NUMBER(10,2);                                    --定义保存员工薪资的变量
   v_sal2 NUMBER(10,2);
   v_sal3 NUMBER(10,2); 
   v_selectcounter NUMBER := 1;                            --查询计数器变量      
BEGIN
   SELECT sal INTO v_sal1 FROM emp WHERE empno=v_empno1;  --查询员工薪资信息
   v_selectcounter:=2;
   SELECT sal INTO v_sal2 FROM emp WHERE empno=v_empno2;
   v_selectcounter:=3;   
   SELECT sal INTO v_sal3 FROM emp WHERE empno=v_empno3;
EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --处理未找到数据的异常
     DBMS_OUTPUT.PUT_LINE('错误编号：'||SQLCODE||' 错误消息：'||SQLERRM
                              ||' 触发异常的位置是：'||v_selectcounter);   
END;      



DECLARE
   v_empno1 NUMBER(4):=&empno1;                            --定义员工查询条件变量
   v_empno2 NUMBER(4):=&empno2;
   v_empno3 NUMBER(4):=&empno3;   
   v_sal1 NUMBER(10,2);                                    --定义保存员工薪资的变量
   v_sal2 NUMBER(10,2);
   v_sal3 NUMBER(10,2);      
BEGIN
   BEGIN
   SELECT sal INTO v_sal1 FROM emp WHERE empno=v_empno1;  --查询员工薪资信息
   EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --处理未找到数据的异常
     DBMS_OUTPUT.PUT_LINE('错误编号：'||SQLCODE||' 错误消息：'||SQLERRM
                              ||' 触发异常的位置是 1');  
   END;  
   BEGIN      
   SELECT sal INTO v_sal2 FROM emp WHERE empno=v_empno2;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --处理未找到数据的异常
     DBMS_OUTPUT.PUT_LINE('错误编号：'||SQLCODE||' 错误消息：'||SQLERRM
                              ||' 触发异常的位置是 2'); 
   END;  
   BEGIN   
   SELECT sal INTO v_sal3 FROM emp WHERE empno=v_empno3;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --处理未找到数据的异常
     DBMS_OUTPUT.PUT_LINE('错误编号：'||SQLCODE||' 错误消息：'||SQLERRM
                              ||' 触发异常的位置是 3'); 
   END;     
EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --处理未找到数据的异常
     DBMS_OUTPUT.PUT_LINE('错误编号：'||SQLCODE||' 错误消息：'||SQLERRM);   
END;   



DECLARE
   v_empno1 NUMBER(4):=&empno1;                            --定义员工查询条件变量
   v_empno2 NUMBER(4):=&empno2;
   v_empno3 NUMBER(4):=&empno3;   
   v_sal1 NUMBER(10,2);                                    --定义保存员工薪资的变量
   v_sal2 NUMBER(10,2);
   v_sal3 NUMBER(10,2);      
   v_str VARCHAR2(200);
BEGIN
   SELECT sal INTO v_sal1 FROM emp WHERE empno=v_empno1;  --查询员工薪资信息
   SELECT sal INTO v_sal2 FROM emp WHERE empno=v_empno2;
   SELECT sal INTO v_sal3 FROM emp WHERE empno=v_empno3;
EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --处理未找到数据的异常
     DBMS_OUTPUT.PUT_LINE('错误编号：'||SQLCODE||' 错误消息：'||SQLERRM
                              ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);   
END;    

SELECT * FROM emp WHERE empno=7881;

DECLARE
   e_duplicate_name     EXCEPTION;                      --定义异常
   v_ename              emp.ename%TYPE;                 --保存姓名的变量
   v_newname            emp.ename%TYPE   := '史密斯';   --新插入的员工名称  
BEGIN   
   LOOP                                                 --开始循环
   BEGIN                                                --将语句块嵌入到子块中
      SAVEPOINT 开始事务;                               --定义一个保存点
      SELECT ename INTO v_ename FROM emp WHERE empno = 7369;   --开始语句块代码
      IF v_ename = v_newname
      THEN
         RAISE e_duplicate_name;                 --如果产生重复，触发e_duplicate_name异常
      END IF;
      INSERT INTO emp VALUES (7881, v_newname, '职员', NULL, TRUNC (SYSDATE), 2000, 200, 20);
      COMMIT;                                       --提交事务
      EXIT;                                         --提交完成退出循环
      EXCEPTION                                     --异常处理语句块
      WHEN e_duplicate_name THEN
         ROLLBACK TO 开始事务;                      --回滚事务到检查点位置
         v_newname:='刘大夏';                       --为产生异常的新员工名重新赋值，重新开始循环执行
   END;                                            
   END LOOP;    
END;