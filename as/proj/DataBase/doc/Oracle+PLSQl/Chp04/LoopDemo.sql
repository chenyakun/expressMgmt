/* Formatted on 2011/08/16 21:45 (Formatter Plus v4.8.8) */
DECLARE
   v_count   NUMBER (2) := 0;         --����ѭ����������
BEGIN
   LOOP                               --��ʼִ��ѭ��
      v_count := v_count + 1;         --ѭ����������1
      --��ӡ�ַ���Ϣ
      DBMS_OUTPUT.put_line ('��' || v_count || '��Hello PL/SQL!');
      --�����������Ϊ10,���˳�ѭ��
      IF v_count = 10
      THEN
         EXIT;       --ʹ��EXIT�˳�ѭ��
      END IF;
   END LOOP;
   --ѭ���˳��󣬽�ִ���������
   DBMS_OUTPUT.put_line ('ѭ���Ѿ��˳��ˣ�');
END;


DECLARE
   v_count   NUMBER (2) := 0;         --����ѭ����������
BEGIN
   LOOP                               --��ʼִ��ѭ��
      v_count := v_count + 1;         --ѭ����������1
      --��ӡ�ַ���Ϣ
      DBMS_OUTPUT.put_line ('��' || v_count || '��Hello PL/SQL!');
      --�����������Ϊ10,���˳�ѭ��
      EXIT WHEN v_count=10;
   END LOOP;
   --ѭ���˳��󣬽�ִ���������
   DBMS_OUTPUT.put_line ('ѭ���Ѿ��˳��ˣ�');
END;