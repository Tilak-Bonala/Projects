USE restaurant_db;
-- 1.1 View the menu_items table.
select *
from menu_items;
-- 1.2 Find number of items on the menu
select count(*)
from menu_items;
-- 1.3 What are the  least price and most expensive items on the menu?
select *  
from menu_items
where price =(select Min(Price) from menu_items) ;

select * 
from menu_items
where price =(select MAX(Price) from menu_items);

-- 1.4 How many Italian dishes are on the menu?
select *
from menu_items
where category = "Italian";
-- 1.5 What are the least and most expensive dishesh in each category?
select category,menu_item_id,item_name,price
from menu_items
where category = "Italian"
order by price
limit 1;
select category,menu_item_id,item_name,price
from menu_items
where category = "Italian"
order by price DESC
limit 1;
-- 1.6 How many dishes in each category?
select category,count(*)
from menu_items
group by category;

-- 1.7 Average dishe prices with in each category
select category,avg(price) as average_price
from menu_items
group by category;

-- 2.1 order details 
select *
from order_details;

-- 2.2 order date analysis
select *
from order_details
order by order_date;
select *
from order_details
order by order_date desc;

-- 2.3 Orders with in date range
select count(*)
from order_details;

-- 2.4 Looking for orders having more number of items
select order_id,count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;

-- 2.5 Looking for orders having more number of items 12
select count(*)
from ( select order_id,count(item_id) as num_items
       from order_details
       group by order_id
      having num_items>12) as orders;
      
-- 3.1 Combine the menu_items and order_details tables into a single table.
select *
from order_details od 
left join  menu_items mi on od.item_id=mi.menu_item_id;

-- 3.2  What were the least and most ordered items? What categories were they in?
select item_name,category,count(order_details_id) as num_purchases
from order_details od 
left join  menu_items mi on od.item_id=mi.menu_item_id
group by item_name,category
order by num_purchases asc ;

select item_name,category,count(order_details_id) as num_purchases
from order_details od 
left join  menu_items mi on od.item_id=mi.menu_item_id
group by item_name,category
order by num_purchases desc ;

-- 3.3 What were the top 5 orders that spent the most money?
select order_id,sum(price) as total_spent
from order_details od 
left join  menu_items mi on od.item_id=mi.menu_item_id
group by order_id
order by total desc
limit 5;
-- 3.5 View the details of the top 5 highest spend orders
select category,count(item_id) as num_items 
from order_details od 
left join  menu_items mi on od.item_id=mi.menu_item_id
where order_id =440
group by category;

-- Top 5 orders
select order_id,category,count(item_id) as num_items 
from order_details od 
left join  menu_items mi on od.item_id=mi.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by order_id,category;

