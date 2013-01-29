/* Formatted on 2011/11/03 07:07 (Formatter Plus v4.8.8) */

CREATE TYPE address AS OBJECT (     --������ַ����
   street     VARCHAR2 (35),
   city       VARCHAR2 (15),
   state      CHAR (2),
   zip_code   INTEGER
);
CREATE TABLE addresses OF address;  --������ַ�����
CREATE TYPE person AS OBJECT (      --������Ա��������
   person_name     VARCHAR2 (15),
   birthday       DATE,
   home_address   REF address,      --ʹ��REF�ؼ��֣�ָ������Ϊָ����һ�������Ķ���
   phone_number   VARCHAR2 (15)
);
CREATE TABLE persons OF person;     --������Ա�����
--�����ַ
INSERT INTO addresses
     VALUES (address ('����', '����', 'GD', '52334'));
INSERT INTO addresses
     VALUES (address ('�Ƹ�', '����', 'GD', '52300'));
--����һ����Ա��ע�������home_address��������β���һ��ref address�ġ�
INSERT INTO persons
     VALUES (person ('��С��',
                     TO_DATE ('1983-01-01', 'YYYY-MM-DD'),
                     (SELECT REF (a)
                        FROM addresses a
                       WHERE street = '����'),
                     '16899188'
                    ));
--Ҳ����������Ĺ���������һ����Ա��¼

DECLARE
   addref   REF address;
BEGIN
   SELECT REF (a)
     INTO addref
     FROM addresses a
    WHERE street = '����';   --ʹ��SELECT INTO��ѯһ�����ö���
   --ʹ��INSERT�����persons���в������ö���
   INSERT INTO persons
        VALUES (person ('�����',
                        TO_DATE ('1983-01-01', 'yyyy-mm-dd'),
                        addref,
                        '16899188'
                       ));
END;

--��ѯĳ�˵ĵ�ַ��Ϣ
SELECT person_name, DEREF (home_address)
  FROM persons;
  
  
DECLARE
   addr address;
BEGIN
   SELECT DEREF(home_address) INTO addr FROM persons WHERE person_name='��С��';
   addr.street:='��һ';
   UPDATE address SET street=addr.street WHERE zip_code='523330';
END;
