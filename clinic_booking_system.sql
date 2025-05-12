-- create database clinic booking
create database clinic booking;
use clinic booking;
-- create table specialisation

CREATE TABLE Specializations (
    specializationID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- create table doctors
CREATE TABLE Doctors (
    doctorID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    specializationID INT,
    FOREIGN KEY (specializationID) REFERENCES Specializations(specializationID)
);

--create table patients

CREATE TABLE Patients (
    patientID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    birthDate DATE,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

--create table rooms

CREATE TABLE Rooms (
    roomID INT AUTO_INCREMENT PRIMARY KEY,
    roomNumber VARCHAR(10) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL
);

-- create table appointments

CREATE TABLE Appointments (
    appointmentID INT AUTO_INCREMENT PRIMARY KEY,
    patientID INT NOT NULL,
    doctorID INT NOT NULL,
    roomID INT,
    appointmentDate DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID),
    FOREIGN KEY (roomID) REFERENCES Rooms(roomID)
);

-- create table prescription

CREATE TABLE Prescriptions (
    prescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    appointmentID INT NOT NULL,
    medicationName VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (appointmentID) REFERENCES Appointments(appointmentID)
);

--create table bills

CREATE TABLE Bills (
    billID INT AUTO_INCREMENT PRIMARY KEY,
    appointmentID INT NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    paymentStatus ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Pending',
    paymentMethod ENUM('Cash', 'Card', 'Insurance', 'Online'),
    billingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointmentID) REFERENCES Appointments(appointmentID)
);

--create table users

CREATE TABLE Users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'doctor', 'patient') NOT NULL,
    linkedID INT,
    -- linkedID refers to doctorID or patientID based on role
    UNIQUE (role, linkedID)
);
