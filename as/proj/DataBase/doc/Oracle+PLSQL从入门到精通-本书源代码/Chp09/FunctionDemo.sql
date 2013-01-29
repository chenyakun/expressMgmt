SELECT * FROM employees;
/* Formatted on 2011/09/12 10:17 (Formatter Plus v4.8.8) */
SELECT INITCAP (first_name || ' ' || last_name) AS 姓名,
       LOWER (email) 电子邮件, UPPER (first_name) 姓
  FROM employees WHERE ROWNUM<=5;
  
  
DECLARE
   v_namelower VARCHAR2(50):='this is lower character';
   v_nameupper VARCHAR2(50):='THIS IS UPPER CHARACTER';
BEGIN
   DBMS_OUTPUT.PUT_LINE(UPPER(v_namelower));
   DBMS_OUTPUT.PUT_LINE(LOWER(v_nameupper));
   DBMS_OUTPUT.PUT_LINE(INITCAP(v_nameupper));   
END;     


/* Formatted on 2011/09/12 10:53 (Formatter Plus v4.8.8) */
SELECT CONCAT (first_name, last_name) 姓名, LENGTH (email) 邮件长度,
       INSTR (first_name, 'a') "'a'第一次出现的位置"
  FROM employees WHERE SUBSTR(job_id, 4) = 'CLERK' AND ROWNUM<=5;
  
  
  
DECLARE
   v_str VARCHAR2(20):='Thisisastring';   
BEGIN
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,5,2)：'||SUBSTR(v_str,5,2));
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,-5,2)：'||SUBSTR(v_str,-5,2)); 
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,5,-2)：'||SUBSTR(v_str,5,-2));      
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,5.23,2.34)：'||SUBSTR(v_str,5.23,2.43));        
END;   
     
/* Formatted on 2011/09/12 15:19 (Formatter Plus v4.8.8) */
DECLARE
   v_str   VARCHAR (50) := 'This is oracle database';
BEGIN
   DBMS_OUTPUT.put_line (   'REPLACE(v_str,''oracle'',''sqlserver'')：'
                         || REPLACE (v_str, 'oracle', 'sqlserver')
                        );
   DBMS_OUTPUT.put_line (   'REPLACE(v_str,''oracle'')：'
                         || REPLACE (v_str, 'oracle')
                        );
   DBMS_OUTPUT.put_line (   'TRANSLATE(v_str,''is'',''*'')：'
                         || TRANSLATE (v_str, 'is', '*')
                        );
END;



/* Formatted on 2011/09/12 15:38 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/12 15:43 (Formatter Plus v4.8.8) */
SELECT ROUND (45.927, 2), ROUND (45.923, 0), ROUND (45.923, -1),
       TRUNC (45.923), TRUNC (45.923, 2), MOD (45, 12)
  FROM DUAL;
  
  
SELECT ROUND(SYSDATE),TRUNC(SYSDATE) FROM DUAL;


SELECT SYSDATE FROM DUAL;
SELECT * FROM employees;

/* Formatted on 2011/09/12 16:23 (Formatter Plus v4.8.8) */
ALTER SESSION SET nls_date_format='yyyy-mm-dd hh24:mi:ss';


/* Formatted on 2011/09/12 16:44 (Formatter Plus v4.8.8) */
SELECT SYSDATE - 1 当前日期减1, SYSDATE - (SYSDATE - 100) 两个日期相减,
       SYSDATE + 5 / 24 当前日期加5小时
  FROM DUAL;
SELECT SYSDATE-(SYSDATE-100) FROM DUAL;



/* Formatted on 2011/09/12 17:04 (Formatter Plus v4.8.8) */
BEGIN
   DBMS_OUTPUT.put_line (   '两个日期之间的差异月份：'
                         || MONTHS_BETWEEN ('1995-01-01', '1994-11-01')
                        );
   DBMS_OUTPUT.put_line ('向指定日期添加月份：' || ADD_MONTHS (SYSDATE, 6));
   DBMS_OUTPUT.put_line ('下个星期五为：' || NEXT_DAY (SYSDATE, '星期五'));
   DBMS_OUTPUT.put_line ('显示当前月的最后1天：' || LAST_DAY (SYSDATE));
END;


