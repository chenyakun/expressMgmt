UPDATE ic_vendor_stock
   SET cutoff_date = TRUNC (TRUNC (SYSDATE) - TO_CHAR (TRUNC (SYSDATE), 'D'));  --调整库存截断日期
UPDATE os_ic_so_temp
   SET cutoff_date = TRUNC (TRUNC (SYSDATE) - TO_CHAR (TRUNC (SYSDATE), 'D'));  --调整销售订单截断日期
UPDATE os_ic_demand_temp
   SET demand_date = ADD_MONTHS (demand_date, 18),demand_level=2   --调整需求日期，加上18个月，在读者调试时，可以加一个接近的日期。