CREATE TABLE emp_index AS SELECT * FROM emp;


SELECT ROWIDTOCHAR(rowid) rowid_char,x.* from emp x;
/* Formatted on 2011/08/27 08:49 (Formatter Plus v4.8.8) */
SELECT *
  FROM emp_index;
CREATE INDEX idx_emp_ename ON emp_index(ename);


/* Formatted on 2011/08/27 11:14 (Formatter Plus v4.8.8) */
CREATE INDEX idx_emp_empnoname ON emp_index(ename,empno);  --B������
CREATE INDEX idx_emp_job ON emp_index(job);                --B������
CREATE BITMAP INDEX idx_emp_job_bitmap ON emp_index(job);  --λͼ����
CREATE INDEX idx_emp_name ON emp(UPPER(ename));            --��������