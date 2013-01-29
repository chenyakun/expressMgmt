--创建员工表
CREATE TABLE 员工表
(
  --定义员工表列
  工号 INT NOT NULL,
  中文姓名 NVARCHAR2(20) NOT NULL,
  英文姓名 VARCHAR2(20) NULL,
  别名 VARCHAR2(20) NULL, 
  年龄 INT DEFAULT 18,
  入职日期 DATE NULL,
  部门编号 INT NULL,
  --定义员工表主键
  CONSTRAINT PK_员工表 PRIMARY KEY(工号)
);
--创建部门表
CREATE TABLE 部门表
(
  --定义部门表列
  部门编号 INT NOT NULL,
  部门名称 NVARCHAR2(50) NULL,
  部门经理 INT NOT NULL,
  部门描述 NVARCHAR2(200) NULL,
  工号 INT NOT NULL,
  --定义部门表主键
  CONSTRAINT PK_部门表 PRIMARY KEY(部门编号)   
);
--为员工表添加外键引用
ALTER TABLE 员工表 ADD (
  CONSTRAINT FK_部门编号 
 FOREIGN KEY (部门编号) 
 REFERENCES 部门表 (部门编号));
 
--为部门表添加外键引用
ALTER TABLE 部门表 ADD (
  CONSTRAINT FK_部门经理 
 FOREIGN KEY (部门经理) 
 REFERENCES 员工表 (工号)); 
 
--张三是理财部的经理，他不属于任何部门 
INSERT INTO 员工表 VALUES(100,'张三','San Zhang','老三',20,date'2011-01-01',null);
--李四是财务部职员
INSERT INTO 员工表 VALUES(101,'李四','Li Si','老四',20,date'2011-01-01',100);
--部门表
INSERT INTO 部门表 VALUES(100,'财务部',100,'理财部',0); 
--让张三属于财务部
UPDATE 员工表 SET 部门编号=100 WHERE 工号=100;

COMMIT;



SELECT * FROM 员工表 WHERE 部门编号=100;


DECLARE
  --在PL/SQL匿名块中定义变量
  v_EmpNo INT:=102;
  v_ChsName NVARCHAR2(20):='王五';
  v_EngName VARCHAR2(20):='Wang wu';
  v_AlsName VARCHAR2(20):='老五';
  v_Age INT:=28;
  v_EnrDate DATE:=date'2011-04-01';
  v_DeptNo INT:=100;
BEGIN
  --先更新已存在的记录
  UPDATE 员工表 SET 中文姓名=v_ChsName,
                    英文姓名=v_EngName,
                    别名=v_AlsName,
                    年龄=v_Age,
                    入职日期=v_EnrDate,
                    部门编号=v_DeptNo
              WHERE 工号=v_EmpNo;
     DBMS_OUTPUT.PUT_LINE('员工更新成功');                   
   --判断如果未更新数据
   IF SQL%NOTFOUND THEN
     --则向员工表中插入员工记录
     INSERT INTO 员工表 
     VALUES(v_EmpNo,v_ChsName,v_EngName,v_AlsName,
             v_Age,v_EnrDate,v_DeptNo);  
     DBMS_OUTPUT.PUT_LINE('员工插入成功');             
   END IF;  
   --错误处理
   EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('插入员工表错误');  
END;      



--开启屏幕输出显示
SET SERVEROUTPUT ON;
--显示当前日期与时间
BEGIN
  DBMS_OUTPUT.PUT_LINE('现在的日期时间：');
  --显示信息不换行
  DBMS_OUTPUT.PUT('今天是：');
  --显示信息并换行
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'DAY'));
  DBMS_OUTPUT.PUT('现在时间是： ');
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'));  
END;