-- Monthly revenue, suppliers, customers

select
    c.category_id, c.category_name,
    format(o.order_date,'yyyy-MM') as month,
    sum(od.quantity) as total_units_sold,
    sum(od.quantity * od.unit_price) as total_revenue,
    avg(od.unit_price) as average_unit_price
from Products p
inner join Categories c on c.category_id = p.category_id
inner join OrderDetails od on od.product_id = p.product_id
inner join Orders o on o.order_id = od.order_id
group by c.category_id, c.category_name, format(o.order_date,'yyyy-MM')
having sum(od.quantity) > 50
order by c.category_id, month;

with cte as (
    select *, lag(monthly_revenue) over(partition by supplier_id order by months asc) as previous_revenue
    from (
        select s.supplier_id, s.supplier_name, format(o.order_date,'yyyy-MM') as months,
            sum(od.quantity * od.unit_price) as monthly_revenue
        from Products p
        inner join Suppliers s on s.supplier_id = p.supplier_id
        inner join OrderDetails od on od.product_id = p.product_id
        inner join Orders o on o.order_id = od.order_id
        group by s.supplier_id, s.supplier_name, format(o.order_date,'yyyy-MM')
    ) as Results
)
select *,
    case
        when monthly_revenue > previous_revenue then 'Up'
        else 'No'
    end as growth_flag
from cte;