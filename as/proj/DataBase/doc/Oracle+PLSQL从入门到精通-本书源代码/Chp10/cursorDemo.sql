/* Formatted on 2011/09/23 15:35 (Formatter Plus v4.8.8) */
DECLARE
   emprow   emp%ROWTYPE;     --���屣���α��������еļ�¼����
   CURSOR emp_cur            --�����α�
   IS
      SELECT *
        FROM emp
       WHERE deptno IS NOT NULL;
BEGIN
   OPEN emp_cur;             --���α�
   LOOP                      --ѭ�������α�
      FETCH emp_cur          --��ȡ�α�����
       INTO emprow;
      --������������α��е���Ϣ
      DBMS_OUTPUT.put_line (   'Ա����ţ�'
                            || emprow.empno
                            || ' '
                            || 'Ա�����ƣ�'
                            || emprow.ename
                           );
      EXIT WHEN emp_cur%NOTFOUND;  --���α����ݼ�������˳�ѭ��
   END LOOP;   
   CLOSE emp_cur;           --�ر��α�
END;


SELECT * FROM emp;

/* Formatted on 2011/09/24 13:39 (Formatter Plus v4.8.8) */
BEGIN
   UPDATE emp
      SET comm = comm * 1.12
    WHERE empno = 7369;              --����Ա�����Ϊ7369��Ա����Ϣ       
   --ʹ����ʽ�α������ж��Ѹ��µ�����
   DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' �б�����');
   --���û���κθ���
   IF SQL%NOTFOUND
   THEN
      --��ʾδ���µ���Ϣ
      DBMS_OUTPUT.put_line ('���ܸ���Ա����Ϊ7369��Ա��!');
   END IF;
   --�����ݿ��ύ����
   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);  --��������쳣����ʾ�쳣��Ϣ
END;



/* Formatted on 2011/09/24 14:27 (Formatter Plus v4.8.8) */
DECLARE
   CURSOR emp_cursor      --����һ����ѯemp���в��ű��Ϊ20���α� 
   IS
      SELECT *
        FROM emp
       WHERE deptno = 20;
BEGIN
   NULL;
END;


DECLARE
   v_deptno NUMBER;
   CURSOR emp_cursor      --����һ����ѯemp���в��ű��Ϊ20���α� 
   IS
      SELECT *
        FROM emp
       WHERE deptno = v_deptno;
BEGIN
   v_deptno:=20;
   OPEN emp_cursor;       --���α�
   IF emp_cursor%ISOPEN THEN
      DBMS_OUTPUT.PUT_LINE('�α��Ѿ�����');
   END IF;
END;


/* Formatted on 2011/09/24 15:15 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/24 15:17 (Formatter Plus v4.8.8) */
DECLARE
   CURSOR emp_cursor (p_deptno IN NUMBER)            --�����α겢ָ���α����
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   OPEN emp_cursor (20);
END;



/* Formatted on 2011/09/24 16:06 (Formatter Plus v4.8.8) */
DECLARE
   --�����α겢ָ���α귵��ֵ����
   CURSOR emp_cursor (p_deptno IN NUMBER) RETURN dept%ROWTYPE
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;  
BEGIN
   OPEN emp_cursor (20);   --���α�
END;


DECLARE
   CURSOR emp_cursor (p_deptno IN NUMBER)            --�����α겢ָ���α����
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   IF NOT emp_cursor%ISOPEN THEN                    --����α껹û�б���
     OPEN emp_cursor (20);                          --���α�
   END IF;
   IF emp_cursor%ISOPEN THEN                        --�ж��α�״̬����ʾ״̬��Ϣ
     DBMS_OUTPUT.PUT_LINE('�α��Ѿ����򿪣�');
   ELSE
     DBMS_OUTPUT.PUT_LINE('�α껹û�б��򿪣�');   
   END IF;   
END;


