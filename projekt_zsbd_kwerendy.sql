use schronisko



select * from schronisko.dbo.Rasa
select * from schronisko.dbo.Klatka
select * from schronisko.dbo.Pies
select * from schronisko.dbo.Pracownik
select * from schronisko.dbo.Pensja_pracownika
select * from schronisko.dbo.Zamowienia_zywnosci
select * from schronisko.dbo.Klatka_pracownika
select * from schronisko.dbo.Historia_zdrowia




--1. Wszystkie psy rasy Akita Inu kt�re zosta�y wydane

select p.pies_id,p.nazwa,p.data_przyjecia from pies as p
join Rasa as r on r.rasa_id=p.rasa_id
where r.nazwa='Akita Inu' and p.data_wydania is not null

--2. Wszystkie psy kt�re by�y szczepione w ci�gu 4 lat od przyjecia

select p.pies_id,p.nazwa,p.data_przyjecia,h.data as data_zabiegu from pies as p
join Historia_zdrowia as h on h.pies_id=p.pies_id
where h.opis='Szczepienie'and (year(h.data)-year(p.data_przyjecia) <4)

--3. R�nica miedzy najstarszym a najmlodszym psem b�d�cym jeszcze w schronisku
select MAX(p.rok_urodzenia) - MIN(p.rok_urodzenia) as roznica
from Pies as p
where p.data_wydania is null


--4. Wolne miejsca w poszczeg�lnych klatkach

select k.klatka_id,(k.pojemnosc - (select count(klatka_id) from pies where k.klatka_id=klatka_id)) as wolne_miejsca from klatka as k
group by k.klatka_id,k.pojemnosc


--5. Ilosc wolnych miejsc og�em

select (sum(k.pojemnosc) - (select count(p.klatka_id) from pies as p)) as wolne_miejsca from klatka as k

--6. Pracownicy ktorych pensja nie zmienila sie od poczatku


select concat(p.imie,' ', p.nazwisko) as Nazwa from Pracownik as p
where ((select count(pracownik_id) from Pensja_pracownika where pracownik_id=p.pracownik_id) = 1 )



--7. suma rocznych wydatk�w na pensje pracownik�w

select (sum(p.pensja)*12) from Pensja_pracownika  as p 
where p.data_do is null

--8. Dane pracownikow zajmuj�cych si� wi�cej ni� 2 klatkami
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
							
--10. Wszystkie psy przyj�te w roku, w kt�rym ilo�� przyj�� by�a najwi�ksza
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
