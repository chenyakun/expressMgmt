UPDATE ic_vendor_stock
   SET cutoff_date = TRUNC (TRUNC (SYSDATE) - TO_CHAR (TRUNC (SYSDATE), 'D'));  --�������ض�����
UPDATE os_ic_so_temp
   SET cutoff_date = TRUNC (TRUNC (SYSDATE) - TO_CHAR (TRUNC (SYSDATE), 'D'));  --�������۶����ض�����
UPDATE os_ic_demand_temp
   SET demand_date = ADD_MONTHS (demand_date, 18),demand_level=2   --�����������ڣ�����18���£��ڶ��ߵ���ʱ�����Լ�һ���ӽ������ڡ