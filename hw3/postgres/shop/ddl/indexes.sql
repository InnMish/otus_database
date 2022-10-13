--1
-- select all deliveries on the exact date. Useful when here're many deliveries a day
create INDEX IF NOT EXISTS idx_delivery_date
    ON delivery.delivery(delivery_date);

--2

-- Index Scan using idx_delivery_date on delivery as delivery
--Index Cond: (delivery_date = '2011-01-01 00:00:00'::timestamp without time zone)
explain select * from delivery.delivery where delivery_date = '2011-01-01'

                                    --ИЛИ

--1
--select customers that have deliveries
create INDEX IF NOT EXISTS idx_customer_to_delivery ON delivery.delivery(customer_id);

--2

--1.	Merge Inner Join
--2.	Index Scan using idx_customer_to_delivery on delivery as d
--3.	Index Scan using customer_pkey on customer as c
explain select * from delivery.delivery d inner join delivery.customer c on d.customer_id = c.customer_id

--3  здесь были проблемы, пришлось поразбираться с to_tsvector и lexeme, почитала пару статей на хабре
select first_name, to_tsvector(last_name) from delivery.customer;
select first_name, to_tsvector(last_name)@@to_tsquery('mishustina | mishustin') from delivery.customer;
alter table delivery.customer add column lastName_lexeme tsvector;
update delivery.customer set lastName_lexeme = to_tsvector(last_name) where address = 'Russia';
create index search_index_last_name on delivery.customer using GIN (lastName_lexeme);

--4
-- only search for future deliveries
create index search_delivery_index on delivery.delivery(delivery_date) where delivery_date > '01-01-2022'

--5
---- select all products with such a name available for sale
CREATE INDEX IF NOT EXISTS idx_product_name_quantity
    ON shop.product(product_name, quantity);

