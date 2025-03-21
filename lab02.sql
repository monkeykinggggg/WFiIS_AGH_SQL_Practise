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
(       /* Zakresy dla poszczegolnycgh stopni zaszeregowania plac powinny byc rozlaczne ! - trzeba zadbac o logike przy wstawianiu danych */
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
(11, 5800.00, 30.00, 3, 1, '`Tester`', 'Szymański', 1),
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


/* tabela asocjacyjna */
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


/*  Zapytania: */

-- nazwisko i nazwy działu w którym pracuje pracownik dla wszystkich pracowników w kolejności alfabetycznej według nazwiska.
select p.nazwisko, d.nazwa as dzial
from pracownik p
join dzial d on p.dzial_id = d.dzial_id
order by p.nazwisko asc;


-- nazwisko, wynagrodzenie i stopień_zaszeregowania pracowników od najlepiej zarabiającego
select nazwisko, wynagrodzenie, stopien_id as stopien_zaszeregowania
from pracownik p, stopien s where p.wynagrodzenie between s.min_wynagrodzenia and s.max_wynagrodzenia
order by wynagrodzenie desc;
-- UWAGA! za pomoca join rowniez mozna to zrobic:
SELECT p.nazwisko, p.wynagrodzenie, s.stopien_id AS stopien_zaszeregowania
FROM pracownik p
JOIN stopien s ON p.wynagrodzenie BETWEEN s.min_wynagrodzenia AND s.max_wynagrodzenia
ORDER BY p.wynagrodzenie DESC;


--nazwiska pracowników zatrudnionych w wybranej lokalizacji
select nazwisko
from pracownik p join dzial d using(dzial_id)
where d.lokal='Krakow';


--numer projektu, nazwiska pracowników biorących udział w aktywnych projektach (nie ma daty ukończenie) posortowane według numeru projektu i nazwiska
SELECT pp.projekt_id, p.nazwisko
FROM pracownik_projekt pp
JOIN projekt pr ON pp.projekt_id = pr.projekt_id
JOIN pracownik p ON pp.pracownik_id = p.pracownik_id
WHERE pr.koniec IS NULL
ORDER BY pp.projekt_id, p.nazwisko;
-- albo tez:
select projekt_id, nazwisko, p.dzial_id
from (pracownik_projekt pp inner join pracownik p using(pracownik_id)) inner join projekt prj using(projekt_id)
where prj.koniec is null
order by projekt_id,nazwisko;


--dla wybranego pracownika wypisać nazwy zrealizowanych projektów
select prj.nazwa
from pracownik p inner join pracownik_projekt pp using(pracownik_id) 
inner join projekt prj using(projekt_id)
where p.nazwisko='Mrowacki' and prj.koniec is not null ;





