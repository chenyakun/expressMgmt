--����ʱ�Ĵ�����
DECLARE
   v_count NUMBER;
BEGIN
   --����emp001�������ڣ����PL/SQL���潫��������ʱ����
   SELECT COUNT(*) INTO v_count FROM emp001;
   DBMS_OUTPUT.PUT_LINE('Ա������Ϊ��'||v_count);
END;   


DECLARE
   x NUMBER:=&x;  --ʹ�ò���������ֵ
   y NUMBER:=&y;
   z NUMBER;  
BEGIN
   z:=x+y;        --���������       
   DBMS_OUTPUT.PUT_LINE('x+y='||z);      
   z:=x/y;        --���������
   DBMS_OUTPUT.PUT_LINE('x/y='||z);   
END;   



DECLARE
   x NUMBER:=&x;  --ʹ�ò���������ֵ
   y NUMBER:=&y;
   z NUMBER;  
BEGIN
   z:=x+y;        --���������       
   DBMS_OUTPUT.PUT_LINE('x+y='||z);
   IF y<>0 THEN      
   z:=x/y;        --���������
   DBMS_OUTPUT.PUT_LINE('x/y='||z);
   END IF;   
END;   


DECLARE
   x NUMBER:=&x;  --ʹ�ò���������ֵ
   y NUMBER:=&y;
   z NUMBER;  
BEGIN
   z:=x+y;        --���������       
   DBMS_OUTPUT.PUT_LINE('x+y='||z);     
   z:=x/y;        --���������
   DBMS_OUTPUT.PUT_LINE('x/y='||z);
EXCEPTION         --�쳣��������
   WHEN ZERO_DIVIDE THEN   --����0���쳣
     DBMS_OUTPUT.PUT_LINE('����������Ϊ0');   
END;   

SELECT * FROM emp;

/* Formatted on 2011/10/09 18:15 (Formatter Plus v4.8.8) */
DECLARE
   e_duplicate_name   EXCEPTION;                      --�����쳣
   v_ename              emp.ename%TYPE;                 --���������ı���
   v_newname            emp.ename%TYPE   := 'ʷ��˹';   --�²����Ա������  
BEGIN
   --��ѯԱ�����Ϊ7369������
   SELECT ename
     INTO v_ename
     FROM emp
    WHERE empno = 7369;
   --ȷ�����������û���ظ�
   IF v_ename = v_newname
   THEN
      RAISE e_duplicate_name;                 --��������쳣������e_duplicate_name�쳣
   END IF;
   --���û���쳣����ִ�в������
   INSERT INTO emp
        VALUES (7881, v_newname, 'ְԱ', NULL, TRUNC (SYSDATE), 2000, 200, 20);
EXCEPTION                                     --�쳣��������
   WHEN e_duplicate_name                      --�����쳣      
   THEN
      DBMS_OUTPUT.put_line ('���ܲ����ظ���Ա������');
END;

DECLARE
   e_duplicate_name     EXCEPTION;                      --�����쳣
   v_ename              emp.ename%TYPE;                 --���������ı���
   v_newname            emp.ename%TYPE   := 'ʷ��˹';   --�²����Ա������  
BEGIN
   --��ѯԱ�����Ϊ7369������
   SELECT ename
     INTO v_ename
     FROM emp
    WHERE empno = 7369;
   --ȷ�����������û���ظ�
   IF v_ename = v_newname
   THEN
      RAISE e_duplicate_name;                 --��������쳣������e_duplicate_name�쳣
   END IF;
   --���û���쳣����ִ�в������
   INSERT INTO emp
        VALUES (7881, v_newname, 'ְԱ', NULL, TRUNC (SYSDATE), 2000, 200, 20);
EXCEPTION                                     --�쳣��������
   WHEN e_duplicate_name   THEN
      DBMS_OUTPUT.put_line ('���ܲ����ظ���Ա������');
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('�쳣���룺'||SQLCODE||' �쳣��Ϣ��'||SQLERRM);      
END;




/* Formatted on 2011/10/10 00:09 (Formatter Plus v4.8.8) */
DECLARE
   v_tmpstr   VARCHAR2 (10);    --����һ���ַ�������
