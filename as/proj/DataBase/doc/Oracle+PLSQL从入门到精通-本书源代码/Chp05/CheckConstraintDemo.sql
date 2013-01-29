CREATE TABLE invoice_check
(
   invoice_id NUMBER ,
   invoice_total  NUMBER(9,2)  CHECK (invoice_total>0 AND invoice_total<=5000) ,                                                                   
   payment_total NUMBER(9,2)  DEFAULT 0 CHECK(payment_total>0 AND payment_total<=10000)
);

INSERT INTO invoice_check VALUES(1,-100,20000);

DROP TABLE invoice_check;


CREATE TABLE invoice_check
(
   invoice_id NUMBER ,
   invoice_total  NUMBER(9,2) DEFAULT 0 ,
   payment_total NUMBER(9,2)  DEFAULT 0,
   CONSTRAINT invoice_ck_total CHECK(invoice_total<=5000 AND payment_total<=10000)      
);

INSERT INTO invoice_check VALUES(1,6000,100);



CREATE TABLE invoice_check_others
(
   invoice_id NUMBER ,
   invoice_name VARCHAR2(20),
   invoice_type INT,
   invoice_clerk VARCHAR2(20),
   invoice_total  NUMBER(9,2) DEFAULT 0 ,
   payment_total NUMBER(9,2)  DEFAULT 0,
   --发票总数必须在1-1000之间
   CONSTRAINT invoice_ck_01 CHECK(invoice_total BETWEEN 1 AND 1000) ,
   --发票名称必须为大写字母
   CONSTRAINT check_invoice_name CHECK (invoice_name = UPPER(invoice_name)),
   --发票类别必须在1,2,3,4,5,6,7之间
   CONSTRAINT check_invoice_type CHECK (invoice_type IN (1,2,3,4,5,6,7)),
   --发票处理员工编号不能为NULL值
   CONSTRAINT check_invoice_clerk CHECK (invoice_clerk IS NOT NULL)
);

INSERT INTO invoice_check_others VALUES(1,'INVOICE_NAME1',1,'b02393',1000,1000);

SELECT * FROM invoice_check_others;

INSERT INTO invoice_check_others VALUES(1,'invoice_name1',1,'b02393',1000,1000);




select * from user_constraints 


--查询invoice_check_others表中的所有约束
SELECT constraint_name, search_condition, status
  FROM user_constraints
 WHERE table_name = UPPER ('invoice_check_others');
--查询约束应用的列信息 
SELECT constraint_name, column_name
  FROM user_cons_columns
 WHERE table_name = UPPER ('invoice_check_others');
 
 
 SELECT *
  FROM user_cons_columns;

SELECT a.table_name, a.constraint_name, a.search_condition, b.column_name,
       a.constraint_type
  FROM all_constraints a, all_cons_columns b
 WHERE a.table_name = UPPER ('invoice_check_others')
   AND a.table_name = b.table_name
   AND a.owner = b.owner
   AND a.constraint_name = b.constraint_name;
   
ALTER TABLE invoice_check ADD invoice_name VARCHAR2(100) CHECK(LENGTH(invoice_name)<=50);
ALTER TABLE invoice_check DROP COLUMN invoice_name;



SELECT ROWIDTOCHAR(rowid), x.*
  FROM invoice_check x;
  
select * from invoice_check;

delete from invoice_check where ROWIDTOCHAR(rowid)='AAWV5SAHrAAAvB6AAE';  
  
  
  truncate table invoice_check;
  
drop table invoice_check; 

ALTER TABLE invoice_check DROP CONSTRAINT SYS_C001118879;
ALTER TABLE invoice_check MODIFY invoice_name VARCHAR2(100) CHECK(LENGTH(invoice_name)<=50);


INSERT INTO invoice_check VALUES(1,200,200,'Demo1');
INSERT INTO invoice_check VALUES(2,300,400,'Demo2');
INSERT INTO invoice_check VALUES (3, 300, 400, 'This is a invoice_name field');
INSERT INTO invoice_check VALUES (3, 300, 400, 'This is a invoice_name field');
INSERT INTO invoice_check VALUES(4,300,400,'Demo2');

delete from invoice_check where invoice_id=3;
ALTER TABLE invoice_check MODIFY invoice_name VARCHAR2(20); 
ALTER TABLE invoice_check DROP COLUMN invoice_name;
/* Formatted on 2011/08/24 23:08 (Formatter Plus v4.8.8) */
ALTER TABLE invoice_check RENAME COLUMN invoice_name TO invoice_name_short;


--添加约束
ALTER TABLE invoice_check ADD CONSTRAINT invoice_check_pk PRIMARY KEY (invoice_id);
ALTER TABLE invoice_check DROP CONSTRAINT invoice_check_pk;
SELECT * FROM invoice_check;

--移除UNIQUE约束
ALTER TABLE invoice_check DROP CONSTRAINT invoice_check_nn;
--使用DEFERRABLE关键字增强一个被禁用的约束
ALTER TABLE invoice_check ADD CONSTRAINT invoice_check_nn UNIQUE (invoice_name) DEFERRABLE DISABLE;
--启用约束，对于已存在的记录不进行验证
ALTER TABLE invoice_check ENABLE NOVALIDATE CONSTRAINT invoice_check_nn;

ALTER TABLE invoice_check DISABLE CONSTRAINT invoice_check_nn;

ALTER TABLE invoice_check DISABLE VALIDATE CONSTRAINT invoice_check_nn;

--添加检查约束
ALTER TABLE invoice_check_others
ADD CONSTRAINT invoice_total_ck CHECK(invoice_total>=1) DISABLE
--添加外键约束
ALTER TABLE invoice_check_others
ADD CONSTRAINT invoice_fk_vendors FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
--添加NOT NULL约束
ALTER TABLE vendors 
ADD CONSTRAINT vendor_vendor_name_nn NOT NULL;

commit;



DROP TABLE invoice_check;


select * from invoice_check_others;


DROP TABLE vendors CASCADE CONSTRAINTS; 