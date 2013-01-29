--ICоƬǷ�ϼƻ����淶
CREATE OR REPLACE PACKAGE plsql_ic_planning_study
AS
/******************************************************************************
   ����:       plsql_ic_planning_study
   ����:       ����A��˾��ICоƬǷ�ϳ���
   �޶���ʷ��   
   �汾       ����          ����               ����
   ---------  ----------  ---------------  ------------------------------------
   1.0        11/08/2011  PL/SQL�����ű�ͨ  1. ��ʼ������
******************************************************************************/
   PROCEDURE init;        --�����κźͳ�ʼ���ڽ��г�ʼ��           
   FUNCTION get_batch     --��ȡ��ǰ���κ�
      RETURN NUMBER;
   FUNCTION check_ic_item (p_item IN VARCHAR2)  --���IC���
      RETURN NUMBER;
   PROCEDURE gen_ic_demand;   --����IC��������
   PROCEDURE actual_ship (    --����ָ������֮���ʵ���߻�����
      p_date_cut   IN   DATE,
      p_date_to    IN   DATE DEFAULT SYSDATE
   );
   PROCEDURE openning_so;     --���㵱ǰ�ѿ��������۶����б�
   PROCEDURE shortage_cal;    --����ICнƬǷ��������
   PROCEDURE ic_cd_main (p_recal IN NUMBER DEFAULT 0);--�ڼ�����ɺ����������µĽضϿ���
   PROCEDURE data_pre_main (p_date IN DATE); --�������򣬹��ⲿ���е���
END plsql_ic_planning_study;
/




