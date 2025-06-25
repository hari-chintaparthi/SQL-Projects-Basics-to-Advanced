-- Supplier-wise sales, recent supply activity

select
    s.supplier_id, s.supplier_name,
    count(p.product_id) as total_products_supplied,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_revenue_generated
from Products p
inner join Suppliers s on s.supplier_id = p.supplier_id
inner join OrderDetails od on od.product_id = p.product_id
group by s.supplier_id, s.supplier_name;

select s.supplier_id, s.supplier_name
from Suppliers s
left join Products p on p.supplier_id = s.supplier_id
left join OrderDetails od on od.product_id = p.product_id
left join Orders o on o.order_id = od.order_id
group by s.supplier_id, s.supplier_name
having max(o.order_date) is null or datediff(month, max(o.order_date), getdate()) > 6;

select top(5)
    s.supplier_id, s.supplier_name,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_revenue,
    max(o.order_date) as last_order_date
from Products p
inner join OrderDetails od on od.product_id = p.product_id
inner join Orders o on o.order_id = od.order_id
inner join Suppliers s on s.supplier_id = p.supplier_id
where datediff(month, o.order_date, getdate()) <= 3
group by s.supplier_id, s.supplier_name
order by total_revenue desc;