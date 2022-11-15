select c.first_name, c.last_name, c.gender, a.city, a.postal_code, c.spent
from customer c
left join address a on c.address_id = a.address_id
left join company c2 on c.company_id = c2.company_id
where a.postal_code != ''
and c2.name = 'F'
and c.spent > (select AVG(spent) from customer c3);

