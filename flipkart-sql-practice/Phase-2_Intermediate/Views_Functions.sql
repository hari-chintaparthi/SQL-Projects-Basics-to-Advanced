-- Views, Conditional, System Functions
-- CASE, IF-ELSE, COALESCE

/* Identify high-value products that haven't been sold in the last 4 months. */
select
    p.product_id, p.name, (od.unit_price),
    max(o.order_date) as last_sold_date,
    case
        when max(o.order_date) is null then 'Never Sold'
        when datediff(month, max(o.order_date), getdate()) > 4 then 'Not Sold Recently'
        else 'Sold Recently'
    end as status_on_orders
from Products p
left join OrderDetails od on od.product_id = p.product_id
left join Orders o on o.order_id = od.order_id
where od.unit_price > 1000
group by p.product_id, p.name, od.unit_price;

/* Product price update: show old and new price if price < 100 */
select
    product_id,
    name,
    supplier_id,
    price as old_price,
    round(price * 1.15, 2) as new_price
from Products
where price < 100;
