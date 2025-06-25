-- Top products by revenue, average prices

select category_id, category_name, product_id, name, total_revenue_generated
from (
    select
        c.category_id, c.category_name, p.product_id, p.name,
        sum(od.quantity * od.unit_price) as total_revenue_generated,
        dense_rank() over (partition by c.category_id order by sum(od.quantity * od.unit_price) desc) as revenue_ranks
    from Orders o
    inner join OrderDetails od on od.order_id = o.order_id
    inner join Products p on od.product_id = p.product_id
    inner join Categories c on c.category_id = p.category_id
    where datediff(month, o.order_date, getdate()) <= 6
    group by c.category_id, c.category_name, p.product_id, p.name
) as top_selling_product
where revenue_ranks = 1;

select p.product_id, p.name, count(*) as number_of_reviews
from Products p
inner join Reviews r on p.product_id = r.product_id
group by p.product_id, p.name
having count(*) > 5;

select
    c.category_id, c.category_name,
    count(od.product_id) as total_products,
    sum(od.quantity) as total_units_sold,
    avg(od.unit_price) as average_product_price
from Products p
inner join Categories c on p.category_id = c.category_id
inner join OrderDetails od on od.product_id = p.product_id
group by c.category_id, c.category_name;

select
    c.category_id, c.category_name,
    avg(p.price) as avg_unit_price,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_sales_revenue
from Products p
inner join Categories c on p.category_id = c.category_id
inner join OrderDetails od on od.product_id = p.product_id
group by c.category_id, c.category_name;

select top(3)
    c.category_id, c.category_name,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_revenue
from Products p
inner join Categories c on c.category_id = p.category_id
inner join OrderDetails od on od.product_id = p.product_id
group by c.category_id, c.category_name
order by total_revenue desc;