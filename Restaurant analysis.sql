select *
from menu_items;

-- count the number of items on the menu
select count(menu_item_id) as "Number of items on menu"
from menu_items;

-- Find the highest and lowest priced item on the menu
select item_name, price
from menu_items
where price = (select max(price) from menu_items)
union all
select item_name, price
from menu_items
where price = (select min(price) from menu_items);

-- Find the number of Italian dishes
select count(*) as "Number of Italian Dishes"
from menu_items
where category = "Italian";

-- Count how many dishes of each category there are
select category, count(*) as "Number of Dishes"
from menu_items
group by category;

-- Find the average price of each category
select category, round(avg(price), 2)
from menu_items
group by category;

select *
from order_details;

-- find the date range of orders from the orders table
select min(order_date) "Oldest Order", max(order_date) as "Newest Order"
from order_details;

-- count how many total orders there are
select count(distinct order_id) as "Number of Orders"
from order_details;

-- count how many total items there were ordered
select count(*) as "Items Ordered"
from order_details;

-- find the orders with the most items in a single order
select order_id, count(item_id) as "Items in a single order"
from order_details
group by order_id
order by count(item_id) desc;

-- find all the orders that contain the largest amount of items ordered
WITH order_counts AS (
  SELECT order_id, COUNT(*) AS item_count
  FROM order_details
  GROUP BY order_id
),
max_count AS (
  SELECT MAX(item_count) AS max_items
  FROM order_counts
)
SELECT oc.order_id, oc.item_count
FROM order_counts oc
JOIN max_count mc ON oc.item_count = mc.max_items;

-- only show orders that had more than 12 items
select count(*) as "Orders with More than 12 Items" from
(select order_id, count(item_id)
from order_details
group by order_id
having count(item_id) > 12
order by count(item_id) desc) as number_of_orders;

-- join the two tables
select *
from menu_items m
join order_details o 
on m.menu_item_id = o.item_id;

-- find the least ordered item
select item_name, count(order_details_id)
from menu_items m
join order_details o 
on m.menu_item_id = o.item_id
group by item_name
order by count(order_details_id)
limit 1;

-- find the most ordered item
select item_name, count(order_details_id)
from menu_items m
join order_details o 
on m.menu_item_id = o.item_id
group by item_name
order by count(order_details_id) desc
limit 1;

-- find the 5 largest orders
select order_id, sum(price) as "Total Price in Order"
from menu_items m
join order_details o 
on m.menu_item_id = o.item_id
group by order_id
order by sum(price) desc
limit 5;

-- find the details of the largest order
select *
from menu_items m
join order_details o 
on m.menu_item_id = o.item_id
where order_id = 440;

-- find the details of the 5 largest orders
select *
from menu_items m
join order_details o 
on m.menu_item_id = o.item_id
where order_id in(440, 2075, 1957, 330, 2675);