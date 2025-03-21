-- Zadanie 1
--
-- Proszę utworzyć funkcję tablicującą wartości funkcji y = A*x2+B*x+C dla wartości A,B,C podanych przez użytkownika i x w zakresie od xo co krok. Rezultat ma być zwracany w postaci trzykolumnowej (i numer rekordu, x oraz y wartość funkcji dla danego x).
--
-- select * from rownanie_tables(1,2,1,1,1,10);(A,B,C,xo,krok, ilość_rekordów)
-- 
--   i  | x  |  y
--  ----+----+-----
--  
--    1 |  1 |   4
--  
--    2 |  2 |   9
--  
--    3 |  3 |  16
--  
--    4 |  4 |  25
--  
--    5 |  5 |  36
--  
--    6 |  6 |  49
--  
--    7 |  7 |  64
--  
--    8 |  8 |  81
--  
--    9 |  9 | 100
--  
--   10 | 10 | 121
--  
--  (10 wierszy)

CREATE OR REPLACE FUNCTION rownanie_tables(A DECIMAL, B DECIMAL, C DECIMAL, x0 DECIMAL, krok DECIMAL, ilosc_rekordow INTEGER) RETURNS TABLE(i INTEGER, x DECIMAL, y DECIMAL) AS
$$
BEGIN
	FOR it IN 1..ilosc_rekordow LOOP
		i := it;
		x := x0;
		y := A * x0 * x0 + B * x0 + C;
		x0 := x0 + krok;
		RETURN NEXT;
	END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM rownanie_tables(1, 2, 1, 1, 1, 10);

-- Zadanie 2
--
-- Proszę utworzyć funkcję rozwiązująca równanie kwadratowe
--
-- select rownanie_1(1,10,1); (A, B, C)
-- 
-- INFORMACJA:  DELTA = 96
-- 
-- INFORMACJA:  Rozwiazanie posiada dwa rzeczywiste pierwiastki
-- 
-- INFORMACJA:  x1 = -0.101020514433644
-- 
-- INFORMACJA:  x2 = -9.89897948556636
-- 
--                       equ_solve
-- 
-- ------------------------------------------------------
-- 
--  (x1 = -0.101020514433644 ),(x2 = -9.89897948556636 )
-- 
-- (1 wiersz)
-- 
-- 
-- 
--  select rownanie_1(1,10,1);
-- 
-- INFORMACJA:  DELTA = 96
-- 
-- INFORMACJA:  Rozwiazanie posiada dwa rzeczywiste pierwiastki
-- 
-- INFORMACJA:  x1 = -0.101020514433644
-- 
-- INFORMACJA:  x2 = -9.89897948556636
-- 
--                       equ_solve
-- 
-- ------------------------------------------------------
-- 
--  (x1 = -0.101020514433644 ),(x2 = -9.89897948556636 )
-- 
-- (1 wiersz)
-- 
-- 
-- 
--  select rownanie_1(10,5,1);
-- 
-- INFORMACJA:  DELTA = -15
-- 
-- INFORMACJA:  Rozwiazanie w dziedzinie liczb zespolonych
-- 
-- INFORMACJA:  x1 = -0.25 + 0.193649167310371i
-- 
-- INFORMACJA:  x2 = -0.25 - 0.193649167310371i
-- 
--                                equ_solve
-- 
-- -----------------------------------------------------------------------
-- 
--  (x1 = -0.25 + 0.193649167310371i ),(x2 = -0.25 - 0.193649167310371i )
-- 
-- (1 wiersz)

CREATE OR REPLACE FUNCTION rownanie_1(A DECIMAL, B DECIMAL, C DECIMAL) RETURNS text AS
$$
DECLARE
	delta DECIMAL;
	x0 DECIMAL;
	x1 DECIMAL;
	x2 DECIMAL;
	x1i DECIMAL;
	x2i DECIMAL;
	x1complexresult text;
	x2complexresult text;
