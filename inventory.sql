create database inventory;
use inventory;

create table supplier(
S_id char(5),
Sname varchar(20),
Sadd varchar(30),
Scity varchar(30),
Sphone char(15),
Semail varchar(30));

 ALTER TABLE supplier
ALTER COLUMN S_id CHAR(5) NOT NULL;


 alter table supplier
 add constraint s_pk primary key(S_id);

alter table supplier
alter column Sname varchar(30) not null;

alter table supplier
alter column Scity varchar(30) not null;

alter table supplier
add constraint s_unique unique(Sphone);

EXEC sp_help 'supplier';


create table prod(
Pid char(5) primary key,
Pdesc char(30) not null,
Price float(15) check (price>0),
category varchar(30) check (category in('IT','HA','HC')),
S_id char(5),
constraint s_fk foreign key(S_id) references supplier(S_id));

EXEC sp_help 'prod';

create table stock(
Pid char(5) foreign key(Pid) references prod(Pid),
SQTY int check(SQTY>=0),
ROL int check(ROL>0),
MOQ int check(MOQ>=5));

 exec sp_help 'stock';

 create table customer(
 Cid char(5) primary key,
 Cname varchar(30) not null,
 Caddress varchar(30) not null,
 CCity varchar(30) not null,
 Cphone char(15)not null unique,
 Cemail varchar(30) not null,
 Cdob date check(Cdob < '2000-1-1'));

 exec sp_help 'customer';

 create table orders(
 Oid char(5),
 Odate date,
 Pid char(5) foreign key(Pid) references Prod(Pid),
 Cid char(5) foreign key(Cid) references customer(Cid),
 OQTY int);

 execute sp_help 'orders';



INSERT INTO supplier (S_id, Sname, Sadd, Scity, Sphone, Semail)
VALUES
('S001', 'Aryan Traders', '12 MG Road', 'Mumbai', '02223456789', 'aryantraders@gmail.com'),
('S002', 'Sharma Enterprises', '45 Brigade Road', 'Bengaluru', '08044556677', 'sharmaent@gmail.com'),
('S003', 'Kapoor & Co', '78 Nehru Marg', 'Delhi', '01122334455', 'kapoorco@gmail.com'),
('S004', 'Patel Supplies', '23 Station Road', 'Ahmedabad', '07998765432', 'patelsupplies@gmail.com'),
('S005', 'Singh Industries', '56 MG Road', 'Chandigarh', '01722233445', 'singhindustries@gmail.com'),
('S006', 'Reddy Solutions', '89 Residency Road', 'Hyderabad', '04055667788', 'reddysolutions@gmail.com'),
('S007', 'Mehta Traders', '34 Marine Drive', 'Mumbai', '02233445566', 'mehtatraders@gmail.com'),
('S008', 'Gupta Enterprises', '67 Park Street', 'Kolkata', '03377889900', 'guptaent@gmail.com'),
('S009', 'Verma Industries', '12 Palace Road', 'Jaipur', '01412223344', 'vermaindustries@gmail.com'),
('S010', 'Iyer Supplies', '90 Church Street', 'Bengaluru', '08099887766', 'iyersupplies@gmail.com');

select * from supplier;

INSERT INTO prod (Pid, Pdesc, Price, Category, S_id)
VALUES
('P001', 'Laptop Dell Inspiron', 55000, 'IT', 'S001'),
('P002', 'HP Desktop', 45000, 'IT', 'S002'),
('P003', 'Lenovo ThinkPad', 65000, 'IT', 'S003'),
('P004', 'iPhone 13', 70000, 'IT', 'S004'),
('P005', 'Samsung Galaxy S21', 65000, 'IT', 'S005'),
('P006', 'Leather Sofa', 25000, 'HA', 'S006'),
('P007', 'Dining Table Set', 18000, 'HA', 'S007'),
('P008', 'Queen Bed', 22000, 'HA', 'S008'),
('P009', 'Microwave Oven', 8000, 'HA', 'S009'),
('P010', 'Refrigerator LG', 28000, 'HA', 'S010'),
('P011', 'Hair Dryer', 1200, 'HC', 'S001'),
('P012', 'Shampoo Pack', 350, 'HC', 'S002'),
('P013', 'Face Cream', 500, 'HC', 'S003'),
('P014', 'Handwash', 150, 'HC', 'S004'),
('P015', 'Toothpaste', 100, 'HC', 'S005'),
('P016', 'Router TP-Link', 1500, 'IT', 'S006'),
('P017', 'Smartwatch', 7000, 'IT', 'S007'),
('P018', 'Vacuum Cleaner', 5000, 'HA', 'S008'),
('P019', 'Iron Box', 1200, 'HA', 'S009'),
('P020', 'Face Wash', 250, 'HC', 'S010');

