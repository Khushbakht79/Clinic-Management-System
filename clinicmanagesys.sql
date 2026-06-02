CREATE DATABASE ClinicManagementSystem;
USE ClinicManagementSystem;

CREATE TABLE DiseaseCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE Specialization (
    SpecializationID INT PRIMARY KEY,
    SpecName VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE Medicine (
    MedicineID INT PRIMARY KEY,
    MedName VARCHAR(100) NOT NULL,
    GenericName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);

CREATE TABLE Disease (
    DiseaseID INT PRIMARY KEY,
    CategoryID INT,
    DiseaseName VARCHAR(100) NOT NULL,
    ICD10Code VARCHAR(50),
    Severity VARCHAR(20),
    FOREIGN KEY (CategoryID)
        REFERENCES DiseaseCategory(CategoryID)
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    DepartmentID INT,
    SpecializationID INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    LicenseNumber VARCHAR(100),
    Email VARCHAR(100),

    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID),

    FOREIGN KEY (SpecializationID)
        REFERENCES Specialization(SpecializationID)
);

ALTER TABLE Department
ADD HeadDoctorID INT;

ALTER TABLE Department
ADD CONSTRAINT fk_department_headdoctor
FOREIGN KEY (HeadDoctorID)
REFERENCES Doctor(DoctorID);

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    BloodGroup VARCHAR(5)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role VARCHAR(50),
    Shift VARCHAR(20),

    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

CREATE TABLE Room (
    RoomID INT PRIMARY KEY,
    DepartmentID INT,
    RoomNumber INT,
    RoomType VARCHAR(50),
    IsAvailable BOOLEAN,

    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    RoomID INT NOT NULL,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(20),
    Type VARCHAR(30),

    FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID),

    FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID),

    FOREIGN KEY (RoomID)
        REFERENCES Room(RoomID)
);

CREATE TABLE MedicalRecord (
    RecordID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    DiseaseID INT NOT NULL,
    RecordDate DATE,
    Diagnosis TEXT,

    FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID),

    FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID),

    FOREIGN KEY (DiseaseID)
        REFERENCES Disease(DiseaseID)
);

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    IssuedDate DATE,
    Notes TEXT,

    FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID),

    FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID),

    FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID)
);

CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    DoctorID INT NOT NULL,
    TreatmentType VARCHAR(50),
    Cost DECIMAL(10,2),
    Outcome VARCHAR(50),

    FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID),

    FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID)
);

CREATE TABLE Bill (
    BillID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    AppointmentID INT NOT NULL,
    TotalAmount DECIMAL(10,2),
    InsuranceCovered DECIMAL(10,2),
    PatientDue DECIMAL(10,2),
    PaymentStatus VARCHAR(30),

    FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID),

    FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID)
);

CREATE TABLE SpecializationDisease (
    SpecializationID INT,
    DiseaseID INT,

    PRIMARY KEY (SpecializationID, DiseaseID),

    FOREIGN KEY (SpecializationID)
        REFERENCES Specialization(SpecializationID),

    FOREIGN KEY (DiseaseID)
        REFERENCES Disease(DiseaseID)
);

CREATE TABLE PrescriptionMedicine (
    PrescriptionID INT,
    MedicineID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    DurationDays INT,

    PRIMARY KEY (PrescriptionID, MedicineID),

    FOREIGN KEY (PrescriptionID)
        REFERENCES Prescription(PrescriptionID),

    FOREIGN KEY (MedicineID)
        REFERENCES Medicine(MedicineID)
);

SHOW TABLES;

SELECT COUNT(*) FROM Patient;

SELECT * FROM Patient;

DESCRIBE Patient;

SELECT * FROM Patient LIMIT 5;

DELETE FROM Patient;

SHOW CREATE TABLE Patient;

TRUNCATE TABLE Patient;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/Khushbakht Malik/Downloads/1 Patients.csv'
INTO TABLE Patient
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PatientID, FirstName, LastName, DateOfBirth, Gender, Phone, Email, BloodGroup);


