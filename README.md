# Programozási Nyelvek (Ada), Generic Beadandó


A feladat két részből fog állni, egy rendezés implementálása és egy Adatbázis kezelőben található tábla létrehozása genericek segítségével. Minden feladatrészhez tartozik egy tesztelő, amelyet le tudnak tölteni. Ez a tesztelőt is ki kell egészíteni és beadni. A végén a gyakorlatvezető fogadja el a beadandót: nem biztos, hogy elfogad egy olyan megoldást, amely látszólag jó! A tesztelőt is értékeli az oktató. A funkcionális helyesség mellett a megoldás nyelvi szépségét, a tanult nyelvi elemek használatának profizmusát is ugyanolyan hangsúllyal beszámítjuk az értékelésbe.

A megoldáshoz használható az Ada Language Reference Manual itt A kiegészítendő teszt fájlok itt érhetőek el. Az egész tesztelő elérhető lesz az alábbi linken: itt. (Legkésőbb október 9.-én estére várható).

Feltölteni csak .adb és .ads fileokat kell egy .zip-ben.

Zárthelyi időpontok:

* Zárthelyi : Október 27 16:00 Péntek Lovarda
* Zárthelyi : December 18 14:00 Hétfő Lovarda
* Pótzárthelyi : Január 10 16:00 Szerda Lovarda

## Rendezés implementálása
Definiáljon egy sabloneljárást, amely segítségével egy tömbböt rendezhetünk egy adott feltétel szerint.

A sabloneljárás neve legyen TableSort. Sablonparaméterként kell átadni egy indefinit tömb típust (Table_Array) az elemek (Item) és indexek (Index) típusával, valamint egy "<" függvényt, mely két Item típuson értelmezett rendezési predikátum. (Kötelező ezeket az azonosítókat használni!)

A sabloneljárásból példányosítható eljárásnak egy paramétere legyen: egy tömb (bemenő és kimenő) típusú. Az algoritmushoz használja a beszúró rendezést.

Egészísd ki az alábbi linken található tesztelőt, úgy hogy helyesen működjön! itt (A megjegyzés utáni részben kell kódot írni :) )

## Table implementálása
Definiáljon egy sabloncsomagot, amelyben a Table (magyarul : tábla) típust valósítja meg: ez egy olyan tábla amely az adatbázis is használ. Az egyszerűség kedvéért a sabloncsomagnak két generic paramétere legyen: az egyik (Item), amely a tábla attribútumai (megjegyzés : a tesztelő itt majd egy record-ot fog átadni, amiben fel vannak sorolva az attribútumok egyessével, de ezzel a program elkészítése közben nem kell foglalkozni), és egy tömböt (Table_Array) amely Positive értékekkel van indexelve és Item típusokat tárol.

A sabloncsomag példányosításával kapható csomagban legyen egy Table_Type típus, melynek diszkriminánsa (Capacity) azt mondja meg, hogy legfeljebb hány adat kerülhet a táblába. Továbbá ebben a reprezentációban nyilván tartjuk azt is, hogy aktuálisan hány elem van a tömbben.

A Table típusnak több darab kisebb műveletét kell implementálni. Elsőként készítsünk egy Size függvényt amely paraméterül vár egy Table_Type típust és visszaadja a Table_Array-ben lévő értékek aktuális számát. Továbbá írjunk egy Get_Table függvényt is, amely paraméterül vár egy Table_Type típust és visszaadja az aktuális Table_Array-t.

Az Insert eljárás kap egy Table_Type típust be- és kimenő paraméterként, valamint egy Item típusú paramétert. Ha a Tábla mérete már elérte a kapacitást, akkor ne csináljon semmit a művelet. Egyébként tegye be az Item típust a táblába. (Ha már szerepelt a táblában ez az Item akkor is helyezzük el a táblában. Tehát egyfajta multihalmaz fog létrejönni.)

Egészísd ki az alábbi linken található tesztelőt, úgy hogy helyesen működjön! itt (A megjegyzés utáni részben kell kódot írni :) )

## Lekérdezések lépéseinek implementálása
A Table sabloncsomagon belül készítsünk egy Table_Where sabloneljárást. Sablonparaméterként kapjon egy olyan (op nevű) függvényt, amelynek egy Item típusú bemenő paramétere van és egy logikai értékkel tér vissza. A Table_Where példányosításából származó eljárások kapjanak paraméterként egy bemenő Table_Type-ot, egy kimenő Table_Array típust és egy kimenő Natural típusú paramétert. A Table_Where sabloneljárás a paraméterként kapott Table_Array-be 1-től indexelve kigyűjti azon Table_Type beli elemeket, amelyekre a generic paraméterként kapott op függvény igazat add vissza. (A Natural típusú változót arra használjuk, hogy éppen melyik helyre kell beszúrni a Table_Array-be. Szóval a végén a Natural típusú változóban fog visszajönni, hogy a Table_Array-be hány elemet szúrtunk be.) Írjunk hozzá egy op függvényt is!

Implementáljunk egy Table_Sort nevű sabloneljárást. Sablonparaméterként kapjon egy olyan "<" nevű predikátum függvényt, amelynek két Item típusú bemenő paramétere van és egy logikai értékkel tér vissza. A Table_Sort példányosításából származó eljárások kapjanak paraméterként egy kimenő és bemenő Table_Type-ot. Az eljárás a paraméterként kapott Table_Type-on definiált Table_Array-t rendezze be a már régebben megírt TableSort sabloneljárás segítségével.

A Table sabloncsomagon kívül definiáljunk egy Selects sabloneljárást az alábbi módon: Az alábbi sablonparamétereket kapja:

* Egy (OldItem), amely a régi tábla attribútumai
* Egy (OldTable_Array), amely egy tömb amely Positive értékekkel van indexelve ésOldItem típusokat tárol.
* Egy (NewItem), amely az új tábla attribútumai
* Egy (NewTable_Array), amely egy tömb amely Positive értékekkel van indexelve és NewItem típusokat tárol.
* Egy (OldTable_Type) ami egy Table package az OldItem és OldTable_Array paraméterekkel,
* Egy (NewTable_Type) ami egy Table package az NewItem és NewTable_Array paraméterekkel
* Olyan (Transfer nevű) függvényt, amelynek egy Item (aktuális tábla Item típusa) típusú bemenő paramétere van és egy NewItem (az új tábla Item típusa) típussal tér vissza. A NewItem típus mindig szűkebb halmazt definiál mint az Item típus.
A Table_Select eljárásnak két paramétere van, az egyik a bemenő tábla (In_Table), a másik pedig az eredmény tábla (Out_Table) . A művelet során az aktuális táblán végigmenve, a Transfer függvény eredményét beszúrjuk a kimenő Table-be. Írjunk hozzá egy Transfer függvényt is!

Tesztelje a megoldását a mainfull.adb fájllal. (Később válik elérhetővé!)

Határidő: Október 23 23:59 perc. Bármi kérdéssel írjatok emailt az alábbi címre: mikecz.mark.laszlo+ada@gmail.com

Jó munkát kívánunk.
