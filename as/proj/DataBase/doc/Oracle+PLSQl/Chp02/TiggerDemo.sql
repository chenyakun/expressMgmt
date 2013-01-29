DROP TABLE Scott.RaiseSalaryLog;
--创建表
CREATE TABLE Scott.RaiseSalaryLog
(  
   EmpNo NUMBER(10) NOT NULL PRIMARY KEY,   --员工编号
   RaisedDate DATE,                         --加薪日期
   OriginalSal NUMBER(10,2),                --加薪前薪资
   RaisedSal NUMBER(10,2)                   --加薪后薪资
);

--定义触发器
CREATE OR REPLACE TRIGGER Scott.RaiseSalaryChange
--定义AFTER触发器，监测EMP表的SAL列的更新
AFTER UPDATE OF sal ON scott.emp
--定义的是行级别触发器
FOR EACH ROW
--声明区
DECLARE
  v_RecCount INT;  --定义记录数变量
BEGIN
 --查询更新EMP表的当前已被更新的员工是否在RAISESALARYLOG中存在
 SELECT COUNT(*) INTO v_RecCount FROM scott.RaiseSalaryLog WHERE EmpNo=:old.EmpNo;
 IF v_RecCount=0 THEN
    --如果不存在，则插入新的记录
    INSERT INTO scott.RaiseSalaryLog VALUES(:old.EmpNo,SYSDATE,:old.sal,:new.sal);  
 ELSE
   --如果存在则更新记录
    UPDATE scott.RaiseSalaryLog SET RaisedDate=SYSDATE,
    OriginalSal=:old.sal,RaisedSal=:new.sal WHERE EmpNo=:old.EmpNo;
 END IF;
  --如果出现错误，则显示错误消息
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


SELECT *FROM EMP;

SELECT * FROM Scott.RaiseSalaryLog;

UPDATE Scott.emp SET sal=sal*1.2 WHERE empno=7369;

commit;

