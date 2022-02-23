create database student_management;
use student_management;

create table students(
  id int primary key auto_increment,
  name varchar(50) not null,
  address varchar(50) not null ,
  sex bit default 0,
  age int not null ,
  email varchar(50) unique not null ,
  phone varchar(10)
);

create table classes (
    id int primary key auto_increment not null ,
    name varchar(50) not null
);


alter table students add column class_id int;

alter table students add foreign key (class_id) references classes(id);

insert into classes (name) values ('B1'),
                                  ('B2'),
                                  ('B3'),
                                  ('B4'),
                                  ('B5');

insert into students (name, address, sex ,age, email, phone, class_id) values
                        ('BINH', 'HN', 1, 25, 'BINH@codegym.vn',03333333,1),
                        ('hoa', 'HN', 1, 22, 'viet2k@codegym.vn',03333333,1),
                        ('Viet', 'HCM', 1, 32, 'Viet91@codegym.vn',03333333,2),
                        ('Toan', 'DN', 1, 36, 'toan@codegym.vn',03333333,1),
                        ('Quach Minh', 'HN', 0, 27, 'minhquach@codegym.vn',03333333,2),
                        ('Tinh', 'HN', 0, 26, 'tinh@codegym.vn',03333333,3),
                        ('Sang', 'DN', 1, 27, 'sang@codegym.vn',03333333,4),
                        ('leminh', 'HN', 1, 32, 'minh.le@codegym.vn',03333333,2),
                        ('thuy', 'HN', 0, 32, 'thuy@codegym.vn',03333333,3),
                        ('cuong', 'HCM', 1, 23, 'cuong@codegym.vn',03333333,1);
 #7)hiển thị tất cả học viên có trong bảng studert
 select *
 from students;
 
 #8) hiển thị tất cả học viên nam 
 select * 
 from students
 where sex =1;
 
 #9) hiển thị tất cả học viên có số tuổi nhỏ nhơ và bằng 25
 select *
 from students
 where age <=25;
 
 #10) hiển thị tất cả học viên có quê hà nội, hồ chí minh
 select *
 from students
 where address in ('HN', 'HCM');
                        
#11) hiển thị tất cả học viên không quê ở hà nội
select *
from students
where address <> 'HN'; # <>: khác 

#12) hiển thị tất cả học viên có tên bắt đầu bằng chữ h
select *
from students
where name like 'H%';

#13) hiển thị tất cả học viên có tên là việt
select *
from students
where name like '%viet';

#14) hiển thị đanh sách học viên theo tên giảm dần
select *
from students
order by name desc;

#15) hiển thị danh sách học viên theo tuổi tăng dần 
select *
from students
order by age, name desc;

#16) hiển thị tổng số lượng học sinh mỗi lớp 
select c.name, count(students.id) as 'Sĩ số'
from students join classes c on students.class_id = c.id
group by c.name;

#17. Hiển thị lớp có số lượng học viên là đông nhất
select classes.name, count(students.id)
from classes join students on students.class_id = classes.id
group by classes.name
having count(students.id) = (
    select count(students.id)
    from students join classes on students.class_id = classes.id
    group by students.class_id
    order by count(students.id) desc
    limit 1
    );

# 18. Hiển thị lớp có số lượng học viên là ít nhất
select classes.name, count(students.id)
from classes join students on students.class_id = classes.id
group by classes.name
having count(students.id) = (
    select count(students.id)
    from students join classes on students.class_id = classes.id
    group by students.class_id
    order by count(students.id)
    limit 1
);

#15.Thống kê số lượng học viên theo từng địa chỉ
select address, count(id)
from students
group by address;
#16.Hiển thị những lớp có số lượng học viên lớn hơn 3
select classes.name, count(s.id)
from classes join students s on classes.id = s.class_id
group by classes.name
having count(s.id) >= 3;
#17.Hiển thị những thành phố có số lượng học viên lớn hơn 3
select address, count(students.id)
from students
group by address
having count(students.id) >= 3;
#18.Hiển thị học viên có tuổi lớn nhất
select *
from students
where age = (select max(age) from students);
#19. Hiển thị học viên có tuổi nhỏ nhất
select *
from students
where age = (select min(age) from students);
#20. Cập nhật thông tin của học viên có quê ở Hà Nội thành giới tính nữ
update students set sex = 0 where address = 'HN';
select *
from students
where address='HN';
#21.Hiển thị học viên có số tuổi lớn thứ hai
# Tìm học viên tuổi lớn nhất => tìm tuổi lớn nhất trong dãy còn lại sau khi bỏ max
select *
from students
where age = (select max(age)
              from students
              where age < (select max(age)
                           from students));
#22.Hiển thị học viên có số tuổi lớn thứ hai
select *
from students
where age = (select min(age)
             from students
             where age > (select min(age)
                          from students));
#23. Hiển thị học viên có tuổi nhỏ thứ 2 và đếm số lượng học viên có số tuổi như vậy.
select age, count(students.id)
from students
where age = (select age
             from students
             where age = (select min(age)
                          from students
                          where age > (select min(age)
                                       from students)))
group by age;