/* Formatted on 2011/09/24 18:37 (Formatter Plus v4.8.8) */
DECLARE
   emp_row   emp%ROWTYPE;                                --�����α�ֵ�洢����
   CURSOR emp_cursor (p_deptno IN NUMBER)            --�����α겢ָ���α����
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   IF NOT emp_cursor%ISOPEN
   THEN                                                --����α껹û�б���
      OPEN emp_cursor (20);                                        --���α�
   END IF;
   IF emp_cursor%FOUND IS NULL                        --��ʹ��FETCH��ȡ�α�����֮ǰ��ֵΪNULL
   THEN
      DBMS_OUTPUT.put_line ('%FOUND����ΪNULL');   --�����ʾ��Ϣ
   END IF;
   LOOP                                               --ѭ����ȡ�α�����
      FETCH emp_cursor  
       INTO emp_row;                                  --ʹ��FETCH�����ȡ�α�����
      --ÿѭ��һ���ж�%FOUND����ֵ�������ֵΪFalse����ʾ��ȡ��ɣ����˳�ѭ����
      EXIT WHEN NOT emp_cursor%FOUND;
   END LOOP;
END;


DECLARE
   emp_row   emp%ROWTYPE;                                --�����α�ֵ�洢����
   CURSOR emp_cursor (p_deptno IN NUMBER)            --�����α겢ָ���α����
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   OPEN emp_cursor (20);                                        --���α�
   IF emp_cursor%NOTFOUND IS NULL                        --��ʹ��FETCH��ȡ�α�����֮ǰ��ֵΪNULL
   THEN
      DBMS_OUTPUT.put_line ('%NOTFOUND����ΪNULL');   --�����ʾ��Ϣ
   END IF;
   LOOP                                               --ѭ����ȡ�α�����
      FETCH emp_cursor  
       INTO emp_row;                                  --ʹ��FETCH�����ȡ�α�����
      --ÿѭ��һ���ж�%FOUND����ֵ�������ֵΪFalse����ʾ��ȡ��ɣ����˳�ѭ����
      EXIT WHEN emp_cursor%NOTFOUND;
   END LOOP;
END;

DECLARE
   emp_row   emp%ROWTYPE;                                --�����α�ֵ�洢����
   CURSOR emp_cursor (p_deptno IN NUMBER)            --�����α겢ָ���α����
   IS
      SELECT *
        FROM emp
       WHERE deptno = p_deptno;
BEGIN
   OPEN emp_cursor (20);                                        --���α�
   LOOP                                               --ѭ����ȡ�α�����
      FETCH emp_cursor  
       INTO emp_row;                                  --ʹ��FETCH�����ȡ�α�����
      --ÿѭ��һ���ж�%FOUND����ֵ�������ֵΪFalse����ʾ��ȡ��ɣ����˳�ѭ����
      EXIT WHEN emp_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('��ǰ����ȡ������Ϊ��'||emp_cursor%ROWCOUNT||' �У�');
   END LOOP;
   CLOSE emp_cursor;
END;


SELECT * FROM dept;

DECLARE
  deptno dept.deptno%TYPE;                   --���屣���α����ݵı���
  dname dept.dname%TYPE;
  loc dept.loc%TYPE;
  dept_row dept%ROWTYPE;                     --�����¼����
  CURSOR dept_cur IS SELECT * FROM dept;     --�����α�
BEGIN
   OPEN dept_cur ;                           --���α�
   LOOP      
      IF dept_cur%ROWCOUNT<=4 THEN           --�ж������ǰ��ȡ���α�С�ڵ���4��
        FETCH dept_cur  INTO dept_row;       --��ȡ�α����ݵ���¼������
        IF dept_cur%FOUND THEN               --���FETCH�����ݣ��������ʾ
        DBMS_OUTPUT.PUT_LINE(dept_row.deptno||' '||dept_row.dname||' '||dept_row.loc);
        END IF;
      ELSE
        FETCH dept_cur INTO deptno,dname,loc;--������ȡ��¼�������б���
        IF dept_cur%FOUND THEN               --�����ȡ�������������ʾ
        DBMS_OUTPUT.PUT_LINE(deptno||' '||dname||' '||loc);
        END IF;        
      END IF;
      EXIT WHEN dept_cur%NOTFOUND;           --�ж��Ƿ���ȡ���
   END LOOP;
   CLOSE dept_cur
