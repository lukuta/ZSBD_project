if exists(select 1 from master.dbo.sysdatabases where name = 'schronisko') drop database schronisko
GO
CREATE DATABASE schronisko
GO
USE schronisko

create table Rasa
(
	rasa_id int identity(1,1) constraint rasa_id_nn not null,
	nazwa varchar(25) constraint rasa_nazwa_nn not null
)

alter table Rasa add constraint rasa_id_pk primary key (rasa_id)

create table Klatka 
(
	klatka_id int identity(1,1) constraint klatka_id_nn not null,
	--w metrach kwadratowych--
	pojemnosc int constraint pojemnosc_nn not null
)

alter table Klatka add constraint klatka_id_pk primary key (klatka_id) 


create table Pies
(
	pies_id int identity(1,1) constraint pies_id_nn not null,
	rasa_id int constraint rasa_id_nn not null,
	klatka_id int,
	nazwa varchar(25),
	rok_urodzenia smallint,
	data_przyjecia date constraint data_przyjecia_nn not null,
	data_wydania date
)



alter table Pies add constraint pies_id_pk primary key (pies_id)
alter table Pies add constraint rasa_id_fk foreign key (rasa_id) references Rasa(rasa_id)
alter table Pies add constraint klatka_id_fk foreign key (klatka_id) references Klatka(klatka_id)


CREATE TABLE Pracownik
(
	pracownik_id int identity(1,1) constraint pracownik_id_nn NOT NULL,
	imie varchar(25),
	nazwisko varchar(25),
)

ALTER TABLE Pracownik ADD CONSTRAINT pracownik_id_pk PRIMARY KEY (pracownik_id)

CREATE TABLE Pensja_pracownika
(
	pensja_pracownika_id int identity(1,1) constraint pracownik_id_nn NOT NULL,
	pracownik_id int constraint pracownik_id_nn NOT NULL,
	pensja smallmoney constraint pensja_nn NOT NULL,
	data_od date constraint data_od_nn NOT NULL,
	data_do date 
)

ALTER TABLE Pensja_pracownika ADD CONSTRAINT pensja_pracownika_id_pk PRIMARY KEY (pensja_pracownika_id)
ALTER TABLE Pensja_pracownika ADD CONSTRAINT pracownik_id_fk2 FOREIGN KEY (pracownik_id) REFERENCES Pracownik(pracownik_id)

CREATE TABLE Zamowienia_zywnosci
(
	zamowienia_zywnosci_id int identity(1,1) constraint zamowienia_zywnosci_id_nn NOT NULL,
	pracownik_id int constraint pracownik_id_nn NOT NULL,
	cena float,
	data datetime
)

ALTER TABLE Zamowienia_zywnosci ADD CONSTRAINT zamowienia_zywnosci_id_pk PRIMARY KEY (zamowienia_zywnosci_id)
ALTER TABLE Zamowienia_zywnosci ADD CONSTRAINT zamowienia_zywnosci_id_fk FOREIGN KEY (pracownik_id) REFERENCES Pracownik(pracownik_id)

Create TABLE Klatka_pracownika
(
	klatka_pracownika_id int identity(1,1) constraint klatka_pracownika_id_nn NOT NULL,
	pracownik_id int constraint pracownik_id_nn NOT NULL,
	klatka_id int constraint klatka_id_nn NOT NULL
)

ALTER TABLE Klatka_pracownika ADD CONSTRAINT klatka_pracownika_id_pk PRIMARY KEY (klatka_pracownika_id)
ALTER TABLE Klatka_pracownika ADD CONSTRAINT pracownik_id_fk FOREIGN KEY (pracownik_id) REFERENCES Pracownik(pracownik_id)
ALTER TABLE Klatka_pracownika ADD CONSTRAINT klatka_id_fk2 FOREIGN KEY (klatka_id) REFERENCES Klatka(klatka_id)

Create TABLE Historia_zdrowia
(
	historia_zdrowia_id int identity(1,1) constraint historia_zdrowia_id_nn NOT NULL,
	pies_id int constraint pies_id_nn NOT NULL,
	opis varchar(50) constraint opis_nn NOT NULL,
	data date constraint data_nn NOT NULL
)

ALTER TABLE Historia_zdrowia ADD CONSTRAINT historia_zdrowia_id_pk PRIMARY KEY (historia_zdrowia_id)
ALTER TABLE Historia_zdrowia ADD CONSTRAINT pies_id_fk FOREIGN KEY (pies_id) REFERENCES Pies(pies_id)

Create TABLE Pensja_minimalna
(
	pensja_minimalna_id int constraint pensja_minimalna_id_nn NOT NULL,
	wartosc smallmoney constraint wartosc_nn NOT NULL
)

ALTER TABLE Pensja_minimalna ADD CONSTRAINT pensja_minimalna_id_pk PRIMARY KEY (pensja_minimalna_id)