BEGIN
   v_tmpstr := '������ʱ����';  --��һ�����������ͳ��ȵ��ַ���
EXCEPTION
   WHEN VALUE_ERROR             -- ��׽VALUE_ERROR����
   THEN
      DBMS_OUTPUT.put_line ( '������VALUE_ERROR����'
                            || ' �����ţ�'
                            || SQLCODE
                            || ' �������ƣ�'
                            || SQLERRM
                           );    --��ʾ�����źʹ�����Ϣ
END;


DECLARE
   e_nodeptno EXCEPTION;   --�����Զ����쳣
BEGIN
   NULL;
END;



DECLARE
   e_userdefinedexception   EXCEPTION;
   e_userdefinedexception   EXCEPTION;
BEGIN
   RAISE e_userdefinedexception;
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;


DECLARE
   e_userdefinedexception   EXCEPTION;          --����������쳣
BEGIN
   DECLARE
      e_userdefinedexception   EXCEPTION;       --���ڴ���ж�����ͬ���쳣
   BEGIN
      RAISE e_userdefinedexception;             --�����ڴ���е��쳣
   END;
   RAISE e_userdefinedexception;                --���������е��쳣
EXCEPTION
   WHEN OTHERS THEN                             --���񲢴��������е��쳣
      DBMS_OUTPUT.put_line ('�����˴���'
                            || ' �����ţ�'
                            || SQLCODE
                            || ' �������ƣ�'
                            || SQLERRM
                           );    --��ʾ�����źʹ�����Ϣ      
END;


DECLARE
   e_outerexception   EXCEPTION;          --����������쳣
BEGIN
   DECLARE
      e_innerexception   EXCEPTION;       --���ڴ���ж�����ͬ���쳣
   BEGIN
      RAISE e_innerexception;              --�����ڴ���е��쳣
      RAISE e_outerexception;              --���ڴ���д����������ж�����쳣
   END;
   RAISE e_outerexception;                  --���������е��쳣
   --RAISE e_innerexception;                --�������д����ڴ���е��쳣�ǷǷ���
EXCEPTION
   WHEN OTHERS THEN                             --���񲢴��������е��쳣
      DBMS_OUTPUT.put_line ('�����˴���'
                            || ' �����ţ�'
                            || SQLCODE
                            || ' �������ƣ�'
                            || SQLERRM
                           );    --��ʾ�����źʹ�����Ϣ      
END;


DECLARE
   e_userdefinedexception   EXCEPTION;          --����������쳣
BEGIN
   DECLARE
      e_userdefinedexception   EXCEPTION;       --�����������е��쳣
   BEGIN
      RAISE e_userdefinedexception;             --�����ڴ���е��쳣
   END;
EXCEPTION
   WHEN e_userdefinedexception THEN              --��ʱ�����ܲ���ȡ���쳣
      DBMS_OUTPUT.put_line ('�����˴���'
                            || ' �����ţ�'
                            || SQLCODE
                            || ' �������ƣ�'
                            || SQLERRM
                           );    --��ʾ�����źʹ�����Ϣ    
   WHEN OTHERS THEN                              --�������쳣������
      NULL;                             
END;


/* Formatted on 2011/10/10 11:44 (Formatter Plus v4.8.8) */
DECLARE
   e_missingnull   EXCEPTION;                          --������һ���쳣
   PRAGMA EXCEPTION_INIT (e_missingnull, -1400);       --�����쳣��-1400���й���
BEGIN
   INSERT INTO emp(empno)VALUES (NULL);                --��emp���в�Ϊ�յ���empno����NULLֵ
   COMMIT;                                             --���ִ�гɹ���ʹ��COMMIT�ύ
EXCEPTION
   WHEN e_missingnull THEN                             --���ʧ����׽���������쳣
      DBMS_OUTPUT.put_line ('������ORA-1400����'||SQLERRM);
      ROLLBACK;
END;
/


