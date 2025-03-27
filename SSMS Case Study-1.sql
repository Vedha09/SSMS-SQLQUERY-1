create database DPADB;
use DPADB;

-- Create Doctor table (parent table for many relationships)
CREATE TABLE Doctor(
    doctor_id VARCHAR(6) PRIMARY KEY,
    dr_first_name VARCHAR(15),
    dr_middle_name VARCHAR(15),
    dr_last_name VARCHAR(15)
);

-- Create Patient table (parent table for Appointment)
CREATE TABLE Patient(
    patient_id VARCHAR(6) PRIMARY KEY,
    p_first_name VARCHAR(15),
    p_middle_name VARCHAR(15),
    p_last_name VARCHAR(15),
    address VARCHAR(20),
    city VARCHAR(15),
    contact_number VARCHAR(10),
    p_app INT
);

-- Create Appointment table (references Doctor and Patient)
CREATE TABLE Appointment(
    app_number VARCHAR(6) PRIMARY KEY,
    app_date DATE,
    app_time VARCHAR(8),
    app_reason VARCHAR(20),
    doctor_id VARCHAR(6),
    patient_id VARCHAR(6),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Create BIII table (references Appointment)
CREATE TABLE BIII(
    bil_number VARCHAR(6) PRIMARY KEY,
    bil_date DATE,
    bil_status VARCHAR(8),
    bil_amount DECIMAL(7, 2),
    app_number VARCHAR(6),
    FOREIGN KEY (app_number) REFERENCES Appointment(app_number)
);

-- Create Payment table (references BIII)
CREATE TABLE Payment(
    payment_id VARCHAR(6) PRIMARY KEY,
    pay_date DATE,
    Pay_node VARCHAR(100),
    pay_amount DECIMAL(7, 2),
    bil_number VARCHAR(6),
    FOREIGN KEY (bil_number) REFERENCES BIII(bil_number)
);

-- Insert sample data into Doctor table
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC001', 'John', 'A.', 'Smith');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC002', 'Sarah', 'M.', 'Johnson');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC003', 'Michael', NULL, 'Williams');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC004', 'Emily', 'R.', 'Brown');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC005', 'David', 'K.', 'Jones');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC006', 'Jennifer', NULL, 'Garcia');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC007', 'Robert', 'T.', 'Miller');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC008', 'Lisa', 'P.', 'Davis');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC009', 'Thomas', 'E.', 'Rodriguez');
INSERT INTO Doctor(doctor_id, dr_first_name, dr_middle_name, dr_last_name) VALUES('DOC010', 'Nancy', NULL, 'Martinez');
--2
select * from Doctor where doctor_id not in(select doctor_id from Appointment);
--10
select * from Doctor where doctor_id not in(select doctor_id from Appointment);
--------4
select d1.doctor_id as doctor_id1, d2.doctor_id as doctor_id2, d1.dr_last_name from Doctor d1 
join Doctor d2 on d1.dr_last_name=d2.dr_last_name and d1.doctor_id!=d2.doctor_id;

select * from Doctor;

-- Insert sample data into Patient table
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT001', 'James', 'B.', 'Wilson', '123 Main St', 'Boston', '6175550101', 3);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT002', 'Mary', 'L.', 'Taylor', '456 Oak Ave', 'New York', '2125550202', 5);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT003', 'William', NULL, 'Anderson', '789 Pine Rd', 'Chicago', '3125550303', 2);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT004', 'Patricia', 'S.', 'Thomas', '321 Elm St', 'Houston', '7135550404', 1);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT005', 'Richard', 'D.', 'Jackson', '654 Maple Dr', 'Phoenix', '6025550505', 4);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT006', 'Jennifer', NULL, 'White', '987 Cedar Ln', 'Philadelphia', '2155550606', 3);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT007', 'Charles', 'F.', 'Harris', '147 Birch Ct', 'San Antonio', '2105550707', 2);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT008', 'Linda', 'G.', 'Martin', '258 Walnut Way', 'San Diego', '6195550808', 5);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT009', 'Joseph', NULL, 'Thompson', '369 Spruce Pl', 'Dallas', '2145550909', 1);
INSERT INTO Patient(patient_id, p_first_name, p_middle_name, p_last_name, address, city, contact_number, p_app) VALUES('PAT010', 'Susan', 'H.', 'Robinson', '741 Aspen Blvd', 'San Jose', '4085551010', 4);
--1
select * from Patient where city in ('Boston', 'New York', 'Chicago');
--3
select * from Patient where p_middle_name is null;
--7
select distinct city from Patient;
--8
select dr_last_name from Doctor UNION select p_last_name from Patient;
--9
select distinct p.patient_id, p.p_first_name, p.p_last_name from Patient p 
inner join Appointment a on p.patient_id=a.patient_id 
inner join BIII b on a.app_number=b.app_number;
--------3
select p.patient_id, concat(p.p_first_name, ' '+p.p_middle_name+ ' '+p.p_last_name) as names_of_patient, a.app_number, a.app_date, a.app_time, a.app_reason 
from Patient p left join Appointment a on p.patient_id=a.patient_id;
--------5
select p.patient_id, concat(p.p_first_name, ' '+p.p_middle_name+ ' '+p.p_last_name) as names_of_patient, sum(pa.pay_amount) as total_paidamount from Patient p 
join Appointment a on p.patient_id=a.patient_id 
join BIII b on a.app_number=b.app_number 
join Payment pa on b.bil_number=pa.bil_number group by p.patient_id;
--------7
select p.patient_id, concat(p.p_first_name, ' '+p.p_middle_name+ ' '+p.p_last_name) as names_of_patient from Patient p 
join Appointment a on p.patient_id=a.patient_id 
join BIII b on a.app_number=b.app_number where b.bil_amount>(
select avg(bil_amount) from BIII);

