--IC芯片欠料计划包规范
CREATE OR REPLACE PACKAGE plsql_ic_planning_study
AS
/******************************************************************************
   包名:       plsql_ic_planning_study
   功能:       计算A公司的IC芯片欠料程序
   修订历史：   
   版本       日期          作者               描述
   ---------  ----------  ---------------  ------------------------------------
   1.0        11/08/2011  PL/SQL从入门表精通  1. 初始包创建
******************************************************************************/
   PROCEDURE init;        --对批次号和初始日期进行初始化           
   FUNCTION get_batch     --获取当前批次号
      RETURN NUMBER;
   FUNCTION check_ic_item (p_item IN VARCHAR2)  --检查IC编号
      RETURN NUMBER;
   PROCEDURE gen_ic_demand;   --生产IC的需求量
   PROCEDURE actual_ship (    --计算指定日期之间的实际走货日期
      p_date_cut   IN   DATE,
      p_date_to    IN   DATE DEFAULT SYSDATE
   );
   PROCEDURE openning_so;     --计算当前已开出的销售订单列表
   PROCEDURE shortage_cal;    --计算IC薪片欠料主程序
   PROCEDURE ic_cd_main (p_recal IN NUMBER DEFAULT 0);--在计算完成后，重新生成新的截断快照
   PROCEDURE data_pre_main (p_date IN DATE); --包主程序，供外部进行调用
END plsql_ic_planning_study;
/