/* Formatted on 2011/09/12 17:15 (Formatter Plus v4.8.8) */
SELECT TRUNC (SYSDATE, 'MONTH'), ROUND (SYSDATE, 'YEAR'),
       ROUND (SYSDATE, 'DAY'), TRUNC (SYSDATE, 'YEAR'),
       TRUNC (SYSDATE, 'DAY'), TRUNC (SYSDATE, 'HH24'), TRUNC (SYSDATE, 'MI')
  FROM DUAL;
  
  
  
/* Formatted on 2011/09/13 05:53 (Formatter Plus v4.8.8) */
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS AM')
  FROM DUAL
  
  
  
  
 /* Formatted on 2011/09/13 06:25 (Formatter Plus v4.8.8) */
SELECT TO_CHAR (SYSDATE, 'ddspth') FROM DUAL;

/* Formatted on 2011/09/13 06:26 (Formatter Plus v4.8.8) */
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS AM') FROM DUAL;

/* Formatted on 2011/09/13 06:26 (Formatter Plus v4.8.8) */
SELECT TO_CHAR (SYSDATE, 'DD "of" MONTH') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'A.D.YYYY"年"-MONTH-DD"日"-DAY') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'W') FROM DUAL;







SELECT TO_CHAR(123.45678,'L99999.999') FROM DUAL;


SELECT TO_CHAR(1234,'C9999') FROM DUAL;

/* Formatted on 2011/09/13 20:21 (Formatter Plus v4.8.8) */
SELECT TO_CHAR (123456789, 'L999G999G999D99', 'NLS_CURRENCY=%')
  FROM DUAL;
  
  
/* Formatted on 2011/09/13 20:36 (Formatter Plus v4.8.8) */
SELECT TO_DATE ('2010/09/13', 'YYYY-MM-DD', 'NLS_DATE_LANGUAGE=english')
  FROM DUAL;
  
SELECT TO_DATE ('20100913', 'YYYY-MM-DD')
  FROM DUAL;  
  
  
SELECT TO_NUMBER('$1234.5678','$9999.9999') FROM DUAL;
  
SELECT TO_NUMBER('$123,456,789.00','$999G999G999D99') FROM DUAL;
  
  
SELECT * FROM dept;
  
  
/* Formatted on 2011/09/13 21:57 (Formatter Plus v4.8.8) */
SELECT last_name 英文名, salary 薪资, NVL (commission_pct, 0) 提成比率,
       (salary * 12) + (salary * 12 * NVL (commission_pct, 0)) 年度薪水
  FROM employees


SELECT last_name 英文名, salary 薪资, commission_pct 提成,
       NVL2 (commission_pct, salary * 12 * commission_pct,
             salary * 12) 收入
  FROM employees
 WHERE department_id IN (50, 80);
 
 
SELECT NULLIF(commission_pct,0) FROM employees ;

/* Formatted on 2011/09/14 06:11 (Formatter Plus v4.8.8) */
SELECT empno, ename, NVL (NULLIF (job, '销售人员'), '业务人员') job
  FROM emp
 WHERE deptno = 20;
 
 
 
 SELECT * FROM emp;
 
 
 /* Formatted on 2011/09/14 06:23 (Formatter Plus v4.8.8) */
SELECT empno, ename, COALESCE (mgr, deptno, empno) 员工
  FROM emp
 WHERE empno > 7700 AND ROWNUM < 10;
 
 SELECT last_name, job_id, salary,
DECODE(job_id, 'IT_PROG',  1.10*salary,
'ST_CLERK', 1.15*salary,
'SA_REP',   1.20*salary,
salary)
REVISED_SALARY
FROM   employees;

SELECT * FROM emp;


/* Formatted on 2011/09/14 06:37 (Formatter Plus v4.8.8) */
SELECT empno, ename,
       DECODE (job,
               '职员', 1.15 * sal,
               '销售人员', 1.20 * sal,
               '经理', 2.0 * sal,
               '分析人员', 1.12 * sal,
               sal
              ) 调薪表
  FROM emp
 WHERE ROWNUM < 12;
 
 
 
/* Formatted on 2011/09/14 09:48 (Formatter Plus v4.8.8) */
SELECT   ename, deptno, sal, SUM (sal) OVER (ORDER BY deptno, ename) 运行总计,
         SUM (sal) OVER (PARTITION BY deptno ORDER BY ename) 分部门运行总计,
         ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY ename) 序列
    FROM emp
   WHERE deptno IN (10, 20)
