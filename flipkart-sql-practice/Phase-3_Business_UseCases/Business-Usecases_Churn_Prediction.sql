-- Inactive customers, reactivations (LAG/LEAD)

select c.customer_id, c.full_name, c.email, max(o.order_date) as last_order_date
from Customers c
left join Orders o on o.customer_id = c.customer_id
group by c.customer_id, c.full_name, c.email
having max(o.order_date) is null or datediff(month, max(o.order_date), getdate()) > 3;

with result_set as (
    select
        c.customer_id, format(o.order_date,'yyyy-MM') as order_month,
        format(lead(o.order_date) over(partition by c.customer_id order by o.order_date),'yyyy-MM') as next_month,
        datediff(month, o.order_date, lead(o.order_date) over(partition by c.customer_id order by o.order_date)) as gap_in_mon
    from Customers c
    inner join Orders o on o.customer_id = c.customer_id
)
select customer_id, order_month, next_month, gap_in_mon,
    case
        when gap_in_mon = 1 then 'continue'
        when gap_in_mon > 1 then 'churned or reactivated'
        when gap_in_mon is null then 'last month active'
        else 'unknown'
    end as Flag
from result_set
order by customer_id, order_month;

with cte as (
    select *, lead(order_month) over (partition by customer_id order by order_month) as next_order_month
    from (
        select customer_id, cast(datefromparts(year(order_date), month(order_date), 1) as date) as order_month
        from Orders
        group by customer_id, year(order_date), month(order_date)
    ) as inner_cte
)
select *, case
        when next_order_month is null or datediff(month, order_month, next_order_month) > 1 then 'Yes'
        else 'No'
    end as churned_in_next_month
from cte;