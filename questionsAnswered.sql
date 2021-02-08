use inlamning1;

-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter. 
SELECT categories.category as Kategori, count(*) as Antal FROM category_product
inner join categories on category_product.category_id = categories.id
GROUP BY categories.category;


-- Skapa en kundlista med den totala summan pengar som varje kund har handlat för. Kundens
-- för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas.
select customers.firstname as Namn, customers.lastname as Efternamn, (select sum(order_details.amount * products.price)) as Summa from customers
inner join orders on orders.customer_id = customers.id
inner join order_details on order_details.order_id = orders.id
inner join products on products.id = order_details.product_id
group by customers.id
;


-- Vilka kunder har köpt svarta sandaler i storlek 38 av märket Ecco? Lista deras namn.
select customers.firstname as Namn, customers.lastname as Efternamn from customers
inner join orders on orders.customer_id = customers.id
inner join order_details on order_details.order_id = orders.id
inner join products on products.id = order_details.product_id
inner join category_product on category_product.product_id = products.id
inner join categories on category_product.category_id = categories.id
inner join colors on colors.id = products.color_id
inner join brands on brands.id = products.brand_id
inner join sizes on sizes.id = products.size_id
where colors.color = 'Black' and categories.category = 'Sandaler' and sizes.size = 38 and brands.brand = 'Ecco';


-- Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än
-- 1000 kr. Ortnamn och värde ska visas. (det måste finnas orter i databasen där det har
-- handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)
select cities.city as Ort, (select sum(order_details.amount * products.price)) as Summa from customers
inner join cities on cities.id = customers.city_id
inner join orders on orders.customer_id = customers.id
inner join order_details on order_details.order_id = orders.id
inner join products on products.id = order_details.product_id 
group by cities.city
having Summa > 1000
;


-- Skapa en topp-5 lista av de mest sålda produkterna.
select sizes.size, colors.color, brands.brand, (select sum(order_details.amount)) as TotalSales from products
inner join order_details on order_details.product_id = products.id
inner join colors on colors.id = products.color_id
inner join brands on brands.id = products.brand_id
inner join sizes on sizes.id = products.size_id
group by products.id
order by TotalSales desc
limit 5
;

-- Vilken månad hade du den största försäljningen? (det måste finnas data som anger
-- försäljning för mer än en månad i databasen för att visa att frågan är korrekt formulerad)
-- select MONTHNAME(STR_TO_DATE(extract(month from orders.datum), '%m')) as Month, (select sum(orders.amount * products.price)) as Summa from orders
select MONTHNAME(STR_TO_DATE(extract(month from orders.datum), '%m')) as Month, (select sum(order_details.amount * products.price)) as Summa from order_details
inner join orders on orders.id = order_details.order_id
inner join products on products.id = order_details.product_id 
group by Month
order by sum(order_details.amount * products.price) desc
limit 1
;


-- Dessutom ska databasen utökas med funktionalitet som möjliggör att kunder kan sätta
-- betyg och kommentera på olika produkter.
select * from review_details;