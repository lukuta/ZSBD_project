--1. Dodawanie nowego psa do schroniska
if exists (select 1 from sys.objects where type = 'P' and name = 'proc1')
drop procedure proc1

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
exec proc1 1,1,'Puszek',null,@tmp,null
