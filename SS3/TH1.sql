DROP DATABASE IF exists QuanLySinhVien;
CREATE DATABASE QuanLySinhVien1;
use QuanLySinhVien1;

CREATE TABLE class(
classId int primary key auto_increment,
className varchar(20) not null,
startDate date,
statuss bit 
);

CREATE TABLE students(
studentId int primary key auto_increment,
studentName varchar(20) not null,
address varchar(20) not null,
phone varchar(20),
statuss bit,
classId int
);

CREATE TABLE subjects(
subId int primary key auto_increment,
subName varchar(20) not null,
credit int not null,
statuss bit
);

CREATE TABLE mark(
markId int primary key auto_increment,
subId int not null,
studentId int not null,
mark int not null,
examTimes int not null check(examTimes >0)
);

alter table students add constraint pk_student_class foreign key (classId) references class(classId);
alter table mark add constraint pk_mark_subjects foreign key (subId) references subjects(subId);
alter table mark add constraint pk_mark_students foreign key (studentId) references students(studentId);

INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1),(2, 'A2', '2008-12-22', 1),(3, 'B3', current_date, 0);

INSERT INTO Students (StudentName, Address, Phone, Statuss, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1),('Hoa', 'Hai phong',null, 1, 1),('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subjects
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
       
INSERT INTO mark (subId, studentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);

select studentId,studentName, address, phone, students.statuss, class.className  from students
left join class on students.classId = class.classId;