LOAD DATA LOCAL INFILE 'C:/Users/Khushbakht Malik/Downloads/1 Patients.csv'
INTO TABLE Patient
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PatientID, FirstName, LastName, DateOfBirth, Gender, Phone, Email, BloodGroup);

SELECT * FROM Patient LIMIT 5;

SELECT PatientID, DateOfBirth
FROM Patient
LIMIT 10;

SELECT COUNT(*) FROM Patient;

DESCRIBE Patient;

TRUNCATE TABLE Patient;

CREATE TABLE Patient_new LIKE Patient;

SELECT * FROM Patient_new;

RENAME TABLE Patient TO Patient_backup;

RENAME TABLE Patient_new TO Patient;

SELECT * FROM Patient;
SELECT * FROM appointment;

DROP TABLE Patient_backup;

ALTER TABLE appointment
DROP FOREIGN KEY appointment_ibfk_1;

SET FOREIGN_KEY_CHECKS = 0;

SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE Appointment
ADD CONSTRAINT appointment_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

ALTER TABLE MedicalRecord
ADD CONSTRAINT medicalrecord_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

ALTER TABLE Prescription
ADD CONSTRAINT prescription_ibfk_2
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

ALTER TABLE Bill
ADD CONSTRAINT bill_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

ALTER TABLE MedicalRecord
DROP FOREIGN KEY medicalrecord_ibfk_1;

ALTER TABLE MedicalRecord
ADD CONSTRAINT medicalrecord_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

ALTER TABLE MedicalRecord
ADD CONSTRAINT medicalrecord_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

DESCRIBE Patient;
DESCRIBE MedicalRecord;

SELECT PatientID
FROM MedicalRecord
WHERE PatientID NOT IN (SELECT PatientID FROM Patient);

ALTER TABLE MedicalRecord
ADD CONSTRAINT medicalrecord_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE MedicalRecord
ADD CONSTRAINT medicalrecord_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

SET FOREIGN_KEY_CHECKS = 1;

SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'MedicalRecord'
AND CONSTRAINT_TYPE = 'FOREIGN KEY';

ALTER TABLE MedicalRecord
DROP FOREIGN KEY constraint_name_here;

SHOW CREATE TABLE MedicalRecord;

ALTER TABLE MedicalRecord
DROP FOREIGN KEY medicalrecord_ibfk_1;

SHOW TABLES;

SELECT COUNT(*) FROM Patient;

SELECT COUNT(*) FROM PatientBackup;

SELECT PatientID, DateOfBirth
FROM Patient
LIMIT 5;

SELECT * FROM Patient
LIMIT 100;

SELECT COUNT(*) FROM Doctor;
SELECT COUNT(*) FROM Disease;
SELECT COUNT(*) FROM Appointment;
SELECT COUNT(*) FROM MedicalRecord;

SHOW CREATE TABLE Doctor;
SHOW CREATE TABLE Appointment;
SHOW CREATE TABLE MedicalRecord;
SHOW CREATE TABLE Prescription;
SHOW CREATE TABLE Bill;

SELECT COUNT(*) FROM Department;

DESCRIBE Doctor;

DESCRIBE Department;

SHOW CREATE TABLE doctor;
SHOW CREATE TABLE staff;
SHOW CREATE TABLE appointment;
SHOW CREATE TABLE treatment;
SHOW CREATE TABLE prescription;
SHOW CREATE TABLE prescriptionmedicine;
SHOW CREATE TABLE specializationdisease;

DESCRIBE Room;

SELECT COUNT(*) FROM Department;

SELECT COUNT(*) FROM Department;

describe Department;
LOAD DATA LOCAL INFILE 'C:/Users/Khushbakht Malik/Downloads/4 Department.csv'
INTO TABLE Department
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM Room;

SHOW WARNINGS;

SELECT MIN(DepartmentID), MAX(DepartmentID), COUNT(*) 
FROM Department;

