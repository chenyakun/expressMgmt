SELECT * FROM employees;
/* Formatted on 2011/09/12 10:17 (Formatter Plus v4.8.8) */
SELECT INITCAP (first_name || ' ' || last_name) AS ����,
       LOWER (email) �����ʼ�, UPPER (first_name) ��
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
SELECT CONCAT (first_name, last_name) ����, LENGTH (email) �ʼ�����,
       INSTR (first_name, 'a') "'a'��һ�γ��ֵ�λ��"
  FROM employees WHERE SUBSTR(job_id, 4) = 'CLERK' AND ROWNUM<=5;
  
  
  
DECLARE
   v_str VARCHAR2(20):='Thisisastring';   
BEGIN
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,5,2)��'||SUBSTR(v_str,5,2));
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,-5,2)��'||SUBSTR(v_str,-5,2)); 
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,5,-2)��'||SUBSTR(v_str,5,-2));      
   DBMS_OUTPUT.PUT_LINE('SUBSTR(v_str,5.23,2.34)��'||SUBSTR(v_str,5.23,2.43));        
END;   
     
/* Formatted on 2011/09/12 15:19 (Formatter Plus v4.8.8) */
DECLARE
   v_str   VARCHAR (50) := 'This is oracle database';
BEGIN
   DBMS_OUTPUT.put_line (   'REPLACE(v_str,''oracle'',''sqlserver'')��'
                         || REPLACE (v_str, 'oracle', 'sqlserver')
                        );
   DBMS_OUTPUT.put_line (   'REPLACE(v_str,''oracle'')��'
                         || REPLACE (v_str, 'oracle')
                        );
   DBMS_OUTPUT.put_line (   'TRANSLATE(v_str,''is'',''*'')��'
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
SELECT SYSDATE - 1 ��ǰ���ڼ�1, SYSDATE - (SYSDATE - 100) �����������,
       SYSDATE + 5 / 24 ��ǰ���ڼ�5Сʱ
  FROM DUAL;
SELECT SYSDATE-(SYSDATE-100) FROM DUAL;



/* Formatted on 2011/09/12 17:04 (Formatter Plus v4.8.8) */
BEGIN
   DBMS_OUTPUT.put_line (   '��������֮��Ĳ����·ݣ�'
                         || MONTHS_BETWEEN ('1995-01-01', '1994-11-01')
                        );
   DBMS_OUTPUT.put_line ('��ָ����������·ݣ�' || ADD_MONTHS (SYSDATE, 6));
   DBMS_OUTPUT.put_line ('�¸�������Ϊ��' || NEXT_DAY (SYSDATE, '������'));
   DBMS_OUTPUT.put_line ('��ʾ��ǰ�µ����1�죺' || LAST_DAY (SYSDATE));
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

SELECT TO_CHAR(SYSDATE,'A.D.YYYY"��"-MONTH-DD"��"-DAY') FROM DUAL;

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
SELECT last_name Ӣ����, salary н��, NVL (commission_pct, 0) ��ɱ���,
       (salary * 12) + (salary * 12 * NVL (commission_pct, 0)) ���нˮ
  FROM employees


SELECT last_name Ӣ����, salary н��, commission_pct ���,
       NVL2 (commission_pct, salary * 12 * commission_pct,
             salary * 12) ����
  FROM employees
 WHERE department_id IN (50, 80);
 
 
SELECT NULLIF(commission_pct,0) FROM employees ;

/* Formatted on 2011/09/14 06:11 (Formatter Plus v4.8.8) */
SELECT empno, ename, NVL (NULLIF (job, '������Ա'), 'ҵ����Ա') job
  FROM emp
 WHERE deptno = 20;
 
 
 
 SELECT * FROM emp;
 
 
 /* Formatted on 2011/09/14 06:23 (Formatter Plus v4.8.8) */
SELECT empno, ename, COALESCE (mgr, deptno, empno) Ա��
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
               'ְԱ', 1.15 * sal,
               '������Ա', 1.20 * sal,
               '����', 2.0 * sal,
               '������Ա', 1.12 * sal,
               sal
              ) ��н��
  FROM emp
 WHERE ROWNUM < 12;
 
 
 
/* Formatted on 2011/09/14 09:48 (Formatter Plus v4.8.8) */
SELECT   ename, deptno, sal, SUM (sal) OVER (ORDER BY deptno, ename) �����ܼ�,
         SUM (sal) OVER (PARTITION BY deptno ORDER BY ename) �ֲ��������ܼ�,
         ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY ename) ����
    FROM emp
   WHERE deptno IN (10, 20)
