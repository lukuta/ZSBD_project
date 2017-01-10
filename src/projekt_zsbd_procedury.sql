--1. Dodawanie nowego psa do schroniska
if exists (select 1 from sys.objects where type = 'P' and name = 'proc1')
drop procedure proc1
go

create procedure proc1 
@rasa_id int = null,
@klatka_id int = null,
@nazwa varchar(25) = null,
@rok_urodzenia smallint = null,
@data_przyjecia date = null,
@data_wydania date = null
as
begin
	if @rasa_id is null or @data_przyjecia is null
		begin
			print 'Wyst¹pi³ b³¹d. Podano zbyt ma³o danych!'
		end
	else
		begin
			if @klatka_id in (select k.klatka_id 
							  from schronisko..klatka as k
							  group by k.klatka_id,k.pojemnosc
							  having (k.pojemnosc - (select count(klatka_id) 
													 from schronisko..pies 
													 where k.klatka_id=klatka_id)) > 0)
				begin
					insert into schronisko..Pies values
					(@rasa_id, @klatka_id, @nazwa, @rok_urodzenia, @data_przyjecia, @data_wydania)
					print 'Pomyœlnie dodano psa do schroniska.'
				end
			else
				begin
					print 'W klatce nr: '+ CAST(@klatka_id AS varchar(5)) + ' nie ma ju¿ miejsca'
				end
		end
end
go

DECLARE @tmp DATETIME
SET @tmp = GETDATE()
exec proc1 1,4,'Pluto',2011,@tmp

select * from pies


--2. Wydanie psa ze chroniska
if exists (select 1 from sys.objects where type = 'P' and name = 'proc2')
drop procedure proc2
go

create procedure proc2
@id_psa int = null
as
begin
	if @id_psa is null or @id_psa not in (select p.pies_id from schronisko..Pies as p)
		begin
			print 'B³êdne id psa!'
		end
	else
		begin
			DECLARE @data_wydania date
			set @data_wydania = ( select p.data_wydania from schronisko..Pies as p where p.pies_id = @id_psa )
			if @data_wydania is not null
				begin
					print 'Pies o id ' + CAST(@id_psa AS varchar(5)) + ' zosta³ ju¿ wydany dnia ' + CAST(@data_wydania as varchar(10))
				end
			else
				begin
					update schronisko..pies set data_wydania=GETDATE() where pies_id = @id_psa
					print 'Pomyœlnie wydano psa o id ' + CAST(@id_psa as varchar(5)) + ' ze schroniska'
				end
		end
end
go

exec proc2 12

select * from Pies where pies_id = 12 


--3. Dodanie nowego pracownika wraz z przypisaniem mu klatki, któr¹ opiekuje siê najmniej pracowników
if exists (select 1 from sys.objects where type = 'P' and name = 'proc3')
drop procedure proc3
go

create procedure proc3
@imie varchar(25) = null,
@nazwisko varchar(25) = null,
@pensja smallmoney = null
as
begin
	if @imie = null or @nazwisko = null
		begin 
			print 'Podano b³êdne imie/nazwisko'
		end
	else
		begin
			insert into schronisko..Pracownik (imie, nazwisko)
			values (@imie, @nazwisko)
			print 'Dodano nowego pracownika: ' + CAST(@imie as varchar(25)) + ' ' + CAST (@nazwisko as varchar(25))
			DECLARE @id_pracownika int, @id_klatki int
			SET @id_pracownika = (select top 1 pracownik_id 
								  from schronisko..Pracownik
								  order by pracownik_id desc)
			SET @id_klatki = (select top 1 klatka_id
							  from schronisko..Klatka_pracownika
							  group by klatka_id 
							  order by COUNT(pracownik_id))

			insert into schronisko..Klatka_pracownika (pracownik_id, klatka_id) values
			(@id_pracownika, @id_klatki)
			print 'Dodano klatke o id: ' + CAST(@id_klatki as varchar(5)) + ' dla nowego pracownika'

			if @pensja is not null
				begin
					update schronisko..Pensja_pracownika set pensja = @pensja where pracownik_id = @id_pracownika
					print 'Zmieniono pensje dla nowego pracownika. Teraz wynosi ona ' + CAST (@pensja as varchar(5))
				end
		end
end
go

exec proc3 '£ukasz', 'Szaku³'