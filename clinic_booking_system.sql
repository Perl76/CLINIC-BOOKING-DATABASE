create database clinic bookig;
use clinical booking;
CREATE TABLE Specializations (
    specializationID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Doctors (
    doctorID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    specializationID INT,
    FOREIGN KEY (specializationID) REFERENCES Specializations(specializationID)
);

CREATE TABLE Patients (
    patientID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    birthDate DATE,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Rooms (
    roomID INT AUTO_INCREMENT PRIMARY KEY,
    roomNumber VARCHAR(10) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL
);

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
