/* Formatted on 2011/08/14 09:36 (Formatter Plus v4.8.8) */
DECLARE
   SUBTYPE empcounttype IS INTEGER ;          --定义子类型
   empcount   empcounttype;                   --声明子类型变量
BEGIN
   SELECT COUNT (*)                           --查询emp表为子类型变量赋值
     INTO empcount
     FROM emp;
   --输出员工人数
   DBMS_OUTPUT.put_line ('员工人数为：' || empcount);
END;

/* Formatted on 2011/08/14 09:57 (Formatter Plus v4.8.8) */
DECLARE
   TYPE empnamelist IS TABLE OF VARCHAR2 (20); --定义表类型
   --定义表类型的子类型
   SUBTYPE namelist IS empnamelist;
   --定义员工记录
   TYPE emprec IS RECORD (
      empno   NUMBER (4),
      ename   VARCHAR2 (20)
   );
   --定义员工记录子类型
   SUBTYPE emprecord IS emprec;
   --定义数据库表emp中的empno列类型
   SUBTYPE empno IS emp.empno%TYPE;
   --定义数据库表emp中的行记录子类型
   SUBTYPE emprow IS emp%ROWTYPE;
BEGIN
   NULL;
END;


/* Formatted on 2011/08/14 10:11 (Formatter Plus v4.8.8) */
DECLARE
   SUBTYPE numtype IS NUMBER (1, 0);  --定义子类型
   --定义子类型变量
   x_value   numtype;
   y_value   numtype;
BEGIN
   x_value := 3;                    --正常
   y_value := 10;                   --弹出异常提示
END;

DECLARE 
   SUBTYPE numtype IS NUMBER;       --定义类型和变量
   x_value NUMBER;
   y_value numtype;
BEGIN
   x_value:=10;                     --赋初值
   y_value:=x_value;                --类型交换
END; 
/  


DECLARE 
   SUBTYPE numtype IS VARCHAR2(200);       --定义类型和变量
   x_value VARCHAR2(20);
   y_value numtype;
BEGIN
   x_value:='This is a word';                     --赋初值
   y_value:=x_value;                --类型交换
END; 
/  






