create schema zad02;
set search_path to zad02;
create table dzial
(
        dzial_id int primary key,
        nazwa varchar(64) not null,
        lokal varchar(64) not null
);

create table pracownik
(
    pracownik_id int primary key,
    wynagrodzenie numeric(7,2) not null check(wynagrodzenie>=1000.0),
    prowizja numeric(7,2) not null check(prowizja between 20 and 60),
    staz int not null check(staz>=0),
    manager_id int not null,
    stanowisko varchar(32) not null,
    nazwisko varchar(32) not null,
    dzial_id int references dzial(dzial_id) on delete cascade
);

create table stopien
(
        stopien_id int primary key ,
        min_wynagrodzenia numeric(7,2) check(min_wynagrodzenia>=1000.0),
        max_wynagrodzenia numeric(7,2),
        constraint logika check(min_wynagrodzenia<max_wynagrodzenia)
);

create table projekt
(
    projekt_id int primary key,
    nazwa varchar(64) not null,
    start date not null,
    koniec date
);

insert into dzial(dzial_id,nazwa,lokal) values
(1,'IT','Krakow'),
(2,'Zarzad','Warszawa'),
(3,'Ksiegowosc','Warszawa'),
(4,'Marketing','Gdansk');

insert into pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES
(1, 5500.00, 30.00, 5, 2, 'Programista', 'Kowalski', 1),
(2, 4800.00, 25.00, 3, 1, 'Księgowy', 'Nowak', 2),
(3, 7000.00, 40.00, 8, 1, 'Ksiegowy', 'Wiśniewski', 3),
(4, 6200.00, 50.00, 6, 1, 'Specjalista', 'Zieliński', 4),
(5, 5300.00, 35.00, 4, 2, 'Tester', 'Kaczmarek', 1),
(6, 4600.00, 20.00, 2, 2, 'Młodszy Księgowy', 'Wiśniewska', 3),
(7, 7600.00, 45.00, 10, 3, 'Kierownik Sprzedaży', 'Wójcik', 3),
(8, 6900.00, 30.00, 7, 3, 'Specjalista ds. Sprzedaży', 'Lewandowski', 3),
(9, 5400.00, 50.00, 6, 4, 'Specjalista ds. Marketingu', 'Kowalczyk', 4),
(10, 5100.00, 40.00, 5, 4, 'Grafik', 'Dąbrowski', 1),
(11, 5800.00, 30.00, 3, 1, 'Tester', 'Szymański', 1),
(12, 7500.00, 60.00, 12, 3, 'Dyrektor Sprzedaży', 'Zielińska', 4),
(13, 4800.00, 22.00, 2, 4, 'Tester', 'Nowicka', 1),
(14, 8500.00, 50.00, 15, 1, 'Architekt IT', 'Grabowski', 1),
(15, 7200.00, 55.00, 9, 1, 'Senior Programista', 'Król', 1);

insert into stopien(stopien_id,min_wynagrodzenia,max_wynagrodzenia) values
(1, 1000.00, 3000.00),
(2, 3000.01, 8000.00),
(3, 8000.01, 12000.00),
(4, 12000.01, 20000.00);



SET datestyle TO 'ISO, YMD';

insert into projekt(projekt_id,nazwa,start,koniec) values
(1, 'Ulepszanie sprzedazy,relacje z klientami', '2023-01-15', '2023-12-31'),
(2, 'Portal internetowy', '2023-03-01', '2023-09-30'),
(3, 'Aplikacja mobilna', '2023-06-10', NULL),
(4, 'Automatyzacja procesow', '2024-02-01', NULL);


create table pracownik_projekt
(
	projekt_id int references projekt(projekt_id),
	pracownik_id int references pracownik(pracownik_id)
);

insert into pracownik_projekt(projekt_id,pracownik_id) values
(1, 1), 
(2, 14),
(2, 11), 
(2, 5), 
(3, 8), 
(3, 7), 
(3, 12),
(4, 9),  
(4, 10),
(4, 13),
(1, 4),  
(2, 15), 
(3, 6);


/*
a
*/
select p.projekt_id,p.nazwa, count(pracownik_id) as ilosc_pracoownikow
from projekt p join pracownik_projekt pp on p.projekt_id=pp.projekt_id
group by p.projekt_id,p.nazwa
;

/*
b
*/

select stanowisko, max(wynagrodzenie)
from pracownik
group by stanowisko
;

/*
c
*/

select d.nazwa, avg(wynagrodzenie) as kwota
from dzial d join pracownik p on d.dzial_id=p.dzial_id
group by d.dzial_id,d.nazwa having count(p.pracownik_id)>3;

/*
d
*/
select (max(wynagrodzenie)-min(wynagrodzenie))
from pracownik;

/*
e
*/
select s.stopien_id, avg(p.wynagrodzenie)
from pracownik p join stopien s on p.wynagrodzenie between s.min_wynagrodzenia AND s.max_wynagrodzenia
group by s.stopien_id
order by s.stopien_id asc;

/*
f
*/
select pp.pracownik_id, count(pp.projekt_id) as ilosc_projektow
from projekt p join pracownik_projekt pp on p.projekt_id=pp.projekt_id
group by pp.pracownik_id
order by count(pp.projekt_id)
limit 1
;

/*
g
*/
select prj.projekt_id,d.nazwa
from ((dzial d join pracownik p using(dzial_id)) join pracownik_projekt pp using(pracownik_id))join  projekt prj using(projekt_id)
group by prj.projekt_id,d.nazwa;


/*
h
*/
select manager_id, count(pracownik_id) as ilosc_podwladnych
from pracownik
group by manager_id
;

/*
i
*/
select p.nazwisko
from pracownik_projekt pp join pracownik p using(pracownik_id)
group by p.nazwisko having count(projekt_id)>1;

/*
j
*/

select pp.projekt_id,sum(p.wynagrodzenie) as koszt
from (projekt prj join pracownik_projekt pp using(projekt_id))join pracownik p using(pracownik_id)
group by pp.projekt_id;



