CREATE OR REPLACE PACKAGE BODY SCOTT.plsql_ic_planning_study
IS
   xp_appl         VARCHAR2 (120) := 'IC_PLANNING';   --应用程序名称
   xp_date_start   DATE;                               --当前起始日期
   xp_date         DATE;                               --临时日期变量
   xp_date_wx2     DATE;                               --临时的保存星期六的日期
   xp_date_wx1     DATE;                               --上个星期天的排期日是期
   xp_batch        NUMBER;                             --上一次执行的批次号
   xp_org          NUMBER;                             --执行组织
   xp_leadtime     NUMBER;                             --提前期

   PROCEDURE init                                      --初始化批次数据
   IS
      CURSOR cur_tbl (lp_date DATE)                    --定义游标，获取计算上次截断日期以来供应商的批次号码（即获取当前供应商库存快照）
      IS
         SELECT   *
             FROM ic_vendor_stock ivs
            WHERE ivs.cutoff_date < lp_date           --要求截断日期小于传入日期
         ORDER BY batch_id DESC;
   BEGIN
      xp_batch := 0;                                  --初始化批次号
      FOR xr IN cur_tbl (xp_date_start)               --使用游标FOR循环提取游标数据
      LOOP
         xp_batch := xr.batch_id;                     --获取最近的批次号
         xp_date_wx2 := xr.cutoff_date;               --获取上次的截断日期
         EXIT;                                        --立即退出         
      END LOOP;
      IF xp_batch = 0                                 --如果没有提取到任何批次
      THEN
         FOR xr IN (SELECT   *
                        FROM ic_vendor_stock ivs
                    ORDER BY batch_id)                --获取截断快照之前的批次号
         LOOP
            xp_batch := xr.batch_id;
            xp_date_wx2 := xr.cutoff_date;            --保存上次截断日期
            EXIT;
         END LOOP;
      END IF;
      IF xp_batch = 0
      THEN
         xp_date_wx2 := xp_date_wx1;                 --如果没有批次，获取上次日期
      END IF;
   END init;

   FUNCTION get_batch
      RETURN NUMBER
   IS
   BEGIN
      RETURN xp_batch;                               --返回在init过程中获取的批次号
   END get_batch;

   FUNCTION check_ic_item (p_item IN VARCHAR2)       --检查需求表中的Item数
      RETURN NUMBER
   IS
      x_end   NUMBER;  -- 0 为产品的组件IC, 1 是一个独立的IC需求, -1不是一个IC物料
      CURSOR cur_item (lp_item VARCHAR2)
      IS
         SELECT item_no
           FROM os_ic_demand_temp ID       --获取销售订单中特定IC的的物料编码
          WHERE ID.demand_level = 0 AND item_no = lp_item
         UNION
         SELECT item_no
           FROM ic_vendor_stock vs         --获取供应商库存的物料编码
          WHERE vs.item_no = lp_item;
   BEGIN
      x_end := -1;
      IF SUBSTR (p_item, 1, 2) = '89'         --如果产品编号为89开头,表示为外发加工的产成品
      THEN
         x_end := 0;                          --表示该IC为一个相关需求
      ELSE
         FOR xr IN cur_item (p_item)
         LOOP
            x_end := 1;                      --否则表示是一个独立的IC需求
            EXIT;
         END LOOP;
      END IF;
      RETURN x_end;
   END check_ic_item;

   PROCEDURE gen_ic_demand                 --生成IC需求
   IS
      x_date   DATE;
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE OS_IC_DEMAND';      
      x_date := xp_date_wx2 + 1 - 1 / 24 / 60 / 60;       --得到传入日期的周六作为日期
      INSERT INTO OS_IC_DEMAND                            --获取本周六以后的IC需求量
                  (organization_id, item_id, item_no, demand_level,
                   level_desc, demand_date, demand_qty, model_id, model_no,
                   model_customer_id, model_customer, model_demand_date,
                   model_demand_qty, item_usage, scrap_rate, leadtime, mpq)
        SELECT organization_id, item_id, item_no, demand_level,
                   level_desc, demand_date, demand_qty, model_id, model_no,
                   model_customer_id, model_customer, model_demand_date,
                   model_demand_qty, item_usage, scrap_rate, leadtime, mpq
            FROM os_ic_demand_temp
            WHERE demand_date>= x_date;                  --仅获取需求日期大过当前cutoff以后的日期的需求
   END gen_ic_demand;

   PROCEDURE actual_ship (p_date_cut IN DATE, p_date_to IN DATE
            DEFAULT SYSDATE)             --生成实际走货量
   IS
      x_date_from   DATE;                --起始日期
      x_date_to     DATE;                --结束日期
   BEGIN
      x_date_from := p_date_cut + 1 - 1 / 24 / 60 / 60;  --从上一次截断日期以来的星期六
      x_date_to := p_date_to + 1 - 1 / 24 / 60 / 60;     --目标的星期六
      EXECUTE IMMEDIATE 'TRUNCATE TABLE os_ic_so';       --清除销售表
      INSERT INTO os_ic_so
                  (batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   cutoff_date, rcv_id)
         SELECT  batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   xp_date_wx1, rcv_id
           FROM  os_ic_so_temp                           --从IC销售数据中获取已经走货的记录
           WHERE cutoff_date>x_date_from
           AND cutoff_date<=x_date_to
           AND (so_level=1.2 or so_level=2.2);           --指定为已具有走货数据的销售订单数量            
   END actual_ship;

   PROCEDURE openning_so                                  --获取当前已经开出的销售订单
   IS
   BEGIN     
      INSERT INTO os_ic_so                                --向表中插入销售订单数据
                  (batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   cutoff_date)
      SELECT batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   cutoff_date 
      from os_ic_so_temp where so_level=2.1 
                         and check_ic_item(item_no) = 1;  --仅插入item为独立需求的销售订单       
   END openning_so;

   PROCEDURE shortage_cal                               --计算IC需求量
   IS
      x_supply_d1   DATE;
      x_supply_d2   DATE;
      x_shortage    NUMBER;
      x_supply      NUMBER;

      CURSOR cur_supply (
         lp_item_id       NUMBER,
         lp_customer_id   NUMBER,
         lp_d1            DATE,
         lp_d2            DATE
      )
      IS
         SELECT SUM (so_qty) qty                 --汇总特定的客户在特定的产品的下时间段内的供应量
           FROM os_ic_so ist
          WHERE ist.ship_date > lp_d1
            AND ist.ship_date <= lp_d2
            AND ist.item_id = lp_item_id
            AND ist.customer_id = lp_customer_id
            AND ist.batch_id = -1;
   BEGIN
      x_shortage := 0;                          --保存需求量的临时变量
      x_supply_d1 := xp_date_wx2;               --供应日期
      --循环IC的需求量
      FOR xr IN (SELECT     idt.demand_qty
                          * (1 + NVL (idt.scrap_rate, 0)) xdm_qty,
                          idt.*
                     FROM os_ic_demand idt
                    WHERE idt.demand_level = 2
                 ORDER BY item_no, model_customer, idt.demand_date)
      LOOP
         x_supply_d2 := xr.demand_date;       
         --得到需求时间段内的供应量
         OPEN cur_supply (xr.item_id,
                          xr.model_customer_id,
                          x_supply_d1,
                          x_supply_d2
                         );         
         FETCH cur_supply
          INTO x_supply;       --提取游标数据
         CLOSE cur_supply;     --关闭游标
         --计算欠料数
         x_shortage := -xr.xdm_qty + (NVL (x_supply, 0) + x_shortage);
         x_supply_d1 := x_supply_d2;  
         --插入到os_ic_demand表中，将欠料的数据插入到
         INSERT INTO os_ic_demand
                     (organization_id, item_id, item_no, demand_level,
                      level_desc, demand_date, demand_qty,
                      model_customer_id, model_customer, item_usage,
                      scrap_rate, leadtime, mpq
                     )
              VALUES (xp_org, xr.item_id, xr.item_no, 9,
                      '需求短缺', xr.demand_date, x_shortage,
                      xr.model_customer_id, xr.model_customer, xr.item_usage,
                      xr.scrap_rate, xr.leadtime, xr.mpq
                     );
      END LOOP;                                                          -- xr
   END shortage_cal;

   PROCEDURE ic_cd_main (p_recal IN NUMBER DEFAULT 0)                    --重新生成Vendor Stock和SO列表
   IS
      CURSOR cur_last_stock                                              --获取供应商库存最后一次的批次号
      IS
         SELECT   *
             FROM ic_vendor_stock
         ORDER BY batch_id DESC;
                  
      x_date_pre   DATE;                                                  --上一周的周六的日期
      x_batch      NUMBER;                                                --最近一次的批次号
      x_d1         DATE;                                                  --保存临时日期的变量
      x_d2         DATE;
   BEGIN
      x_batch := 1;                                                       --初始化批次号
      x_date_pre := xp_date_wx1 - 7;                                      --最近一次的Batch日期
      FOR xr IN cur_last_stock
      LOOP
         x_batch := xr.batch_id;                                          --得到最后一次的批次
         x_date_pre := xr.cutoff_date;                                    --得到最后一次的截断日期
         EXIT;                                                            --退出游标循环
      END LOOP;

      IF x_date_pre = xp_date_wx1                                         --如果上次的截断日期为与操作日期相等
      THEN
         IF p_recal = 0                                                   --如果不对表进行回重新初始化，则传入参数0
         THEN
            RETURN;                                                       --退出子程序
         ELSE
            DELETE   ic_vendor_stock
                  WHERE batch_id = x_batch;                              --删除最后一次批次的供应商库存

            DELETE   os_ic_so_list
                  WHERE batch_id = x_batch;                              --删除批次的IC销售订单列表
         END IF;
      ELSE
         x_batch := x_batch + 1;                                         --加入一个新的批次
      END IF;
      x_d2 := xp_date_wx1 + 1;                                           --指定新的截断日期 
      x_d1 := x_d2 - 7;                                                  --得到前一周的起始日期
      actual_ship (x_d1, x_d2);                                          --重新计算并插入两个日期之间的Actual ship
      INSERT INTO ic_vendor_stock                                        --向供应商库存中插入最新截断的批次信息  
                  (batch_id, organization_id, cutoff_date, remarks,
                   creation_date
                  )
           VALUES (x_batch, xp_org, xp_date_wx1, '截断动作',
                   SYSDATE
                  );
      INSERT INTO ic_vendor_stock                                        --重新向供应商库存中插入新的库存信息
                  (batch_id, organization_id, item_id, item_no, customer_id,
                   customer, cutoff_date, quantity, quantity_orig,
                   ship_to_vendor, ship_by_model, remarks, last_update_date,
                   last_updated_by, creation_date, created_by)
         SELECT x_batch, organization_id, item_id, item_no, customer_id,
                customer, xp_date_wx1, quantity, quantity, 0, 0, remarks,
                SYSDATE, -1, SYSDATE, -1
           FROM ic_vendor_stock_temp
          WHERE batch_id = x_batch - 1 AND quantity > 0;
      --使用游标FOR循环遍历销售订单中的已经走货的IC数据
      FOR xr IN (SELECT ist.item_id, ist.item_no, ist.customer_id,
                        ist.customer, ist.so_level, ist.so_qty,
                        DECODE (ist.so_level, 2.2, ist.so_qty, 0) qty_ic,
                        DECODE (ist.so_level, 2.9, ist.so_qty, 0) qty_80
                   FROM os_ic_so ist
                  WHERE ist.so_level IN (2.2, 2.9))
      LOOP
         UPDATE ic_vendor_stock ivs                                    --更新供应该的库存数为已经走货的销售数据
            SET ship_to_vendor = NVL (ship_to_vendor, 0) + xr.qty_ic,
                ship_by_model = NVL (ship_by_model, 0) + xr.qty_80,
                quantity = NVL (quantity, 0) + xr.qty_ic - xr.qty_80,
                quantity_orig = NVL (quantity_orig, 0) + xr.qty_ic - xr.qty_80
          WHERE ivs.customer_id = xr.customer_id
            AND ivs.item_id = xr.item_id
            AND ivs.batch_id = x_batch;
         IF SQL%NOTFOUND                                              --如果不存在供应商的数据，则插入新的数据
         THEN
            INSERT INTO ic_vendor_stock
                        (batch_id, organization_id, item_id, item_no,
                         customer_id, customer, cutoff_date,
                         quantity, quantity_orig,
                         ship_to_vendor, ship_by_model, remarks,
                         last_update_date, last_updated_by, creation_date,
                         created_by
                        )
                 VALUES (x_batch, xp_org, xr.item_id, xr.item_no,
                         xr.customer_id, xr.customer, xp_date_wx1,
                         xr.qty_ic - xr.qty_80, xr.qty_ic - xr.qty_80,
                         xr.qty_ic, xr.qty_80, NULL,
                         SYSDATE, -1, SYSDATE,
                         -1
                        );
         END IF;
      END LOOP;
      INSERT INTO os_ic_so_list                                      --将历史的销售数据插入到销售订单历史数据列表中
                  (batch_id, so_level, org_id, item_id, item_no, so_header_id,
                   so_no, so_line_id, so_line, ship_date, so_qty, customer_id,
                   customer, so_status, cutoff_date, rcv_id)
         SELECT batch_id, so_level, org_id, item_id, item_no, so_header_id,
                so_no, so_line_id, so_line, ship_date, so_qty, customer_id,
                customer, so_status, cutoff_date, rcv_id
           FROM os_ic_so;
      COMMIT;                                                        --提交事务
   END ic_cd_main;

   PROCEDURE data_pre_main (p_date IN DATE)
   IS
   BEGIN
      xp_date_start := TRUNC(p_date);
      init;                              --初始化日期选项
      gen_ic_demand;                     --生成IC需求信息       
      actual_ship (xp_date);             --计算当前为止已经出货的IC信息
      openning_so;                       --获取销售订单中的IC数量
      shortage_cal;                      --计算IC的真实需求量
      ic_cd_main(1);                        --准备下一次计算的数据
   END;
BEGIN
   --包初始化阶段
   xp_org := 84;  
   xp_date := TRUNC (SYSDATE);    --获取当前日期
   --获取当前日期上一个星期六的日期
   xp_date_wx1 := TRUNC (xp_date) - TO_CHAR (xp_date, 'D');
   xp_leadtime := 14;            --指定提前期为14天。
   init;                         --调用初始化子程序
END plsql_ic_planning_study;
/
