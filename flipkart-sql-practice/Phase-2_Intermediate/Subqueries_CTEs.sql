-- Subqueries & Common Table Expressions
-- All SELECT/WHERE subqueries, WITH clause

/* For each customer, show customer_id, customer_name, email, total_orders using subquery */
select customer_id, full_name, email, (select count(order_id) from Orders o where o.customer_id = c.customer_id) as total_orders
from Customers c;

/* Customers who placed more orders than the average per customer */
select customer_id, full_name, email, total_orders from (
    select c.customer_id, c.full_name, c.email, count(*) as total_orders
    from Customers c
    inner join Orders o on o.customer_id = c.customer_id
    group by c.customer_id, c.full_name, c.email
) as customers_table
where total_orders > (
    select avg(order_count)
    from (
        select count(*) as order_count
        from Orders
        group by customer_id
    ) as avg_orders
);

/* Customers with >=3 orders and their total spend */
select
    c.customer_id,
    c.full_name, c.email,
    count(*) as total_orders,
    sum(od.quantity * od.unit_price) as total_amount_spent
from Customers c
inner join Orders o on c.customer_id = o.customer_id
inner join OrderDetails od on od.order_id = o.order_id
group by c.customer_id, c.full_name, c.email
having count(*) >= 3;

/* Product Revenue & Reviews Insight (CTE and HAVING) */
select
    p.product_id,
    p.name,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_revenue,
    avg(r.rating) as average_rating
from Products p
inner join OrderDetails od on od.product_id = p.product_id
inner join Reviews r on r.product_id = od.product_id
group by p.product_id, p.name
having sum(od.quantity) >=1 and count(r.review_id) >= 1;

/* Category-Level Performance (HAVING for count) */
select
    c.category_id,
    c.category_name,
    count(p.product_id) as total_products,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_revenue
from Products p
inner join Categories c on c.category_id = p.category_id
inner join OrderDetails od on od.product_id = p.product_id
group by c.category_id, c.category_name
having count(p.product_id) >= 5
order by total_revenue desc;