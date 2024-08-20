create database universitymanagementsystem;
use universitymanagementsystem;
create table login(username varchar(25), password varchar(25));
insert into login values('admin', '12345');
create table student(name varchar(40), fname varchar(40), rollno varchar(20), dob varchar(40), address varchar(100), phone varchar(20),
email varchar(40), class_x varchar(20), class_xii varchar(20), reg varchar(20), course varchar(40), branch varchar(40));
create table teacher(name varchar(40), fname varchar(40), id varchar(20), dob varchar(40), address varchar(100), 
phone varchar(20), email varchar(40), reg varchar(20), education varchar(40), department varchar(40));
create table studentleave(rollno varchar(20), date varchar(50), duration varchar(20));
create table teacherleave(empId varchar(20), date varchar(50), duration varchar(20));
create table subject(rollno varchar(20), semester varchar(20), subject1 varchar(50), subject2 varchar(50), subject3 varchar(50), subject4 varchar(50), subject5 varchar(50),subject6 varchar(50), subject7 varchar(50), subject8 varchar(50));
create table marks(rollno varchar(20), semester varchar(20), marks1 varchar(50), marks2 varchar(50), marks3 varchar(50), marks4 varchar(50), marks5 varchar(50), marks6 varchar(50), marks7 varchar(50), marks8 varchar(50));
select * from marks;
select * from subject

 