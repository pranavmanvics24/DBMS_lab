show databases;
create database Insurance;
use Insurance;

create table PERSON (driver_id varchar(5) primary key, name varchar(30), address varchar(50));
insert into PERSON values('A01', 'Richard','Srinivas nagar');
insert into PERSON values('A02', 'Pradeep','Rajaji nagar');
insert into PERSON values('A03', 'Smith','Ashok nagar');
insert into PERSON values('A04', 'Venu','N R Colony');
insert into PERSON values('A05', 'Jhon','Hanumanth nagar');
select * from PERSON;

create table CAR (reg_num varchar(10) primary key, model varchar(30), year int);
insert into CAR values('KA052250', 'Indica',1990);
alter table CAR modify reg_num varchar(15);
insert into CAR values('KA031181', 'Lancer',1957);
insert into CAR values('KA095477', 'Toyota',1998);
insert into CAR values('KA053408', 'Honda',2008);
insert into CAR values('KA041702', 'Audi',2005);
select * from CAR;

create table OWNS(driver_id varchar(5) primary key, reg_num varchar(15), foreign key(driver_id) references PERSON(driver_id));
insert into OWNS values('A01','KA052250');
insert into OWNS values('A02','KA053408');
insert into OWNS values('A03','KA031181');
insert into OWNS values('A04','KA095477');
insert into OWNS values('A05','KA041702');
select* from OWNS;

create table PARTICIPATED(driver_id varchar(5) primary key, reg_num varchar(15), report_num int, damage_amount int, foreign key(driver_id) references PERSON(driver_id));
insert into PARTICIPATED values('A01','KA052250', 11, 10000);
insert into PARTICIPATED values('A02','KA053408', 12, 50000);
insert into PARTICIPATED values('A03','KA095477',13,25000);
insert into PARTICIPATED values('A04', 'KA031181',14,3000);
insert into PARTICIPATED values('A05', 'KA041702',15,5000);
select * from PARTICIPATED;

create table ACCIDENT (report_num int primary key, accident_date date, location varchar(30));
insert into ACCIDENT values(11,'2003-01-01','Mysore road');
insert into ACCIDENT values(12,'2004-02-02','South End circle');
insert into ACCIDENT values(13,'2003-01-21','Bull Temple road');
insert into ACCIDENT values(14,'2008-02-17','Mysore road');
insert into ACCIDENT values(15,'2005-03-04','Kankpura road');
select * from ACCIDENT;

show tables;

update PARTICIPATED set damage_amount=25000 where report_num=12 and reg_num='KA053408';
insert into accident values(16,'2008-03-15','Domlur');
select accident_date, location from accident;

select driver_id from participated where damage_amount>=25000;

alter table owns add constraint foreign key(reg_num) references CAR(reg_num);

alter table participated add constraint foreign key(reg_num) references car(reg_num);
alter table participated add constraint foreign key(report_num) references accident(report_num);