create schema zad05;
set search_path to zad05;
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
    manager_id int,
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

INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(17, 5500.00, 30.00, 5, 2, 'Programista', 'Kowalski', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(2, 4800.00, 25.00, 3, 1, 'Księgowy', 'Nowak', 2);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(3, 7000.00, 40.00, 8, 1, 'Ksiegowy', 'Wiśniewski', 3);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(5, 5300.00, 35.00, 4, 2, 'Tester', 'Kaczmarek', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(6, 4600.00, 20.00, 2, 2, 'Młodszy Księgowy', 'Wiśniewska', 3);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(7, 7600.00, 45.00, 10, 3, 'Kierownik Sprzedaży', 'Wójcik', 3);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(8, 6900.00, 30.00, 7, 3, 'Specjalista ds. Sprzedaży', 'Lewandowski', 3);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(9, 5400.00, 50.00, 6, 4, 'Specjalista ds. Marketingu', 'Kowalczyk', 4);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(10, 5100.00, 40.00, 5, 4, 'Grafik', 'Dąbrowski', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(13, 4800.00, 22.00, 2, 4, 'Tester', 'Nowicka', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(14, 8500.00, 50.00, 15, 1, 'Architekt IT', 'Grabowski', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(15, 7200.00, 55.00, 9, 1, 'Senior Programista', 'Król', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(11, 5800.00, 30.00, 3, 1, 'Tester', 'Szymanski', 1);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(16, 7000.00, 30.00, 5, 1, 'Tester', 'Wojewódzki', 2);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(4, 6200.00, 50.00, 6, 1, 'Specjalista', 'Zielinski', 4);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(12, 7500.00, 60.00, 12, 3, 'Dyrektor Sprzedaży', 'Mrowacki', 4);
INSERT INTO pracownik (pracownik_id, wynagrodzenie, prowizja, staz, manager_id, stanowisko, nazwisko, dzial_id) VALUES(1, 6000.00, 20.00, 2, NULL, 'Tester', 'Pilsudzki', 1);


INSERT INTO stopien (stopien_id, min_wynagrodzenia, max_wynagrodzenia) VALUES(1, 1000.00, 5000.00);
INSERT INTO stopien (stopien_id, min_wynagrodzenia, max_wynagrodzenia) VALUES(2, 5000.01, 7000.00);
INSERT INTO stopien (stopien_id, min_wynagrodzenia, max_wynagrodzenia) VALUES(3, 7000.01, 8000.00);
INSERT INTO stopien (stopien_id, min_wynagrodzenia, max_wynagrodzenia) VALUES(4, 8000.01, 20000.00);


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

INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(1, 1);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(2, 14);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(2, 11);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(2, 5);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(3, 8);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(3, 7);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(3, 12);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(4, 9);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(4, 10);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(4, 13);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(1, 4);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(2, 15);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(3, 6);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(2, 1);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(1, 6);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(1, 15);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(4, 12);
INSERT INTO pracownik_projekt (projekt_id, pracownik_id) VALUES(1, 12);


/* Dodatkowa tabelka do lab05 */
CREATE TABLE staff ( empno INT, empname VARCHAR(20), mgrno INT ) ;
    
   INSERT INTO staff VALUES ( 100, 'Kowalski',    null),
                       ( 101, 'Jasny',      100),
                       ( 102, 'Ciemny',     101),
                       ( 103, 'Szary',     102),
                       ( 104, 'Bury',    101),
                       ( 105, 'Cienki',    104),
                       ( 106, 'Dlugi', 100),
                       ( 107, 'Stary',       106),
                       ( 108, 'Mlody',   106),
                       ( 109, 'Bialy',    107),
                       ( 110, 'Sztuka',      109),
                       ( 111, 'Czarny',       110),
                       ( 112, 'Nowy',     110),
                       ( 113, 'Sredni', 110),
                       ( 114, 'Jeden',      100),
                       ( 115, 'Drugi',    114),
                       ( 116, 'Ostatni',       115),
                       ( 117, 'Lewy',   115)  ; 



-- ZADANIA:
-- 1.Proszę zapisać kwerendę krzyżową (CASE) tworzącą raport w postaci

select d.nazwa as nazwa_dzialu,
sum(case
		when pp.projekt_id = 1 then 1 else 0
	end
	) as "projekt_1",
sum(case
		when pp.projekt_id = 2 then 1 else 0
	end
	) as "projekt_2",
sum(case
		when pp.projekt_id = 3 then 1 else 0
	end
	) as "projekt_3",
sum(case
		when pp.projekt_id = 4 then 1 else 0
	end
	) as "projekt_4"
from pracownik_projekt pp join pracownik p using(pracownik_id) join dzial d using(dzial_id)
group by d.dzial_id,d.nazwa
order by d.dzial_id;

-- 2.Proszę zapisać kwerendę z wyrażeniem tabelarycznym (CTE) zwracająca zestawienie w ile osób z poszczególnych działów brało udział w poszczególnych projektach (nazwa_działu nazwa projektu, ilość_osób)

with zestaw as(select* from pracownik_projekt join pracownik using(pracownik_id)),
zestaw_dzialy as(select* from zestaw join dzial using(dzial_id))
select nazwa as nazwa_dzialu,
	sum(case
		when projekt_id = 1 then 1 else 0   -- count
		end
		) as "projekt_1",
	sum(case
			when projekt_id = 2 then 1 else 0
		end
		) as "projekt_2",
	sum(case
			when projekt_id = 3 then 1 else 0
		end
		) as "projekt_3",
	sum(case
			when projekt_id = 4 then 1 else 0
		end
		) as "projekt_4"
from zestaw_dzialy group by dzial_id,nazwa
order by dzial_id;

-- mozna zawsze zrobic cos takiego lpatologicznie:
with project_departament as(
	select prj.projekt_id, prj.nazwa,d.dzial_id,d.nazwa, count(pracownik_id) as ile_pracownikow_w_danym_projekcie_i_dziale
	from pracownik_projekt pp join projekt prj using(projekt_id)
	join pracownik p using(pracownik_id) 
	join dzial d using(dzial_id)
	group by prj.projekt_id,prj.nazwa, d.dzial_id, d.nazwa
)
select * from project_departament ;


-- 3. nazwisko pracownika i jego przełożonego

-- pierwsza opcja: gdy wypisujemy rowzniez najwyzszego nadzorce

/*select s.empno,s.empname as employee_name,s.mgrno,
(select empname from staff s2 where s.mgrno=s2.empno) as manager_name
from staff s;*/

-- druga opcja, bez wypisywania najwiekszego managera bez nikogo nad soba:
select s.empno,s.empname,s.mgrno,s2.empname
from staff s join staff s2 on s.mgrno=s2.empno;


-- 4. nazwisko pracownika, nazwisko bezpośredniego przełożonego i poziom w hierarchii
with recursive cte as (
	select p.pracownik_id,p.nazwisko,null::integer as manager_id, null::varchar as manager, 1 as lvl 
	from pracownik p where manager_id is null
	
	union 
	
	select p.pracownik_id,p.nazwisko,c.pracownik_id, c.nazwisko,lvl+1
	from cte c join pracownik p on p.manager_id = c.pracownik_id
)
select * from cte;

-- 5. nazwisko pracownika, poziom w hierarchii i listę przełożonych
with recursive emp_man as (
	select s.*,1 as lvl,'' as path
	from staff s
	where mgrno is null
	union all
	select s.*, em.lvl+1, em.path||' -> '||em.empname
	from staff s inner join emp_man em on s.mgrno=em.empno	
)
select empname,lvl,path
from emp_man;

-- na liscie moich pracownikow:

with recursive cte as (
	select p.pracownik_id,p.nazwisko,null::integer as manager_id, ' ' as manager, 1 as lvl
	from pracownik p where manager_id is null
	
	union 
	
	select p.pracownik_id,p.nazwisko, c.pracownik_id, c.manager||' -> '||c.nazwisko,lvl+1
	from cte c join pracownik p on p.manager_id = c.pracownik_id
)
select * from cte;



