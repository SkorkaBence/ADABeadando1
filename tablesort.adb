with Ada.Text_IO; use Ada.Text_IO;

procedure TableSort(arr: in out Table_Array) is

   procedure Swap(ind1 : Index; ind2 : Index) is
      tmp : Item;
   begin
      tmp := arr(ind1);
      arr(ind1) := arr(ind2);
      arr(ind2) := tmp;
   end Swap;

begin

   --for I in Index'Succ(arr'First) .. arr'Last loop
   --   tmp := arr(I);
   --   j := Index'Pred(I);

   --   while arr'First <= j and then tmp < arr(j) loop
   --      arr(Index'Succ(j)) := arr(j);

   --      if j > arr'First then
   --         j := Index'Pred(j);
   --      else exit; end if;
   --   end loop;

   --   arr(Index'Succ(j)) := tmp;
   --end loop;

   for I in reverse Index'Succ(arr'First) .. arr'Last loop
      for J in arr'First .. Index'Pred(I) loop
         if arr(Index'Succ(J)) < arr(J) then
            Swap(Index'Succ(J), J);
         end if;
      end loop;
   end loop;

end TableSort;
