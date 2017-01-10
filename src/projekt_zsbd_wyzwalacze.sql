use schronisko

drop trigger trig1
go
drop trigger trig2
go

--1. zmiana klatki na null kiedy wprowadzimy date wydania psa 
create trigger trig1
on pies
after update
as
	update pies
	set klatka_id=null
	where data_wydania is not null
	print 'Aktualizacja w tabeli Pies' 
go

--2. Dodanie nowego pracownika przypisuje mu domyœln¹ pensje minimaln¹
create trigger trig2
on Pracownik
after insert
as
	DECLARE @id_pracownika int, @pensja_minimalna smallmoney
	SET @id_pracownika = (select top 1 pracownik_id from Pracownik order by pracownik_id desc)
	SET @pensja_minimalna = (select top 1 wartosc from pensja_minimalna)

	insert into schronisko..Pensja_pracownika (pracownik_id, pensja, data_od) values
	(@id_pracownika, @pensja_minimalna, GETDATE());

	print 'Dodano domyœlna p³ace dla nowego pracownika' 
go
