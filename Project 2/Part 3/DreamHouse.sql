/*
Author: Timur Naimov
Professor: Jose Santos
Course: CIS 395-1900
Date: May 6, 2022
*/

use dreamhomedb;

CREATE TABLE Staff
( 
staffNo varchar (5) not null
, name varchar (200)
, gender char (1)
, dob date
, position varchar (20)
, salary decimal (7,2) not null default 0
, branchNo varchar (5) 
, supervisorStaffNo varchar (5) 
, CONSTRAINT PK_Staff PRIMARY KEY (staffNo)
);

CREATE TABLE Manager
(
staffNo varchar (5) not null
, managerStartDate date
, managerBonus decimal (7,2) not null default 0
, CONSTRAINT PK_ManagerStaff PRIMARY KEY (staffNo)
, CONSTRAINT FK_ManagerStaff FOREIGN KEY (staffNo) REFERENCES Staff (staffNo)
);

CREATE TABLE Supervisor
(
staffNo varchar (5) not null
, CONSTRAINT PK_ManagerStaff PRIMARY KEY (staffNo)
, CONSTRAINT FK_ManagerStaff FOREIGN KEY (staffNo) REFERENCES Staff (staffNo)
);

CREATE TABLE Branch
( 
branchNo varchar (5) not null
, branchAddress varchar (200)
, mgrStaffNo varchar (5)
, CONSTRAINT PK_Branch PRIMARY KEY (branchNo)
);

CREATE TABLE BranchTel
(
branchNo varchar (5) not null
, branchTelNo varchar (10) not null
, CONSTRAINT PK_BranchTel PRIMARY KEY (branchNo, branchTelNo)
, CONSTRAINT FK_BranchTel FOREIGN KEY (branchNo) REFERENCES Branch (branchNo)
);

CREATE TABLE Client
( 
clientNo varchar (5) not null
, clientName varchar (200)
, branchNo varchar (5)
, branchAddress varchar (200)
, staffName varchar (5)
, registerDate date
, clientTelNo varchar (10)
, clientEmail varchar (30) 
, CONSTRAINT PK_Client PRIMARY KEY (clientNo)
);

CREATE TABLE Owner
( 
ownerNo varchar (5) not null
, name varchar (200)
, ownerAddress varchar (200)
, ownerTelNo varchar (10)
, CONSTRAINT PK_Owner PRIMARY KEY (ownerNo)
);

CREATE TABLE Property
(
propertyNo varchar (5) not null 
, ownerNo varchar (5)
, staffNo varchar (5)
, branchNo varchar (5)
, propertyType varchar (20)
, rooms int (2)
, rent decimal (7,2)
, address varchar (200)
, CONSTRAINT PK_Property PRIMARY KEY (propertyNo)
, CONSTRAINT FK_PropertyOwner FOREIGN KEY (ownerNo) REFERENCES Owner (ownerNo)
);

CREATE TABLE PropertyViewing
( 
propertyNo varchar (5) not null
, clientNo varchar (5) not null
, viewingDate date
, comments varchar (200)
, CONSTRAINT FK_ViewingProperty FOREIGN KEY (propertyNo) REFERENCES Property (propertyNo)
, CONSTRAINT FK_ViewingClient FOREIGN KEY (clientNo) REFERENCES Client (clientNo)
);

CREATE TABLE Lease
(
leaseNo varchar (5) not null
, clientNo varchar (5) not null
, propertyNo varchar (5) not null
, monthlyRentAmt decimal (7,2)
, paymentMethod varchar (20)
, repositPaidIndicator bool
, rentStartDate date
, rentFinishDate date
, rentDuration varchar (200)
, CONSTRAINT PK_Lease PRIMARY KEY (clientNo, propertyNo, rentStartDate)
, CONSTRAINT FK_LeaseClient FOREIGN KEY (clientNo) REFERENCES Client (clientNo)
, CONSTRAINT FK_LeaseProperty FOREIGN KEY (propertyNo) REFERENCES Property (propertyNo)
);

CREATE TABLE Person
(
ownerNo varchar (5) not null
);

CREATE TABLE Business
(
ownerNo varchar (5) not null
, contactName varchar (20)
);

ALTER TABLE Person
ADD CONSTRAINT FK_PersonOwner FOREIGN KEY (ownerNo) REFERENCES Owner (ownerNo);

ALTER TABLE Business
ADD CONSTRAINT FK_BusinessOwner FOREIGN KEY (ownerNo) REFERENCES Owner (ownerNo);

ALTER TABLE Staff
ADD CONSTRAINT FK_StaffSupervisor FOREIGN KEY (supervisorStaffNo) REFERENCES Staff (staffNo);

ALTER TABLE Branch
ADD CONSTRAINT FK_BranchMgr FOREIGN KEY (mgrStaffNo) REFERENCES Staff (staffNo);

CREATE INDEX IDX_TEL ON BranchTel (branchTelNo);

ALTER TABLE Staff
ADD CONSTRAINT FK_StaffBranch FOREIGN KEY (branchNo) REFERENCES Branch (branchNo);

ALTER TABLE Property
ADD CONSTRAINT FK_PropertyStaff FOREIGN KEY (staffNo) REFERENCES Staff (staffNo);

ALTER TABLE Property
ADD CONSTRAINT FK_PropertyBranch FOREIGN KEY (branchNo) REFERENCES Branch (branchNo);