select * from Patient;

-- Insert sample data into Appointment table
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP001', '2023-01-10', '09:00 AM', 'Annual Checkup', 'DOC001', 'PAT001');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP002', '2023-01-11', '10:30 AM', 'Flu Symptoms', 'DOC002', 'PAT002');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP003', '2023-01-12', '02:15 PM', 'Back Pain', 'DOC003', 'PAT003');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP004', '2023-01-13', '11:00 AM', 'Vaccination', 'DOC004', 'PAT004');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP005', '2023-01-14', '03:45 PM', 'Allergy Consult', 'DOC005', 'PAT005');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP006', '2023-01-15', '08:30 AM', 'Follow-up', 'DOC006', 'PAT006');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP007', '2023-01-16', '01:00 PM', 'Skin Rash', 'DOC007', 'PAT007');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP008', '2023-01-17', '04:30 PM', 'Blood Test', 'DOC008', 'PAT008');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP009', '2023-01-18', '09:45 AM', 'Physical Exam', 'DOC009', 'PAT009');
INSERT INTO Appointment(app_number, app_date, app_time, app_reason, doctor_id, patient_id) VALUES('APP010', '2023-01-19', '10:15 AM', 'Headache', 'DOC010', 'PAT010');
--5
select app_number, app_date, app_time, app_reason, 
coalesce(doctor_id, 'UNASSIGNED') as doctor_id, patient_id from Appointment;
--------1
select a.app_number, a.app_date, a.app_time, a.app_reason, a.patient_id, a.doctor_id, 
concat(d.dr_first_name, ' '+d.dr_middle_name+ ' '+d.dr_last_name) as names_of_doctor, 
concat(p.p_first_name, ' '+p.p_middle_name+ ' '+p.p_last_name) as names_of_patient from Appointment a 
join Doctor d on a.doctor_id=d.doctor_id 
join Patient p on a.patient_id=p.patient_id;
--------6
select doctor_id from Appointment group by doctor_id having count(*)>3;
--------9
select a.app_number, a.app_date, a.app_time, a.app_reason, a.patient_id, a.doctor_id, concat(p.p_first_name, ' '+p.p_middle_name+ ' '+p.p_last_name) as names_of_patient, 
p.city from Appointment a join Patient p on a.patient_id=p.patient_id where p.city=(
select city from Patient group by city having count(*)>1);
--------10
select doctor_id, count(*) as number_of_appointments from Appointment 
group by doctor_id having count(*)=(
select max(number_of_appointments)from(select doctor_id, count(*) as number_of_appointments from Appointment 
group by doctor_id) as count_appointments);

select * from Appointment;

-- Insert sample data into BIII table
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL001', '2023-01-10', 'Paid', 150.00, 'APP001');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL002', '2023-01-11', 'Pending', 200.00, 'APP002');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL003', '2023-01-12', 'Paid', 175.50, 'APP003');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL004', '2023-01-13', 'Pending', 120.00, 'APP004');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL005', '2023-01-14', 'Paid', 90.75, 'APP005');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL006', '2023-01-15', 'Pending', 250.00, 'APP006');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL007', '2023-01-16', 'Paid', 180.25, 'APP007');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL008', '2023-01-17', 'Pending', 300.00, 'APP008');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL009', '2023-01-18', 'Paid', 150.00, 'APP009');
INSERT INTO BIII(bil_number, bil_date, bil_status, bil_amount, app_number) VALUES('BIL010', '2023-01-19', 'Pending', 125.50, 'APP010');
--4
select * from BIII where bil_status is not null;
--------2
select b.* from BIII b left join Payment p on b.bil_number=p.bil_number;
--------8
select b.* from BIII b left join Payment p on b.bil_number=p.bil_number where p.payment_id is null;

select * from BIII;

-- Insert sample data into Payment table
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY001', '2023-01-10', 'Credit Card', 150.00, 'BIL001');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY002', '2023-01-12', 'Cash', 175.50, 'BIL003');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY003', '2023-01-14', 'Insurance', 90.75, 'BIL005');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY004', '2023-01-16', 'Credit Card', 180.25, 'BIL007');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY005', '2023-01-18', 'Check', 150.00, 'BIL009');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY006', '2023-01-20', 'Credit Card', 100.00, 'BIL002');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY007', '2023-01-21', 'Cash', 120.00, 'BIL004');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY008', '2023-01-22', 'Insurance', 125.00, 'BIL006');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY009', '2023-01-23', 'Credit Card', 200.00, 'BIL008');
INSERT INTO Payment(payment_id, pay_date, Pay_node, pay_amount, bil_number) VALUES('PAY010', '2023-01-24', 'Check', 125.50, 'BIL010');
--6
select * from Payment where pay_date between '2023-01-12' and '2023-01-18';

select * from Payment;
