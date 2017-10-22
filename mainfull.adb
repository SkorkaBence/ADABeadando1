with Ada.Text_IO, Table, TableSort, Selects;
use Ada.Text_IO;

procedure mainFull is

    function TestFull return Boolean is
        type Int_Array is array(Positive range<>) of Integer;

        function Asc(A,B : in Integer) return Boolean is (A < B);
        function Desc(A,B : in Integer) return Boolean is (A > B);

        procedure Sort_Asc is new TableSort(Item=>Integer, Index=>Positive, Table_Array=>Int_Array,"<"=>Asc);
        procedure Sort_Desc is new TableSort(Item=>Integer, Index=>Positive, Table_Array=>Int_Array,"<"=>Desc);
        Int_Array_First : Int_Array := (3,6,4,2,7,8,1);
        Int_Array_Second : Int_Array := (2,4,3,2,2,5);

        Int_Array_First_Asc : Int_Array := (1,2,3,4,6,7,8);
        Int_Array_First_Desc : Int_Array := (8,7,6,4,3,2,1);
        Int_Array_Second_Asc : Int_Array := (2,2,2,3,4,5);
        Int_Array_Second_Desc : Int_Array := (5,4,3,2,2,2);
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

        type People is record
            Kor : Integer;
            Money : Integer;
        end record; 
        type People_Array is array(Positive range<>) of People;

        package People_Table is new Table(People, People_Array);
        People_1 : People_Table.Table_Type(1);
        People_5 : People_Table.Table_Type(5);
        People_Temp : People_Array(1..5);
        function People_Table_Test return Boolean is
        begin
            for I in Positive range 1..5 loop
                begin
                    People_Table.Insert(People_5,(Kor=>I*3+5,Money=>I*200+10000));
                    People_Temp := People_Table.Get_Table(People_5);
                    for J in Positive range 1..I loop
                        if People_Temp(J).Kor /= J*3+5 or People_Temp(J).Money /= J*200+10000 then
                            return false;
                        end if;
                    end loop;
                end;
            end loop;
            if People_Table.Size(People_5) /= 5 then
                return false;
            end if;
            People_Table.Insert(People_1,(Kor=>3+5,Money=>200+10000));
            return true;
        end People_Table_Test;
        function op1(A : in People) return Boolean is begin return A.Money >= 10400; end;
        function op2(A : in People) return Boolean is begin return A.Kor <= 14; end;
        function op3(A,B : in People) return Boolean is begin return A.Kor > B.Kor; end;
        function People_Where_Test return Boolean is
            procedure Where1 is new People_Table.Table_Where(op1);
            procedure Where2 is new People_Table.Table_Where(op2);
            procedure Sort1 is new People_Table.Table_Sort(op3);
            Temp : Natural;
            People_Temp_1 : People_Array(1..4);
            People_Temp_2 : People_Array(1..3);
        begin
            if People_Table.Size(People_5) /= 5 then
                return false;
            end if;
            begin
                Where1(People_5, People_Temp_1,Temp);
                if Temp /= 4 then
                    return false;
                end if;
                for I in Positive range 1..4 loop
                    if People_Temp_1(I).Kor /= (I+1)*3+5 or People_Temp_1(I).Money /= (I+1)*200+10000 then
                        return false;
                    end if;
                end loop;
            end;
            begin
                Where2(People_5, People_Temp_2,Temp);
                if Temp /= 3 then
                    return false;
                end if;
                for I in Positive range 1..3 loop
                    if People_Temp_2(I).Kor /= I*3+5 or People_Temp_2(I).Money /= I*200+10000 then
                        return false;
                    end if;
                end loop;
            end;
            Sort1(People_5);
            People_Temp := People_Table.Get_Table(People_5);
            for I in Positive range 1..5 loop
                if People_Temp(I).Kor /= 23-I*3 then
                    return false;
                end if;
            end loop;
            return true;
        end People_Where_Test;
		type NewPeople_1 is record
			Kor : Integer;
		end record;
		type New_People_Array_1 is array(Positive range<>) of NewPeople_1;
		package New_People_Table_1 is new Table(NewPeople_1, New_People_Array_1);
		
		function transfer1(p1 : People) return NewPeople_1 is
			np : NewPeople_1 := (Kor=>p1.Kor); 
		begin
			return np;
		end transfer1;
		type NewPeople_2 is record
			Money : Integer;
		end record;
		type New_People_Array_2 is array(Positive range<>) of NewPeople_2;
		package New_People_Table_2 is new Table(NewPeople_2, New_People_Array_2);
		
		function transfer2(p1 : People) return NewPeople_2 is
			np : NewPeople_2 := (Money=>p1.Money); 
		begin
			return np;
		end transfer2;
		function People_Select_Test return Boolean is
			procedure Selects_1 is new Selects(OldItem => People, OldTable_Array => People_Array, NewItem => NewPeople_1, NewTable_Array => New_People_Array_1, OldTable_Type => People_Table, NewTable_Type => New_People_Table_1, Transfer => transfer1);
			procedure Selects_2 is new Selects(OldItem => People, OldTable_Array => People_Array, NewItem => NewPeople_2, NewTable_Array => New_People_Array_2, OldTable_Type => People_Table, NewTable_Type => New_People_Table_2, Transfer => transfer2);
			People_Select_3 : People_Table.Table_Type(3);
			People_Select_3_New_1 : New_People_Table_1.Table_Type(3);
			People_Select_3_New_2 : New_People_Table_2.Table_Type(3);
			People_Temp_1 : New_People_Array_1(1..3);
			People_Temp_2 : New_People_Array_2(1..3);
		begin
			for I in Positive range 1..3 loop
                begin
                    People_Table.Insert(People_Select_3,(Kor=>I*3+5,Money=>I*200+10000));
                end;
            end loop;
			Selects_1(People_Select_3, People_Select_3_New_1);
			Selects_2(People_Select_3, People_Select_3_New_2);
			People_Temp_1 := New_People_Table_1.Get_Table(People_Select_3_New_1);
			People_Temp_2 := New_People_Table_2.Get_Table(People_Select_3_New_2);
			for J in Positive range 1..3 loop
				if People_Temp_1(J).Kor /= J*3+5 then
					return false;
				end if;
			end loop;
			for J in Positive range 1..3 loop
				if People_Temp_2(J).Money /= J*200+10000 then
					return false;
				end if;
			end loop;
			return true;
		end People_Select_Test;
		function PeopleFullTest return Boolean is
		begin
            if not People_Table_Test then
                return False;
            end if;
			if not People_Where_Test then
				return False;
			end if;
			if not People_Select_Test then
				return False;
			end if;
			return True;
		end PeopleFullTest;
    begin
        return
            Correct(Sort_Asc'Access, Int_Array_First,Int_Array_First_Asc) and then
            Correct(Sort_Desc'Access, Int_Array_First,Int_Array_First_Desc) and then
            Correct(Sort_Asc'Access, Int_Array_Second,Int_Array_Second_Asc) and then
            Correct(Sort_Desc'Access, Int_Array_Second, Int_Array_Second_Desc) and then
            PeopleFullTest;
    end TestFull;

begin
    if not TestFull then
        Put_Line("Megbukott a teszteken :-( ");
    else
        Put_Line("Atment a teszteken :-) ");   
    end if;
end mainfull;