select * from prod;

INSERT INTO stock (Pid, SQTY, ROL, MOQ)
VALUES
('P001', 50, 10, 5),
('P002', 30, 5, 10),
('P003', 20, 5, 5),
('P004', 15, 3, 5),
('P005', 25, 5, 10),
('P006', 40, 8, 5),
('P007', 10, 2, 5),
('P008', 35, 7, 5),
('P009', 50, 10, 5),
('P010', 12, 3, 5);

select * from stock;

INSERT INTO customer (Cid, Cname, Caddress, CCity, Cphone, Cemail, Cdob)
VALUES
('C001', 'Ravi Kumar', '12 MG Road', 'Mumbai', '02212345678', 'ravikumar@gmail.com', '1985-06-12'),
('C002', 'Anita Sharma', '45 Brigade Road', 'Bengaluru', '08023456789', 'anitasharma@gmail.com', '1990-11-05'),
('C003', 'Vikram Singh', '78 Nehru Marg', 'Delhi', '01134567890', 'vikramsingh@gmail.com', '1978-02-20'),
('C004', 'Priya Patel', '23 Station Road', 'Ahmedabad', '07945678901', 'priyapatel@gmail.com', '1995-09-18'),
('C005', 'Sunil Reddy', '56 Residency Road', 'Hyderabad', '04056789012', 'sunilreddy@gmail.com', '1982-07-03'),
('C006', 'Neha Gupta', '67 Park Street', 'Kolkata', '03367890123', 'nehagupta@gmail.com', '1989-04-27'),
('C007', 'Arjun Verma', '12 Palace Road', 'Jaipur', '01412345678', 'arjunverma@gmail.com', '1975-12-15'),
('C008', 'Lakshmi Iyer', '90 Church Street', 'Bengaluru', '08078901234', 'lakshmiyer@gmail.com', '1988-03-09'),
('C009', 'Deepak Mehta', '34 Marine Drive', 'Mumbai', '02289012345', 'deepakmehta@gmail.com', '1992-08-22'),
('C010', 'Kavita Joshi', '15 Brigade Road', 'Bengaluru', '08090123456', 'kavitajoshi@gmail.com', '1980-05-30');

select * from customer;

INSERT INTO orders (Oid, Odate, Pid, Cid, OQTY)
VALUES
('O001', '2026-02-01', 'P001', 'C001', 2),
('O002', '2026-02-02', 'P004', 'C002', 1),
('O003', '2026-02-03', 'P006', 'C003', 3),
('O004', '2026-02-04', 'P010', 'C004', 1),
('O005', '2026-02-05', 'P015', 'C005', 5);

select * from orders;
-- IN THE INVENTORY STRUCTURE DISPLAY :
--1) PID, PDESC,  CATEGORY, SNAME, SCITY

select Pid,Pdesc,category,Sname,Scity from prod p,supplier s where s.S_id=p.S_id;


--2 ) DISPLAY OID , ODATE , CNAME, CADDRESS, CPHONE, PDESC, PRICE,OQTY, AMT
select Oid,Odate,Cname,Caddress,Cphone,Pdesc,price,OQTY,price*OQTY as amt from orders o,customer c,prod p where p.Pid=o.Pid and c.Cid = o.Cid;

/*4) IN THE INVENTORY STRUCTURE GENERATE A VIEW BILL. IT SHOULD DISPLAY
OID,ODATE,CNAME,ADDRESS,PHONE,PDESC, PRICE, OQTY, AMOUNT*/

use inventory;
SELECT* FROM prod,customer,orders;

go 
create view view_bill as 
select Oid,Odate,Cname,Caddress,Cphone,Pdesc,Price,OQTY,Price*OQTY as amount from customer c,Orders o,prod p where o.Cid=c.Cid and p.PId=o.pid;


