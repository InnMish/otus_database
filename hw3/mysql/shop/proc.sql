create procedure `transactions`()
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT 'delete all products that no longer in access, change Mail for VK, TVs for sale'
BEGIN
start transaction;
delete from product where quantity = 0;

update producer set producer_name = 'VK'
where producer_name = 'Mail';

update product set price = price - 10.00
where product_name = 'TV';
commit;
end;