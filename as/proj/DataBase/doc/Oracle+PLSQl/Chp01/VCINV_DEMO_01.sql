CREATE OR REPLACE PROCEDURE VTTPC.VCINV_DEMO_01(pEmpNo IN NUMBER) IS
tmpVar VARCHAR2(100);
BEGIN
   tmpVar := 0;
   DBMS_OUTPUT.PUT_LINE('����ʼ��ѯ���ݿ�:'); 
   SELECT EName INTO tmpVar FROM Scott.Emp WHERE EmpNo=pEmpNo;
   DBMS_OUTPUT.PUT_LINE('Ա������Ϊ��'||tmpVar);
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('û���ҵ���Ա����¼!');
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END VCINV_DEMO_01;
/