END;


/* Formatted on 2011/09/24 21:08 (Formatter Plus v4.8.8) */
/* Formatted on 2011/09/24 21:10 (Formatter Plus v4.8.8) */
DECLARE
   TYPE depttab_type IS TABLE OF dept%ROWTYPE;    --����dept�����͵�Ƕ�ױ�����
   depttab   depttab_type;                        --����Ƕ�ױ����
   CURSOR deptcur IS SELECT * FROM dept;          --�����α�
BEGIN
   OPEN deptcur;
   FETCH deptcur BULK COLLECT INTO depttab;       --ʹ��BULK COLLECT INTO�Ӿ����β���
   CLOSE deptcur;                                 --�ر��α�
   FOR i IN 1 .. depttab.COUNT                    --ѭ��Ƕ�ױ�����е�����
   LOOP
      DBMS_OUTPUT.put_line (   depttab (i).deptno
                            || ' '
                            || depttab (i).dname
                            || ' '
                            || depttab (i).loc
                           );
   END LOOP;
   CLOSE deptcur;                                --�ر��α�
END;



DECLARE
   TYPE depttab_type IS TABLE OF dept%ROWTYPE;    --����dept�����͵�Ƕ�ױ�����
   depttab   depttab_type;                        --����Ƕ�ױ����
   CURSOR deptcur IS SELECT * FROM dept;          --�����α�
BEGIN
   OPEN deptcur;
   FETCH deptcur BULK COLLECT INTO depttab;       --ʹ��BULK COLLECT INTO�Ӿ����β���
   CLOSE deptcur;                                 --�ر��α�
   FOR i IN 1 .. depttab.COUNT                    --ѭ��Ƕ�ױ�����е�����
   LOOP
      DBMS_OUTPUT.put_line (   depttab (i).deptno
                            || ' '
                            || depttab (i).dname
                            || ' '
                            || depttab (i).loc
                           );
   END LOOP;
   CLOSE deptcur;                                --�ر��α�
END;



/* Formatted on 2011/09/25 09:48 (Formatter Plus v4.8.8) */
DECLARE
   TYPE dept_type IS VARRAY (4) OF dept%ROWTYPE;    --����䳤��������
   depttab   dept_type;                             --����䳤�������
   CURSOR dept_cursor                               --�����dept���α�
   IS
      SELECT *
        FROM dept;
   v_rows    INT       := 4;                        --ʹ��LIMIT���Ƶ�����
   v_count   INT       := 0;                        --�����α���ȡ��������
BEGIN
   OPEN dept_cursor;                                --���α�
   LOOP                                             --ѭ����ȡ�α�
      --ÿ����ȡ4�����ݵ��䳤������
      FETCH dept_cursor BULK COLLECT INTO depttab LIMIT v_rows;
      EXIT WHEN dept_cursor%NOTFOUND;               --û���α�����ʱ�˳�   
      DBMS_OUTPUT.put('�������ƣ�');             --�����������
      --ѭ����ȡ�䳤�������ݣ���Ϊ�䳤����ֻ�ܴ��4��Ԫ�أ���˲���Խ���ȡ
      FOR i IN 1 .. (dept_cursor%ROWCOUNT - v_count) 
      LOOP
         DBMS_OUTPUT.put (depttab (i).dname || ' '); --�����������
      END LOOP;
      DBMS_OUTPUT.new_line;                      --�������
      v_count := dept_cursor%ROWCOUNT;              --Ϊv_count���µ�ֵ
   END LOOP;
   CLOSE dept_cursor;                               --�ر��α�
