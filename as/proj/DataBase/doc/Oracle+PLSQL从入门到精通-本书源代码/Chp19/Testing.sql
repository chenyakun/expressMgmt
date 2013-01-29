begin
  -- 调用包中的存储过程
  plsql_ic_planning_study.data_pre_main(SYSDATE);
  COMMIT;
end;


/* Formatted on 2011/11/13 16:48 (Formatter Plus v4.8.8) */
SELECT   batch_id, cutoff_date, remarks,
         TO_CHAR (creation_date, 'YYYY-MM-DD') creationdate
    FROM ic_vendor_stock
   WHERE remarks IS NOT NULL
ORDER BY creation_date DESC;


SELECT * FROM ic_vendor_stock;


/* Formatted on 2011/11/13 17:04 (Formatter Plus v4.8.8) */
DECLARE
   x   NUMBER;                      --用于获取作业编号
BEGIN
   SYS.DBMS_JOB.submit            --提交作业信息
      (job            => x,
       what           => 'SCOTT.PLSQL_IC_PLANNING_STUDY.DATA_PRE_MAIN
  (SYSDATE /* DATE */  );',
       next_date      => TO_DATE ('11-13-2011 17:03:24',
                                  'mm/dd/yyyy hh24:mi:ss'
                                 ),
       INTERVAL       => 'TRUNC(SYSDATE+7)',
       no_parse       => FALSE
      );
   :jobnumber := TO_CHAR (x);        --返回作业编号
END;