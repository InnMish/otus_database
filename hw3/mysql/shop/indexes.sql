--существующие индексы
create index idx_delivery_date
ON delivery(delivery_date);

create index idx_customer_to_delivery
ON delivery(customer_id);

CREATE index idx_product_name_quantity
ON product(product_name, quantity);

---------------------------------------

--можно искать разные модели похожих товаров
ALTER TABLE product ADD INDEX type( (CAST(description->>'$.type' AS char(60))) );

--ищем только телевизоры с функцией SmartTv
--здесь может использоваться индекс idx_product_name_quantity, чтобы найти product_name,
--но не используется индекс по json
--explain:
-- id   select_type  table  type  possible_keys                             key
-- 1	SIMPLE	     p		ref	  idx_product_name_quantity,product_name	idx_product_name_quantity
SELECT * FROM product p
WHERE description ->>'$.type' = 'SmartTv' and product_name = 'TV';

-- а здесь используется index по json, потому что мы используем функцию преобразования
-- explain
-- id   select_type  table  type  possible_keys                                 key
-- 1	SIMPLE	     p		ref	  idx_product_name_quantity,type,product_name	type
SELECT * FROM product p
WHERE CAST(description ->>'$.type' as char(60)) = 'SmartTv' and product_name = 'TV';


-- добавили поле, чтобы  реализовать полнотекстовый поиск
alter table product add details text ;
alter table product add fulltext(product_name,details);

--ищем телевизоры с функцией bluetooth
SELECT * FROM product WHERE MATCH (product_name,details) AGAINST ('bluetooth') and product_name = 'TV';