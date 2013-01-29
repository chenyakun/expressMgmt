DECLARE
  --定义变量
  v_Max INT;
  v_X INT;
  v_Y INT;
BEGIN
  v_Max : =0;    --不允许用空格将:=分开
  --ENDIF需要使用空格进行分开，另外要使用加车符进行换行显示。
  IF v_X>v_Y THEN v_Max:=v_X;ELSE v_Max:=v_Y;ENDIF;
END;


DECLARE
  --定义变量
  V_MAX INT;
  V_X INT;
  V_Y INT;
  "1_MAX" INT;
BEGIN
  V_MAX:=0;    --不允许用空格将:=分开
  --ENDIF需要使用空格进行分开，另外要使用加车符进行换行显示。
  IF V_X>V_Y THEN 
     V_MAX:=V_X;
  ELSE 
     V_MAX:=V_Y;
  END IF;
  "1_MAX":=V_MAX;
END;


VARIABLE_NUMBER;
Variable_Number;
VARIABLE_number;
variable_NUMBER;