/* Formatted on 2011/10/10 14:52 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PROCEDURE registeremployee (
   p_empno    IN   emp.empno%TYPE,                  --Ա�����
   p_ename    IN   emp.ename%TYPE,                  --Ա������
   p_sal      IN   emp.sal%TYPE,                    --Ա��н��
   p_deptno   IN   emp.deptno%TYPE                  --���ű��
)
AS
   v_empcount   NUMBER;                             
BEGIN
   IF p_empno IS NULL                               --���Ա�����ΪNULL�򴥷�����
   THEN
      raise_application_error (-20000, 'Ա����Ų���Ϊ��');  --����Ӧ�ó����쳣
   ELSE
      SELECT COUNT (*)
        INTO v_empcount
        FROM emp
       WHERE empno = p_empno;                       --�ж�Ա������Ƿ����
      IF v_empcount > 0                             --���Ա������Ѵ���
      THEN
         raise_application_error (-20001,
                                  'Ա�����Ϊ��' || p_empno
                                  || '��Ա���Ѵ��ڣ�'
                                 );                  --����Ӧ�ó����쳣
      END IF;
   END IF;
   IF p_deptno IS NULL                              --������ű��ΪNULL
   THEN
      raise_application_error (-20002, '���ű�Ų���Ϊ��');  --����Ӧ�ó����쳣
   END IF;
   INSERT INTO emp                                  --��emp���в���Ա����¼
               (empno, ename, sal, deptno
               )
        VALUES (p_empno, p_ename, p_sal, p_deptno
               );
EXCEPTION
   WHEN OTHERS THEN                                 --��׽Ӧ�ó����쳣
      raise_application_error (-20003,
                                  '��������ʱ���ִ����쳣���룺'
                               || SQLCODE
                               || ' �쳣���� '
                               || SQLERRM
                              );
END;



BEGIN
   RegisterEmployee(7369,'����',2000,NULL);
END;



/* Formatted on 2011/10/10 15:51 (Formatter Plus v4.8.8) */
DECLARE
   e_nocomm   EXCEPTION;                     --�Զ�����쳣
   v_comm     NUMBER (10, 2);                --��ʱ����������ݵı���
   v_empno    NUMBER (4)     := &empno;      --�Ӱ󶨲����л�ȡԱ����Ϣ
BEGIN
   SELECT comm INTO v_comm FROM emp WHERE empno = v_empno;  --��ѯ����ȡԱ�����
   IF v_comm IS NULL                         --���û�����
   THEN 
      RAISE e_nocomm;                        --�����쳣
   END IF;
EXCEPTION
   WHEN e_nocomm THEN                        --�����Զ����쳣
      DBMS_OUTPUT.put_line ('ѡ���Ա��û����ɣ�');
   WHEN NO_DATA_FOUND THEN                    --����Ԥ�����쳣
      DBMS_OUTPUT.put_line ('û���ҵ��κ�����');     
   WHEN OTHERS THEN                    --����Ԥ�����쳣
      DBMS_OUTPUT.put_line ('�κ�����δ������쳣');          
END;


DECLARE
   e_nocomm   EXCEPTION;                     --�Զ�����쳣
   v_comm     NUMBER (10, 2);                --��ʱ����������ݵı���
   v_empno    NUMBER (4)     := &empno;      --�Ӱ󶨲����л�ȡԱ����Ϣ
BEGIN
   SELECT comm INTO v_comm FROM emp WHERE empno = v_empno;  --��ѯ����ȡԱ�����
   IF v_comm IS NULL                         --���û�����
   THEN 
      RAISE e_nocomm;                        --�����쳣
   END IF;
EXCEPTION
   WHEN OTHERS THEN                            --OTHERS���뵥������
      DBMS_OUTPUT.put_line ('������룺'||SQLCODE||' ������Ϣ��'||SQLERRM(100));          
END;



DECLARE
   e_outerexception   EXCEPTION;  
   e_innerexception   EXCEPTION;     
   e_threeexception   EXCEPTION;                 
BEGIN
   BEGIN
      RAISE e_innerexception;
      RAISE e_outerexception;
      RAISE e_threeexception;                  
   EXCEPTION  
      WHEN  e_innerexception THEN
         --�쳣�������          
   END;        
