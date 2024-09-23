
--SCHEMA design

create database Eapp

--TABLE customers
create table customers(
customer_id int not null primary key,
[name] varchar(20),
email varchar(30) unique,
[password] varchar(20))

--TABLE products

create table products(
product_id int not null primary key,
[name] varchar(20),
price int ,
[description] varchar(200),
stockQuantity int )

--TABLE cart

create table cart(
cart_id int not null primary key,
customer_id int ,
constraint FK_cart_customers foreign key(customer_id) references customers(customer_id),
product_id int ,
constraint FK_cart_products foreign key(product_id) references products(product_id),
quantity int)

--TABLE orders

create table orders(
order_id int not null primary key,
customer_id int,
constraint FK_orders_customers foreign key(customer_id) references customers(customer_id),
order_date date,
total_price int,
shipping_address varchar(200))

--TABLE order_items

create table order_items(
order_item_id int not null primary key,
order_id int ,
constraint FK_oitem_orders foreign key(order_id) references orders(order_id),
product_id int ,
constraint FK_oitem_products foreign key(product_id) references products(product_id),
quantity int)


insert into customers (customer_id, name, email, password) values
(1001, 'john doe', 'john.doe@example.com', 'password123'),
(1002, 'jane smith', 'jane.smith@example.com', 'securepass')

insert into products (product_id, name, price, description, stockQuantity) values
(2001, 'laptop', 50000, 'high-performance laptop', 10),
(2002, 'smartphone', 20000, 'latest model smartphone', 25)

insert into cart (cart_id, customer_id, product_id, quantity) values
(3001, 1001, 2001, 1),  
(3002, 1002, 2002, 2)

insert into orders (order_id, customer_id, order_date, total_price, shipping_address) values
(4001, 1001, '2024-09-23', 50000, '123 main st, city a'),
(4002, 1002, '2024-09-24', 40000, '456 elm st, city b')


insert into order_items (order_item_id, order_id, product_id, quantity) values
(5001, 4001, 2001, 1),  
(5002, 4002, 2002, 2)





