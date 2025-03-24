create database SISDB;
use SISDB;

create table Students(student_id int primary key, first_name VARCHAR(50) not null, last_name VARCHAR(50) not null, 
date_of_birth date not null, email VARCHAR(100) unique not null, phone_number VARCHAR(25) unique);
insert into Students values(1, 'Vedha', 'sruthi', '2003-12-09', 'vedhasruthi.091203@gmail.com', '7871437250');
insert into Students values(2, 'Aparna', 'shree', '2003-11-10', 'aparnashree.101103@gmail.com', '8912534670');
insert into Students values(3, 'Sowmi', 'priya', '2004-02-15', 'sowmipriya.150204@gmail.com', '7654983210');
insert into Students values(4, 'Gowri', 'shankar', '2003-09-24', 'gowrishankar.240303@gmail.com', '9231465790');
insert into Students values(5, 'Ammu', 'valli', '2003-01-05', 'ammuvalli.050102@gmail.com', '8071625340');
insert into Students values(6, 'Lina', 'son', '2002-04-18', 'linason.180403@gmail.com', '6789012345');
insert into Students values(7, 'Tharun', 'kumar', '2003-07-30', 'tharunkumar.200703@gmail.com', '8124914041');
insert into Students values(8, 'Manisha', 'gopi', '2002-08-29', 'manishagopi.290802@gmail.com', '7102983640');
insert into Students values(9, 'Eniyan', 'velu', '2004-01-02', 'eniyanvelu.200104@gmail.com', '8907162345');
insert into Students values(10, 'Dani', 'Jason', '2003-06-17', 'danijason.170603@gmail.com', '9102348765');
--1
insert into Students values(11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');
select * from Students where date_of_birth between '2003-05-15' and '2004-05-30';
--6
delete from Students where student_id=1;

select * from Students;
drop table Students;

create table Teacher(teacher_id int primary key, first_name VARCHAR(50) not null, last_name VARCHAR(50) not null, email VARCHAR(100) not null);
insert into Teacher values(1, 'Rubin', 'Shaa', 'rubinshaa.191292@gmail.com');
insert into Teacher values(2, 'Meenu', 'Govind', 'meenugovind.121194@gmail.com');
insert into Teacher values(3, 'Sri', 'Nanth', 'srinanth.110291@gmail.com');
insert into Teacher values(4, 'Vidhya', 'Vardhini', 'vidhyavardhini.210393@gmail.com');
insert into Teacher values(5, 'Charles', 'Ben', 'charlesben.170192@gmail.com');
insert into Teacher values(6, 'Akshi', 'Ram', 'akshiram.100488@gmail.com');
insert into Teacher values(7, 'Thanish', 'Rumar', 'thanishkumar.030393@gmail.com');
insert into Teacher values(8, 'Dhana', 'Riya', 'dhanariya.040890@gmail.com');
insert into Teacher values(9, 'Raja', 'Aravinth', 'rajaravinth.300185@gmail.com');
insert into Teacher values(10, 'Vetri', 'Singh', 'vetrisingh.230683@gmail.com');
insert into Teacher values(11, 'Vishnu', 'Dhivi', 'vishnudhivi.220588@gmail.com');
--3
update Teacher set email='queencharli.200192@gmail.com' where teacher_id=5;
select * from Teacher where email like '%mail.com';

select * from Teacher;
drop table Teacher;

create table Courses(course_id int primary key, course_name VARCHAR(100) not null, credits int, teacher_id int, 
foreign key(teacher_id) references Teacher(teacher_id));
insert into Courses values(1, 'AWS', 8, 1);
insert into Courses values(2, 'Jenkins', 7, 2);
insert into Courses values(3, 'Kubernetes', 6, 3);
insert into Courses values(4, 'Docker', 7, 4);
insert into Courses values(5, 'RDBMS', 8, 5);
insert into Courses values(6, 'Javascript', 9, 6);
insert into Courses values(7, 'React.js', 7, 7);
insert into Courses values(8, 'Dotnet', 6, 8);
insert into Courses values(9, 'Express.js', 8, 9);
insert into Courses values(10, 'Node.js', 9, 10);
insert into Courses values(11, 'ManjoDB', 8, 11);
--5
update Courses set teacher_id=8 where course_id=4;

select * from Courses;
drop table Courses;

create table Enrollments(enrollment_id int primary key, enrollment_date date not null, student_id int, course_id int, 
foreign key(student_id) references Students(student_id), foreign key(course_id) references Courses(course_id));
insert into Enrollments values(1, 1, 1, '2025-01-10');
insert into Enrollments values(2, 2, 2, '2025-01-12');
insert into Enrollments values(3, 3, 3, '2025-01-15');
insert into Enrollments values(4, 4, 4, '2025-01-20');
insert into Enrollments values(5, 5, 5, '2025-01-22');
insert into Enrollments values(6, 6, 6, '2025-01-25');
insert into Enrollments values(7, 7, 7, '2025-01-30');
insert into Enrollments values(8, 8, 8, '2025-02-02');
insert into Enrollments values(9, 9, 9, '2025-02-05');
insert into Enrollments values(10, 10, 10, '2025-02-10');
--2
insert into Enrollments values(11, 11, 11, '2025-03-10');
--4
delete from Enrollments where student_id=3 or course_id=9;
--6
delete from Enrollments where enrollment_id=1;
alter table Enrollments add enrollment_date1 date not null;
update Enrollments set enrollment_date1=enrollment_date;
alter table Enrollments drop column enrollment_date;
EXEC sp_rename 'Enrollments.enrollment_date1', 'enrollment_date', 'column';

select * from Enrollments;
drop table Enrollments;

create table Payments(payment_id int primary key, student_id int, foreign key(student_id) references Students(student_id), 
amount decimal(35, 2), payment_date date not null);
insert into Payments values(1, 1, 1000.00, '2025-01-05');
insert into Payments values(2, 2, 500.00, '2025-01-08');
insert into Payments values(3, 3, 600.00, '2025-01-12');
insert into Payments values(4, 4, 300.00, '2025-01-15');
insert into Payments values(5, 5, 500.00, '2025-01-18');
insert into Payments values(6, 6, 550.00, '2025-01-20');
insert into Payments values(7, 7, 550.00, '2025-01-22');
insert into Payments values(8, 8, 450.00, '2025-01-25');
insert into Payments values(9, 9, 550.00, '2025-02-01');
insert into Payments values(10, 10, 600.00, '2025-02-05');
insert into Payments values(11, 11, 780.00, '2025-03-01');
--7
update Payments set amount=650.00 where payment_id=10;

select * from Payments;
drop table Payments;
