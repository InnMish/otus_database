--1
--выбираем всех customer с российским номером телефона
select first_name, last_name from delivery.customer where phone similar to '(\+7|8)%';

--2
--выбираем имена и номера телефонов только тех клиентов, которые ожидают доставку
--в данном случае порядок в from такой, потому что мы хотим получить только тех клиентов, которые ожидают доставку.
--При другом порядке мы бы получили всех клиентов независимо от того, ждут они доставку или нет, так как left join
--подразумевает получение всех записей из левой таблицы и совпадающих из правой.
select first_name, phone from delivery.delivery as d left join delivery.customer as c
on c.customer_id = d.customer_id;

--3
--Добавляем нового клиента
insert into delivery.customer (first_name, last_name, address, phone)
values ('Jack', 'Sparrow', 'Caribbean', '123654789') returning delivery.customer.*;

--4
--Обновляем client_id в таблице доставок так, чтобы все доставки, адресованные Джеку Воробью, получила Элизабет Свон
update delivery.delivery
set customer_id = (select c.customer_id from delivery.customer c
				   where c.first_name = 'Elizabeth' and c.last_name = 'Swan')
where customer_id = (select c.customer_id from delivery.customer c
					   where c.first_name = 'Jack' and c.last_name = 'Sparrow');

--5
--Удаляем все доставки из Амазона
delete from delivery.delivery d using delivery.provider p
  where d.provider_id = p.provider_id and p.provider_name = 'Amazon'


