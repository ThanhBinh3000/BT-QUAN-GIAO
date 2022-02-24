create database TourDuLich;
use TourDuLich;

create table diemdendulich(
id int auto_increment primary key,
name varchar(50),
description  varchar(50),
price double,
cyty_id int
);

create table khachhang(
id int auto_increment primary key,
name varchar(50),
identuty varchar(20),
city_id integer
);

create table thanhpho(
id int auto_increment primary key,
name varchar(50)
);

create table tour(
id int auto_increment primary key,
ma_tour varchar(10) unique,
type_tour_id int,
diem_den_id  int,
startDate   datetime,
endDate  datetime
);

create table typeTour(
id int auto_increment primary key,
ma_type varchar(10) unique,
name varchar(50)
);

create table bill(
id int auto_increment primary key,
tour_id int,
customer_id int,
status bit
);

alter table diemdendulich add foreign key (city_id) references Thanhpho (id);
alter table khachhang add foreign key (city_id) references Thanhpho (id);
alter table tour add foreign key (type_tour_id) references typeTour (id);
alter table tour add foreign key (diem_den_id) references diemdendulich (id);
alter table bill add foreign key (tour_id) references tour (id);
alter table bill add foreign key (customer_id) references khanhhang(id);

insert into Thanhpho (name)
values ('HN'),
       ('DN'),
       ('HCM'),
       ('HP'),
       ('BN');
       
insert into typeTour ( ma_type, name)
values ('001', 'A'),       
       ('002', 'B'),
       ('003', 'C'),
       ('004', 'D'),
       ('005', 'E');
       
insert into diemdendulich (name, description, price, city_id)
values ('Tiên Giới', 'RÙa', 1000, 1),
       ('Linh Giới', 'Hồ', 1500, 2),
       ('Minh Giới', 'Trần', 1100, 3),
       ('Mãng Hoang Giới', 'Hoang', 1600, 1),
       ('Linh La Giới', 'Yên Bình', 1400, 4);
       
insert into khachhang (name, identity, dateOfBirth, city_id)
values ('Bình' , '00001000', 2000, 1),
       ('Diệp' , '00002000', 2001, 2),
       ('Thư' , '00003000', 2002, 2),
       ('Hà' , '00004000', 2003, 5),
       ('Mạnh' , '00005000', 2004, 3),
       ('Tú' , '00006000', 2005, 3),
       ('Thúy' , '00007000', 2006, 1),
       ('Hiền' , '00008000', 2000, 2),
       ('Nhung' , '00009000', 2001, 4),
       ('Nga' , '000010000', 2002, 2);
       
insert into tour (ma_tour, type_tour_id, diem_den_id, startDate, endDate)
values ('001', 1, 2, '2022-01-12', '2022-01-20'),
       ('002', 2, 3, '2022-02-11', '2022-02-20'),
       ('003', 3, 2, '2022-02-12', '2022-02-20'),
       ('004', 4, 1, '2022-02-12', '2022-02-20'),
       ('005', 5, 2, '2022-01-12', '2022-01-20'),
       ('006', 1, 3, '2022-01-12', '2022-01-20'),
       ('007', 2, 2, '2022-01-12', '2022-01-20'),
       ('008', 3, 2, '2022-01-12', '2022-01-20'),
       ('009', 4, 1, '2022-01-12', '2022-01-20'),
       ('010', 3, 2, '2022-01-12', '2022-01-20'),
       ('011', 2, 4, '2022-01-12', '2022-01-20'),
       ('012', 5, 1, '2022-01-12', '2022-01-20'),
       ('013', 2, 4, '2022-01-12', '2022-01-20'),
       ('014', 3, 1, '2022-01-12', '2022-01-20'),
       ('015', 1, 2, '2022-01-12', '2022-01-20');
       
insert into bill (tour_id, customer_id, status)
VALUES (1, 2, 1),
       (2, 2, 1),
       (2, 3, 0),
       (3, 1, 1),
       (4, 1, 1),
       (4, 2, 1),
       (3, 1, 0),
       (2, 3, 0),
       (4, 2, 0),
       (4, 2, 1),
       (2, 1, 0),
       (5, 3, 1);
       
# -    Thống kê số lượng tour của các thành phố
select Thanhpho.name, count(tour.id) as 'Số lượng tour'
from Thanhpho
         left join diemdendulich on diemdendulich.city_id = Thanhpho.id
         left join tour on diemdendulich.id = tour.diem_den_id
group by Thanhpho.name;

# -    Tính số tour có ngày bắt đầu trong tháng 1 năm 2022
select count(id) as 'số tour'
from tour
where month(startDate) = 1
  and year(startDate) = 2022;

#- Tính số tour có ngày kết thúc trong tháng 2 năm 2022
select count(id) as 'số tour'
from tour
where month(endDate) = 2 and year(endDate) = 2022;

