generic
    type Index is (<>);
    type Item is private;
    type Table_Array is array (Index range <>) of Item;
    with function "<" (it1: Item; it2: Item) return Boolean;
procedure TableSort(arr: in out Table_Array);
