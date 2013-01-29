select * from vendors;
delete from vendors;
select * from invoice;

INSERT INTO vendors VALUES(1,'纵横国际');
INSERT INTO vendors VALUES(2,'宇河国际');

INSERT INTO invoice(invoice_id,vendor_id,invoice_number) VALUES(1,1,'0001'); --插入成功
INSERT INTO invoice(invoice_id,vendor_id,invoice_number) VALUES(1,2,'0001'); --插入失败


/* Formatted on 2011/08/23 20:43 (Formatter Plus v4.8.8) */
DELETE FROM vendors WHERE vendor_id = 1;

/* Formatted on 2011/08/23 20:51 (Formatter Plus v4.8.8) */
SELECT * FROM invoice;