SHOW CREATE TABLE Room;

LOAD DATA LOCAL INFILE 'C:/Users/Khushbakht Malik/Downloads/9 Room.csv'
INTO TABLE Room
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM Room;

DESCRIBE Doctor;

SELECT COUNT(*) FROM Department;
SELECT COUNT(*) FROM Specialization;
SELECT COUNT(*) FROM Doctor;

SELECT COUNT(*) FROM TableName;

SELECT COUNT(*) FROM diseasecategory;
SELECT COUNT(*) FROM disease;
SELECT COUNT(*) FROM medicine;
SELECT COUNT(*) FROM staff;
SELECT COUNT(*) FROM appointment;
SELECT COUNT(*) FROM medicalrecord;
SELECT COUNT(*) FROM treatment;
SELECT COUNT(*) FROM prescription;

SHOW WARNINGS;

SHOW CREATE TABLE Prescription;

SHOW TABLES LIKE 'patient_backup';

SELECT COUNT(*) FROM Appointment WHERE AppointmentID = 95;

SELECT COUNT(*) FROM Patient WHERE PatientID = 94;

SELECT COUNT(*) FROM Doctor WHERE DoctorID = 3;
SHOW TABLES LIKE 'patient_backup';

SHOW WARNINGS;

SELECT COUNT(*) FROM Appointment WHERE AppointmentID = 95;

SELECT COUNT(*) FROM Patient WHERE PatientID = 94;

SHOW CREATE TABLE Prescription;

SELECT COUNT(*) FROM Prescription;

SHOW CREATE TABLE Appointment;
SHOW CREATE TABLE MedicalRecord;

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'clinicmanagementsystem'
AND TABLE_NAME = 'prescription'
AND REFERENCED_TABLE_NAME IS NOT NULL;

ALTER TABLE Prescription
DROP FOREIGN KEY prescription_ibfk_2;

ALTER TABLE Prescription
ADD CONSTRAINT prescription_ibfk_2
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

SHOW CREATE TABLE Prescription;

SELECT COUNT(*) FROM Prescription;

DESCRIBE Prescription;

LOAD DATA LOCAL INFILE 'C:/Users/Khushbakht Malik/Downloads/12 Prescription.csv'
INTO TABLE Prescription
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS(PrescriptionID,
 AppointmentID,
 PatientID,
 DoctorID,
 IssuedDate,
 Notes);
 
 SELECT * FROM Prescription LIMIT 5;
 
 SELECT MAX(PrescriptionID) FROM Prescription;
 
 SELECT COUNT(*) FROM TableName;
 
 SELECT COUNT(*) FROM treatment;
 SELECT COUNT(*) FROM Bill;
 SHOW CREATE TABLE Bill;
 
 ALTER TABLE Bill
DROP FOREIGN KEY bill_ibfk_1;

ALTER TABLE Bill
ADD CONSTRAINT bill_ibfk_1
FOREIGN KEY (PatientID)
REFERENCES Patient(PatientID);

SHOW CREATE TABLE Bill;

SELECT COUNT(*) FROM Bill;

LOAD DATA LOCAL INFILE 'C:/Users/Khushbakht Malik/Downloads/14 Bill.csv'
INTO TABLE Bill
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(BillID,
 PatientID,
 AppointmentID,
 TotalAmount,
 InsuranceCovered,
 PatientDue,
 PaymentStatus);

SHOW WARNINGS;
SELECT COUNT(*) FROM Bill;

SELECT COUNT(*) FROM specializationdisease;

SHOW CREATE TABLE SpecializationDisease;

SELECT MIN(SpecializationID), MAX(SpecializationID), COUNT(*) FROM Specialization;

SELECT MIN(DiseaseID), MAX(DiseaseID), COUNT(*) FROM Disease;

 
 SELECT COUNT(*) FROM Disease;
 TRUNCATE TABLE Disease;
 DELETE FROM Disease;
 SELECT * FROM Disease;
 
 DESCRIBE Disease;
 SELECT COUNT(*) FROM MedicalRecord;
 
 DELETE FROM MedicalRecord;
 
 DELETE FROM MedicalRecord
