CREATE OR REPLACE PACKAGE demo_base64 IS
   FUNCTION encode(r IN RAW) RETURN VARCHAR2;
END;

    ------------------------------------

 /* Formatted on 2011/11/15 06:24 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PACKAGE BODY demo_base64
IS
   TYPE vc2_table IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   MAP   vc2_table;

   -- Initialize the Base64 mapping
   PROCEDURE init_map
   IS
   BEGIN
      MAP (0) := 'A';
      MAP (1) := 'B';
      MAP (2) := 'C';
      MAP (3) := 'D';
      MAP (4) := 'E';
      MAP (5) := 'F';
      MAP (6) := 'G';
      MAP (7) := 'H';
      MAP (8) := 'I';
      MAP (9) := 'J';
      MAP (10) := 'K';
      MAP (11) := 'L';
      MAP (12) := 'M';
      MAP (13) := 'N';
      MAP (14) := 'O';
      MAP (15) := 'P';
      MAP (16) := 'Q';
      MAP (17) := 'R';
      MAP (18) := 'S';
      MAP (19) := 'T';
      MAP (20) := 'U';
      MAP (21) := 'V';
      MAP (22) := 'W';
      MAP (23) := 'X';
      MAP (24) := 'Y';
      MAP (25) := 'Z';
      MAP (26) := 'a';
      MAP (27) := 'b';
      MAP (28) := 'c';
      MAP (29) := 'd';
      MAP (30) := 'e';
      MAP (31) := 'f';
      MAP (32) := 'g';
      MAP (33) := 'h';
      MAP (34) := 'i';
      MAP (35) := 'j';
      MAP (36) := 'k';
      MAP (37) := 'l';
      MAP (38) := 'm';
      MAP (39) := 'n';
      MAP (40) := 'o';
      MAP (41) := 'p';
      MAP (42) := 'q';
      MAP (43) := 'r';
      MAP (44) := 's';
      MAP (45) := 't';
      MAP (46) := 'u';
      MAP (47) := 'v';
      MAP (48) := 'w';
      MAP (49) := 'x';
      MAP (50) := 'y';
      MAP (51) := 'z';
      MAP (52) := '0';
      MAP (53) := '1';
      MAP (54) := '2';
      MAP (55) := '3';
      MAP (56) := '4';
      MAP (57) := '5';
      MAP (58) := '6';
      MAP (59) := '7';
      MAP (60) := '8';
      MAP (61) := '9';
      MAP (62) := '+';
      MAP (63) := '/';
   END;

   FUNCTION encode (r IN RAW)
      RETURN VARCHAR2
   IS
      i   PLS_INTEGER;
      x   PLS_INTEGER;
      y   PLS_INTEGER;
      v   VARCHAR2 (32767);
   BEGIN
      -- For every 3 bytes, split them into 4 6-bit units and map them to

      -- the Base64 characters
      i := 1;

      WHILE (i + 2 <= UTL_RAW.LENGTH (r))
      LOOP
         x :=
              TO_NUMBER (UTL_RAW.SUBSTR (r, i, 1), '0X') * 65536
            + TO_NUMBER (UTL_RAW.SUBSTR (r, i + 1, 1), '0X') * 256
            + TO_NUMBER (UTL_RAW.SUBSTR (r, i + 2, 1), '0X');
         y := FLOOR (x / 262144);
         v := v || MAP (y);
         x := x - y * 262144;
         y := FLOOR (x / 4096);
         v := v || MAP (y);
         x := x - y * 4096;
         y := FLOOR (x / 64);
         v := v || MAP (y);
         x := x - y * 64;
         v := v || MAP (x);
         i := i + 3;
      END LOOP;

      -- Process the remaining bytes that has fewer than 3 bytes.
      IF (UTL_RAW.LENGTH (r) - i = 0)
      THEN
         x := TO_NUMBER (UTL_RAW.SUBSTR (r, i, 1), '0X');
         y := FLOOR (x / 4);
         v := v || MAP (y);
         x := x - y * 4;
         x := x * 16;
         v := v || MAP (x);
         v := v || '==';
      ELSIF (UTL_RAW.LENGTH (r) - i = 1)
      THEN
         x :=
              TO_NUMBER (UTL_RAW.SUBSTR (r, i, 1), '0X') * 256
            + TO_NUMBER (UTL_RAW.SUBSTR (r, i + 1, 1), '0X');
         y := FLOOR (x / 1024);
         v := v || MAP (y);
         x := x - y * 1024;
         y := FLOOR (x / 16);
         v := v || MAP (y);
         x := x - y * 16;
         x := x * 4;
         v := v || MAP (x);
         v := v || '=';
      END IF;

      RETURN v;
   END;
BEGIN
   init_map;
END;