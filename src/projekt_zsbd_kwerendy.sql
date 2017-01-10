use schronisko



select * from schronisko.dbo.Rasa
select * from schronisko.dbo.Klatka
select * from schronisko.dbo.Pies
select * from schronisko.dbo.Pracownik
select * from schronisko.dbo.Pensja_pracownika
select * from schronisko.dbo.Zamowienia_zywnosci
select * from schronisko.dbo.Klatka_pracownika
select * from schronisko.dbo.Historia_zdrowia
select * from schronisko.dbo.Pensja_minimalna




--1. Wszystkie psy rasy Akita Inu które zosta³y wydane

select p.pies_id,p.nazwa,p.data_przyjecia from pies as p
join Rasa as r on r.rasa_id=p.rasa_id
where r.nazwa='Akita Inu' and p.data_wydania is not null

--2. Wszystkie psy które by³y szczepione w ci¹gu 4 lat od przyjecia

select p.pies_id,p.nazwa,p.data_przyjecia,h.data as data_zabiegu from pies as p
join Historia_zdrowia as h on h.pies_id=p.pies_id
where h.opis='Szczepienie'and (year(h.data)-year(p.data_przyjecia) <4)

--3. Ró¿nica miedzy najstarszym a najmlodszym psem bêd¹cym jeszcze w schronisku
select MAX(p.rok_urodzenia) - MIN(p.rok_urodzenia) as roznica
from Pies as p
where p.data_wydania is null


--4. Wolne miejsca w poszczególnych klatkach

select k.klatka_id,(k.pojemnosc - (select count(klatka_id) from pies where k.klatka_id=klatka_id)) as wolne_miejsca from klatka as k
group by k.klatka_id,k.pojemnosc

--5. Ilosc wolnych miejsc ogó³em

select (sum(k.pojemnosc) - (select count(p.klatka_id) from pies as p)) as wolne_miejsca from klatka as k

--6. Pracownicy ktorych pensja nie zmienila sie od poczatku


select concat(p.imie,' ', p.nazwisko) as Nazwa from Pracownik as p
where ((select count(pracownik_id) from Pensja_pracownika where pracownik_id=p.pracownik_id) = 1 )



--7. suma rocznych wydatków na pensje pracowników

select (sum(p.pensja)*12) as roczne_wydatki from Pensja_pracownika  as p 
where p.data_do is null

--8. Dane pracownikow zajmuj¹cych siê wiêcej ni¿ 2 klatkami
select p.imie, p.nazwisko
from Pracownik as p
where p.pracownik_id 
IN ( select kp.pracownik_id
	 from Klatka_pracownika as kp
	 group by kp.pracownik_id
	 having COUNT(kp.pracownik_id) > 2)

--9. Cena i data ostatniego zamownienia zywnosci wraz z danymi pracownika, ktory je wykonal
select p.imie, p.nazwisko, z.cena, z.data
from Pracownik as p
right join
(
select top 1 zz.pracownik_id, zz.cena, zz.data
from Zamowienia_zywnosci as zz
order by zz.data desc
) as z on z.pracownik_id = p.pracownik_id
							
--10. Wszystkie psy przyjête w roku, w którym iloœæ przyjêæ by³a najwiêksza
select p.pies_id, p.nazwa, j.data_przyjecia
from Pies as p
join
(
	select p.pies_id, p.data_przyjecia
	from Pies as p
	group by p.pies_id, p.data_przyjecia
	having YEAR(p.data_przyjecia) = (Select top 1 YEAR(p.data_przyjecia)
									 From Pies as p
									 group by YEAR(p.data_przyjecia)
									 order by COUNT(YEAR(p.data_przyjecia)) desc)
) as j on j.pies_id = p.pies_id

--11. Ilosc przyjetych psow w poszczegolnych latach
select YEAR(p.data_przyjecia) as rok, COUNT(*) as ilosc
from Pies as p
group by YEAR(p.data_przyjecia)

--12. Ilosc wydanych psow w poszczegolnych latach
select YEAR(p.data_wydania) as rok, COUNT(*) as ilosc 
from Pies as p
where p.data_wydania is not null
group by YEAR(p.data_wydania)

--13. Rasa psa, któr¹ ka¿dy z pracowników ma najwiecej pod opiek¹
select pr.pracownik_id, max(klatki.nazwa) as nazwa
from Pracownik as pr
join
(
	select kp.pracownik_id, kp.klatka_id, psy.nazwa
	from Klatka_pracownika as kp
	join
	(
		select p.rasa_id, p.klatka_id, r.nazwa
		from Pies as p, Rasa as r
		where r.rasa_id = p.rasa_id
	) as psy on psy.klatka_id = kp.klatka_id
) 
as klatki on klatki.pracownik_id = pr.pracownik_id
group by pr.pracownik_id

--14. Suma zarobkow kazdego z pracownikow
Select pp.pracownik_id, p.imie, p.nazwisko, SUM(DATEDIFF(month,pp.data_od, CAST(
															CASE 
																 WHEN pp.data_do is null
																	THEN GETDATE() 
																 ELSE pp.data_do 
															END AS date)) * pp.pensja) as zarobki_ogó³em
from Pensja_pracownika as pp, Pracownik as p
where p.pracownik_id = pp.pracownik_id
group by pp.pracownik_id, p.imie, p.nazwisko


--15 Psy z imiemiem zawieraj¹cym 'a'
Select *
From Pies
where nazwa like '%a%'
