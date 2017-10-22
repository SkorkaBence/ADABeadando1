with Ada.Text_IO, Table;
use Ada.Text_IO;

procedure maintable is

   function TestTable return Boolean is
      -- Az alabbi modon egeszisd ki a tesztelot:
      -- Hozz letre egy People recordot amiben:
      -- Van egy Kor ami Integer,
      -- Van egy Money ami Integer,
      -- Hozz letre egy People_Array-t is.
      
      type People is
         record
            Kor : Integer;
            Money: Integer;
         end record;
      
      type People_Array is array (Positive range <>) of People;
	
      package People_Table is new Table(People, People_Array);
      People_1 : People_Table.Table_Type(1);
      People_5 : People_Table.Table_Type(5);
      People_Temp : People_Array(1..5);
      function People_Table_Test return Boolean is
         exc_count : Integer := 0;
      begin
         for I in Positive range 1..5 loop
            People_Table.Insert(People_5,(Kor=>I*3+5,Money=>I*200+10000));
            People_Temp := People_Table.Get_Table(People_5);
            for J in Positive range 1..I loop
               if People_Temp(J).Kor /= J*3+5 or People_Temp(J).Money /= J*200+10000 then
                  return false;
               end if;
            end loop;
         end loop;
         People_Table.Insert(People_1,(Kor=>3+5,Money=>200+10000));
         return true;
      end People_Table_Test;
   begin
      return People_Table_Test;
   end TestTable;

begin
   if not TestTable then
      Put_Line("Megbukott a teszteken :-( ");
   else
      Put_Line("Átment a teszteken :-) ");   
   end if;
end maintable;
