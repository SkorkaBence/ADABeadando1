with Table;

generic
   
   type OldItem is private;
   type OldTable_Array is array (Positive range <>) of OldItem;
   with package OldTable_Type is new Table (Item => OldItem, Table_Array => OldTable_Array);
   
   type NewItem is private;
   type NewTable_Array is array (Positive range <>) of NewItem;
   with package NewTable_Type is new Table (Item => NewItem, Table_Array => NewTable_Array);
   
   
   with function Transfer (itm : OldItem) return NewItem;
procedure Selects(In_Table : in OldTable_Type.Table_Type; Out_Table : out NewTable_Type.Table_Type);
