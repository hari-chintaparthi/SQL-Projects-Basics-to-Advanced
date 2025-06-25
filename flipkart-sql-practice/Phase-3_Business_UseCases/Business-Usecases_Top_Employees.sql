-- Most active employees, recent orders, revenue handled

select
    e.employee_id,
    e.full_name,
    count(*) as total_orders_handled,
    sum(od.quantity * od.unit_price) as total_revenue_generated
from Orders o
inner join OrderDetails od on o.order_id = od.order_id
inner join Employees e on e.employee_id = o.employee_id
group by e.employee_id, e.full_name
having count(*) >= 10;

select
    e.employee_id, e.full_name,
    count(*) as total_orders_handled,
    sum(od.quantity * od.unit_price) as total_revenue_generated
from Orders o
inner join Employees e on e.employee_id = o.employee_id
inner join OrderDetails od on od.order_id = o.order_id
group by e.employee_id, e.full_name
having sum(od.quantity * od.unit_price) > 10000;

select top(3)
    e.employee_id, e.full_name,
    sum(od.quantity) as total_orders_handled,
    sum(od.quantity * od.unit_price) as total_revenue_generated,
    max(o.order_date) as last_order_date
from Employees e
inner join Orders o on e.employee_id = o.employee_id
inner join OrderDetails od on od.order_id = o.order_id
where datediff(month, o.order_date, getdate()) <= 2
group by e.employee_id, e.full_name
order by total_revenue_generated desc;

select
    e.employee_id, e.full_name,
    format(o.order_date, 'yyyy-MM') as order_year_mon,
    count(*) as total_orders_handled,
    sum(od.quantity * od.unit_price) as total_revenue_generated
from Orders o
inner join Employees e on e.employee_id = o.employee_id
inner join OrderDetails od on od.order_id = o.order_id
group by e.employee_id, e.full_name, format(o.order_date, 'yyyy-MM');