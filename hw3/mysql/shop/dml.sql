--1
--узнаем, товары каких поставщиков есть на складе
select distinct producer_name from producer p
inner join product pr
on p.producer_id = pr.producer_id ;

--2
--находим все товары в категории Электроника
select product_name from product p
left join product_to_category ptc
on p.product_id = ptc.product_id
left join category c on c.category_id = ptc.category_id
where c.category_name = 'Electronics';

--3.1
--выбираем всю электронику с подходящей ценой. Частый фильтр в интернет-магазинах
select product_name, quantity from product p
left join product_to_category ptc
on p.product_id = ptc.product_id
left join category c on c.category_id = ptc.category_id
where c.category_name = 'Electronics' and p.price < 100.00;

--3.2
--выбираем все товары, которые есть в наличии
select product_name, price from product p
where quantity > 0;

--3.3
--выбираем все службы доставки, у которых не заполнена детальная информация, чтобы заполнить и начать с ними работать
select provider_name from provider p where details is null;

--3.4
-- выбираем товары, которые не относятся к какой-либо категории. Дальше можно или заполнить, или отнести их к категории Разное
select product_name, quantity from product p
left join product_to_category ptc
on p.product_id = ptc.product_id
left join category c on c.category_id = ptc.category_id
where c.category_name is null;

--3.5
-- выбираем телевизоры в диапазоне цены от 100 до 500
select description, quantity from product p
where p.product_name = 'TV'
and (p.price > 100.00) and (p.price < 500.00);