END;



DECLARE
   dept_row dept%ROWTYPE;                      --�����α�����¼����
   CURSOR dept_cursor IS SELECT * FROM dept;   --�����α����
BEGIN 
   OPEN dept_cursor;                           --���α�
   LOOP                                        --��ѭ��
      FETCH dept_cursor INTO dept_row;         --��ȡ�α�����
      EXIT WHEN dept_cursor%NOTFOUND;          --�˳�ѭ���Ŀ������
      DBMS_OUTPUT.PUT_LINE('�������ƣ�'||dept_row.dname);
   END LOOP;
   CLOSE dept_cursor;                          --�ر��α�
END;   


DECLARE
   dept_row dept%ROWTYPE;                      --�����α�����¼����
   CURSOR dept_cursor IS SELECT * FROM dept;   --�����α����
BEGIN 
   OPEN dept_cursor;                           --���α�
   FETCH dept_cursor INTO dept_row;            --��ȡ�α�����   
   WHILE dept_cursor%FOUND  LOOP                 
      DBMS_OUTPUT.PUT_LINE('�������ƣ�'||dept_row.dname);
      FETCH dept_cursor INTO dept_row;         --��ȡ�α�����         
   END LOOP;
   CLOSE dept_cursor;                          --�ر��α�
END;   



DECLARE
   CURSOR dept_cursor IS SELECT * FROM dept;   --�����α����
BEGIN 
   FOR dept_row IN dept_cursor LOOP            --���α�FORѭ���м�������
     DBMS_OUTPUT.PUT_LINE('�������ƣ�'||dept_row.dname);
   END LOOP;
END;   


BEGIN 
   FOR dept_row IN (SELECT * FROM dept) LOOP    --���α�FORѭ���м�������
     DBMS_OUTPUT.PUT_LINE('�������ƣ�'||dept_row.dname);
   END LOOP;
END;   


 DECLARE
   dept_row dept%ROWTYPE;                      --�����α�����¼����
   CURSOR dept_cursor IS SELECT * FROM dept FOR UPDATE deptno,dname;   --�����α����
BEGIN 
   OPEN dept_cursor;                           --���α�
   FETCH dept_cursor INTO dept_row;            --��ȡ�α�����   
   WHILE dept_cursor%FOUND  LOOP                 
      DBMS_OUTPUT.PUT_LINE('�������ƣ�'||dept_row.dname);
      FETCH dept_cursor INTO dept_row;         --��ȡ�α�����         
   END LOOP;
   CLOSE dept_cursor;                          --�ر��α�
END;   



/* Formatted on 2011/09/25 17:02 (Formatter Plus v4.8.8) */
DECLARE
   CURSOR emp_cursor (p_deptno IN NUMBER)
   IS
      SELECT  *
            FROM emp
           WHERE deptno = p_deptno
      FOR UPDATE;                              --ʹ��FOR UPDATE�Ӿ���ӻ�����
BEGIN
   FOR emp_row IN emp_cursor (20)              --ʹ���α�FORѭ�������α�
   LOOP
      UPDATE emp                      
         SET comm = comm * 1.12
       WHERE CURRENT OF emp_cursor;            --ʹ��WHERE CURRENT OF�����α�����
   END LOOP;
   COMMIT;                                     --�ύ����
END;


DECLARE
   CURSOR emp_cursor (p_empno IN NUMBER)
   IS
      SELECT  *
            FROM emp
           WHERE empno = p_empno 
      FOR UPDATE;                              --ʹ��FOR UPDATE�Ӿ���ӻ�����
BEGIN
   FOR emp_row IN emp_cursor (7369)              --ʹ���α�FORѭ�������α�
   LOOP
    DELETE FROM emp
       WHERE CURRENT OF emp_cursor;            --ʹ��WHERE CURRENT OFɾ���α�����
   END LOOP;