EXCEPTION
   WHEN e_outerexception THEN                     
      --�쳣�������   
END;




BEGIN
   DECLARE
     v_ename VARCHAR2(2):='ABC';
   BEGIN
     DBMS_OUTPUT.PUT_LINE(v_ename);
   EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('�������쳣');
   END;
EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('�����ţ�'
                          ||SQLCODE||' ������Ϣ��'
                          ||SQLERRM);   
END;   


DECLARE
   e_outerexception   EXCEPTION;  
   e_innerexception   EXCEPTION;     
   e_threeexception   EXCEPTION;                 
BEGIN
   BEGIN
      RAISE e_innerexception;
      RAISE e_outerexception;
      RAISE e_threeexception;                  
   EXCEPTION  
      WHEN  e_innerexception THEN
         RAISE e_outerexception;
      WHEN e_outerexception THEN
         --�쳣�������         
      WHEN OTHERS THEN
         --�쳣�������              
   END;        
EXCEPTION
   WHEN e_outerexception THEN                     
      --�쳣�������   
END;


SELECT * FROM emp;

DECLARE
   e_nocomm   EXCEPTION;                     --�Զ�����쳣
   v_comm     NUMBER (10, 2);                --��ʱ����������ݵı���
   v_empno    NUMBER (4)     := &empno;      --�Ӱ󶨲����л�ȡԱ����Ϣ
BEGIN
   SELECT comm INTO v_comm FROM emp WHERE empno = v_empno;  --��ѯ����ȡԱ�����
   IF v_comm IS NULL                         --���û�����
   THEN 
      RAISE e_nocomm;                        --�����쳣
   END IF;
EXCEPTION
   WHEN OTHERS THEN                            --OTHERS���뵥������
      DBMS_OUTPUT.put_line ('������룺'||SQLCODE||' ������Ϣ��'||SQLERRM(100));  
      RAISE;                                   --�����׳��쳣              
END;





DECLARE
   e_duplicate_name     EXCEPTION;                      --�����쳣
   v_ename              emp.ename%TYPE;                 --���������ı���
   v_newname            emp.ename%TYPE   := 'ʷ��˹';   --�²����Ա������  
BEGIN   
   BEGIN                                                --��Ƕ�׿��д����쳣
   SELECT ename INTO v_ename FROM emp WHERE empno = 7369;
   IF v_ename = v_newname
   THEN
      RAISE e_duplicate_name;                 --��������쳣������e_duplicate_name�쳣
   END IF;
   EXCEPTION
       WHEN e_duplicate_name  THEN
          v_newname:='������';
   END;
   --���û���쳣����ִ�в������
   INSERT INTO emp VALUES (7881, v_newname, 'ְԱ', NULL, TRUNC (SYSDATE), 2000, 200, 20);
EXCEPTION                                     --�쳣��������
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('�쳣���룺'||SQLCODE||' �쳣��Ϣ��'||SQLERRM);      
END;


DECLARE
   v_empno1 NUMBER(4):=&empno1;                            --����Ա����ѯ��������
   v_empno2 NUMBER(4):=&empno2;
   v_empno3 NUMBER(4):=&empno3;   
   v_sal1 NUMBER(10,2);                                    --���屣��Ա��н�ʵı���
   v_sal2 NUMBER(10,2);
   v_sal3 NUMBER(10,2); 
   v_selectcounter NUMBER := 1;                            --��ѯ����������      
BEGIN
   SELECT sal INTO v_sal1 FROM emp WHERE empno=v_empno1;  --��ѯԱ��н����Ϣ
   v_selectcounter:=2;
   SELECT sal INTO v_sal2 FROM emp WHERE empno=v_empno2;
   v_selectcounter:=3;   
   SELECT sal INTO v_sal3 FROM emp WHERE empno=v_empno3;
EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --����δ�ҵ����ݵ��쳣
     DBMS_OUTPUT.PUT_LINE('�����ţ�'||SQLCODE||' ������Ϣ��'||SQLERRM
                              ||' �����쳣��λ���ǣ�'||v_selectcounter);   
END;      



