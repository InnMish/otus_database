--1
create user "manager"@"localhost" identified by "manager";
create user "client"@"localhost" identified by "client";

--2
-- процедура для выборки всех товаров по скидке
create procedure get_products (OUT on_sale integer(8))
begin
    select count(product_id) into on_sale from product
    where on_sale = 1;
end;

call get_products(@a);
select @a;

--3
--даем права на исполнение юзеру client
grant execute on get_products to client;

--4
-- процедура для сбора статистики по покупкам за определенную дату и от определенной компании
delimiter $$

create procedure get_orders (out order_statistic integer(8),
					in provider_name varchar(32),
					in delivery_date date)
deterministic
sql security invoker
begin
	select COUNT(p.purchase_id) into order_statistic from purchase p
	left join delivery d on p.delivery_id = d.delivery_id
	left join provider p2 on p2.provider_id = d.provider_id
	left join customer c on c.customer_id = d.customer_id
	where p2.provider_name = provider_name
	and d.delivery_date = delivery_date;
end$$

delimiter ;

call get_orders(@a, 'delivery club', '2022-11-05');
select @a;

--5
--даем права на исполнение юзеру manager
grant execute on get_products to manager;

