/* Formatted on 2011/08/14 09:36 (Formatter Plus v4.8.8) */
DECLARE
   SUBTYPE empcounttype IS INTEGER ;          --����������
   empcount   empcounttype;                   --���������ͱ���
BEGIN
   SELECT COUNT (*)                           --��ѯemp��Ϊ�����ͱ�����ֵ
     INTO empcount
     FROM emp;
   --���Ա������
   DBMS_OUTPUT.put_line ('Ա������Ϊ��' || empcount);
END;

/* Formatted on 2011/08/14 09:57 (Formatter Plus v4.8.8) */
DECLARE
   TYPE empnamelist IS TABLE OF VARCHAR2 (20); --���������
   --��������͵�������
   SUBTYPE namelist IS empnamelist;
   --����Ա����¼
   TYPE emprec IS RECORD (
      empno   NUMBER (4),
      ename   VARCHAR2 (20)
   );
   --����Ա����¼������
   SUBTYPE emprecord IS emprec;
   --�������ݿ��emp�е�empno������
   SUBTYPE empno IS emp.empno%TYPE;
   --�������ݿ��emp�е��м�¼������
   SUBTYPE emprow IS emp%ROWTYPE;
BEGIN
   NULL;
END;


/* Formatted on 2011/08/14 10:11 (Formatter Plus v4.8.8) */
DECLARE
   SUBTYPE numtype IS NUMBER (1, 0);  --����������
   --���������ͱ���
   x_value   numtype;
   y_value   numtype;
BEGIN
   x_value := 3;                    --����
   y_value := 10;                   --�����쳣��ʾ
END;

DECLARE 
   SUBTYPE numtype IS NUMBER;       --�������ͺͱ���
   x_value NUMBER;
   y_value numtype;
BEGIN
   x_value:=10;                     --����ֵ
   y_value:=x_value;                --���ͽ���
END; 
/  


DECLARE 
   SUBTYPE numtype IS VARCHAR2(200);       --�������ͺͱ���
   x_value VARCHAR2(20);
   y_value numtype;
BEGIN
   x_value:='This is a word';                     --����ֵ
   y_value:=x_value;                --���ͽ���
END; 
/  






