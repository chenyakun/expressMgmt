--3�ո���������
CREATE OR REPLACE PROCEDURE set_salary(in_empno IN emp.empno%TYPE) 
IS 
   CURSOR c_emp(cp_empno emp.empno%TYPE)     --�����α�
   IS 
        SELECT ename 
              ,sal 
          FROM emp 
         WHERE empno = cp_empno 
      ORDER BY ename; 
   -- 
   r_emp          c_emp%ROWTYPE;            --����Ա����¼����
   l_new_sal      emp.sal%TYPE;             --����Ա��н�ʼ�¼
BEGIN 
   OPEN c_emp(in_empno);                    --���α�
   FETCH c_emp INTO r_emp;                  --��ȡ�α��¼
   l_new_sal:=GetAddSalaryRatio(c_emp.job);
   CLOSE c_emp;                             --�ر��α�
   IF r_emp.sal <> l_new_sal                --����¹��������й��ʲ���
   THEN 
      UPDATE emp                            --����Ա�����й���
         SET sal = l_new_sal 
       WHERE empno = in_empno; 
   END IF; 
END set_salary; 