ORDER BY deptno, ename;

SELECT   ename, deptno, sal, SUM (sal) OVER (ORDER BY ename) 运行总计     
    FROM emp
   WHERE deptno IN (10, 20)
ORDER BY deptno, ename;


SELECT   o.deptno, o.job, SUM (o.sal) 部门职级汇总,
         SUM (SUM (o.sal)) OVER (PARTITION BY o.deptno ORDER BY o.job) 部门薪资运行总计
    FROM emp o
   WHERE deptno IN (10, 20, 30) AND job IS NOT NULL
GROUP BY o.deptno, o.job
ORDER BY o.deptno;


--SELECT region_id, cust_nbr, 

--  SUM(tot_sales) cust_sales,

--  RANK(  ) OVER (ORDER BY SUM(tot_sales) DESC) sales_rank,

--  DENSE_RANK(  ) OVER (ORDER BY SUM(tot_sales) DESC) sales_dense_rank,

--  ROW_NUMBER(  ) OVER (ORDER BY SUM(tot_sales) DESC) sales_number

--FROM orders

--WHERE year = 2001

--GROUP BY region_id, cust_nbr

--ORDER BY 6;



SELECT   o.deptno, o.job, SUM (o.sal) 部门职级汇总,
         RANK() OVER (ORDER BY SUM(o.sal) DESC) 薪资等级,
         DENSE_RANK() OVER (ORDER BY SUM(o.sal) DESC) DENSE_RANK排名,   
         ROW_NUMBER() OVER (PARTITION BY o.deptno ORDER BY SUM(o.sal) DESC ) 分组行号,               
         SUM (SUM (o.sal)) OVER (PARTITION BY o.deptno ORDER BY o.job) 部门薪资运行总计
    FROM emp o
   WHERE deptno IN (10, 20, 30) AND job IS NOT NULL
GROUP BY o.deptno, o.job



/* Formatted on 2011/09/14 17:19 (Formatter Plus v4.8.8) */
SELECT deptno, empno, ename,job,
       ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY empno) 分组行号
  FROM emp WHERE deptno IN (10,20,30);
  
  /* Formatted on 2011/09/14 17:31 (Formatter Plus v4.8.8) */
SELECT ename, sal, AVG (sal) OVER ()
  FROM emp WHERE ROWNUM<=3; 
  
SELECT ename, sal, AVG (sal) OVER(ORDER BY ename)
  FROM emp WHERE ROWNUM<=3;  
  
  
--select month,
--           sum(tot_sales) month_sales,
--   3         sum(sum(tot_sales)) over (order by month
--   4            rows between unbounded preceding and unbounded following) total_sales
--   5    from orders
--   6   group by month;

/* Formatted on 2011/09/14 20:53 (Formatter Plus v4.8.8) */
SELECT   deptno, SUM (sal) 部门薪资小计,
         SUM (SUM (sal)) OVER (ORDER BY deptno ROWS BETWEEN UNBOUNDED 
                               PRECEDING AND UNBOUNDED FOLLOWING) 部门总计
         FROM emp GROUP BY deptno;
  


/* Formatted on 2011/09/14 21:23 (Formatter Plus v4.8.8) */
SELECT empno, ename,
       COUNT (*) OVER (PARTITION BY deptno ORDER BY empno) 条数小计
  FROM emp;
  
/* Formatted on 2011/09/14 21:30 (Formatter Plus v4.8.8) */
SELECT empno, ename, sal,
       COUNT (*) OVER (ORDER BY sal RANGE BETWEEN
                       50 PRECEDING AND 150 FOLLOWING) 薪水差异个数
  FROM emp
  
  
/* Formatted on 2011/09/14 21:43 (Formatter Plus v4.8.8) */
SELECT deptno, empno, ename, sal,
       AVG (sal) OVER (PARTITION BY deptno ORDER BY deptno) avg_sal
  FROM emp;
  
  
SELECT deptno,empno,ename,hiredate,sal,MIN(sal) OVER(PARTITION BY deptno 
                                                     ORDER BY hiredate 
                                                     RANGE UNBOUNDED PRECEDING) 最低薪水,
                                       MAX(sal) OVER(PARTITION BY deptno
                                                     ORDER BY hiredate 
                                                     RANGE UNBOUNDED PRECEDING) 最高薪水