END;








/* Formatted on 2011/09/25 21:03 (Formatter Plus v4.8.8) */
DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --�����α��������
   emp_cur   emp_type;                                   --�����α����
   emp_row   emp%ROWTYPE;                                --�����α���ֵ����
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp;                   --���α�
   LOOP
      FETCH emp_cur INTO emp_row;                        --ѭ����ȡ�α�����
      EXIT WHEN emp_cur%NOTFOUND;                        --ѭ���˳����
      DBMS_OUTPUT.put_line ('Ա�����ƣ�' || emp_row.ename);
   END LOOP;
END;




DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;      --�����α�����
   TYPE gen_type IS REF CURSOR;                         
   emp_cur emp_type;                                   --�����α����
   gen_cur gen_type;
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;
END;   
   


DECLARE
    gen_type SYS_REFCURSOR;
BEGIN
END;    


DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --�����α�����
   emp_cur emp_type;                                     --�����α����
   emp_row emp%ROWTYPE;
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;  
   FOR emp_row IN emp_cur LOOP
      DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename);
   END LOOP;
   CLOSE emp_cur;
END;   


DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --�����α�����
   emp_cur emp_curtype;                                  --�����α����͵ı���
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp;                   --���α�,��ѯemp������
   OPEN emp_cur FOR SELECT empno FROM emp;               --���α�,��ѯemp��empno�� 
   OPEN emp_cur FOR SELECT deptno FROM dept;             --���α�,��ѯdept��deptno��
END;


DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --�����α�����
   emp_cur emp_type;                                     --�����α����
   emp_row emp%ROWTYPE;
BEGIN
   IF NOT emp_cur%ISOPEN THEN                            --����α����û�д�
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;   --���α����
   END IF;
   LOOP
     FETCH emp_cur INTO emp_row;                         --��ȡ�α����
     EXIT WHEN emp_cur%NOTFOUND;                         --�����ȡ������˳�ѭ��
     DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename
                         ||' Ա��ְλ��'||emp_row.job);  --���Ա����Ϣ
   END LOOP;
END;   



DECLARE
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;       --�����α�����
   emp_cur emp_type;                                     --�����α����
   emp_row emp%ROWTYPE;
BEGIN
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;   --���α�
   FETCH emp_cur INTO emp_row;                           --��ȡ�α�
   WHILE emp_cur%FOUND LOOP                              --ѭ����ȡ�α�
     DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename);
     FETCH emp_cur INTO emp_row;       
   END LOOP;
   CLOSE emp_cur;                                        --�ر��α�
END;   


DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --�����α�����
   emp_cur emp_curtype;                                  --�����α����͵ı���
   emp_row emp%ROWTYPE;
BEGIN   
   FETCH emp_cur INTO emp_row;
END;


DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --�����α�����
   emp_cur1 emp_curtype;                                 --�����α����͵ı���
   emp_cur2 emp_curtype;
   emp_row emp%ROWTYPE;                                  --���屣���α����ݵļ�¼����
BEGIN   
   OPEN emp_cur1 FOR SELECT * FROM emp WHERE deptno=20;  --�򿪵�1���α�
   FETCH emp_cur1 INTO emp_row;                          --��ȡ����ʾ�α���Ϣ
   DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename||' ���ű�ţ�'||emp_row.deptno);
   FETCH emp_cur2 INTO emp_row;                          --��ȡ��2���α�����������쳣
EXCEPTION
   WHEN INVALID_CURSOR THEN                              --�쳣����
      emp_cur2:=emp_cur1;                                --��emp_cur1ָ��Ĳ�ѯ���򸳸�emp_cur2
      FETCH emp_cur2 INTO emp_row;                       --����emp_cur1��emp_cur2ָ����ͬ�Ĳ�ѯ
      DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename||' ���ű�ţ�'||emp_row.deptno);
      OPEN emp_cur2 FOR SELECT * FROM emp WHERE deptno=30; --���´�emp_cur2�α������������ͬ�Ĳ�ѯ����
      FETCH emp_cur1 INTO emp_row;                         --����emp_cur1��emp_cur2������ͬ�Ĳ�ѯ������˽����ͬ
      DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename||' ���ű�ţ�'||emp_row.deptno);      
