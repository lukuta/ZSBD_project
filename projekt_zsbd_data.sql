use schronisko;

insert into schronisko.dbo.Rasa values
('Owczarek niemiecki'),
('Labrador'),
('Husky'),
('Beagle'),
('Akita Inu'),
('Rottwieler'),
('Malamut'),
('Terier'),
('Mieszaniec')
go


insert into schronisko.dbo.Klatka values
(4),
(3),
(2),
(2),
(1),
(2),
(3)
go



insert into schronisko.dbo.pies values
(1,1,null,2008,'2010-07-15',null),
(2,1,'Maja',2004,'2004-03-19',null),
(3,null,null,2006,'2008-01-15','2011-01-15'),
(3,1,null,2006,'2008-01-15',null),
(3,2,null,2006,'2008-01-15',null),
(4,2,'Bia³y kie³',2011,'2011-01-15',null),
(4,2,null,2010,'2011-01-21',null),
(5,null,null,2004,'2011-01-15','2015-01-05'),
(5,3,'Brutus',2011,'2011-01-15',null),
(6,3,null,2007,'2011-12-15',null),
(9,4,'Warka',2007,'2011-12-15',null),
(8,5,'Puszek',2004,'2009-12-15',null),
(7,6,null , 2000 , '2002-01-19',null),
(7,7,null , 2001 , '2003-10-21',null),
(6,7,null , 2011 , '2015-01-05',null),
(5,null,null,2004,'2006-01-15','2011-06-20'),
(6,null,null,2005,'2007-02-16','2012-07-21'),
(7,null,null,2006,'2008-03-17','2013-08-22'),
(8,null,null,2007,'2009-04-18','2014-09-23'),
(9,null,null,2008,'2010-05-19','2015-10-24')




insert into schronisko.dbo.Pracownik values
('Agata','Xsinska'),
('Jan','Kowalski'),
('Brayan','Nowak'),
('Jan','Nowak')


--Pensja pracownika--
insert into schronisko.dbo.Pensja_pracownika values
(1,1230,'2014-05-15',null),
(1,1000,'2013-06-16','2014-05-15'),
(1,1100,'2012-07-17','2013-06-16'),

(2,1230,'2012-01-16','2014-09-15'),
(2,1230,'2014-05-15','2014-09-15'),
(2,1500,'2014-09-15', null),

(3,1730,'2013-02-25',null),

(4,1530,'2011-01-25','2015-02-25'),
(4,1730,'2015-02-25',null)



insert into schronisko.dbo.Zamowienia_zywnosci values
(1,561,'2016-05-25'),
(4,561,'2016-03-25'),
(2,461,'2016-01-25'),
(3,120,'2015-11-25'),
(1,876,'2015-09-25'),
(4,561,'2015-07-25'),
(4,234,'2015-05-25'),
(4,653,'2015-02-25')
go


--klatka pracownika--idpracownik,idklatka 7 klatek 4 pracownikow


insert into schronisko.dbo.Klatka_pracownika values
(1,1),
(1,2),
(1,7),
(2,2),
(2,3),
(2,6),
(3,1),
(3,4),
(4,1),
(4,5),
(4,6)

--pies id opies data


insert into schronisko.dbo.Historia_zdrowia values
(1,'Szczepienie','2014-06-11'),
(2,'Szczepienie','2015-05-12'),
(3,'Szczepienie','2010-03-23'),
(4,'Gor¹czka','2012-11-30'),
(5,'Szczepienie','2011-02-19'),
(6,'Szczepienie','2013-02-11'),
(6,'Gor¹czka','2015-05-30'),
(7,'Szczepienie','2015-05-12'),
(8,'Szczepienie','2011-05-12'),
(9,'Gor¹czka','2015-04-12')





