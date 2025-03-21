create schema zad06;
set search_path to zad06;

create table dzial
(
        dzial_id int primary key,
        nazwa varchar(64) not null,
        lokal varchar(64) not null
);

create table pracownik
(
    pracownik_id int primary key ,
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
	projekt_id int references projekt(projekt_id) on delete cascade,
	pracownik_id int references pracownik(pracownik_id) on delete cascade
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




/* dodatkowe tablice do lab06 */
create table koszty
    (
    projekt_id                      integer,
    koszt_graniczny                 numeric (7,2), --koszt graniczny
    pracownicy                      integer    not null, --ilosc proacowników w projekcie
    koszt_plus                      numeric(7,2), --kwota o która koszt projektu przekracza wartosc graniczna
    CONSTRAINT                      koszt_pk PRIMARY KEY(projekt_id)
  );

create table nagrody
    (
    pracownik_id                   integer,
    nagroda                         numeric(7,2), 
    date                             date, --data przyznania nagrody, czyli moment wykonania funkcji
    CONSTRAINT                      nagrody_pk PRIMARY KEY(pracownik_id)
  ); 


-- Tabela koszty przechowuje informacje o projektach, które przekraczają wyznaczony koszt graniczny 
create or replace function fun_1(integer)
returns integer as 
$$
declare
	graniczny alias for $1;
	count_rec integer:=0;
begin
	delete from koszty; -- usuwamy wynik ostatniego wywolania

	insert into koszty(projekt_id,koszt_graniczny,pracownicy,koszt_plus)
	select prj.projekt_id,graniczny,sum(p.wynagrodzenie) as pracownicy,sum(p.wynagrodzenie)-graniczny
	from projekt prj
	join pracownik_projekt pp on prj.projekt_id=pp.projekt_id
	join pracownik p on pp.pracownik_id=p.pracownik_id
	group by prj.projekt_id
	having sum(p.wynagrodzenie)>graniczny;

	GET DIAGNOSTICS count_rec = ROW_COUNT; -- get rows from last insert
    RETURN count_rec;
end
$$
language plpgsql;

select fun_1(30000);        -- koszt graniczny = 30 000


/*Proszę skonstruować trygger, który zrealizuje wprowadzanie danych do tabel powiązanych
Tabela koszty przechowuje informacje o projektach, które przekraczają wyznaczony koszt graniczny (ćwiczenie1 z poprzednich zajęć).
Należy skonstruować wyzwalacz, który będzie uruchamiany po każdej zmianie w tabeli projekt_pracownik, który będzie aktualizował tabelę koszty*/

CREATE OR REPLACE FUNCTION update_koszty() 
RETURNS TRIGGER AS 
$$
BEGIN
	delete from koszty where projekt_id = new.projekt_id; --usuwamy te rekordy kore nalezaly do dodanego projektu

    insert into koszty(projekt_id,koszt_graniczny,pracownicy,koszt_plus)
	select prj.projekt_id,30000,sum(p.wynagrodzenie) as pracownicy,sum(p.wynagrodzenie)-30000
	from projekt prj
	join pracownik_projekt pp on prj.projekt_id=pp.projekt_id
	join pracownik p on pp.pracownik_id=p.pracownik_id
	where prj.projekt_id = new.projekt_id
	group by prj.projekt_id
	having sum(p.wynagrodzenie)>30000;

    RETURN NEW;
END;
$$ 
LANGUAGE 'plpgsql';

CREATE or replace TRIGGER koszty after update ON pracownik_projekt
FOR EACH ROW EXECUTE PROCEDURE update_koszty();

update pracownik_projekt set pracownik_id = 14 where (pracownik_id <> 14 and projekt_id=3);




/*Proszę skonstruować trygger, który po każdych 3 projektach, w których bierze udział pracownik zwiększy jego premie   o 2% - nie może być wyższa niż 100
--do tabeli pracownik dodajemy kolumnę premia, która przechowuje wartość premii przysługująca pracownikowi
ALTER TABLE pracownik ADD COLUMN premia REAL DEFAULT 0 CHECK (premia BETWEEN 0.0 AND 100.0); --dodajemy*/

alter table pracownik rename column prowizja to premia;
alter table pracownik add constraint check_premia  check(premia between 0.0 and 100.0);


CREATE OR REPLACE FUNCTION premia_trigger()
RETURNS TRIGGER AS
$$
BEGIN
	if ((select count(*) from pracownik_projekt where pracownik_id=new.pracownik_id) % 3 = 0)		-- po kazdym dodaniu kolejnych 3 projektow
		
	then 
		update pracownik set premia = premia+ premia*0.02 where pracownik_id=new.pracownik_id;
	end if;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

create trigger update_premia after insert on pracownik_projekt 
for each row execute procedure premia_trigger();

insert into pracownik_projekt (projekt_id,pracownik_id) values(1,17);
insert into pracownik_projekt (projekt_id,pracownik_id) values(2,17);
insert into pracownik_projekt (projekt_id,pracownik_id) values(3,17);


/*Proszę skonstruować trygger, który zapewnienia integralności danych
Próba usunięcia pracownika z tabeli pracownik 
w przypadku, gdy bierze on udział w niezrealizowanym projekcie  nie może  zostać usunięty  - należy wygenerować stosowny komunikat
w przypadku, gdy nie bierze on udziału w niezrealizowanym projekcie  może  zostać usunięty - i cała historia jego pracy */

CREATE OR REPLACE FUNCTION custom_employee_deletion_trigger()
RETURNS TRIGGER AS
$$
BEGIN
	-- jezeli pracownik ma nieskonczone projekty
	if (exists(select 1 
				from pracownik_projekt pp join projekt prj using(projekt_id)
				where pp.pracownik_id=old.pracownik_id and prj.koniec is null ))
	then
	raise notice 'pracownik bierze udział w niezrealizowanym projekcie  nie może  zostać usunięty';
	else
	delete from pracownik_projekt where pracownik_id=old.pracownik_id;
	end if;
	return old;
END;
$$
LANGUAGE plpgsql;


-- przed proba
create trigger employee_deletion before delete on pracownik for each row execute procedure custom_employee_deletion_trigger();




