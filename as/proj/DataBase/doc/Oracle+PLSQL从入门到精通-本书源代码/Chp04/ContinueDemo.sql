/* Formatted on 2011/08/17 06:24 (Formatter Plus v4.8.8) */
DECLARE
   x   NUMBER := 0;
BEGIN
   LOOP               -- ��ʼѭ����������CONTINUE���ʱ�������¿�ʼLOOP��ִ��
      DBMS_OUTPUT.put_line ('�ڲ�ѭ��ֵ:  x = ' || TO_CHAR (x));
      x := x + 1;
      IF x < 3
      THEN                            --���������С��3�������¿�ʼִ��ѭ����
         CONTINUE;             --ʹ��CONTINUE��������Ĵ���ִ�У����¿�ʼѭ��
      END IF;
      --��ѭ����������3ʱִ�еĴ���
      DBMS_OUTPUT.put_line ('CONTINUE֮���ֵ:  x = ' || TO_CHAR (x));
      EXIT WHEN x = 5;         --��ѭ������Ϊ5ʱ���˳�ѭ��
   END LOOP;
   --���ѭ���Ľ���ֵ
   DBMS_OUTPUT.put_line (' ѭ����������ֵ:  x = ' || TO_CHAR (x));
END;
/


DECLARE
   x   NUMBER := 0;
BEGIN
   LOOP               -- ��ʼѭ����������CONTINUE���ʱ�������¿�ʼLOOP��ִ��
      DBMS_OUTPUT.put_line ('�ڲ�ѭ��ֵ:  x = ' || TO_CHAR (x));
      x := x + 1;
      CONTINUE WHEN x<3;
      --��ѭ����������3ʱִ�еĴ���
      DBMS_OUTPUT.put_line ('CONTINUE֮���ֵ:  x = ' || TO_CHAR (x));
      EXIT WHEN x = 5;         --��ѭ������Ϊ5ʱ���˳�ѭ��
   END LOOP;
   --���ѭ���Ľ���ֵ
   DBMS_OUTPUT.put_line (' ѭ����������ֵ:  x = ' || TO_CHAR (x));
END;
/
