generic
   type Item is private;
   type Table_Array is array (Positive range <>) of Item;
package Table is
   
   Type Table_Type (Capacity : Natural) Is Private;
   
   function Size (tbl : Table_Type) return Natural;
   function Get_Table (tbl : Table_Type) return Table_Array;
   procedure Insert (tbl : in out Table_Type; itm : Item);
   
   generic
      with function op (itm : Item) return Boolean;
   procedure Table_Where (tbl : Table_Type; outarr : out Table_Array; insertpos : out Natural);
   
   generic
      with function "<" (itm1 : Item; itm2 : Item) return Boolean;
   procedure Table_Sort (tbl : in out Table_Type);
   
   private
   
   type Table_Type (Capacity : Natural) is
      record
         size: Natural := 0;
         table: Table_Array(1..Capacity);
         next_index: Positive := 1;
      end record;

end Table;