ORDER BY deptno, ename;

SELECT   ename, deptno, sal, SUM (sal) OVER (ORDER BY ename) �����ܼ�     
    FROM emp
   WHERE deptno IN (10, 20)
ORDER BY deptno, ename;


SELECT   o.deptno, o.job, SUM (o.sal) ����ְ������,
         SUM (SUM (o.sal)) OVER (PARTITION BY o.deptno ORDER BY o.job) ����н�������ܼ�
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



SELECT   o.deptno, o.job, SUM (o.sal) ����ְ������,
         RANK() OVER (ORDER BY SUM(o.sal) DESC) н�ʵȼ�,
         DENSE_RANK() OVER (ORDER BY SUM(o.sal) DESC) DENSE_RANK����,   
         ROW_NUMBER() OVER (PARTITION BY o.deptno ORDER BY SUM(o.sal) DESC ) �����к�,               
         SUM (SUM (o.sal)) OVER (PARTITION BY o.deptno ORDER BY o.job) ����н�������ܼ�
    FROM emp o
   WHERE deptno IN (10, 20, 30) AND job IS NOT NULL
GROUP BY o.deptno, o.job



/* Formatted on 2011/09/14 17:19 (Formatter Plus v4.8.8) */
SELECT deptno, empno, ename,job,
       ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY empno) �����к�
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
SELECT   deptno, SUM (sal) ����н��С��,
         SUM (SUM (sal)) OVER (ORDER BY deptno ROWS BETWEEN UNBOUNDED 
                               PRECEDING AND UNBOUNDED FOLLOWING) �����ܼ�
         FROM emp GROUP BY deptno;
  


/* Formatted on 2011/09/14 21:23 (Formatter Plus v4.8.8) */
SELECT empno, ename,
       COUNT (*) OVER (PARTITION BY deptno ORDER BY empno) ����С��
  FROM emp;
  
/* Formatted on 2011/09/14 21:30 (Formatter Plus v4.8.8) */
SELECT empno, ename, sal,
       COUNT (*) OVER (ORDER BY sal RANGE BETWEEN
                       50 PRECEDING AND 150 FOLLOWING) нˮ�������
  FROM emp
  
  
/* Formatted on 2011/09/14 21:43 (Formatter Plus v4.8.8) */
SELECT deptno, empno, ename, sal,
       AVG (sal) OVER (PARTITION BY deptno ORDER BY deptno) avg_sal
  FROM emp;
  
  
SELECT deptno,empno,ename,hiredate,sal,MIN(sal) OVER(PARTITION BY deptno 
                                                     ORDER BY hiredate 
                                                     RANGE UNBOUNDED PRECEDING) ���нˮ,
                                       MAX(sal) OVER(PARTITION BY deptno
                                                     ORDER BY hiredate 
                                                     RANGE UNBOUNDED PRECEDING) ���нˮ
FROM emp;  

SELECT deptno,ename,sal,mgr,
       RANK() OVER(ORDER BY deptno) RANK���,
       DENSE_RANK() OVER(ORDER BY deptno) DENSE_RANK���,
       ROW_NUMBER() OVER(ORDER BY deptno) ROW_NUMBER���       
FROM emp
WHERE deptno IN (10,20,30) AND mgr IS NOT NULL
ORDER BY DEPTNO;


SELECT deptno,
       MIN(sal) KEEP(DENSE_RANK FIRST ORDER BY comm) ������нˮ,
       MAX(sal) KEEP(DENSE_RANK LAST ORDER BY comm) ������нˮ
FROM emp WHERE deptno IN (10,20,30)
GROUP BY deptno;


SELECT deptno,empno,sal,
       FIRST_VALUE(sal) OVER(PARTITION BY deptno order by empno) "��һ��ֵ",
       LAST_VALUE(sal) OVER(PARTITION BY deptno order by empno) "���һ��ֵ"
FROM emp WHERE deptno IN (10,20);




SELECT ename,hiredate,sal,deptno,
       LAG(sal,1,0) OVER(ORDER BY hiredate) AS ǰһ����Աнˮ,
       LEAD(sal,1,0) OVER(ORDER BY hiredate) AS ��һ����Աнˮ
FROM emp WHERE  deptno=30;



