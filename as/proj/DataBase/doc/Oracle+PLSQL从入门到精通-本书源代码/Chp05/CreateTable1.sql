SELECT *  FROM EMP;

drop table company_emp;

/* Formatted on 2011/08/20 15:16 (Formatter Plus v4.8.8) */
CREATE TABLE company_emp
(
  empno     NUMBER(4) PRIMARY KEY NOT NULL,   --员工工号
  ename     VARCHAR2(10 BYTE),                --员工名称
  job       VARCHAR2(9 BYTE),                 --员工职位
  mgr       NUMBER(4),                        --所属经理
  hiredate  DATE,                             --雇佣日期
  sal       NUMBER(7,2),                      --员工工资
  comm      NUMBER(7,2),                      --员工描述
  deptno    NUMBER(2)                         --部门编码
)

/* Formatted on 2011/08/20 15:31 (Formatter Plus v4.8.8) */


ALTER TABLE company_emp DROP COLUMN description;   

ALTER TABLE company_emp ADD description VARCHAR2(200) NULL; 


DROP TABLE company_emp;  --移除company_emp表


DROP TABLE workcenter;
--创建表workcenter
CREATE TABLE workcenter    --指定表名称
(  
   id int,                 --添加编号字段
   name varchar2(200)      --添加名称字段
)



CREATE TABLE invoice
(
   invoice_id NUMBER PRIMARY KEY,                     --自动编号，唯一，不为空
   vendor_id NUMBER NOT NULL,                                       --供应商ID
   invoice_number VARCHAR2(50)  NOT NULL,                           --发票编号
   invoice_date DATE DEFAULT SYSDATE,                               --发票日期
   invoice_total  NUMBER(9,2) NOT NULL,                             --发票总数
   payment_total NUMBER(9,2)   DEFAULT 0                            --付款总数
)


DROP TABLE invoice;

desc invoice;


CREATE TABLE invoice
(
   invoice_id NUMBER CONSTRAINT invoice_pk PRIMARY KEY,               --自动编号，唯一，不为空                                                    
   vendor_id NUMBER CONSTRAINT vendor_id_nn NOT NULL,                --供应商ID
   invoice_number VARCHAR2(50) CONSTRAINT vendor_number_nn   NOT NULL, --发票编号                                                                   
   invoice_date DATE DEFAULT SYSDATE,                                      --发票日期
   invoice_total  NUMBER(9,2)  CONSTRAINT invoice_total_nn  NOT NULL,       --发票总数
   payment_total NUMBER(9,2)   DEFAULT 0                                    --付款总数
)



CREATE TABLE invoice
(
   invoice_id NUMBER CONSTRAINT invoice_pk PRIMARY KEY,               --自动编号，唯一，不为空                                                    
   vendor_id NUMBER CONSTRAINT vendor_id_nn NOT NULL,                --供应商ID
   invoice_number VARCHAR2(50) CONSTRAINT vendor_number_nn   NOT NULL, --发票编号                                                                   
   invoice_date DATE DEFAULT SYSDATE,                                      --发票日期
   invoice_total  NUMBER(9,2)  CONSTRAINT invoice_total_nn  NOT NULL,       --发票总数
   payment_total NUMBER(9,2)   DEFAULT 0                                    --付款总数
)


DROP TABLE invoice;

/* Formatted on 2011/08/22 06:26 (Formatter Plus v4.8.8) */
CREATE TABLE invoice
(
   invoice_id NUMBER ,                                --自动编号，唯一，不为空
   vendor_id NUMBER,                                                --供应商ID
   invoice_number VARCHAR2(50),                                     --发票编号
   invoice_date DATE DEFAULT SYSDATE,                               --发票日期
   invoice_total  NUMBER(9,2) ,                                     --发票总数
   payment_total NUMBER(9,2)   DEFAULT 0,                           --付款总数
   CONSTRAINT invoice_pk PRIMARY KEY (invoice_id),
   CONSTRAINT vendor_id_un UNIQUE (vendor_id)
);

drop table invoice;
desc emp



CREATE TABLE invoice
(
   invoice_id NUMBER ,                                --自动编号，唯一，不为空
   vendor_id NUMBER   REFERENCES vendors (vendor_id),               --供应商ID
   invoice_number VARCHAR2(50),                                     --发票编号
   invoice_date DATE DEFAULT SYSDATE,                               --发票日期
   invoice_total  NUMBER(9,2) ,                                     --发票总数
   payment_total NUMBER(9,2)   DEFAULT 0,                           --付款总数
   CONSTRAINT invoiceid_vendorid_pk PRIMARY KEY (invoice_id,vendor_id),
   CONSTRAINT vendor_id_un UNIQUE (vendor_id)
);


CREATE TABLE vendors
(
   vendor_id NUMBER,                         --供应商id
   vendor_name VARCHAR2(50) NOT NULL,        --供应商名称
   CONSTRAINT vendors_pk PRIMARY KEY (vendor_id), --主键
   CONSTRAINT vendor_name_uq UNIQUE (vendor_name) --唯一性约束
)


INSERT INTO vendors VALUES(1,'路人甲供应商');
INSERT INTO vendors VALUES(2,'路人乙供应商');



CREATE TABLE invoice
(
   invoice_id NUMBER ,                                --自动编号，唯一，不为空
   vendor_id NUMBER,                                                --供应商ID
   invoice_number VARCHAR2(50),                                     --发票编号
   invoice_date DATE DEFAULT SYSDATE,                               --发票日期
   invoice_total  NUMBER(9,2) ,                                     --发票总数
   payment_total NUMBER(9,2)   DEFAULT 0,                           --付款总数
   CONSTRAINT invoiceid_vendorid_pk PRIMARY KEY (invoice_id,vendor_id),
   CONSTRAINT vendor_id_un UNIQUE (vendor_id),
   CONSTRAINT invoice_fk_vendors FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id) 
   ON DELETE CASCADE
);

INSERT INTO invoice VALUES(1,1,'0001',NULL,100,100);
commit;

/* Formatted on 2011/08/23 06:41 (Formatter Plus v4.8.8) */
DROP TABLE invoice;


