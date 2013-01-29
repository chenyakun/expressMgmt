/* Formatted on 2011/11/03 07:07 (Formatter Plus v4.8.8) */

CREATE TYPE address AS OBJECT (     --创建地址类型
   street     VARCHAR2 (35),
   city       VARCHAR2 (15),
   state      CHAR (2),
   zip_code   INTEGER
);
CREATE TABLE addresses OF address;  --创建地址对象表
CREATE TYPE person AS OBJECT (      --创建人员对象类型
   person_name     VARCHAR2 (15),
   birthday       DATE,
   home_address   REF address,      --使用REF关键字，指定属性为指向另一个对象表的对象
   phone_number   VARCHAR2 (15)
);
CREATE TABLE persons OF person;     --创建人员对象表
--插入地址
INSERT INTO addresses
     VALUES (address ('玉兰', '深圳', 'GD', '52334'));
INSERT INTO addresses
     VALUES (address ('黄甫', '广州', 'GD', '52300'));
--插入一个人员，注意这里的home_address部分是如何插入一个ref address的。
INSERT INTO persons
     VALUES (person ('王小五',
                     TO_DATE ('1983-01-01', 'YYYY-MM-DD'),
                     (SELECT REF (a)
                        FROM addresses a
                       WHERE street = '玉兰'),
                     '16899188'
                    ));
--也可以用下面的过程来插入一个人员记录

DECLARE
   addref   REF address;
BEGIN
   SELECT REF (a)
     INTO addref
     FROM addresses a
    WHERE street = '玉兰';   --使用SELECT INTO查询一个引用对象
   --使用INSERT语句向persons表中插入引用对象
   INSERT INTO persons
        VALUES (person ('五大狼',
                        TO_DATE ('1983-01-01', 'yyyy-mm-dd'),
                        addref,
                        '16899188'
                       ));
END;

--查询某人的地址信息
SELECT person_name, DEREF (home_address)
  FROM persons;
  
  
DECLARE
   addr address;
BEGIN
   SELECT DEREF(home_address) INTO addr FROM persons WHERE person_name='王小五';
   addr.street:='五一';
   UPDATE address SET street=addr.street WHERE zip_code='523330';
END;
