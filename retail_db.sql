create database if not exists retail_db;



use retail_db;
create table if not exists Customers (
customer_id int auto_increment primary key,
first_name varchar(30) not null,
last_name varchar(30),
email varchar(50)not null,
ph_no varchar (15) unique,
address varchar(100 )not null,
city varchar(20)not null,
country varchar(20) default 'india',
created_at timestamp default current_timestamp
);






create table Product (
product_id int primary key ,
name varchar (20) not null,
category varchar (20),
price decimal(10,2) not null ,
stock int default 0,
created_at timestamp default current_timestamp);

create table if not exists Orders (
order_id int auto_increment primary key,
customer_id int,
order_date date not null,
status varchar(20) default 'Pending',
foreign key (customer_id) references Customers(customer_id)
on delete cascade);

create table if not exists OrderDetails (
orderdetail_id int  auto_increment primary key ,
order_id int,
product_id int,
quantity int not null,
price decimal(10,2) not null ,
foreign key (order_id) references Orders(order_id) on delete cascade ,
foreign key (product_id) references product(product_id) on delete cascade
);


create table if not exists Payments(
payment_id int auto_increment primary key,
order_id int ,
payment_date date not null ,
amount decimal(10,2) not null,
method varchar (20) ,
foreign key (order_id) references Orders (order_id) on delete cascade);

insert into Customers (first_name ,last_name ,email ,ph_no ,address ,city, country)
values 
( 'JINESH' , 'SHARMA' , 'jineshsharma@gmaill.com' , 9819990290 , ' MG ROAD ', 'MUMBAI' , 'INDIA' ),
( 'alex' , 'WOODMAN' , 'alexwoodman@gmaill.com' , 9748936720 , ' CP', 'DELHI' , 'INDIA' ),
( 'AKANSH' , 'SINHA' , 'akanshsinha@gmaill.com' , 9827384123 , ' SITAPURA ', 'JAIPUR' , 'INDIA' ),
( 'VISHWESH' , 'KUMAR' , 'jvishweshkumar@gmaill.com' , 9873839274 , ' SHANTI CHAWK ', 'KATHMANDU' , 'NEPAL' ),
( 'SOHAM' , 'SINGH' , 'sohamsingh@gmaill.com' , 3894729848 , ' RAM NAGAR ', 'MUMBAI' , 'INDIA' );

insert into Product ( product_id ,name, category, price , stock)
value 
( 101, 'iPhone15' , 'electronic' , '70000' , 205),
(102, 'Macbook Air M4' , 'electronic' , '130000', '0'  ),
(103 , 'NikeJordan' , 'shoes' , '20000' , 110),
(104,  'Bottle' , 'sports' , '70000' , 1034);

update Product
set price = 1000
where product_id = 104;

-- add the gst % if possible 


insert into Orders ( customer_id , order_date, status)
value
(1, '2025-09-03', 'Pending'),
(2, '2025-09-03', 'Shipped'),
(1, '2025-09-04', 'Delivered');

insert into OrderDetails ( order_id , product_id, quantity, price )
value
(1 , 102 , 	1, 130000),
(1 , 101 , 	1, 70000),
(3 , 103 , 	1, 20000),
(2 , 104 , 	5, 1000);

insert into Payments ( order_id , payment_date , amount , method )
value 
(1, '2025-09-03', 236000, 'Credit card'),
(2, '2025-09-03', 5600, 'UPI'),
(3, '2025-09-05', 23600, 'Cash');

ALTER TABLE OrderDetails
ADD COLUMN gst DECIMAL(5,2) DEFAULT 18.00;

select * from OrderDetails;

update OrderDetails
set gst = 12
where product_id= 104;

create or replace view BillSummary as
select
od.order_id,
p.name as product ,
od.quantity,
od.price,
od.gst,
(od.quantity * od.price) as base_amount,
(od.quantity * od.price * od.gst / 100) as gst_amount,
(od.quantity * od.price * (1 + od.gst / 100)) as total_with_gst
from OrderDetails od
join Orders o on od.order_id = o.order_id
join Customers c on o.customer_id = c.customer_id
join Product p on od.product_id = p.product_id;

select * from BillSummary;

create view OrderTotals as 
select
od.order_id,
c.first_name as customer,
  sum(od.quantity* od.price),
  sum(od.quantity * od.price * od.gst / 100) as gst_amount,
  sum(od.quantity * od.price * (1 + od.gst / 100)) as total_with_gst
from OrderDetails od
join Orders o on od.order_id = o.order_id
join Customers c on o.customer_id = c.customer_id
group by od.order_id, c.first_name;


select * from OrderTotals;

create or replace view PaymentStatus as 
select
  ot.order_id,
  ot.customer,
  ot.total_with_gst as bill_amount,
  p.amount as paid_amount,
  p.method as payment_method,
  case  
     when round(p.amount,2) = round(ot.total_with_gst,2) then 'Paid'
     when p.amount is null then 'No Payment'
     else 'Mismatch'
  end as status 
from OrderTotals ot
left join Payments p on ot.order_id = p.order_id;


   

select * from PaymentStatus;

select * from Payments;

select ot.order_id, ot.total_with_gst, p.amount
from OrderTotals ot
left join Payments p on ot.order_id = p.order_id;

select * from OrderDetails;