END;



DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --�����α�����
   emp_cur emp_curtype;                                  --�����α����͵ı���
   emp_row emp%ROWTYPE;                                  --�����α����ݽ������
   dept_row dept%ROWTYPE;                               
BEGIN   
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;   --���α����
   FETCH emp_cur INTO dept_row;                          --��ȡ��һ����ƥ���������
EXCEPTION
   WHEN ROWTYPE_MISMATCH THEN                            --����ROWTYPE_MISMATCH�쳣
     FETCH emp_cur INTO emp_row;                         --�ٴ���ȡ�α�������ݣ�������
     DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename||' ���ű�ţ�'||emp_row.deptno);       
END;



DECLARE
   emp_cur SYS_REFCURSOR;                               --�����������α����
   emp_row emp%ROWTYPE;
   dept_row dept%ROWTYPE;
BEGIN   
   OPEN emp_cur FOR SELECT * FROM emp WHERE deptno=20;  --���α�����
   FETCH emp_cur INTO dept_row;
EXCEPTION
   WHEN ROWTYPE_MISMATCH THEN                           --����ROWTYPE_MISMATCH�쳣
     FETCH emp_cur INTO emp_row;                        --������ȡ������쳣���
     DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename||' ���ű�ţ�'||emp_row.deptno);       
END;





--�������淶
CREATE OR REPLACE PACKAGE emp_data_action AS
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;         --����ǿ�����α�����
   --����ʹ�α�������ӳ���  
   PROCEDURE getempbydeptno(emp_cur IN OUT emp_type,p_deptno NUMBER); 
END emp_data_action;

--ʵ�ְ���
CREATE OR REPLACE PACKAGE BODY emp_data_action AS
   --�����ڰ��淶�ж���Ĺ���   
   PROCEDURE getempbydeptno(emp_cur IN OUT emp_type,p_deptno NUMBER) IS
     emp_row emp%ROWTYPE;
   BEGIN
     OPEN emp_cur FOR SELECT * from emp WHERE deptno=p_deptno;  --���α����
     LOOP
       FETCH emp_cur INTO emp_row;                              --��ȡ����
       EXIT WHEN emp_cur%NOTFOUND;
       --����α�����
       DBMS_OUTPUT.PUT_LINE('Ա�����ƣ�'||emp_row.ename||' ���ű�ţ�'||emp_row.deptno);
     END LOOP;
     CLOSE emp_cur;
   END;
END emp_data_action;



/* Formatted on 2011/09/26 16:55 (Formatter Plus v4.8.8) */
DECLARE
   emp_cursors   emp_data_action.emp_type;         --�����ڰ��ж�����α�����
BEGIN
   emp_data_action.getempbydeptno (emp_cursors, 20);   --�����ڰ��ж���Ĺ���
END;



--�������淶
CREATE OR REPLACE PACKAGE emp_data_action_err AS
   TYPE emp_type IS REF CURSOR RETURN emp%ROWTYPE;         --����ǿ�����α�����
   emp_cur emp_type;
   --����ʹ�α�������ӳ���  
   PROCEDURE getempbydeptno(emp_cur IN OUT emp_type,p_deptno NUMBER);   
END emp_data_action_err;



DECLARE
   TYPE emp_curtype IS REF CURSOR;                       --�����α�����
   emp_cur emp_curtype;                                  --�����α����͵ı���
BEGIN   
   FOR emp_row IN emp_cur LOOP
      DBMS_OUTPUT.PUT_LINE(emp_row.ename);
   END LOOP;
END;