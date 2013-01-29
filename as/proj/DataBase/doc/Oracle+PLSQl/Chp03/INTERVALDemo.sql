/* Formatted on 2011/08/13 16:55 (Formatter Plus v4.8.8) */
DECLARE
   v_start      TIMESTAMP;                         --������ʼ�����ʱ�������
   v_end        TIMESTAMP;
   v_interval   INTERVAL YEAR TO MONTH;
   v_year       NUMBER;
   v_month      NUMBER;
BEGIN
   v_start := TO_TIMESTAMP ('2010-05-12', 'yyyy-MM-dd');  --��ָ����ʱ���ֵ
   v_end := CURRENT_TIMESTAMP;                            --����ǰ��ʱ���ֵ
   v_interval := (v_end - v_start) YEAR TO MONTH;         --YEAR TO MONTH��INTERVAL���ʽ�﷨��
   v_year := EXTRACT (YEAR FROM v_interval);              --��ȡ��ݺ��·�
   v_month := EXTRACT (MONTH FROM v_interval);
   --�����ǰ��INTERVAL���͵�ֵ
   DBMS_OUTPUT.put_line ('��ǰ��INTERVALֵΪ��' || v_interval);
   --���������·�ֵ
   DBMS_OUTPUT.put_line (   'INTERVAL���Ϊ��'
                         || v_year
                         || CHR (13)
                         || CHR (10)
                         || 'INTERVAL�·�Ϊ��'
                         || v_month
                        );
   v_interval := INTERVAL '01-03' YEAR TO MONTH;            --ֱ��ΪINTERVAL��ֵ
   --���INTERVAL��ֵ
   DBMS_OUTPUT.put_line ('��ǰ��INTERVALֵΪ��' || v_interval);
   v_interval := INTERVAL '01' YEAR;                        --ֱ��ΪINTERVAL�����ֵ
   DBMS_OUTPUT.put_line ('��ǰ��INTERVALֵΪ��' || v_interval);
   --��ȡ��ݺ��·�
   v_year := EXTRACT (YEAR FROM v_interval);
   v_month := EXTRACT (MONTH FROM v_interval);
   --���ֵ
   DBMS_OUTPUT.put_line (   'INTERVAL���Ϊ��'
                         || v_year
                         || CHR (13)
                         || CHR (10)
                         || 'INTERVAL�·�Ϊ��'
                         || v_month
                        );
   v_interval := INTERVAL '03' MONTH;                      --ֱ��ΪINTERVAL���·�
   --����·�ֵ
   DBMS_OUTPUT.put_line ('��ǰ��INTERVALֵΪ��' || v_interval);
END;
/