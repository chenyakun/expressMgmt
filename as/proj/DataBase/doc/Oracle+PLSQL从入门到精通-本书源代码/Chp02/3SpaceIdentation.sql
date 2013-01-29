--3空格缩进法则
CREATE OR REPLACE PROCEDURE set_salary(in_empno IN emp.empno%TYPE) 
IS 
   CURSOR c_emp(cp_empno emp.empno%TYPE)     --声明游标
   IS 
        SELECT ename 
              ,sal 
          FROM emp 
         WHERE empno = cp_empno 
      ORDER BY ename; 
   -- 
   r_emp          c_emp%ROWTYPE;            --定义员工记录变量
   l_new_sal      emp.sal%TYPE;             --定义员工薪资记录
BEGIN 
   OPEN c_emp(in_empno);                    --打开游标
   FETCH c_emp INTO r_emp;                  --提取游标记录
   l_new_sal:=GetAddSalaryRatio(c_emp.job);
   CLOSE c_emp;                             --关闭游标
   IF r_emp.sal <> l_new_sal                --如果新工资与现有工资不等
   THEN 
      UPDATE emp                            --更新员工现有工资
         SET sal = l_new_sal 
       WHERE empno = in_empno; 
   END IF; 
END set_salary; 