select * from vendors;
delete from vendors;
select * from invoice;

INSERT INTO vendors VALUES(1,'�ݺ����');
INSERT INTO vendors VALUES(2,'��ӹ���');

INSERT INTO invoice(invoice_id,vendor_id,invoice_number) VALUES(1,1,'0001'); --����ɹ�
INSERT INTO invoice(invoice_id,vendor_id,invoice_number) VALUES(1,2,'0001'); --����ʧ��


/* Formatted on 2011/08/23 20:43 (Formatter Plus v4.8.8) */
DELETE FROM vendors WHERE vendor_id = 1;

/* Formatted on 2011/08/23 20:51 (Formatter Plus v4.8.8) */
SELECT * FROM invoice;