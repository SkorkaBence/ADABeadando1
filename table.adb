with TableSort;

package body Table is

   function Size (tbl : Table_Type) return Natural is
   begin
        return tbl.size;
   end Size;
   
   
   function Get_Table (tbl : Table_Type) return Table_Array is
   begin
      return tbl.table;
   end Get_Table;
   
   
   procedure Insert (tbl : in out Table_Type; itm : Item) is
   begin
      if tbl.size < tbl.Capacity then
         tbl.table(tbl.next_index) := itm;
         tbl.next_index := Positive'Succ(tbl.next_index);
         tbl.size := tbl.size + 1;
      end if;
   end Insert;
   
   procedure Table_Where (tbl : Table_Type; outarr : out Table_Array; insertpos : out Natural) is
   begin
      insertpos := 1;
      for I in 1 .. tbl.size loop
         if op(tbl.table(I)) then
            outarr(insertpos) := tbl.table(I);
            insertpos := insertpos + 1;
         end if;
      end loop;
      insertpos := insertpos - 1;
   end Table_Where;
   
   procedure Table_Sort (tbl : in out Table_Type) is
      procedure tblsrt is new TableSort(Positive, Item, Table_Array, "<");
   begin
      tblsrt(tbl.table);
   end Table_Sort;
   
end Table;
