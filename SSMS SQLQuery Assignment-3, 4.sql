create database SISDB1;
use SISDB1;

create table Students(student_id int primary key, first_name VARCHAR(50) not null, last_name VARCHAR(50) not null, 
date_of_birth date not null, email VARCHAR(100) unique not null, phone_number VARCHAR(25) unique);
insert into Students values(101, 'Vedha', 'sruthi', '2003-12-09', 'vedhasruthi.091203@gmail.com', '7871437250');
insert into Students values(102, 'Aparna', 'shree', '2003-11-10', 'aparnashree.101103@gmail.com', '8912534670');
insert into Students values(103, 'Sowmi', 'priya', '2004-02-15', 'sowmipriya.150204@gmail.com', '7654983210');
insert into Students values(104, 'Gowri', 'shankar', '2003-09-24', 'gowrishankar.240303@gmail.com', '9231465790');
insert into Students values(105, 'Ammu', 'valli', '2003-01-05', 'ammuvalli.050102@gmail.com', '8071625340');
insert into Students values(106, 'Lina', 'son', '2002-04-18', 'linason.180403@gmail.com', '6789012345');
insert into Students values(107, 'Tharun', 'kumar', '2003-07-30', 'tharunkumar.200703@gmail.com', '8124914041');
insert into Students values(108, 'Manisha', 'gopi', '2002-08-29', 'manishagopi.290802@gmail.com', '7102983640');
insert into Students values(109, 'Eniyan', 'velu', '2004-01-02', 'eniyanvelu.200104@gmail.com', '8907162345');
insert into Students values(110, 'Dani', 'Jason', '2003-06-17', 'danijason.170603@gmail.com', '9102348765');
--1
insert into Students values(111, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');
select * from Students where date_of_birth between '2003-05-15' and '2004-05-30';
--6
delete from Students where student_id=1;

----1
select s.first_name, s.last_name, sum(p.amount) as Total_Payment from Students s join Payments p on s.student_id=p.student_id where s.student_id=4 group by s.first_name, s.last_name;

----3
select s.first_name, s.last_name from Students s 
left join Enrollments e on s.student_id=e.student_id where e.course_id is null;

----4
select s.first_name, s.last_name, c.course_name from Students s 
join Enrollments e on s.student_id=e.student_id 
join Courses c on e.course_id=c.course_id;

----6
select distinct s.first_name, s.last_name, e.enrollment_date from Students s 
join Enrollments e on s.student_id=e.student_id 
join Courses c on e.course_id=c.course_id where c.course_id<9;

----7
select s.first_name, s.last_name from Students s 
left join Payments p on s.student_id=p.student_id where p.payment_id is null;

----9
select s.first_name, s.last_name, count(e.course_id) as number_of_courses from Students s 
join Enrollments e on s.student_id=e.student_id group by s.student_id, s.first_name, s.last_name 
having count(e.course_id)>1;

--------2
select s.first_name, s.last_name, p.amount from Students s join Payments p on s.student_id=p.student_id where p.amount=(select max(amount) from Payments);

--------5
select s.first_name, s.last_name from Students s where(select count(distinct e.course_id) from Enrollments e where e.student_id=s.student_id)=(
select count(*) from Courses);

select s.first_name, s.last_name from Students s join Enrollments e on e.student_id=s.student_id 
group by s.student_id, s.first_name, s.last_name having count(distinct e.course_id)=(
select count(*) from Courses);

--------7
select avg(DateDiff(Year, date_of_birth, GetDate())) as average_age from Students;

--------9
select s.first_name, s.last_name, c.course_name, (select sum(p.amount) from Payments p 
where p.student_id=s.student_id) as total_payment from Students s 
join Enrollments e on s.student_id=e.student_id 
join Courses c on e.course_id=c.course_id;

--------10
select s.first_name, s.last_name, count(p.payment_id) as number_of_payments from Students s 
join Payments p on s.student_id=p.student_id group by s.student_id, s.first_name, s.last_name 
having count(p.payment_id)>1;

--------11
select s.first_name, s.last_name, sum(p.amount) as total_paymnets from Students s 
join Payments p on s.student_id=p.student_id group by s.first_name, s.last_name;

select * from Students;
drop table Students;

create table Teacher(teacher_id int primary key, first_name VARCHAR(50) not null, last_name VARCHAR(50) not null, email VARCHAR(100) not null);
insert into Teacher values(501, 'Rubin', 'Shaa', 'rubinshaa.191292@gmail.com');
insert into Teacher values(502, 'Meenu', 'Govind', 'meenugovind.121194@gmail.com');
insert into Teacher values(503, 'Sri', 'Nanth', 'srinanth.110291@gmail.com');
insert into Teacher values(504, 'Vidhya', 'Vardhini', 'vidhyavardhini.210393@gmail.com');
insert into Teacher values(505, 'Charles', 'Ben', 'charlesben.170192@gmail.com');
insert into Teacher values(506, 'Akshi', 'Ram', 'akshiram.100488@gmail.com');
insert into Teacher values(507, 'Thanish', 'Rumar', 'thanishkumar.030393@gmail.com');
insert into Teacher values(508, 'Dhana', 'Riya', 'dhanariya.040890@gmail.com');
insert into Teacher values(509, 'Raja', 'Aravinth', 'rajaravinth.300185@gmail.com');
insert into Teacher values(510, 'Vetri', 'Singh', 'vetrisingh.230683@gmail.com');
insert into Teacher values(511, 'Vishnu', 'Dhivi', 'vishnudhivi.220588@gmail.com');
--3
update Teacher set email='queencharli.200192@gmail.com' where teacher_id=5;
select * from Teacher where email like '%mail.com';

----5
select t.first_name, t.last_name, c.course_name from Teacher t join Courses c on t.teacher_id=c.teacher_id;

----10
select t.first_name, t.last_name from Teacher t left join Courses c on t.teacher_id=c.teacher_id where c.course_id is null;
select t.first_name, t.last_name from Teacher t where not exists(select 1 from Courses c where c.teacher_id=t.teacher_id);

--------4
select t.first_name, t.last_name, (select sum(p.amount) from Payments p join enrollments e on p.student_id=e.student_id 
join Courses c on e.course_id=c.course_id where c.teacher_id=t.teacher_id) as total_payments from Teacher t;

--------6
select first_name, last_name from Teacher 
where teacher_id not in (select teacher_id from Courses);

select * from Teacher;
drop table Teacher;

create table Courses(course_id int primary key, course_name VARCHAR(100) not null, credits int, teacher_id int, 
foreign key(teacher_id) references Teacher(teacher_id) on update cascade);
insert into Courses values(1012, 'AWS', 8, 501);
insert into Courses values(1006, 'Jenkins', 7, 502);
insert into Courses values(1038, 'Kubernetes', 6, 503);
insert into Courses values(1409, 'Docker', 7, 504);
insert into Courses values(1153, 'RDBMS', 8, 505);
insert into Courses values(1625, 'Javascript', 9, 506);
insert into Courses values(1731, 'React.js', 7, 507);
insert into Courses values(1181, 'Dotnet', 6, 508);
insert into Courses values(1692, 'Express.js', 8, 509);
insert into Courses values(1904, 'Node.js', 9, 510);
insert into Courses values(0, 'MonjoDB', 8, 511);

--5
update Courses set teacher_id=507 where course_id=1006;
update Courses set course_name='AWS' where teacher_id=509;

----2
select c.course_name, count(e.student_id) as total_students from Courses c 
left join Enrollments e on c.course_id=e.course_id group by c.course_name;

----8
select c.course_name from Courses c 
left join Enrollments e on c.course_id=e.course_id where e.enrollment_id is null;

--------8
select course_name from Courses where course_id not in (select course_id from Enrollments);

--------12
select c.course_name, count(e.student_id) as total_students from Courses c 
left join Enrollments e on c.course_id=e.course_id group by c.course_name order by total_students;

select * from Courses;
drop table Courses;

create table Enrollments(enrollment_id int primary key, student_id int, course_id int, 
foreign key(student_id) references Students(student_id), foreign key(course_id) references Courses(course_id) on update cascade, enrollment_date date not null);
insert into Enrollments values(501, 101, 1012, '2025-01-10');
insert into Enrollments values(602, 102, 1006, '2025-01-12');
insert into Enrollments values(703, 103, 1038, '2025-01-15');
insert into Enrollments values(804, 104, 1409, '2025-01-20');
insert into Enrollments values(905, 105, 1153, '2025-01-22');
insert into Enrollments values(116, 106, 1625, '2025-01-25');
insert into Enrollments values(207, 107, 1731, '2025-01-30');
insert into Enrollments values(301, 108, 1181, '2025-02-01');
insert into Enrollments values(409, 109, 1692, '2025-02-05');
insert into Enrollments values(510, 110, 1904, '2025-02-10');
--2
insert into Enrollments values(611, 111, 1295, '2025-03-10');
--4
delete from Enrollments where student_id=103 or course_id=1409;
--6
delete from Enrollments where enrollment_id=111;

update Enrollments set enrollment_id=518 where enrollment_date='2025-02-10';
update Enrollments set course_id=0 where course_id=1904;

alter table Enrollments add enrollment_date1 date not null;
update Enrollments set enrollment_date1=enrollment_date;
alter table Enrollments drop column enrollment_date;
EXEC sp_rename 'Enrollments.enrollment_date1', 'enrollment_date', 'column';

--------1
select avg(course_id) as average_number_of_students from(
select course_id, count(student_id) as number_of_students from Enrollments 
group by course_id) as number_of_enrollments;

select * from Enrollments;
drop table Enrollments;

create table Payments(payment_id int primary key, student_id int, foreign key(student_id) references Students(student_id), 
amount decimal(35, 2), payment_date date not null);
insert into Payments values(79865, 101, 1000.00, '2025-01-05');
insert into Payments values(82365, 102, 500.00, '2025-01-08');
insert into Payments values(60254, 103, 600.00, '2025-01-12');
insert into Payments values(72104, 104, 300.00, '2025-01-15');
insert into Payments values(61037, 105, 500.00, '2025-01-18');
insert into Payments values(91734, 106, 550.00, '2025-01-20');
insert into Payments values(82176, 107, 000.00, '2025-01-22');
insert into Payments values(79274, 108, 450.00, '2025-01-25');
insert into Payments values(98737, 109, 550.00, '2025-02-01');
insert into Payments values(69163, 110, 600.00, '2025-02-05');
insert into Payments values(59812, 111, 780.00, '2025-03-01');
--7
update Payments set amount=650.00 where payment_id=10;

--------13
select s.student_id, s.first_name, s.last_name, avg(p.amount) as average_payment from Students s 
join Payments p on s.student_id=p.student_id 
group by s.student_id, s.first_name, s.last_name;

select * from Payments;
drop table Payments;
