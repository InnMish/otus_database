--3
select sum(points) from statistic group by (year_game) order by year_game

--4
with year_amount as (
select year_game, sum(points) as year_points
	from statistic
	group by year_game order by year_game
)
select year_points from year_amount
--5
select lag (sum(points)) over (order by year_game) as lag_1,
sum(points), year_game from statistic group by year_game