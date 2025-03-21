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



-- a wszystkich pracowników zatrudnionych na tym samym stanowisku co XXXXX. (nazwisko, nazwa_działu)
select p.nazwisko, d.nazwa
from pracownik p join dzial d on p.dzial_id=d.dzial_id
where stanowisko=(select stanowisko from pracownik where pracownik_id=11);

-- b wszystkich pracowników zatrudnionych w tych samych projektach co XXXXX. (id_projektu, nazwisko)
select pp.projekt_id, p.nazwisko
from pracownik p join pracownik_projekt pp on p.pracownik_id=pp.pracownik_id
where pp.projekt_id in (select pp.projekt_id 
					from pracownik p 	-- UWAGA! tutaj juz nie musimy joinowac! mamy id pracownikow nam potrzebne!
					where p.pracownik_id=15);



-- c pracowników o pensjach z listy najniższych zarobków osiągalnych w działach (nazwisko)

-- najpierw mamy zbior najnizszych zarobkow z kazdego dzialu:
select dzial_id,nazwa, cast(min(wynagrodzenie) as numeric(7,2)) from pracownik p inner join dzial d using(dzial_id) group by dzial_id,nazwa order by dzial_id;	
-- wkladamy to to zapytania:
select nazwisko
from pracownik 
where wynagrodzenie in(select min(wynagrodzenie) from pracownik p inner join dzial d using(dzial_id) group by dzial_id);	

-- uwaga, mozna bylo szybciej!!!:
select nazwisko
from pracownik 
where wynagrodzenie in(select min(wynagrodzenie) from pracownik group by dzial_id);	    -- w pracowniku juz mielismy id dzialu!


-- d pracowników o najniższych zarobkach w ich dzialach (nazwisko, pensja, daiał)

-- rekurencyjnie musimy znalezc min zarobek w dziale dla kazdego pracownika i go wyswitlic jezeli ma wlasnie tkai zarobek
select nazwisko, wynagrodzenie, nazwa
from pracownik p inner join dzial d using(dzial_id)
where wynagrodzenie = (select min(wynagrodzenie) from pracownik p2 where p2.dzial_id=p.dzial_id);

-- e stosując operator ANY wybrać pracowników zarabiających powyżej najniższego zarobku z działu XXXXXX. (nazwisko)
select nazwisko, wynagrodzenie, nazwa
from pracownik p inner join dzial d using(dzial_id)
where wynagrodzenie > any (select min(wynagrodzenie) from pracownik p2 where p2.dzial_id=p.dzial_id);   -- tutaj dostajemy zbior wynagrodzen pracownikow z tego samego dzialu dlatego musimy uzyc any

-- f pracownika, który brał udział w największej ilości projektów (bez LIMIT)  (nazwisko, ilość)
select nazwisko, count(projekt_id) as ilosc_projektow
from pracownik p inner join pracownik_projekt pp using(pracownik_id) 
group by pracownik_id,nazwisko
having count(projekt_id)>=all(select count(projekt_id) from pracownik_projekt group by pracownik_id);

-- druga opcja:
select nazwisko, count(projekt_id) as ilosc_projektow
from pracownik p inner join pracownik_projekt pp using(pracownik_id) 
group by pracownik_id,nazwisko
having count(projekt_id)=
						(select max(ile) from (
						select count(projekt_id) as ile
						from pracownik_projekt 
						group by pracownik_id) as projekty);

-- g stanowisko, na którym są najwyższe średnie zarobki. (nazwa)
select stanowisko 
from pracownik
where wynagrodzenie>=all(select avg(wynagrodzenie) from pracownik group by stanowisko);
-- UWAGA! TO JEST ZLE   bo tutaj zwracamy wynagrodzenie ktore moze byc akurat srednia z innego dzialu, a z tego pracownika nie jest juz srednia, wiec to bez sensu
select stanowisko
from pracownik
group by stanowisko
having avg(wynagrodzenie)>=all(select avg(wynagrodzenie) from pracownik gorup by stanowisko);
-- ewentualnie:     (inaczej zrobiona klauzula having)
                        = (select avg(wynagrodzenie) from pracownik gorup by stanowisko order by avg(wynagrodzenie) limit 1);


-- druga opcja:
select stanowisko 
from pracownik
group by stanowisko
having avg(wynagrodzenie)=(select avg(wynagrodzenie) from pracownik group by stanowisko order by avg(wynagrodzenie) desc limit 1);

-- h dla każdego działu ostatnio zatrudnionych pracowników. Uporządkować według dat zatrudnienia. (nazwa_działu,nazwisko)
select d.nazwa as dzial,p.nazwisko,p.staz
from pracownik p inner join dzial d using(dzial_id)
where staz<=all(select p2.staz from pracownik p2 where p.dzial_id=p2.dzial_id)
order by p.staz;

-- i zapytanie zwracające procentowy udział liczby pracowników  każdego działu w stosunku do całej firmy ((nazwa, wartosc)
select d.nazwa as dzial,
100*count(p.pracownik_id)/(select count(*) from pracownik p2)||'%' as procentowy_udzial
from pracownik p join dzial d using(dzial_id)
group by d.nazwa;