DECLARE
  p  VARCHAR2(30);                  --��������ַ�������
  n  PLS_INTEGER := 37;             --����Ҫ�жϵ�����
BEGIN
  FOR j in 2..ROUND(SQRT(n)) LOOP   --���ѭ��
    IF n MOD j = 0 THEN             --�ж��Ƿ�Ϊһ������
      p := ' ��������';              --��ʼ��P��ֵ
      GOTO print_now;                --��ת��print_now��ǩλ��
    END IF;
  END LOOP;
  p := ' ��һ������';
  --��ת����ǩλ�� 
  <<print_now>>
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(n) || p);
END;
/


--DECLARE
--  done  BOOLEAN;
--BEGIN
--  FOR i IN 1..50 LOOP
--    IF done THEN
--       GOTO end_loop;
--    END IF;
--    <<end_loop>>
--  END LOOP;
--END;


/* Formatted on 2011/08/18 23:18 (Formatter Plus v4.8.8) */
DECLARE
   v_counter   INT := 0;   --����ѭ������������
BEGIN  
   <<outer>>               --�����ǩ
   v_counter := v_counter + 1;
   DBMS_OUTPUT.put_line ('ѭ����������' || v_counter);
   --�жϼ���������
   IF v_counter < 5
   THEN
      GOTO OUTER;           --������ת����ǩλ��
   END IF;
END;