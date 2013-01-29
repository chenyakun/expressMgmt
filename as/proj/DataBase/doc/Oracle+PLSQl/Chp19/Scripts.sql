--ic供应商库存数据
CREATE TABLE ic_vendor_stock
(
  batch_id          NUMBER,
  organization_id   NUMBER,
  item_id           NUMBER,
  item_no           VARCHAR2(32 BYTE),
  customer_id       NUMBER,
  customer          VARCHAR2(240 BYTE),
  cutoff_date       DATE,
  quantity          NUMBER,
  quantity_orig     NUMBER,
  ship_to_vendor    NUMBER,
  ship_by_model     NUMBER,
  remarks           VARCHAR2(2000 BYTE),
  last_update_date  DATE,
  last_updated_by   VARCHAR2(32 BYTE),
  creation_date     DATE,
  created_by        VARCHAR2(32 BYTE)
)

--ic供应商库存数据
CREATE TABLE ic_vendor_stock_temp
(
  batch_id          NUMBER,
  organization_id   NUMBER,
  item_id           NUMBER,
  item_no           VARCHAR2(32 BYTE),
  customer_id       NUMBER,
  customer          VARCHAR2(240 BYTE),
  cutoff_date       DATE,
  quantity          NUMBER,
  quantity_orig     NUMBER,
  ship_to_vendor    NUMBER,
  ship_by_model     NUMBER,
  remarks           VARCHAR2(2000 BYTE),
  last_update_date  DATE,
  last_updated_by   VARCHAR2(32 BYTE),
  creation_date     DATE,
  created_by        VARCHAR2(32 BYTE)
)

--ic毛需求量数据表
CREATE TABLE os_ic_demand
(
  organization_id    NUMBER,
  item_id            NUMBER,
  item_no            VARCHAR2(32 BYTE),
  demand_level       NUMBER,
  level_desc         VARCHAR2(240 BYTE),
  demand_date        DATE,
  demand_qty         NUMBER,
  model_id           NUMBER,
  model_no           VARCHAR2(32 BYTE),
  model_customer_id  NUMBER,
  model_customer     VARCHAR2(240 BYTE),
  model_demand_date  DATE,
  model_demand_qty   NUMBER,
  item_usage         NUMBER,
  scrap_rate         NUMBER,
  leadtime           NUMBER,
  mpq                NUMBER,
  attribute1         VARCHAR2(240 BYTE),
  attribute2         VARCHAR2(240 BYTE),
  attribute3         VARCHAR2(240 BYTE),
  model_vendor_id    NUMBER
)


--IC毛需求量来源表
CREATE TABLE os_ic_demand_temp
(
  organization_id    NUMBER,
  item_id            NUMBER,
  item_no            VARCHAR2(32 BYTE),
  demand_level       NUMBER,
  level_desc         VARCHAR2(240 BYTE),
  demand_date        DATE,
  demand_qty         NUMBER,
  model_id           NUMBER,
  model_no           VARCHAR2(32 BYTE),
  model_customer_id  NUMBER,
  model_customer     VARCHAR2(240 BYTE),
  model_demand_date  DATE,
  model_demand_qty   NUMBER,
  item_usage         NUMBER,
  scrap_rate         NUMBER,
  leadtime           NUMBER,
  mpq                NUMBER,
  attribute1         VARCHAR2(240 BYTE),
  attribute2         VARCHAR2(240 BYTE),
  attribute3         VARCHAR2(240 BYTE),
  model_vendor_id    NUMBER
)


--销售订单列表
CREATE TABLE vttpc.os_ic_so_list
(
  batch_id          NUMBER,
  so_level          NUMBER,
  org_id            NUMBER,
  item_id           NUMBER,
  item_no           VARCHAR2(32 BYTE),
  so_header_id      NUMBER,
  so_no             NUMBER,
  so_line_id        NUMBER,
  so_line           VARCHAR2(32 BYTE),
  ship_date         DATE,
  so_qty            NUMBER,
  customer_id       NUMBER,
  customer          VARCHAR2(240 BYTE),
  so_status         VARCHAR2(32 BYTE),
  cutoff_date       DATE,
  rcv_id            NUMBER,
  attribute1        VARCHAR2(240 BYTE),
  attribute2        VARCHAR2(240 BYTE),
  creation_date     DATE,
  created_by        NUMBER,
  last_update_date  DATE,
  last_updated_by   NUMBER
)

--销售订单IC列表
CREATE TABLE vttpc.os_ic_so
(
  batch_id          NUMBER,
  so_level          NUMBER,
  so_level_desc     VARCHAR2(240 BYTE),
  org_id            NUMBER,
  item_id           NUMBER,
  item_no           VARCHAR2(32 BYTE),
  so_header_id      NUMBER,
  so_no             NUMBER,
  so_line_id        NUMBER,
  so_line           VARCHAR2(32 BYTE),
  ship_date         DATE,
  so_qty            NUMBER,
  customer_id       NUMBER,
  customer          VARCHAR2(240 BYTE),
  so_status         VARCHAR2(32 BYTE),
  cutoff_date       DATE,
  rcv_id            NUMBER,
  attribute1        VARCHAR2(240 BYTE),
  attribute2        VARCHAR2(240 BYTE),
  creation_date     DATE,
  created_by        NUMBER,
  last_update_date  DATE,
  last_updated_by   NUMBER
)

--销售订单临时数据表
CREATE TABLE vttpc.os_ic_so_temp
(
  batch_id          NUMBER,
  so_level          NUMBER,
  so_level_desc     VARCHAR2(240 BYTE),
  org_id            NUMBER,
  item_id           NUMBER,
  item_no           VARCHAR2(32 BYTE),
  so_header_id      NUMBER,
  so_no             NUMBER,
  so_line_id        NUMBER,
  so_line           VARCHAR2(32 BYTE),
  ship_date         DATE,
  so_qty            NUMBER,
  customer_id       NUMBER,
  customer          VARCHAR2(240 BYTE),
  so_status         VARCHAR2(32 BYTE),
  cutoff_date       DATE,
  rcv_id            NUMBER,
  attribute1        VARCHAR2(240 BYTE),
  attribute2        VARCHAR2(240 BYTE),
  creation_date     DATE,
  created_by        NUMBER,
  last_update_date  DATE,
  last_updated_by   NUMBER
)