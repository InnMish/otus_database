ALTER TABLE delivery
MODIFY delivery_date DATE;

--1
--находим сумму цен и количество товаров в каждой категории, если такие товары вообще имеются
select c.category_name,
       sum(price) as total_price,
       sum(quantity) as total_quantity
from product p
left join product_to_category ptc
on p.product_id = ptc.product_id
left join category c on c.category_id = ptc.category_id
group by c.category_name having total_quantity > 0;

--2
--rollup с количеством товаров по категориям
select c.category_name,
       sum(price) as total_price,
       sum(quantity) as total_quantity
from product p
left join product_to_category ptc
on p.product_id = ptc.product_id
left join category c on c.category_id = ptc.category_id
group by c.category_name with ROLLUP;

--3
--выборка, показывающая самый дорогой и самый дешевый товар в каждой категории
select c.category_name,
       min(price) as min_price,
       max(price) as max_price
from product p
left join product_to_category ptc
on p.product_id = ptc.product_id
left join category c on c.category_id = ptc.category_id
group by c.category_name;

--4
-- выбираем количество доставок на сегодня для каждого провайдера
select p.provider_name,
sum(CASE WHEN d.delivery_date = CURDATE() THEN 1 ELSE 0 END) AS delivery_today
from provider p
left join delivery d
on p.provider_id = d.provider_id
group by p.provider_name;