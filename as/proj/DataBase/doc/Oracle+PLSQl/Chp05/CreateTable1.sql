SELECT *  FROM EMP;

drop table company_emp;

/* Formatted on 2011/08/20 15:16 (Formatter Plus v4.8.8) */
CREATE TABLE company_emp
(
  empno     NUMBER(4) PRIMARY KEY NOT NULL,   --Ա������
  ename     VARCHAR2(10 BYTE),                --Ա������
  job       VARCHAR2(9 BYTE),                 --Ա��ְλ
  mgr       NUMBER(4),                        --��������
  hiredate  DATE,                             --��Ӷ����
  sal       NUMBER(7,2),                      --Ա������
  comm      NUMBER(7,2),                      --Ա������
  deptno    NUMBER(2)                         --���ű���
)

/* Formatted on 2011/08/20 15:31 (Formatter Plus v4.8.8) */


ALTER TABLE company_emp DROP COLUMN description;   

ALTER TABLE company_emp ADD description VARCHAR2(200) NULL; 


DROP TABLE company_emp;  --�Ƴ�company_emp��


DROP TABLE workcenter;
--������workcenter
CREATE TABLE workcenter    --ָ��������
(  
   id int,                 --��ӱ���ֶ�
   name varchar2(200)      --��������ֶ�
)



CREATE TABLE invoice
(
   invoice_id NUMBER PRIMARY KEY,                     --�Զ���ţ�Ψһ����Ϊ��
   vendor_id NUMBER NOT NULL,                                       --��Ӧ��ID
   invoice_number VARCHAR2(50)  NOT NULL,                           --��Ʊ���
   invoice_date DATE DEFAULT SYSDATE,                               --��Ʊ����
   invoice_total  NUMBER(9,2) NOT NULL,                             --��Ʊ����
   payment_total NUMBER(9,2)   DEFAULT 0                            --��������
)


DROP TABLE invoice;

desc invoice;


CREATE TABLE invoice
(
   invoice_id NUMBER CONSTRAINT invoice_pk PRIMARY KEY,               --�Զ���ţ�Ψһ����Ϊ��                                                    
   vendor_id NUMBER CONSTRAINT vendor_id_nn NOT NULL,                --��Ӧ��ID
   invoice_number VARCHAR2(50) CONSTRAINT vendor_number_nn   NOT NULL, --��Ʊ���                                                                   
   invoice_date DATE DEFAULT SYSDATE,                                      --��Ʊ����
   invoice_total  NUMBER(9,2)  CONSTRAINT invoice_total_nn  NOT NULL,       --��Ʊ����
   payment_total NUMBER(9,2)   DEFAULT 0                                    --��������
)



CREATE TABLE invoice
(
   invoice_id NUMBER CONSTRAINT invoice_pk PRIMARY KEY,               --�Զ���ţ�Ψһ����Ϊ��                                                    
   vendor_id NUMBER CONSTRAINT vendor_id_nn NOT NULL,                --��Ӧ��ID
   invoice_number VARCHAR2(50) CONSTRAINT vendor_number_nn   NOT NULL, --��Ʊ���                                                                   
   invoice_date DATE DEFAULT SYSDATE,                                      --��Ʊ����
   invoice_total  NUMBER(9,2)  CONSTRAINT invoice_total_nn  NOT NULL,       --��Ʊ����
   payment_total NUMBER(9,2)   DEFAULT 0                                    --��������
)


DROP TABLE invoice;

/* Formatted on 2011/08/22 06:26 (Formatter Plus v4.8.8) */
CREATE TABLE invoice
(
   invoice_id NUMBER ,                                --�Զ���ţ�Ψһ����Ϊ��
   vendor_id NUMBER,                                                --��Ӧ��ID
   invoice_number VARCHAR2(50),                                     --��Ʊ���
   invoice_date DATE DEFAULT SYSDATE,                               --��Ʊ����
   invoice_total  NUMBER(9,2) ,                                     --��Ʊ����
   payment_total NUMBER(9,2)   DEFAULT 0,                           --��������
   CONSTRAINT invoice_pk PRIMARY KEY (invoice_id),
   CONSTRAINT vendor_id_un UNIQUE (vendor_id)
);

drop table invoice;
desc emp



CREATE TABLE invoice
(
   invoice_id NUMBER ,                                --�Զ���ţ�Ψһ����Ϊ��
   vendor_id NUMBER   REFERENCES vendors (vendor_id),               --��Ӧ��ID
   invoice_number VARCHAR2(50),                                     --��Ʊ���
   invoice_date DATE DEFAULT SYSDATE,                               --��Ʊ����
   invoice_total  NUMBER(9,2) ,                                     --��Ʊ����
   payment_total NUMBER(9,2)   DEFAULT 0,                           --��������
   CONSTRAINT invoiceid_vendorid_pk PRIMARY KEY (invoice_id,vendor_id),
   CONSTRAINT vendor_id_un UNIQUE (vendor_id)
);


CREATE TABLE vendors
(
   vendor_id NUMBER,                         --��Ӧ��id
   vendor_name VARCHAR2(50) NOT NULL,        --��Ӧ������
   CONSTRAINT vendors_pk PRIMARY KEY (vendor_id), --����
   CONSTRAINT vendor_name_uq UNIQUE (vendor_name) --Ψһ��Լ��
)


INSERT INTO vendors VALUES(1,'·�˼׹�Ӧ��');
INSERT INTO vendors VALUES(2,'·���ҹ�Ӧ��');



CREATE TABLE invoice
(
   invoice_id NUMBER ,                                --�Զ���ţ�Ψһ����Ϊ��
   vendor_id NUMBER,                                                --��Ӧ��ID
   invoice_number VARCHAR2(50),                                     --��Ʊ���
   invoice_date DATE DEFAULT SYSDATE,                               --��Ʊ����
   invoice_total  NUMBER(9,2) ,                                     --��Ʊ����
   payment_total NUMBER(9,2)   DEFAULT 0,                           --��������
   CONSTRAINT invoiceid_vendorid_pk PRIMARY KEY (invoice_id,vendor_id),
   CONSTRAINT vendor_id_un UNIQUE (vendor_id),
   CONSTRAINT invoice_fk_vendors FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id) 
   ON DELETE CASCADE
);

INSERT INTO invoice VALUES(1,1,'0001',NULL,100,100);
commit;

/* Formatted on 2011/08/23 06:41 (Formatter Plus v4.8.8) */
DROP TABLE invoice;


