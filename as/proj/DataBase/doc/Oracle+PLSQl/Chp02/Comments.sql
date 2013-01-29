/*
 子程序名：OutPutString
 功能    ：输出字符串到屏幕
 参数    ：StrVar--用来保存要输出的字符串的变量
 创建人  ：xxx
 创建日期：2011-x-0x
 修订历史： 
*/
CREATE OR REPLACE PROCEDURE OutPutString(StrVar VARCHAR(50)
AS    
BEGIN
  DBMS_OUTPUT.PUT_LINE(StrVar);           --输出变量的值
END;
/