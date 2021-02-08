drop database if exists inlamning1;
create database inlamning1;
use inlamning1;

create table cities
(id int not null auto_increment primary key,
city varchar(30) not null);

insert into cities(city) values
('Solna'),('Malung'),('Nacka'),('Danderyd');


create table customers
(id int not null auto_increment primary key,
firstname varchar(30) not null,
lastname varchar(30) not null,
city_id int not null,
foreign key(city_id) references cities(id));

insert into customers(firstname, lastname, city_id) values
('Hanna', 'Edlund', 1),
('Pelle', 'Persson', 2),
('Patrich', 'Nordstand', 1),
('Karl', 'Karlsson', 3),
('Stina', 'Stefansson', 4);

create table categories
(id int not null auto_increment primary key,
category varchar(30) not null);

insert into categories(category) values
('Athletic'),('Sandaler'),('Sneakers'),('Kids'),('Women');


create table sizes
(id int not null auto_increment primary key,
size int not null);

insert into sizes(size) values
(38),(22),(40),(36),(25),(3);


create table colors
(id int not null auto_increment primary key,
color varchar(30) not null);

insert into colors(color) values
('Black'),('Pink'),('Grey'),('Red'),('Blue');


create table brands
(id int not null auto_increment primary key,
brand varchar(30));

insert into brands(brand) values
('Ecco'),('Nike'),('Puma'),('Nly'),('Babies');


create table products
(id int not null auto_increment primary key,
size_id int not null,
color_id int not null,
brand_id int not null,
price int not null,
foreign key(size_id) references sizes(id),
foreign key(color_id) references colors(id),
foreign key(brand_id) references brands(id));

insert into products(size_id, color_id, brand_id, price) values
(1, 1, 1, 599),
(2, 2, 2, 299),
(3, 3, 3, 1999),
(3, 4, 3, 1500),
(4, 2, 4, 599),
(5, 5, 1, 399),
(6, 3, 5, 100),
(1, 2, 3, 699);


create table orders
(id int not null auto_increment primary key,
datum date not null,
customer_id int not null);

insert into orders(datum, customer_id) values
('2020-12-30', 2),
('2020-11-30', 2),
('2020-11-15', 1),
('2020-10-17', 3),
('2020-12-25', 5),
('2020-12-30', 4);


create table order_details
(id int not null auto_increment primary key,
order_id int not null,
product_id int not null,
amount int not null);

insert into order_details(order_id, product_id, amount) values
(1,7,3),
(2,7,1),
(3,5,1),
(3,3,2),
(4,1,1),
(5,1,1),
(4,5,2),
(6,8,1),
(6,2,2);


create table category_product
(id int not null auto_increment primary key,
product_id int,
category_id int,
foreign key(product_id) references products(id),
foreign key(category_id) references categories(id));

insert into category_product(product_id, category_id) values
(1,2),
(2,3),
(2,4),
(3,3),
(3,1),
(4,3),
(5,5),
(6,4),
(7,4),
(8,5),
(8,2);


create table gradings
(id int not null auto_increment primary key,
name varchar(30) not null);

insert into gradings (name) values
('Mycket nöjd'), ('Nöjd'), ('Granska nöjd'), ('Missnöjd');


create table reviews
(id int not null auto_increment primary key,
customer_id int not null,
product_id int not null,
grade_id int not null,
comment varchar(50) default 'No comment',
foreign key(customer_id) references customers(id),
foreign key(product_id) references products(id),
foreign key(grade_id) references gradings(id));

insert into reviews (customer_id, product_id, grade_id) values
(2,1,1);

create or replace view review_details as
select customers.firstname as Namn, customers.lastname as Efternamn, 
sizes.size as Size, colors.color as Color, brands.brand as Brand, 
gradings.name as Betyg, reviews.comment as Kommentar 
from reviews
inner join products on products.id = reviews.product_id
inner join brands on brands.id = products.brand_id
inner join colors on colors.id = products.color_id
inner join sizes on sizes.id = products.size_id
inner join customers on customers.id = reviews.customer_id
inner join gradings on gradings.id = reviews.grade_id;