with Ada.Text_IO, TableSort;
use Ada.Text_IO;

procedure mainsort is

   function TestSort return Boolean is

      -- Definialjon a sabloneljaras ket peldanyat! Az alabbi modon:
      -- Legyen ket függveny ami csökkenö es növekvö sorrendbe rendet;
      -- Definialjon egy Positiv ertekekkel indexelö Integer ertekeket taroló tömböt;
      -- Hozzon letre a sablonfüggvenynek ket peldanyat ezekböl;
      -- Hozzon letre tesztelö tömböket;

      type Item is new Integer;
      type Index is new Positive;
      type Int_Array is array (Index range <>) of Item;

      function kisebb(it1 : Item; it2 : Item) return boolean is
      begin
         return it1 < it2;
      end kisebb;

      function nagyobb(it1 : Item; it2 : Item) return boolean is
      begin
         return it1 > it2;
      end nagyobb;

      procedure Sort_Asc is new TableSort(Index, Item, Int_Array, kisebb);
      procedure Sort_Desc is new TableSort(Index, Item, Int_Array, nagyobb);

      -- Ezt a függvenyt ne bantsa!

      function Correct(
                       SortT : access procedure (A: in out Int_Array);
                       Input: in out Int_Array;
                       Output: in Int_Array
                      ) return Boolean
      is
      begin
         SortT(Input);
         for I in Input'Range loop
            if Input(I) /= Output(I) then
               return false;
            end if;
         end loop;
         return true;
      exception
         when others => return false;
      end Correct;

      -- Idaig tartott a Correct függveny!

      Int_Array_First : Int_Array := (3,6,4,2,7,8,1);
      Int_Array_Second : Int_Array := (2,4,3,2,2,5);

      Int_Array_First_Asc : Int_Array := (1,2,3,4,6,7,8);
      Int_Array_First_Desc : Int_Array := (8,7,6,4,3,2,1);
      Int_Array_Second_Asc : Int_Array := (2,2,2,3,4,5);
      Int_Array_Second_Desc : Int_Array := (5,4,3,2,2,2);

   begin
      -- A Testsort függveny terjen vissza a Correct függveny segitsegevel egy
      -- Igaz vagy hamis allitassal.
      -- Correct függveny hasznalata:
      -- elsö parameter: A sabloneljaras egy peldanyanak a neve.
      -- Peldaul : Sort_Asc (sabloneljaras) akkor az elsö parameter helyere irja azt, hogy
      -- Sort_Asc'Access
      -- masodik parameter: A rendezni kivant tömb
      -- harmadik parameter: A helyesen rendezett tömb

        return
            Correct(Sort_Asc'Access, Int_Array_First,Int_Array_First_Asc) and then
            Correct(Sort_Desc'Access, Int_Array_First,Int_Array_First_Desc) and then
            Correct(Sort_Asc'Access, Int_Array_Second,Int_Array_Second_Asc) and then
            Correct(Sort_Desc'Access, Int_Array_Second, Int_Array_Second_Desc);

   end TestSort;

begin
   if not TestSort then
      Put_Line("Megbukott a teszteken :-( ");
   else
      Put_Line("Atment a teszteken :-) ");
   end if;
end mainsort;