DECLARE
   v_empno1 NUMBER(4):=&empno1;                            --����Ա����ѯ��������
   v_empno2 NUMBER(4):=&empno2;
   v_empno3 NUMBER(4):=&empno3;   
   v_sal1 NUMBER(10,2);                                    --���屣��Ա��н�ʵı���
   v_sal2 NUMBER(10,2);
   v_sal3 NUMBER(10,2);      
BEGIN
   BEGIN
   SELECT sal INTO v_sal1 FROM emp WHERE empno=v_empno1;  --��ѯԱ��н����Ϣ
   EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --����δ�ҵ����ݵ��쳣
     DBMS_OUTPUT.PUT_LINE('�����ţ�'||SQLCODE||' ������Ϣ��'||SQLERRM
                              ||' �����쳣��λ���� 1');  
   END;  
   BEGIN      
   SELECT sal INTO v_sal2 FROM emp WHERE empno=v_empno2;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --����δ�ҵ����ݵ��쳣
     DBMS_OUTPUT.PUT_LINE('�����ţ�'||SQLCODE||' ������Ϣ��'||SQLERRM
                              ||' �����쳣��λ���� 2'); 
   END;  
   BEGIN   
   SELECT sal INTO v_sal3 FROM emp WHERE empno=v_empno3;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --����δ�ҵ����ݵ��쳣
     DBMS_OUTPUT.PUT_LINE('�����ţ�'||SQLCODE||' ������Ϣ��'||SQLERRM
                              ||' �����쳣��λ���� 3'); 
   END;     
EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --����δ�ҵ����ݵ��쳣
     DBMS_OUTPUT.PUT_LINE('�����ţ�'||SQLCODE||' ������Ϣ��'||SQLERRM);   
END;   



DECLARE
   v_empno1 NUMBER(4):=&empno1;                            --����Ա����ѯ��������
   v_empno2 NUMBER(4):=&empno2;
   v_empno3 NUMBER(4):=&empno3;   
   v_sal1 NUMBER(10,2);                                    --���屣��Ա��н�ʵı���
   v_sal2 NUMBER(10,2);
   v_sal3 NUMBER(10,2);      
   v_str VARCHAR2(200);
BEGIN
   SELECT sal INTO v_sal1 FROM emp WHERE empno=v_empno1;  --��ѯԱ��н����Ϣ
   SELECT sal INTO v_sal2 FROM emp WHERE empno=v_empno2;
   SELECT sal INTO v_sal3 FROM emp WHERE empno=v_empno3;
EXCEPTION
   WHEN NO_DATA_FOUND THEN                                 --����δ�ҵ����ݵ��쳣
     DBMS_OUTPUT.PUT_LINE('�����ţ�'||SQLCODE||' ������Ϣ��'||SQLERRM
                              ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);   
END;    

SELECT * FROM emp WHERE empno=7881;

DECLARE
   e_duplicate_name     EXCEPTION;                      --�����쳣
   v_ename              emp.ename%TYPE;                 --���������ı���
   v_newname            emp.ename%TYPE   := 'ʷ��˹';   --�²����Ա������  
BEGIN   
   LOOP                                                 --��ʼѭ��
   BEGIN                                                --������Ƕ�뵽�ӿ���
      SAVEPOINT ��ʼ����;                               --����һ�������
      SELECT ename INTO v_ename FROM emp WHERE empno = 7369;   --��ʼ�������
      IF v_ename = v_newname
      THEN
         RAISE e_duplicate_name;                 --��������ظ�������e_duplicate_name�쳣
      END IF;
      INSERT INTO emp VALUES (7881, v_newname, 'ְԱ', NULL, TRUNC (SYSDATE), 2000, 200, 20);
      COMMIT;                                       --�ύ����
      EXIT;                                         --�ύ����˳�ѭ��
      EXCEPTION                                     --�쳣��������
      WHEN e_duplicate_name THEN
         ROLLBACK TO ��ʼ����;                      --�ع����񵽼���λ��
         v_newname:='������';                       --Ϊ�����쳣����Ա�������¸�ֵ�����¿�ʼѭ��ִ��
   END;                                            
   END LOOP;    
END;