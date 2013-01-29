CREATE OR REPLACE PACKAGE BODY SCOTT.plsql_ic_planning_study
IS
   xp_appl         VARCHAR2 (120) := 'IC_PLANNING';   --Ӧ�ó�������
   xp_date_start   DATE;                               --��ǰ��ʼ����
   xp_date         DATE;                               --��ʱ���ڱ���
   xp_date_wx2     DATE;                               --��ʱ�ı���������������
   xp_date_wx1     DATE;                               --�ϸ������������������
   xp_batch        NUMBER;                             --��һ��ִ�е����κ�
   xp_org          NUMBER;                             --ִ����֯
   xp_leadtime     NUMBER;                             --��ǰ��

   PROCEDURE init                                      --��ʼ����������
   IS
      CURSOR cur_tbl (lp_date DATE)                    --�����α꣬��ȡ�����ϴνض�����������Ӧ�̵����κ��루����ȡ��ǰ��Ӧ�̿����գ�
      IS
         SELECT   *
             FROM ic_vendor_stock ivs
            WHERE ivs.cutoff_date < lp_date           --Ҫ��ض�����С�ڴ�������
         ORDER BY batch_id DESC;
   BEGIN
      xp_batch := 0;                                  --��ʼ�����κ�
      FOR xr IN cur_tbl (xp_date_start)               --ʹ���α�FORѭ����ȡ�α�����
      LOOP
         xp_batch := xr.batch_id;                     --��ȡ��������κ�
         xp_date_wx2 := xr.cutoff_date;               --��ȡ�ϴεĽض�����
         EXIT;                                        --�����˳�         
      END LOOP;
      IF xp_batch = 0                                 --���û����ȡ���κ�����
      THEN
         FOR xr IN (SELECT   *
                        FROM ic_vendor_stock ivs
                    ORDER BY batch_id)                --��ȡ�ضϿ���֮ǰ�����κ�
         LOOP
            xp_batch := xr.batch_id;
            xp_date_wx2 := xr.cutoff_date;            --�����ϴνض�����
            EXIT;
         END LOOP;
      END IF;
      IF xp_batch = 0
      THEN
         xp_date_wx2 := xp_date_wx1;                 --���û�����Σ���ȡ�ϴ�����
      END IF;
   END init;

   FUNCTION get_batch
      RETURN NUMBER
   IS
   BEGIN
      RETURN xp_batch;                               --������init�����л�ȡ�����κ�
   END get_batch;

   FUNCTION check_ic_item (p_item IN VARCHAR2)       --���������е�Item��
      RETURN NUMBER
   IS
      x_end   NUMBER;  -- 0 Ϊ��Ʒ�����IC, 1 ��һ��������IC����, -1����һ��IC����
      CURSOR cur_item (lp_item VARCHAR2)
      IS
         SELECT item_no
           FROM os_ic_demand_temp ID       --��ȡ���۶������ض�IC�ĵ����ϱ���
          WHERE ID.demand_level = 0 AND item_no = lp_item
         UNION
         SELECT item_no
           FROM ic_vendor_stock vs         --��ȡ��Ӧ�̿������ϱ���
          WHERE vs.item_no = lp_item;
   BEGIN
      x_end := -1;
      IF SUBSTR (p_item, 1, 2) = '89'         --�����Ʒ���Ϊ89��ͷ,��ʾΪ�ⷢ�ӹ��Ĳ���Ʒ
      THEN
         x_end := 0;                          --��ʾ��ICΪһ���������
      ELSE
         FOR xr IN cur_item (p_item)
         LOOP
            x_end := 1;                      --�����ʾ��һ��������IC����
            EXIT;
         END LOOP;
      END IF;
      RETURN x_end;
   END check_ic_item;

   PROCEDURE gen_ic_demand                 --����IC����
   IS
      x_date   DATE;
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE OS_IC_DEMAND';      
      x_date := xp_date_wx2 + 1 - 1 / 24 / 60 / 60;       --�õ��������ڵ�������Ϊ����
      INSERT INTO OS_IC_DEMAND                            --��ȡ�������Ժ��IC������
                  (organization_id, item_id, item_no, demand_level,
                   level_desc, demand_date, demand_qty, model_id, model_no,
                   model_customer_id, model_customer, model_demand_date,
                   model_demand_qty, item_usage, scrap_rate, leadtime, mpq)
        SELECT organization_id, item_id, item_no, demand_level,
                   level_desc, demand_date, demand_qty, model_id, model_no,
                   model_customer_id, model_customer, model_demand_date,
                   model_demand_qty, item_usage, scrap_rate, leadtime, mpq
            FROM os_ic_demand_temp
            WHERE demand_date>= x_date;                  --����ȡ�������ڴ����ǰcutoff�Ժ�����ڵ�����
   END gen_ic_demand;

   PROCEDURE actual_ship (p_date_cut IN DATE, p_date_to IN DATE
            DEFAULT SYSDATE)             --����ʵ���߻���
   IS
      x_date_from   DATE;                --��ʼ����
      x_date_to     DATE;                --��������
   BEGIN
      x_date_from := p_date_cut + 1 - 1 / 24 / 60 / 60;  --����һ�νض�����������������
      x_date_to := p_date_to + 1 - 1 / 24 / 60 / 60;     --Ŀ���������
      EXECUTE IMMEDIATE 'TRUNCATE TABLE os_ic_so';       --������۱�
      INSERT INTO os_ic_so
                  (batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   cutoff_date, rcv_id)
         SELECT  batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   xp_date_wx1, rcv_id
           FROM  os_ic_so_temp                           --��IC���������л�ȡ�Ѿ��߻��ļ�¼
           WHERE cutoff_date>x_date_from
           AND cutoff_date<=x_date_to
           AND (so_level=1.2 or so_level=2.2);           --ָ��Ϊ�Ѿ����߻����ݵ����۶�������            
   END actual_ship;

   PROCEDURE openning_so                                  --��ȡ��ǰ�Ѿ����������۶���
   IS
   BEGIN     
      INSERT INTO os_ic_so                                --����в������۶�������
                  (batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   cutoff_date)
      SELECT batch_id, so_level, so_level_desc, org_id, item_id,
                   item_no, so_header_id, so_no, so_line_id, so_line,
                   ship_date, so_qty, customer_id, customer, so_status,
                   cutoff_date 
      from os_ic_so_temp where so_level=2.1 
                         and check_ic_item(item_no) = 1;  --������itemΪ������������۶���       
   END openning_so;

   PROCEDURE shortage_cal                               --����IC������
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
         SELECT SUM (so_qty) qty                 --�����ض��Ŀͻ����ض��Ĳ�Ʒ����ʱ����ڵĹ�Ӧ��
           FROM os_ic_so ist
          WHERE ist.ship_date > lp_d1
            AND ist.ship_date <= lp_d2
            AND ist.item_id = lp_item_id
            AND ist.customer_id = lp_customer_id
            AND ist.batch_id = -1;
   BEGIN
      x_shortage := 0;                          --��������������ʱ����
      x_supply_d1 := xp_date_wx2;               --��Ӧ����
      --ѭ��IC��������
      FOR xr IN (SELECT     idt.demand_qty
                          * (1 + NVL (idt.scrap_rate, 0)) xdm_qty,
                          idt.*
                     FROM os_ic_demand idt
                    WHERE idt.demand_level = 2
                 ORDER BY item_no, model_customer, idt.demand_date)
      LOOP
         x_supply_d2 := xr.demand_date;       
         --�õ�����ʱ����ڵĹ�Ӧ��
         OPEN cur_supply (xr.item_id,
                          xr.model_customer_id,
                          x_supply_d1,
                          x_supply_d2
                         );         
         FETCH cur_supply
          INTO x_supply;       --��ȡ�α�����
         CLOSE cur_supply;     --�ر��α�
         --����Ƿ����
         x_shortage := -xr.xdm_qty + (NVL (x_supply, 0) + x_shortage);
         x_supply_d1 := x_supply_d2;  
         --���뵽os_ic_demand���У���Ƿ�ϵ����ݲ��뵽
         INSERT INTO os_ic_demand
                     (organization_id, item_id, item_no, demand_level,
                      level_desc, demand_date, demand_qty,
                      model_customer_id, model_customer, item_usage,
                      scrap_rate, leadtime, mpq
                     )
              VALUES (xp_org, xr.item_id, xr.item_no, 9,
                      '�����ȱ', xr.demand_date, x_shortage,
                      xr.model_customer_id, xr.model_customer, xr.item_usage,
                      xr.scrap_rate, xr.leadtime, xr.mpq
                     );
      END LOOP;                                                          -- xr
   END shortage_cal;

   PROCEDURE ic_cd_main (p_recal IN NUMBER DEFAULT 0)                    --��������Vendor Stock��SO�б�
   IS
      CURSOR cur_last_stock                                              --��ȡ��Ӧ�̿�����һ�ε����κ�
      IS
         SELECT   *
             FROM ic_vendor_stock
         ORDER BY batch_id DESC;
                  
      x_date_pre   DATE;                                                  --��һ�ܵ�����������
      x_batch      NUMBER;                                                --���һ�ε����κ�
      x_d1         DATE;                                                  --������ʱ���ڵı���
      x_d2         DATE;
   BEGIN
      x_batch := 1;                                                       --��ʼ�����κ�
      x_date_pre := xp_date_wx1 - 7;                                      --���һ�ε�Batch����
      FOR xr IN cur_last_stock
      LOOP
         x_batch := xr.batch_id;                                          --�õ����һ�ε�����
         x_date_pre := xr.cutoff_date;                                    --�õ����һ�εĽض�����
         EXIT;                                                            --�˳��α�ѭ��
      END LOOP;

      IF x_date_pre = xp_date_wx1                                         --����ϴεĽض�����Ϊ������������
      THEN
         IF p_recal = 0                                                   --������Ա���л����³�ʼ�����������0
         THEN
            RETURN;                                                       --�˳��ӳ���
         ELSE
            DELETE   ic_vendor_stock
                  WHERE batch_id = x_batch;                              --ɾ�����һ�����εĹ�Ӧ�̿��

            DELETE   os_ic_so_list
                  WHERE batch_id = x_batch;                              --ɾ�����ε�IC���۶����б�
         END IF;
      ELSE
         x_batch := x_batch + 1;                                         --����һ���µ�����
      END IF;
      x_d2 := xp_date_wx1 + 1;                                           --ָ���µĽض����� 
      x_d1 := x_d2 - 7;                                                  --�õ�ǰһ�ܵ���ʼ����
      actual_ship (x_d1, x_d2);                                          --���¼��㲢������������֮���Actual ship
      INSERT INTO ic_vendor_stock                                        --��Ӧ�̿���в������½ضϵ�������Ϣ  
                  (batch_id, organization_id, cutoff_date, remarks,
                   creation_date
                  )
           VALUES (x_batch, xp_org, xp_date_wx1, '�ض϶���',
                   SYSDATE
                  );
      INSERT INTO ic_vendor_stock                                        --������Ӧ�̿���в����µĿ����Ϣ
                  (batch_id, organization_id, item_id, item_no, customer_id,
                   customer, cutoff_date, quantity, quantity_orig,
                   ship_to_vendor, ship_by_model, remarks, last_update_date,
                   last_updated_by, creation_date, created_by)
         SELECT x_batch, organization_id, item_id, item_no, customer_id,
                customer, xp_date_wx1, quantity, quantity, 0, 0, remarks,
                SYSDATE, -1, SYSDATE, -1
           FROM ic_vendor_stock_temp
          WHERE batch_id = x_batch - 1 AND quantity > 0;
      --ʹ���α�FORѭ���������۶����е��Ѿ��߻���IC����
      FOR xr IN (SELECT ist.item_id, ist.item_no, ist.customer_id,
                        ist.customer, ist.so_level, ist.so_qty,
                        DECODE (ist.so_level, 2.2, ist.so_qty, 0) qty_ic,
                        DECODE (ist.so_level, 2.9, ist.so_qty, 0) qty_80
                   FROM os_ic_so ist
                  WHERE ist.so_level IN (2.2, 2.9))
      LOOP
         UPDATE ic_vendor_stock ivs                                    --���¹�Ӧ�õĿ����Ϊ�Ѿ��߻�����������
            SET ship_to_vendor = NVL (ship_to_vendor, 0) + xr.qty_ic,
                ship_by_model = NVL (ship_by_model, 0) + xr.qty_80,
                quantity = NVL (quantity, 0) + xr.qty_ic - xr.qty_80,
                quantity_orig = NVL (quantity_orig, 0) + xr.qty_ic - xr.qty_80
          WHERE ivs.customer_id = xr.customer_id
            AND ivs.item_id = xr.item_id
            AND ivs.batch_id = x_batch;
         IF SQL%NOTFOUND                                              --��������ڹ�Ӧ�̵����ݣ�������µ�����
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
      INSERT INTO os_ic_so_list                                      --����ʷ���������ݲ��뵽���۶�����ʷ�����б���
                  (batch_id, so_level, org_id, item_id, item_no, so_header_id,
                   so_no, so_line_id, so_line, ship_date, so_qty, customer_id,
                   customer, so_status, cutoff_date, rcv_id)
         SELECT batch_id, so_level, org_id, item_id, item_no, so_header_id,
                so_no, so_line_id, so_line, ship_date, so_qty, customer_id,
                customer, so_status, cutoff_date, rcv_id
           FROM os_ic_so;
      COMMIT;                                                        --�ύ����
   END ic_cd_main;

   PROCEDURE data_pre_main (p_date IN DATE)
   IS
   BEGIN
      xp_date_start := TRUNC(p_date);
      init;                              --��ʼ������ѡ��
      gen_ic_demand;                     --����IC������Ϣ       
      actual_ship (xp_date);             --���㵱ǰΪֹ�Ѿ�������IC��Ϣ
      openning_so;                       --��ȡ���۶����е�IC����
      shortage_cal;                      --����IC����ʵ������
      ic_cd_main(1);                        --׼����һ�μ��������
   END;
BEGIN
   --����ʼ���׶�
   xp_org := 84;  
   xp_date := TRUNC (SYSDATE);    --��ȡ��ǰ����
   --��ȡ��ǰ������һ��������������
   xp_date_wx1 := TRUNC (xp_date) - TO_CHAR (xp_date, 'D');
   xp_leadtime := 14;            --ָ����ǰ��Ϊ14�졣
   init;                         --���ó�ʼ���ӳ���
END plsql_ic_planning_study;
/
