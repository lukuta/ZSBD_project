use schronisko;

insert into schronisko.dbo.Rasa values
('Owczarek niemiecki'),('Labrador'),('Husky'),('Beagle'),
('Akita Inu'),('Rottwieler'),('Malamut'),('Terier'),('Mieszaniec')
go


insert into schronisko.dbo.Klatka values
(20,4),(15,3),(17.5,2),(10.5,2)
go



insert into schronisko.dbo.pies values
(1,1,null,2008,2010-07-15,null),
(2,1,'Maja',2004,2004-03-19,null),
(3,null,null,2006,2008-01-15,2011-01-15),
(3,1,null,2006,2008-01-15,null),
(3,2,null,2006,2008-01-15,null),
(4,2,'Bia³y kie³',2011,2011-01-15,null),
(4,2,null,2010,2011-01-21,null),
(5,null,null,2004,2011-01-15,2015-01-05),
(5,3,'Brutus',2011,2011-01-15,null),
(6,3,null,2007,2011-12-15,null),
(9,4,'Warka',2007,2011-12-15,null)


insert into schronisko.dbo.Pracownik values
('Agata','Xsinska'),('Jan','Kowalski'),('Brayan','Nowak')


--Pensja pracownika--
insert into schronisko.dbo.Pensja_pracownika values
(1,1230,2014-05-15,null),
(2,1230,2014-05-15,2014-09-15),
(2,1500,2014-09-15, null),
(3,1730,2013-02-25,null)



insert into schronisko.dbo.Zamowienia_zywnosci values
(1,561,2016-05-25),(4,561,2016-03-25)
go


--klatka pracownika--


insert into schronisko.dbo.Klatka_pracownika values
(1,1),(1,2),(2,2),(2,3),(3,1),(3,4)



insert into schronisko.dbo.Historia_zdrowia values
(2,'Szczepienie',2015-05-12),
(4,'Szczepienie',2015-04-12),
(6,'Gor¹czka',2015-05-30)




