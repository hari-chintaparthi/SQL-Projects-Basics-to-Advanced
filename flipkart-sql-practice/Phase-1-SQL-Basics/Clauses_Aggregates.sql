-- WHERE, ORDER BY, GROUP BY, HAVING, aggregates

select p.product_id, p.name, c.category_name, s.supplier_name
from Products p
left join Suppliers s on p.supplier_id = s.supplier_id
left join Categories c on c.category_id = p.category_id;

select o.order_id, o.order_date, c.full_name, e.full_name
from Orders o
inner join Customers c on o.customer_id = c.customer_id
inner join Employees e on e.employee_id = o.employee_id;

select top(5) p.name, s.supplier_name, p.price
from Products p
inner join Suppliers s on p.supplier_id = s.supplier_id
order by p.price desc;

select o.order_id, sum(od.quantity * od.unit_price) as Total_Amt_Paid_PerOrder
from OrderDetails od
inner join Orders o on od.order_id = o.order_id
group by o.order_id;

select p.product_id, p.name, isnull(count(od.order_detail_id),0) as times_ordered
from Products p
left join OrderDetails od on p.product_id = od.product_id
group by p.product_id, p.name;

select c.customer_id, c.full_name, c.email
from Customers c
left join Orders o on c.customer_id = o.customer_id
where o.order_id is null;

select o.order_id, c.full_name, sum(od.quantity) as total_items,
       sum(od.quantity * od.unit_price) as total_amount
from Customers c
inner join Orders o on c.customer_id = o.customer_id
inner join OrderDetails od on od.order_id = o.order_id
group by o.order_id, c.full_name;

select c.customer_id, c.full_name, count(*) as total_orders
from Customers c
inner join Orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(*) > 2;

select c.category_name, p.name, sum(od.quantity) as total_quantity_sold
from Products p
inner join OrderDetails od on p.product_id = od.product_id
inner join Categories c on c.category_id = p.category_id
group by c.category_name, p.name;