/* Formatted on 2011/09/22 15:51 (Formatter Plus v4.8.8) */
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                            DESC NULLS LAST) н������_����,
         DENSE_RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                                   DESC NULLS LAST) н������_ͬ��ͬ��,
         ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                                   DESC NULLS LAST) н������_������
    FROM emp
GROUP BY deptno, empno, ename



      
      
DELETE FROM EMP WHERE SAL IS NULL;

SELECT * FROM EMP ORDER BY SAL

SELECT deptno,MIN(SAL),MAX(SAL) FROM EMP GROUP BY deptno;
      
/* Formatted on 2011/09/22 17:18 (Formatter Plus v4.8.8) */
SELECT   MIN (empno)KEEP (DENSE_RANK FIRST 
               ORDER BY SUM (sal) DESC NULLS LAST)  н��������λ,
         MIN (empno)KEEP (DENSE_RANK LAST 
               ORDER BY SUM (sal) DESC NULLS LAST)  н������βλ
    FROM emp
   WHERE sal IS NOT NULL AND deptno IS NOT NULL
GROUP BY empno;  



SELECT deptno,empno,ename,dept_sales,н������ FROM
(
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                            DESC NULLS LAST) н������
    FROM emp WHERE deptno IS NOT NULL
GROUP BY deptno, empno, ename
) WHERE н������<=2;


SELECT deptno,empno,ename,dept_sales,н������ FROM
(
SELECT   deptno, empno, ename, SUM (sal) dept_sales,
         RANK () OVER (PARTITION BY deptno ORDER BY SUM (sal) 
                                             NULLS LAST) н������
    FROM emp WHERE deptno IS NOT NULL
GROUP BY deptno, empno, ename
) WHERE н������<=2;

   

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
                                                     "ǰ10����ְԱ�����н��",
       MAX (sal) OVER (ORDER BY hiredate ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
                                                     "��10����ְԱ�����н��"                                                     
  FROM emp
 WHERE deptno IN (10,20,30) AND sal IS NOT NULL;


SELECT ename, hiredate, deptno, sal, sal - prev_sal "��ǰ��Ĳ���",
       sal - next_sal "�����Ĳ���"
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
SELECT   MAX (DECODE (job, 'ְԱ', ename, NULL)) "ְԱ����",
         MAX (DECODE (job, 'ְԱ', empno, NULL)) "ְԱ���",
         MAX (DECODE (job, '������Ա', ename, NULL)) "������Ա����",
         MAX (DECODE (job, '������Ա', empno, NULL)) "������Ա���",         
         MAX (DECODE (job, '����', ename, NULL)) "��������",
         MAX (DECODE (job, '����', empno, NULL)) "������",                  
         MAX (DECODE (job, '�ϰ�', ename, NULL)) "�ϰ�����",
         MAX (DECODE (job, '�ϰ�', empno, NULL)) "�ϰ���",         
         MAX (DECODE (job, '������Ա', ename, NULL)) "������Ա����",
         MAX (DECODE (job, '������Ա', empno, NULL)) "������Ա���"         
    FROM (SELECT job,empno, ename,
                 ROW_NUMBER () OVER (PARTITION BY job ORDER BY ename) rn
            FROM emp
           WHERE job IS NOT NULL) x
GROUP BY rn;


SELECT   MAX (DECODE (job, 'ְԱ', ename, NULL)) "ְԱ����",
         MAX (DECODE (job, '������Ա', ename, NULL)) "������Ա����",         
         MAX (DECODE (job, '����', ename, NULL)) "��������",              
         MAX (DECODE (job, '�ϰ�', ename, NULL)) "�ϰ�����",         
         MAX (DECODE (job, '������Ա', ename, NULL)) "������Ա����"         
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
   jobname   VARCHAR (20);     --ְλ��
   ename     VARCHAR2 (20);    --Ա����
   empno     NUMBER;           --Ա�����
   rn        INT;              --����
BEGIN
   --���α�
   OPEN empcur FOR
      SELECT job, empno, ename,
             ROW_NUMBER () OVER (PARTITION BY job ORDER BY ename) rn
        FROM emp
       WHERE job IS NOT NULL;
   --ѭ����ȡ�α�����
   LOOP
      EXIT WHEN empcur%NOTFOUND;
      FETCH empcur
       INTO jobname, empno, ename, rn;
       --����α�����
      DBMS_OUTPUT.put_line (jobname || '   ' || empno || '   ' || ename || '   '|| rn);
   END LOOP;
END;
