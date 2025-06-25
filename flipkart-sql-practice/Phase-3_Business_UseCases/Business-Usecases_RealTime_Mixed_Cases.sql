-- All mixed queries from Phases 1–3 together

select p.product_id, p.name, p.date_listed, max(o.order_date) as last_sold_date
from Products p
left join OrderDetails od on od.product_id = p.product_id
left join Orders o on o.order_id = od.order_id
group by p.product_id, p.name, p.date_listed
having max(o.order_date) is null or datediff(month, max(o.order_date), getdate()) > 6;

select
    c.customer_id, c.full_name,
    count(distinct format(o.order_date, 'yyyy-MM')) as months_count,
    sum(od.quantity * od.unit_price) as total_spent
from Customers c
inner join Orders o on o.customer_id = c.customer_id
inner join OrderDetails od on od.order_id = o.order_id
group by c.customer_id, c.full_name
having count(distinct format(o.order_date, 'yyyy-MM')) > 3;

select top(3)
    c.customer_id, c.full_name,
    count(distinct o.order_id) as total_orders,
    sum(od.quantity * od.unit_price) as total_spent,
    max(o.order_date) as last_order_date
from Customers c
inner join Orders o on o.customer_id = c.customer_id
inner join OrderDetails od on od.order_id = o.order_id
where datediff(month, o.order_date, getdate()) < 6
group by c.customer_id, c.full_name
having count(distinct o.order_id) > 2
order by total_spent desc;

with cte as (
    select *, avg(total_monthly_spent) over (partition by month) as monthly_avg_customer_spending
    from (
        select
            format(o.order_date, 'yyyy-MM') as month, c.customer_id, c.full_name,
            sum(od.quantity * od.unit_price) as total_monthly_spent
        from Customers c
        inner join Orders o on o.customer_id = c.customer_id
        inner join OrderDetails od on od.order_id = o.order_id
        group by format(o.order_date, 'yyyy-MM'), c.customer_id, c.full_name
    ) as results
)
select *
from cte
where total_monthly_spent > monthly_avg_customer_spending;

with cte as (
    select
        e.employee_id, e.full_name,
        sum(od.quantity) as total_orders_handled,
        sum(od.quantity * od.unit_price) as total_revenue_generated,
        max(o.order_date) as last_order_date
    from Orders o
    inner join Employees e on e.employee_id = o.employee_id
    inner join OrderDetails od on od.order_id = o.order_id
    where datediff(month, o.order_date, getdate()) <= 3
    group by e.employee_id, e.full_name
    having sum(od.quantity) >= 5
)
select *
from cte
where total_revenue_generated > (select avg(total_revenue_generated) from cte);