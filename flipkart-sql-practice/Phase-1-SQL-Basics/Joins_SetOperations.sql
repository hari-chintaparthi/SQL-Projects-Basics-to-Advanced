-- INNER, LEFT, RIGHT, FULL, UNION, INTERSECT

-- Example set operations with joins from your schema

select customer_id from Orders
intersect
select customer_id from Reviews;

select product_id from OrderDetails
union
select product_id from Reviews;