/* Formatted on 2011/08/19 06:50 (Formatter Plus v4.8.8) */
DECLARE
   v_result   INT := 0;                                    --������ֵ�ı���
BEGIN
   v_result := 16 / 0;                                            --���ⱻ0��
   DBMS_OUTPUT.put_line (   '����ʱ����:'
                         || TO_CHAR (SYSDATE, 'yyyy-MM-dd HH24:MI:SS')
                        );
EXCEPTION                                                     --�쳣��������
   WHEN OTHERS
   THEN
      NULL;                                  --�������κ��쳣ʱ��ʲôҲ������
END;


/* Formatted on 2011/08/19 06:56 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE getleveledbom (bomlevel INT)
AS
BEGIN
   NULL;
END;