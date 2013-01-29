--查询员工信息
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno FROM EMP WHERE empno=&EmpNo;
--更新薪水
UPDATE emp SET sal=sal*(1+1.2) WHERE empno=&EmpNo;
--删除员工
DELETE FROM emp WHERE empno=&EmpNo;


--使用动态SQL语句
DECLARE
  v_SQLStr VARCHAR2(200);  --保存SQL语句的变量
  v_Id INT;                --保存临时字段值的变量
  v_Name VARCHAR(100);
BEGIN
  --在嵌套块中先删除要创建的临时表
  BEGIN
  v_SQLStr:='DROP TABLE temptable';
  EXECUTE IMMEDIATE v_SQLStr;
  --如果产生异常不进行处理
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  --定义DDL语句来创建SQL
  v_SQLStr:='CREATE TABLE temptable (id INT NOT NULL PRIMARY KEY,tmpname VARCHAR2(100))';
  EXECUTE IMMEDIATE v_SQLStr;  --执行动态语句
  --向新创建的临时表中插入数据
  v_SQLStr:='INSERT INTO temptable VALUES(10,''临时名称1'')';
  EXECUTE IMMEDIATE v_SQLStr;  --执行动态语句
  --检索临时表数据，这里使用了动态SQL语句变量
  v_SQLStr:='SELECT * FROM temptable WHERE id=:tempId';
  --执行并获取动态语句查询结果
  EXECUTE IMMEDIATE v_SQLstr INTO v_Id,v_Name USING &1;
  --输出表中的信息
  DBMS_OUTPUT.PUT_LINE(v_Id||' '||v_Name);
END;
/

