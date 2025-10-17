create database Banking;
use Banking;

create table BRANCH (branch_name varchar(30), branch_city varchar(30), assets real);
insert into BRANCH(branch_name, branch_city, assets) values
('SBI_chamrajpet','Bangalore',50000),
('SBI_ResidencyRoadt','Bangalore',10000),
('SBI_ShivajiRoad','Bombay',20000),
('SBI_ParlimentRoad','Delhi',10000),
('SBI_Jantarmantar','Delhi',20000);
select * from branch;
alter table branch add constraint primary key(branch_name);
update BRANCH set branch_name='SBI_ResidencyRoad' where branch_city='Bangalore' and assets=10000; 

create table BANK_ACCOUNT (accno int primary key, branch_name varchar(30), banalnce real, foreign key(branch_name) references BRANCH(branch_name));
alter table BANK_ACCOUNT rename column banalnce to balance;
insert into BANK_ACCOUNT (accno, branch_name, balance) values
(1,'SBI_chamrajpet', 2000),(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),(4,'SBI_ParlimentRoad',9000),
(5,'SBI_Jantarmantar',8000),(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),(9,'SBI_ParlimentRoad',3000),
(10,'SBI_ResidencyRoad',5000),(11,'SBI_Jantarmantar',2000);
select * from BANK_ACCOUNT;

create table BANK_CUSTOMER (customer_name varchar(30) primary key, customer_street varchar(30), customer_city varchar(30));
insert into BANK_CUSTOMER (customer_name, customer_street, customer_city) values
('Avinash','Bull_Temple_Road','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),
('Nikil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');
select * from BANK_CUSTOMER;

create table DEPOSITER (customer_name varchar (30) primary key, accno int, foreign key(customer_name) references BANK_CUSTOMER(customer_name), foreign key(accno) references BANK_ACCOUNT(accno));
 drop table DEPOSITER;
 
create table DEPOSITER (customer_name varchar (30), accno int  primary key, foreign key(customer_name) references BANK_CUSTOMER(customer_name), foreign key(accno) references BANK_ACCOUNT(accno));
insert into DEPOSITER(customer_name, accno) values
('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),
('Avinash',8),('Nikil',9),('Dinesh',10),('Nikil',11);
select * from DEPOSITER;

create table LOAN (loan_no int primary key, branch_name varchar(30), amount real, foreign key(branch_name) references BRANCH(branch_name));
insert into LOAN (loan_no, branch_name, amount) values
(1,'SBI_chamrajpet',1000), (2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000), (4,'SBI_ParlimentRoad',4000),
(5,'SBI_Jantarmantar',5000);
select * from LOAN;

select C.customer_name from BANK_CUSTOMER C where exists (
select D.customer_name, count(D.customer_name) from DEPOSITER D, BANK_ACCOUNT BA where D.accno=BA.accno and C.customer_name=D.customer_name and BA.branch_name='SBI_ResidencyRoad' group by D.customer_name having count(D.customer_name)>=2accidentaccident);


select D.customer_name from DEPOSITER D, BANK_ACCOUNT BA, BRANCH B where D.accno=BA.accno and BA.branch_name=B.branch_name and B.branch_city='Delhi' group by D.customer_name having count(distinct(B.branch_name))=(select count(branch_name) from branch where branch_city='Delhi');

create table BORROWER (customer_name varchar(30), loan_no int primary key, foreign key(customer_name) references BANK_CUSTOMER(customer_name));
insert into borrower (customer_name, loan_no) values
('Avinash',1),('Dinesh',2),('Mohan',3),('Nikil',4),('Ravi',5);

select distinct(customer_name) from borrower where customer_name not in (select customer_name from depositer);

select customer_name from borrower bo,loan l where bo.loan_no =l.loan_no and l.branch_name in ( select branch_name from depositer D, bank_account BA where D.accno=BA.accno and BA.branch_name in (select branch_name from branch where branch_city ='Bangalore'));

insert into branch values ('SBI_MantriMarg','Delhi',200000);
insert into bank_account values (12,'SBI_MantriMarg',2000);

select branch_name from branch where assets > all (select assets from branch where branch_city='Bangalore');

delete from bank_account where branch_name in (select branch_name from branch where branch_city='Bombay');

update bank_account set balance=balance+(0.05*balance);
select * from bank_account;