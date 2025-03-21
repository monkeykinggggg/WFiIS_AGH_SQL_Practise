-- zad1
select nr_konta, typ, kategoria, sum(kwota) from transakcje group by rollup(nr_konta, typ, kategoria) order by nr_konta, typ, kategoria;;

-- zad2
select nr_konta, typ, sum(kwota) from transakcje group by grouping sets((nr_konta, typ),nr_konta) order by nr_konta, typ;

-- zad3
select nr_konta, typ,avg(kwota) as srednia from transakcje group by cube(nr_konta, typ) order by nr_konta, typ;

-- zad4
select 
	rank() over (partition by kategoria order by kwota desc) as rank,
	dense_rank() over (partition by kategoria order by kwota desc) as dense_rank,
	kategoria, data, kwota 
from transakcje 
where nr_konta='11-11111111';

-- zad5
select 
	kwota, data, nr_konta
from (
	select kwota, data, nr_konta, rank() over (order by kwota desc) as rank
    from transakcje
    WHERE typ='WPŁATA'
)as tr
where rank<4;