BEGIN
	delta := B * B - 4 * A * C;
	RAISE INFO 'DELTA = %', delta;
	IF delta > 0 THEN
		RAISE INFO 'Rozwiazanie posiada dwa rzeczywiste pierwiastki';
		x1 := (-b + sqrt(delta)) / (2 * a);
		x2 := (-b - sqrt(delta)) / (2 * a);
		RAISE INFO 'x1 = %', x1;
		RAISE INFO 'x2 = %', x2;
		RETURN CONCAT('(x1 = ', x1, ' ),(x2 = ', x2, ' )');
	END IF;
	IF delta = 0 THEN
		RAISE INFO 'Rozwiazanie posiada jeden rzeczywisty pierwiastek';
		x0 := -b / (2 * a);
		RAISE INFO 'x0 = %', x0;
		RETURN CONCAT('(x0 = ', x0, ' )');
	END IF;
	IF delta < 0 THEN
		RAISE INFO 'Rozwiazanie w dziedzinie liczb zespolonych';
		x1 := -b / (2 * a);
		x2 := -b / (2 * a);
		x1i := sqrt(-delta) / (2 * a);
		x2i := -sqrt(-delta) / (2 * a);
		x1complexresult := CONCAT(x1, ' + ', x1i, 'i');
		x2complexresult := CONCAT(x2, ' + ', x2i, 'i');
		RAISE INFO 'x1 = %', x1complexresult;
		RAISE INFO 'x2 = %', x2complexresult;
		RETURN CONCAT('(x1 = ', x1complexresult, ' ),(x2 = ', x2complexresult, ' )');
	END IF;
END;
$$
LANGUAGE plpgsql;

SELECT rownanie_1(1,10,1);
SELECT rownanie_1(1,4,4);
SELECT rownanie_1(10,5,1);



-- to jest tez krup

create or replace function equ_tables( a int, b int, c int, x1 int, dx int, n int )
returns table ( i int, x int, y int ) AS
$$
	declare
		iter int := 0;
	begin
		x := x1;
		iter := 0;
		while iter < n loop
			i := iter + 1;
			x := x + dx;
			y := a*x*x + b*x + c;
			iter := iter + 1;
			return next;
		end loop;
		return;
	end;

$$
Language plpgsql ;

select * from equ_tables(1,2,1,0,1,12);


--zad2
create or replace function equ_solve( a int, b int, c int )
returns text as
$$
	declare
		delta int := b*b - 4*a*c;
		x1 numeric;
		x2 numeric;
	begin
		raise info 'INFO: DELTA = %', delta;
		if delta > 0 then
			raise info 'INFO: Rozwiazanie posiada dwa rzeczywiste pierwiastki';
			x1 := (-b - sqrt(delta)) / (2.0*a);
			x2 := (-b + sqrt(delta)) / (2.0*a);
			raise info 'x1 = %', x1;
			raise info 'x2 = %', x2;
			return 'INFO: (x1 = ' || x1 || ' ),(x2 = ' || x2 || ' )';
		elsif delta = 0 then
			raise info 'Rozwiazanie posiada jeden rzeczywisty pierwiastek';
			x1 := -b / (2.0*a);
			raise info 'x1 = %', x1;
			return 'INFO: (x1 = ' || x1 || ' )';
		elseif delta < 0 then
			raise info 'INFO: Rozwiazanie w dziedzinie liczb zespolonych';
			x1 := -b / (2.0*a);
			x2 := (sqrt(-delta)) / (2*a);
			raise info 'INFO: x1 = %',|| x1 || ' ' || x2 || 'i';
			raise info 'INFO: x2 = %', || x1 || ' ' || -x2 || 'i';
			return 'INFO: (x1 = ' || x1 || ' ' || x2 || 'i ),(x2 = ' || x1 || ' ' || -x2 ||  'i )';
		end if;
		raise info '\n';
	end;
$$
Language plpgsql ;