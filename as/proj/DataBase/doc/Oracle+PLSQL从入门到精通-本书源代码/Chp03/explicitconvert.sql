/* Formatted on 2011/08/14 17:53 (Formatter Plus v4.8.8) */
DECLARE
   v_startdate    DATE;                                            --��ʼ����
   v_enddate      DATE;                                            --��������
   v_resultdate   NUMBER;                                          --���ؽ��
BEGIN
   --��ʼ���ڣ����ַ���ת��Ϊ����
   v_startdate := TO_DATE ('2007-10-11', 'yyyy-MM-dd');
   v_enddate := TRUNC (SYSDATE);                                   --������ֵ
   v_resultdate := v_enddate - v_startdate;                        --��������ת��
   --��������������
   DBMS_OUTPUT.put_line (   ' ��ʼ���ڣ�'
                         || TO_CHAR (v_startdate, 'yyyy-MM-dd')
                         || CHR (13)
                         || CHR (10)
                         || ' �������ڣ�'
                         || TO_CHAR (v_enddate, 'yyyy-MM-dd')
                         || CHR (13)
                         || CHR (10)
                         || ' ���������'
                         || TO_CHAR (v_resultdate)
                        );
END;



DECLARE
   v_startdate    CHAR(10);                                            --��ʼ����
   v_enddate      CHAR(10);                                            --��������
   v_result       NUMBER(5);
BEGIN
   SELECT MIN(hiredate) INTO v_startdate FROM emp;                     --�Զ�ת��Ϊ�ַ���   
   SELECT TRUNC(SYSDATE) INTO v_enddate FROM dual;
   --��������������
   DBMS_OUTPUT.put_line (   ' ��ʼ���ڣ�'
                         || v_startdate
                         || CHR (13)
                         || CHR (10)
                         || ' �������ڣ�'
                         || v_enddate
                        );   
   v_startdate:='200';                                               --Ϊ�ַ�����ֵ
   v_enddate:='400';   
   v_result:=v_enddate-v_startdate;                                  --���ַ�����������                  
END;  

 

   SELECT TO_CHAR(TRUNC(SYSDATE),'DDD')  FROM dual;
   SELECT TO_CHAR(MIN(hiredate),'DDD')  FROM emp;      

      