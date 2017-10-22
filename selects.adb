procedure Selects(In_Table : in OldTable_Type.Table_Type; Out_Table : out NewTable_Type.Table_Type) is
begin
   for I in 1 .. OldTable_Type.size(In_Table) loop
      NewTable_Type.Insert(Out_Table, Transfer(OldTable_Type.Get_Table(In_Table)(I)));
   end loop;
end Selects;
