/* Formatted on 2011/11/08 05:03 (Formatter Plus v4.8.8) */
DECLARE
   TYPE test_tbl_type IS TABLE OF PLS_INTEGER
      INDEX BY PLS_INTEGER;                        --��������������
   test_tbl   test_tbl_type;                       --�������������͵ı���
   --������Ƕ�ӳ�����IN OUT������ʹ��NOCOPY��ʾ�������ô���
   PROCEDURE TEST (arg_cnt IN PLS_INTEGER, arg_tbl IN OUT NOCOPY test_tbl_type)
   IS
   BEGIN
      FOR cnt_test IN test_tbl.FIRST .. arg_tbl.LAST         --����ѭ��������
      LOOP
         arg_tbl (cnt_test) := arg_tbl (cnt_test) + arg_cnt; --Ϊ��ʽ������ֵ
      END LOOP;
   END;
BEGIN
   FOR cnt IN 0 .. 10000                                      
   LOOP
      test_tbl (cnt) := cnt;      --��ʼһ���ϴ��������
   END LOOP;
   FOR cnt IN 0 .. 10000
   LOOP
      TEST (cnt, test_tbl);       --��10000�ε��ú�����������������
   END LOOP;
END;
/



/* Formatted on 2011/11/08 05:56 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emp_tbl_type IS TABLE OF emp%ROWTYPE
      INDEX BY PLS_INTEGER;        --��������������
   emp_tbl   emp_tbl_type;         --�������������
   CURSOR emp_cur
   IS
      SELECT *
        FROM emp;                  --�����Ա�����ϵ��α�
BEGIN
   OPEN emp_cur;                   --���α�
   FETCH emp_cur
   BULK COLLECT INTO emp_tbl;      --������ȡ�α�����
   CLOSE emp_cur;                  --�ر��α�
END;
/


/* Formatted on 2011/11/08 06:42 (Formatter Plus v4.8.8) */
CREATE TABLE pro_tst_table (a INT);        --�������Ա�
CREATE OR REPLACE PROCEDURE sp_test        --�������Թ���
AS
BEGIN
   FOR i IN 1 .. 10000
   LOOP
      INSERT INTO pro_tst_table            --����в���10000�м�¼
           VALUES (i);
   END LOOP;
   COMMIT;
END;
/

TRUNCATE TABLE pro_tst_table;

DECLARE
   v_run_number   integer;            --����PROFILER�����к���
BEGIN
   --����PROFILER
   DBMS_PROFILER.start_profiler (run_number => v_run_number);
   --��ʾ��ǰ���ٵ��������(�����ѯҪ��)
   DBMS_OUTPUT.put_line ('run_number:' || v_run_number);
   --����Ҫ���ٵ�PLSQL
   sp_test;
   --ֹͣprofiler
   DBMS_PROFILER.stop_profiler;
END;
/


/* Formatted on 2011/11/08 07:02 (Formatter Plus v4.8.8) */
SELECT runid, run_owner, run_date, run_total_time
  FROM plsql_profiler_runs;


/* Formatted on 2011/11/08 07:06 (Formatter Plus v4.8.8) */
SELECT unit_number, unit_type, unit_owner, unit_name, unit_timestamp,
       total_time
  FROM plsql_profiler_units
 WHERE runid = 3 AND unit_name = 'SP_TEST';
 
 
/* Formatted on 2011/11/08 07:09 (Formatter Plus v4.8.8) */
SELECT runid, unit_number, line#, total_occur, total_time, min_time, max_time
  FROM plsql_profiler_data
 WHERE runid = 3 AND unit_number = 2;


/* Formatted on 2011/11/08 20:29 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PUBLIC SYNONYM plsql_trace_runs FOR SYS.plsql_trace_runs;
CREATE OR REPLACE PUBLIC SYNONYM plsql_trace_events FOR SYS.plsql_trace_events;
CREATE OR REPLACE PUBLIC SYNONYM plsql_trace_runnumber FOR SYS.plsql_trace_runnumber;
GRANT SELECT,INSERT,UPDATE,DELETE ON plsql_trace_events TO PUBLIC;
GRANT SELECT,INSERT,UPDATE,DELETE ON plsql_trace_runs TO PUBLIC;
GRANT SELECT ON plsql_trace_runnumber TO PUBLIC;

/* Formatted on 2011/11/08 21:13 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE do_something (p_times IN NUMBER)
AS
   l_dummy   NUMBER;          --����һ�������ۼӵľֲ�����
BEGIN
   FOR i IN 1 .. p_times      --ѭ��p_timesִ���ۼ�
   LOOP
      SELECT l_dummy + 1
        INTO l_dummy
        FROM DUAL;
   END LOOP;
END;
/


/* Formatted on 2011/11/08 21:17 (Formatter Plus v4.8.8) */
DECLARE
   l_result   BINARY_INTEGER;          --���������������
BEGIN
   --�������еĵ���
   DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_calls);
   do_something (100);
   --ֹͣPL/SQL����
   DBMS_TRACE.clear_plsql_trace;
   --�������е�SQL���
   DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_sql);
   do_something (100);
   --ֹͣ����
   DBMS_TRACE.clear_plsql_trace;
   --��������������
   DBMS_TRACE.set_plsql_trace (DBMS_TRACE.trace_all_lines);
   do_something (100);
   --ֹͣ����
   DBMS_TRACE.clear_plsql_trace;
END;
/