FROM emp;  

SELECT deptno,ename,sal,mgr,
       RANK() OVER(ORDER BY deptno) RANK结果,
       DENSE_RANK() OVER(ORDER BY deptno) DENSE_RANK结果,
       ROW_NUMBER() OVER(ORDER BY deptno) ROW_NUMBER结果       
FROM emp
WHERE deptno IN (10,20,30) AND mgr IS NOT NULL
ORDER BY DEPTNO;


SELECT deptno,
       MIN(sal) KEEP(DENSE_RANK FIRST ORDER BY comm) 最低提成薪水,
       MAX(sal) KEEP(DENSE_RANK LAST ORDER BY comm) 最高提成薪水
FROM emp WHERE deptno IN (10,20,30)
GROUP BY deptno;


SELECT deptno,empno,sal,
       FIRST_VALUE(sal) OVER(PARTITION BY deptno order by empno) "第一个值",
       LAST_VALUE(sal) OVER(PARTITION BY deptno order by empno) "最后一个值"
FROM emp WHERE deptno IN (10,20);




SELECT ename,hiredate,sal,deptno,
       LAG(sal,1,0) OVER(ORDER BY hiredate) AS 前一个雇员薪水,
       LEAD(sal,1,0) OVER(ORDER BY hiredate) AS 后一个雇员薪水
FROM emp WHERE  deptno=30;



/* Formatted on 2011/09/22 15:51 (Formatter Plus v4.8.8) */
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                            DESC NULLS LAST) 薪资排名_跳号,
         DENSE_RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                                   DESC NULLS LAST) 薪资排名_同级同号,
         ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                                   DESC NULLS LAST) 薪资排名_不跳号
    FROM emp
GROUP BY deptno, empno, ename



      
      
DELETE FROM EMP WHERE SAL IS NULL;

SELECT * FROM EMP ORDER BY SAL

SELECT deptno,MIN(SAL),MAX(SAL) FROM EMP GROUP BY deptno;
      
/* Formatted on 2011/09/22 17:18 (Formatter Plus v4.8.8) */
SELECT   MIN (empno)KEEP (DENSE_RANK FIRST 
               ORDER BY SUM (sal) DESC NULLS LAST)  薪资排名首位,
         MIN (empno)KEEP (DENSE_RANK LAST 
               ORDER BY SUM (sal) DESC NULLS LAST)  薪资排名尾位
    FROM emp
   WHERE sal IS NOT NULL AND deptno IS NOT NULL
GROUP BY empno;  



SELECT deptno,empno,ename,dept_sales,薪资排名 FROM
(
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                            DESC NULLS LAST) 薪资排名
    FROM emp WHERE deptno IS NOT NULL
GROUP BY deptno, empno, ename
) WHERE 薪资排名<=2;


SELECT deptno,empno,ename,dept_sales,薪资排名 FROM
(
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                             NULLS LAST) 薪资排名
    FROM emp WHERE deptno IS NOT NULL
GROUP BY deptno, empno, ename
) WHERE 薪资排名<=2;

   

/* Formatted on 2011/09/22 21:41 (Formatter Plus v4.8.8) */
SELECT * FROM 
(
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         NTILE (3) OVER (PARTITION BY deptno 
         ORDER BY SUM (sal) NULLS LAST) RANK_RATIO
    FROM emp
   WHERE deptno IS NOT NULL
GROUP BY deptno, empno, ename
) 
WHERE RANK_RATIO=1


SELECT * FROM emp;

select trunc(order_dt) day,
              sum(sale_price) daily_sales,
              avg(sum(sale_price)) over (order by trunc(order_dt)
                       range between interval '2' day preceding 
                                      and interval '2' day following) five_day_avg
    from cust_order
  where sale_price is not null 

--between 1 preceding and unbounded following