WHERE RecordID > 0;

DELETE FROM Disease
WHERE DiseaseID > 0;

SELECT COUNT(*) FROM SpecializationDisease;
 SELECT MIN(DiseaseID), MAX(DiseaseID) FROM Disease;
 
 SHOW CREATE TABLE PrescriptionMedicine;
 SELECT COUNT(*) FROM PrescriptionMedicine;
 
 SELECT MIN(PrescriptionID), MAX(PrescriptionID), COUNT(*) FROM Prescription;

SELECT MIN(MedicineID), MAX(MedicineID), COUNT(*) FROM Medicine;
SELECT COUNT(*) FROM Prescription;
SELECT COUNT(*) FROM Medicine;

SELECT MedicineID
FROM Medicine
ORDER BY MedicineID;

SELECT * FROM Medicine WHERE MedicineID = 11;

SELECT COUNT(*) FROM PrescriptionMedicine;
SHOW WARNINGS;

INSERT INTO PrescriptionMedicine
(PrescriptionID, MedicineID, Dosage, Frequency, DurationDays)
VALUES
(1, 20, '250mg', 'Once Daily', 2);

DELETE FROM PrescriptionMedicine;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM PrescriptionMedicine;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM PrescriptionMedicine;

SHOW ERRORS;
SHOW WARNINGS;

SELECT 'Patient', COUNT(*) FROM Patient
UNION ALL
SELECT 'Department', COUNT(*) FROM Department
UNION ALL
SELECT 'Room', COUNT(*) FROM Room
UNION ALL
SELECT 'Specialization', COUNT(*) FROM Specialization
UNION ALL
SELECT 'Doctor', COUNT(*) FROM Doctor
UNION ALL
SELECT 'DiseaseCategory', COUNT(*) FROM DiseaseCategory
UNION ALL
SELECT 'Disease', COUNT(*) FROM Disease
UNION ALL
SELECT 'Medicine', COUNT(*) FROM Medicine
UNION ALL
SELECT 'Staff', COUNT(*) FROM Staff
UNION ALL
SELECT 'Appointment', COUNT(*) FROM Appointment
UNION ALL
SELECT 'MedicalRecord', COUNT(*) FROM MedicalRecord
UNION ALL
SELECT 'Prescription', COUNT(*) FROM Prescription
UNION ALL
SELECT 'Treatment', COUNT(*) FROM Treatment
UNION ALL
SELECT 'Bill', COUNT(*) FROM Bill
UNION ALL
SELECT 'SpecializationDisease', COUNT(*) FROM SpecializationDisease
UNION ALL
SELECT 'PrescriptionMedicine', COUNT(*) FROM PrescriptionMedicine;

show tables;

SHOW CREATE TABLE Appointment;
SHOW CREATE TABLE MedicalRecord;
SHOW CREATE TABLE Prescription;
SHOW CREATE TABLE Bill;

/* i completed adding the csvs to my tables now i will make 
some queries and run those too. it will Prove that my DATABASE
WORKS  */

-- 1) PATIENTS WITH APPOINTMENTS
SELECT p.FirstName, p.LastName, a.AppointmentDate
FROM Patient p
JOIN Appointment a
ON p.PatientID = a.PatientID;

-- 2) DOC & DEPT
SELECT d.FirstName, d.LastName, dep.DeptName
FROM Doctor d
JOIN Department dep
ON d.DepartmentID = dep.DepartmentID;
-- i got an error cuz my dept name was incorrect
DESCRIBE Department;

-- 3) bills
SELECT BillID, TotalAmount, PaymentStatus
FROM Bill;

SELECT pm.PrescriptionID, pm.MedicineID, pm.Dosage
FROM PrescriptionMedicine pm;

SELECT * FROM medicalrecord LIMIT 10;

-- ending