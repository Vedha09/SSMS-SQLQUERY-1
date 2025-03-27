create database EcommerceDB;
use EcommerceDB;

create table customers(customerID int primary key, firstName varchar(50) not null, lastName varchar(50) not null, 
Email varchar(100) unique not null, address text, password varchar(50) unique not null);
insert into customers values(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City', 'A4op2*.183');
insert into customers values(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town', 'Vs23.rt@15');
insert into customers values(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village', 'X45*@lk.97');
insert into customers values(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb', 'C34*lj.40q');
insert into customers values(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District', 'Wq19ve*130.');
insert into customers values(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County', 'F2z84@.q596');
insert into customers values(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State', 'D30%s1.cev');
insert into customers values(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country', 'Ki97@.aq172');
insert into customers values(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province', 'Z5p@xe.901');
insert into customers values(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory', 'B2*isc1.629');
--12. Count the Number of Orders Placed by Each Customer
select c.firstName, c.lastName, count(o.orderID) as numbers_of_ordersplaced from customers c 
join orders o on c.customerID=o.customerID 
group by c.firstName, c.lastName order by numbers_of_ordersplaced;

--13. Find the Maximum Order Amount for Each Customer
select c.firstName, c.lastName, max(o.totalAmount) as total_maxamount from customers c 
join orders o on c.customerID=o.customerID 
group by c.firstName, c.lastName order by total_maxamount;

--14. Get Customers Who Placed Orders Totaling Over $1000
select c.firstName, c.lastName, sum(o.totalAmount) as total_amount from customers c 
join orders o on c.customerID=o.customerID 
group by c.firstName, c.lastName having sum(o.totalAmount)>=1000 order by total_amount;

--16. Subquery to Find Customers Who Haven't Placed Orders
select * from customers where customerID not in(select customerID from orders);

select * from customers;

create table products(productID int primary key, product_name varchar(50) not null, 
description text, price decimal(10, 2), stockQuantity int not null);
insert into products values(1, 'Laptop', 'High-performance laptop', 800.00, 10);
insert into products values(2, 'Smartphone', 'Latest smartphone', 600.00, 15);
insert into products values(3, 'Tablet', 'Portable tablet', 300.00, 20);
insert into products values(4, 'Headphones', 'Noise-canceling', 150.00, 30);
insert into products values(5, 'TV', '4K Smart TV', 900.00, 5);
insert into products values(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25);
insert into products values(7, 'Refrigerator', 'Energy-efficient', 700.00, 10);
insert into products values(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15);
insert into products values(9, 'Blender', 'High-speed blender', 70.00, 20);
insert into products values(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);
--1. Update refrigerator product price to 800
update products set price='800' where product_name='Refrigerator';
--3. Retrieve Products Priced Below $100
select * from products where price<100;

--4. Find Products with Stock Quantity Greater Than 5
select * from products where stockQuantity>5;

--6. Find Products which name end with letter ‘r’
select * from products where product_name like '%r';

--9. Determine the Minimum Stock Quantity for Each Product Category
select productID, product_name, min(stockQuantity) as minimum_stockquantity from products 
group by productID, product_name order by minimum_stockquantity;

--15. Subquery to Find Products Not in the Cart
select * from products where productID not in(select productID from cart);

--17. Subquery to Calculate the Percentage of Total Revenue for a Product
select p.product_name, (sum(i.itemAmount)/(select sum(itemAmount) from order_items)*100) as percent_totalrevenue from products p 
join order_items i on p.productID=i.productID group by p.product_name order by percent_totalrevenue;

--18. Subquery to Find Products with Low Stock
select * from products where productID in(select productID from products where stockQuantity<10);

--19. Subquery to Find Customers Who Placed High-Value Orders
select c.* from customers c where c.customerID in(select o.customerID from orders o where o.totalAmount>1000);

select * from products;

create table cart(cartID int primary key, customerID int, productID int, quantity int not null, 
foreign key (customerID) references customers(customerID), 
foreign key (productID) references products(productID) on update cascade);
insert into cart values(1, 1, 1, 2);
insert into cart values(2, 1, 3, 1);
insert into cart values(3, 2, 2, 3);
insert into cart values(4, 3, 4, 4);
insert into cart values(5, 3, 5, 2);
insert into cart values(6, 4, 6, 1);
insert into cart values(7, 5, 1, 1);
insert into cart values(8, 6, 10, 2);
insert into cart values(9, 6, 9, 3);
insert into cart values(10, 7, 7, 2);
--2. Remove all cart items for a specific customer 
delete from cart where customerID=1;

--7. Retrieve Cart Items for Customer 5
select * from cart where customerID=5;

select * from cart;

create table orders(orderID int primary key, customerID int, 
order_date date, totalAmount decimal(10, 2), shipping_address text, 
foreign key (customerID) references customers(customerID) on update cascade);
insert into orders values(1, 1, '2023-01-05', 1200.00, '123 Main St, City');
insert into orders values(2, 2, '2023-02-10', 900.00, '456 Elm St, Town');
insert into orders values(3, 3, '2023-03-15', 300.00, '789 Oak St, Village');
insert into orders values(4, 4, '2023-04-20', 150.00, '101 Pine St, Suburb');
insert into orders values(5, 5, '2023-05-25', 1800.00, '234 Cedar St, District');
insert into orders values(6, 6, '2023-06-30', 400.00, '567 Birch St, County');
insert into orders values(7, 7, '2023-07-05', 700.00, '890 Maple St, State');
insert into orders values(8, 8, '2023-08-10', 160.00, '321 Redwood St, Country');
insert into orders values(9, 9, '2023-09-15', 140.00, '432 Spruce St, Province');
insert into orders values(10, 10, '2023-10-20', 1400.00, '765 Fir St, Territory');
--5. Retrieve Orders with Total Amount Between $500 and $1000
select * from orders where totalAmount between '500' and '1000';

--8. Find Customers Who Placed Orders in 2023
select c.*, o.* from customers c join orders o on c.customerID=o.customerID where year(o.order_date)='2023';

--10. Calculate the Total Amount Spent by Each Customer
select c.firstName, c.lastName, sum(o.totalAmount) as total_amount from customers c 
join orders o on c.customerID=o.customerID 
group by c.firstName, c.lastName order by total_amount;

--11. Find the Average Order Amount for Each Customer
select c.firstName, c.lastName, avg(o.totalAmount) as average_orderamount from customers c 
join orders o on c.customerID=o.customerID 
group by c.firstName, c.lastName order by average_orderamount;

select * from orders;

create table order_items(orderItemID int primary key, orderID int, productID int, 
quantity int not null, itemAmount decimal(10, 2), 
foreign key (orderID) references orders(orderID),  
foreign key (productID) references products(productID) on update cascade);
insert into order_items values(1, 1, 1, 2, 1600.00);
insert into order_items values(2, 1, 3, 1, 300.00);
insert into order_items values(3, 2, 2, 3, 1800.00);
insert into order_items values(4, 3, 5, 2, 1800.00);
insert into order_items values(5, 4, 4, 4, 600.00);
insert into order_items values(6, 4, 6, 1, 50.00);
insert into order_items values(7, 5, 1, 1, 800.00);
insert into order_items values(8, 5, 2, 2, 1200.00);
insert into order_items values(9, 6, 10, 2, 240.00);
insert into order_items values(10, 6, 9, 2, 210.00);

select * from order_items;
