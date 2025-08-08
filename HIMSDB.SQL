CREATE DATABASE Full_HospitalDB;
USE Full_HospitalDB;

CREATE TABLE Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE Departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    dept_id INT,
    user_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    dob DATE,
    phone VARCHAR(15),
    address TEXT
);

CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10),
    room_type ENUM('General', 'Private', 'ICU'),
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    room_id INT,
    admission_date DATETIME,
    discharge_date DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    notes TEXT,
    record_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INT DEFAULT 0,
    price DECIMAL(10, 2)
);

CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT,
    medicine_id INT,
    dosage VARCHAR(100),
    duration VARCHAR(100),
    FOREIGN KEY (record_id) REFERENCES MedicalRecords(record_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);

CREATE TABLE LabTests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(100),
    cost DECIMAL(10,2)
);

CREATE TABLE TestReports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    test_id INT,
    patient_id INT,
    doctor_id INT,
    result TEXT,
    report_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (test_id) REFERENCES LabTests(test_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    amount DECIMAL(10,2),
    billing_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT,
    payment_method ENUM('Cash', 'Card', 'UPI'),
    amount_paid DECIMAL(10,2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id)
);

-- Roles
INSERT INTO Roles (role_name) VALUES
('Admin'),
('Doctor'),
('Nurse'),
('Receptionist');

-- Users
INSERT INTO Users (username, password, role_id) VALUES
('admin1', 'adminpass', 1),
('docjohn', 'docpass', 2),
('nurseamy', 'nursepass', 3),
('receptkaren', 'receptpass', 4);

-- Departments
INSERT INTO Departments (dept_name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics');

-- Doctors
INSERT INTO Doctors (full_name, specialization, phone, dept_id, user_id) VALUES
('Dr. John Smith', 'Cardiologist', '9876543210', 1, 2);

-- Patients
INSERT INTO Patients (full_name, gender, dob, phone, address) VALUES
('Alice Brown', 'Female', '1990-06-15', '9123456780', '123 Main St'),
('Bob White', 'Male', '1985-08-22', '9988776655', '456 Oak Lane');

-- Rooms
INSERT INTO Rooms (room_number, room_type, is_available) VALUES
('101A', 'General', TRUE),
('102B', 'Private', TRUE);

-- Admissions
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date) VALUES
(1, 1, '2025-08-01 10:00:00', NULL);

-- Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2025-08-09 10:30:00', 'Regular check-up', 'Scheduled');

-- Medical Records
INSERT INTO MedicalRecords (patient_id, doctor_id, diagnosis, notes) VALUES
(1, 1, 'Hypertension', 'Needs regular BP monitoring');

-- Medicines
INSERT INTO Medicines (name, stock, price) VALUES
('Paracetamol', 100, 1.50),
('Atorvastatin', 50, 2.75),
('Amlodipine', 75, 3.20);

-- Prescriptions
INSERT INTO Prescriptions (record_id, medicine_id, dosage, duration) VALUES
(1, 1, '500mg', '5 days'),
(1, 3, '10mg', '7 days');

-- Lab Tests
INSERT INTO LabTests (test_name, cost) VALUES
('Blood Test', 200.00),
('ECG', 500.00);

-- Test Reports
INSERT INTO TestReports (test_id, patient_id, doctor_id, result) VALUES
(1, 1, 1, 'Normal'),
(2, 1, 1, 'Slight arrhythmia detected');

INSERT INTO Billing (appointment_id, amount, billing_date) 
VALUES (1, 700.00, '2025-08-09 12:00:00');

-- Payments
INSERT INTO Payments (bill_id, payment_date, amount_paid, payment_method) 
VALUES (1, '2025-08-09 12:30:00', 700.00, 'Card');


SELECT 
    p.full_name AS patient_name,
    a.appointment_date,
    d.full_name AS doctor_name,
    a.reason,
    a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

SELECT 
    p.full_name AS patient_name,
    m.name AS medicine_name,
    pr.dosage,
    pr.duration
FROM Prescriptions pr
JOIN MedicalRecords mr ON pr.record_id = mr.record_id
JOIN Patients p ON mr.patient_id = p.patient_id
JOIN Medicines m ON pr.medicine_id = m.medicine_id
WHERE p.patient_id = 1;

SELECT
    pa.full_name AS patient_name,
    b.amount AS total_amount,
    py.amount_paid,
    py.payment_method,
    py.payment_date
FROM Billing b
JOIN Appointments ap ON b.appointment_id = ap.appointment_id
JOIN Patients pa ON ap.patient_id = pa.patient_id
JOIN Payments py ON b.bill_id = py.bill_id
WHERE pa.patient_id = 1
LIMIT 0, 1000;

SELECT room_number, room_type
FROM Rooms
WHERE is_available = TRUE;

SELECT 
    p.full_name AS patient_name,
    lt.test_name,
    tr.result
FROM TestReports tr
JOIN LabTests lt ON tr.test_id = lt.test_id
JOIN Patients p ON tr.patient_id = p.patient_id
WHERE p.patient_id = 1;