/* Formatted on 2011/09/22 22:45 (Formatter Plus v4.8.8) */
SELECT empno, ename, hiredate, sal,
       MAX (sal) OVER (ORDER BY hiredate ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
                                                     "前10天入职员工最高薪资",
       MAX (sal) OVER (ORDER BY hiredate ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
                                                     "后10天入职员工最高薪资"                                                     
  FROM emp
 WHERE deptno IN (10,20,30) AND sal IS NOT NULL;


SELECT ename, hiredate, deptno, sal, sal - prev_sal "与前面的差异",
       sal - next_sal "与后面的差异"
  FROM (SELECT ename, hiredate, sal, deptno,
               LAG (sal, 1, 0) OVER (ORDER BY hiredate) AS prev_sal,
               LEAD (sal, 1, 0) OVER (ORDER BY hiredate) AS next_sal
          FROM emp
         WHERE deptno IS NOT NULL AND SAL IS NOT NULL);
         

/* Formatted on 2011/09/23 09:38 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/23 09:40 (Formatter Plus v4.8.8) */
SELECT *
  FROM (SELECT empno, ename, sal, hiredate,
               ROW_NUMBER () OVER (PARTITION BY EXTRACT
                                   (YEAR FROM hiredate) ORDER BY empno) rn
          FROM emp
         WHERE hiredate IS NOT NULL
           AND EXTRACT (YEAR FROM hiredate) IN (1981, 1982, 1983))
 WHERE rn = 1;
 

SELECT empno, ename, job
  FROM emp
 WHERE ROWNUM < 3;
 
/* Formatted on 2011/09/23 10:05 (Formatter Plus v4.8.8) */
SELECT deptno, ename,
       ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY sal DESC NULLS LAST)
                                                                          seq
  FROM emp
  
  
  
/* Formatted on 2011/09/23 10:26 (Formatter Plus v4.8.8) */
SELECT   MAX (DECODE (job, '职员', ename, NULL)) "职员名称",
         MAX (DECODE (job, '职员', empno, NULL)) "职员编号",
         MAX (DECODE (job, '分析人员', ename, NULL)) "分析人员名称",
         MAX (DECODE (job, '分析人员', empno, NULL)) "分析人员编号",         
         MAX (DECODE (job, '经理', ename, NULL)) "经理名称",
         MAX (DECODE (job, '经理', empno, NULL)) "经理编号",                  
         MAX (DECODE (job, '老板', ename, NULL)) "老板名称",
         MAX (DECODE (job, '老板', empno, NULL)) "老板编号",         
         MAX (DECODE (job, '销售人员', ename, NULL)) "销售人员名称",
         MAX (DECODE (job, '销售人员', empno, NULL)) "销售人员编号"         
    FROM (SELECT job,empno, ename,
                 ROW_NUMBER () OVER (PARTITION BY job ORDER BY ename) rn
            FROM emp
           WHERE job IS NOT NULL) x
GROUP BY rn;


SELECT   MAX (DECODE (job, '职员', ename, NULL)) "职员名称",
         MAX (DECODE (job, '分析人员', ename, NULL)) "分析人员名称",         
         MAX (DECODE (job, '经理', ename, NULL)) "经理名称",              
         MAX (DECODE (job, '老板', ename, NULL)) "老板名称",         
         MAX (DECODE (job, '销售人员', ename, NULL)) "销售人员名称"         
    FROM (SELECT job,empno, ename,
                 ROW_NUMBER () OVER (PARTITION BY job ORDER BY ename) rn
            FROM emp
           WHERE job IS NOT NULL) x
GROUP BY rn;


/* Formatted on 2011/09/23 10:43 (Formatter Plus v4.8.8) */
SELECT job, empno, ename,
       ROW_NUMBER () OVER (PARTITION BY job ORDER BY ename) rn
  FROM emp
 WHERE job IS NOT NULL
 
 


DECLARE
   TYPE refempcur IS REF CURSOR;
   empcur    refempcur;
   jobname   VARCHAR (20);     --职位名
   ename     VARCHAR2 (20);    --员工名
   empno     NUMBER;           --员工编号
   rn        INT;              --排名
BEGIN
   --打开游标
   OPEN empcur FOR
      SELECT job, empno, ename,
             ROW_NUMBER () OVER (PARTITION BY job ORDER BY ename) rn
        FROM emp
       WHERE job IS NOT NULL;
   --循环提取游标内容
   LOOP
      EXIT WHEN empcur%NOTFOUND;
      FETCH empcur
       INTO jobname, empno, ename, rn;
       --输出游标内容
      DBMS_OUTPUT.put_line (jobname || '   ' || empno || '   ' || ename || '   '|| rn);
   END LOOP;
END;
