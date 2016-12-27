use schronisko



select * from schronisko.dbo.Rasa
select * from schronisko.dbo.Klatka
select * from schronisko.dbo.Pies
select * from schronisko.dbo.Pracownik
select * from schronisko.dbo.Pensja_pracownika
select * from schronisko.dbo.Zamowienia_zywnosci
select * from schronisko.dbo.Klatka_pracownika
select * from schronisko.dbo.Historia_zdrowia




--Wszystkie psy rasy Akita Inu które zosta³y wydane

select p.pies_id,p.nazwa,p.data_przyjecia from pies as p
join Rasa as r on r.rasa_id=p.rasa_id
where r.nazwa='Akita Inu' and p.data_wydania is not null

--Wszystkie psy które by³y szczepione w ci¹gu 4 lat od przyjecia

select p.pies_id,p.nazwa,p.data_przyjecia,h.data as data_zabiegu from pies as p
join Historia_zdrowia as h on h.pies_id=p.pies_id
where h.opis='Szczepienie'and (year(h.data)-year(p.data_przyjecia) <4)


--Wolne miejsca w poszczególnych klatkach

select k.klatka_id,(k.pojemnosc - (select count(klatka_id) from pies where k.klatka_id=klatka_id)) as wolne_miejsca from klatka as k
group by k.klatka_id,k.pojemnosc


--Ilosc wolnych miejsc ogó³em

select (sum(k.pojemnosc) - (select count(p.klatka_id) from pies as p)) as wolne_miejsca from klatka as k