SELECT r.runid,
       TO_CHAR(r.run_date, 'DD-MON-YYYY HH24:MI:SS') AS run_date,
       r.run_owner
FROM   plsql_trace_runs r
ORDER BY r.runid;


SELECT e.runid,
       e.event_seq,
       TO_CHAR(e.event_time, 'DD-MON-YYYY HH24:MI:SS') AS event_time,
       e.event_unit_owner,
       e.event_unit,
       e.event_unit_kind,
       e.proc_line,
       e.event_comment
FROM   plsql_trace_events e
WHERE  e.runid = 1
ORDER BY e.runid, e.event_seq;



SELECT empno FROM emp;





SELECT a.empno, a.ename, c.deptno, c.dname, a.log_action, b.sal
  FROM emp b, dept c, emp_log a
 WHERE a.deptno = b.deptno
 AND a.empno=b.empno 
 AND c.deptno IN (20, 30)



 SELECT a.empno, a.ename, c.deptno, c.dname, a.log_action, a.mgr
  FROM emp b, dept c, emp_log a
 WHERE c.deptno IN (20, 30)
 AND  a.deptno = b.deptno
 
 TOAD_PLAN_TABLE
 
 
 SELECT ename,deptno FROM emp WHERE empno=7369 
 
 SELECT empno,ename,deptno FROM emp WHERE deptno=20;
 
 
 SELECT * FROM emp
 
 

 
SELECT COUNT(*),SUM(sal) FROM��emp WHERE deptno = 20
UNION
SELECT COUNT(*),SUM(sal) FROM��emp WHERE deptno =30


/* Formatted on 2011/11/10 09:40 (Formatter Plus v4.8.8) */
SELECT COUNT (DECODE (deptno, 20, 'X', NULL)) dept20_count,
       COUNT (DECODE (deptno, 30, 'X', NULL)) dept30_count,
       SUM (DECODE (deptno, 20, sal, NULL)) dept20_sal,
       SUM (DECODE (deptno, 30, sal, NULL)) dept30_sal
  FROM emp;




SELECT CEIL(100/3) FROM dual;
SELECT FLOOR(100/3) FROM dual;
SELECT TRUNC(100/3) FROM dual;




SELECT   empno, deptno, SUM (sal)
    FROM emp
   WHERE deptno IN (20, 30)
GROUP BY empno, deptno
  HAVING SUM (sal) > 1000
����

SELECT * FROM emp

SELECT empno,deptno FROM emp WHERE empno >=7500 OR deptno=20;


/* Formatted on 2011/11/10 11:15 (Formatter Plus v4.8.8) */
SELECT empno, ename, job, sal
  FROM emp
 WHERE empno > 7500 OR ename LIKE 'S%';


SELECT empno, ename, job, sal
  FROM emp
 WHERE empno > 7500
UNION
SELECT empno, ename, job, sal
  FROM emp
 WHERE ename LIKE 'S%';
 
 
 
 SELECT empno, ename, job, sal
  FROM emp
 WHERE deptno=20 OR deptno=30;
 
 
  SELECT empno, ename, job, sal
  FROM emp
 WHERE deptno IN (20,30);


SELECT * FROM dept;



/* Formatted on 2011/11/10 12:19 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp
 WHERE deptno IN (SELECT deptno
                    FROM dept
                   WHERE loc = 'CHICAGO');
                   
                   
/* Formatted on 2011/11/10 13:43 (Formatter Plus v4.8.8) */
SELECT a.*
  FROM emp a
 WHERE NOT EXISTS (SELECT 1
                     FROM dept b
                    WHERE a.deptno = b.deptno AND loc = 'CHICAGO');   
                   

SELECT *
  FROM emp
 WHERE deptno NOT IN (SELECT deptno
                    FROM dept
                   WHERE loc = 'CHICAGO');      
                   
                   
/* Formatted on 2011/11/10 13:35 (Formatter Plus v4.8.8) */
SELECT a.*
  FROM emp a, dept b
 WHERE a.deptno = b.deptno AND b.loc <> 'CHICAGO';      
 
 
 

/* Formatted on 2011/11/10 16:28 (Formatter Plus v4.8.8) */
DECLARE
   v_sal   NUMBER        := &sal;                 --ʹ�ð󶨱�������н��ֵ
   v_job   VARCHAR2 (20) := &job;                 --ʹ�ð󶨱�������jobֵ
BEGIN
   IF (v_sal > 5000) OR (v_job = '����')          --�ж�ִ������
   THEN
      DBMS_OUTPUT.put_line ('����ƥ���OR����');
   END IF;
END;                               



DECLARE
   v_sal   NUMBER        := &sal;                 --ʹ�ð󶨱�������н��ֵ
   v_job   VARCHAR2 (20) := &job;                 --ʹ�ð󶨱�������jobֵ
BEGIN
   IF (Check_Sal(v_sal) > 5000) AND (v_job = '����')          --�ж�ִ������
   THEN
      DBMS_OUTPUT.put_line ('����ƥ���AND����');
   END IF;
END;           


DECLARE
   v_sal   NUMBER        := &sal;                     --ʹ�ð󶨱�������н��ֵ
   v_job   VARCHAR2 (20) := &job;                     --ʹ�ð󶨱�������jobֵ
BEGIN
   IF (v_job = '����') AND (Check_Sal(v_sal) > 5000)  --�ж�ִ������
   THEN
      DBMS_OUTPUT.put_line ('����ƥ���AND����');
   END IF;
END;                        
