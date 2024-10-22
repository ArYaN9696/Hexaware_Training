

/*1..You need to create a stored procedure that retrieves a list of all customers who have purchased a specific product.
consider below tables Customers, Orders,Order_items and Products
Create a stored procedure,it should return a list of all customers who have purchased the specified product, 
including customer details like CustomerID, CustomerName, and PurchaseDate.
The procedure should take a ProductID as an input parameter.*/

create proc getcustomersbyproduct @ProductID int
as
begin
select c.customer_id AS CustomerID,
        CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
        o.order_date AS PurchaseDate
from
sales.customers c 
inner join
sales.orders o 
on c.customer_id=o.customer_id
inner join
sales.order_items oi 
on o.order_id=oi.order_id
inner join
  production.products p ON oi.product_id = p.product_id
where
p.product_id=@ProductID

END
exec getcustomersbyproduct 4

/*2..CREATE TABLE Department with the below columns
  ID,Name
populate with test data
 
 
CREATE TABLE Employee with the below columns
  ID,Name,Gender,DOB,DeptId
populate with test data
 
a) Create a procedure to update the Employee details in the Employee table based on the Employee id.
b) Create a Procedure to get the employee information bypassing the employee gender and department id from the Employee table
c) Create a Procedure to get the Count of Employee based on Gender(input)*/

create table department(
id int identity(1,1) primary key,
name varchar(20)
)
create table employee(
id int identity(1,1) primary key,
name varchar(20),
gender varchar(1),
dob date,
deptid int,
foreign key (deptid) references department(id) on delete cascade
)
insert into department (Name)
values ('HR'), ('Finance'), ('IT'), ('Sales')

insert into employee (name, gender, dob, deptid)
values 
('Rahul Sharma', 'M', '1990-01-15', 1),
('Priya Singh', 'F', '1985-05-22', 2),
('Amit Kumar', 'M', '1992-07-10', 2),
('Neha Patel', 'F', '1995-03-18', 4),
('Aryan','M','2001-08-15',3)

--a
create proc updateemp(@id int,@name varchar(20),@gender varchar(1),@dob date,@deptid int)
as
begin
update employee
set
name=@name,gender=@gender,dob=@dob,deptid=@deptid
where
id=@id;

end

--b
create procedure getemployeebygenderanddept
    @gender varchar(1),
    @deptid int
as
begin
    select 
        id, name, gender, dob, deptid
    from 
        employee
    where 
        gender = @gender
        and deptid = @deptid;
end

--c
create procedure getemployeecountbygender
    @gender varchar(1)
as
begin
    select 
        count(*) as employeecount
    from 
        employee
    where 
        gender = @gender;
end

exec getemployeebygenderanddept 'M',2

exec getemployeecountbygender @gender = 'F'

exec updateemp
    @id = 1, 
    @name = 'dude', 
    @gender = 'm', 
    @dob = '1990-01-15', 
    @deptid = 1




/*3..Create a user Defined function to calculate the TotalPrice based on productid and Quantity Products Table*/
create function 
calculate_total
(
    @productid int,
    @quantity int
)
returns decimal(10, 2)
as
begin
    return (
        select list_price * @quantity
        from production.products
        where product_id = @productid
    )
end

select dbo.calculate_total(3,2) as total_price

/*4..create a function that returns all orders for a specific customer, 
including details such as OrderID, OrderDate, and the total amount of each order.*/

create function 
ordersbycustomer(@customerid int)
returns table
as
return(
select
 o.order_id,
 o.order_date,
 sum(oi.quantity * oi.list_price) as total_amount
    from sales.orders o
    join sales.order_items oi
    on o.order_id = oi.order_id
    where o.customer_id = @customerid
    group by o.order_id, o.order_date
)

select * from dbo.ordersbycustomer(1)

/*5..create a Multistatement table valued function that calculates the total sales 
for each product, considering quantity and price.*/

create function 
calculate_total_sales()
returns @TotalSalesTable table
(
    product_id int,
    product_name varchar(255),
    total_sales decimal(10, 2)
)
as
begin
    insert into @TotalSalesTable
    select 
        p.product_id,
        p.product_name,
        sum(oi.quantity * oi.list_price) as total_sales
    from production.products p
    join sales.order_items oi
    on p.product_id = oi.product_id
    group by p.product_id, p.product_name;

    return
end


select * from dbo.calculate_total_sales()


/*6..create a  multi-statement table-valued function that lists all customers along with the 
total amount they have spent on orders.*/

create function 
calculate_total_spent()
returns @CustomerSpending table
(
    customer_id int,
    customer_name varchar(255),
    total_spent decimal(10, 2)
)
as
begin
    insert into @CustomerSpending
    select 
        c.customer_id,
        concat(c.first_name, ' ', c.last_name) as customer_name,
        sum(oi.quantity * oi.list_price) as total_spent
    from sales.customers c
    join sales.orders o
        on c.customer_id = o.customer_id
    join sales.order_items oi
        on o.order_id = oi.order_id
    group by c.customer_id, c.first_name, c.last_name;

    return
end

select * from dbo.calculate_total_spent()
