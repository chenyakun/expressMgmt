/* Formatted on 2011/08/11 20:58 (Formatter Plus v4.8.8) */
DECLARE
   v_empname      ROWID;                                --定义ROWID类型的变量
   v_othersname   VARCHAR (18);               --定义用来保存ROWID的字符串变量
BEGIN
   SELECT ROWID                               --查询并获取ROWID的值
     INTO v_empname
     FROM emp
    WHERE empno = &empno;
   --输出ROWID值
   DBMS_OUTPUT.put_line (v_empname);
   v_othersname := ROWIDTOCHAR (v_empname);    --转换ROWID为字符串值
   DBMS_OUTPUT.put_line (v_othersname);
END;
/


SELECT ROWIDTOCHAR(ROWID),ename,empno from emp;