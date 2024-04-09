--Script File for DDL and DML Operations

--Delete tables if they exist on the DB already (Purge is used to ensure the deleted tables are not retained in the recycle bin of the DB)

DROP TABLE Boat;
DROP TABLE BoatEquipment;
DROP TABLE Equipment;
DROP TABLE Owner;
DROP TABLE Charter;
DROP TABLE Customer;
DROP TABLE Itinerary;
DROP TABLE Supply;
DROP TABLE SupplyCharter;
DROP TABLE Crew;
DROP TABLE CrewHire;
DROP TABLE Review;
DROP TABLE Maintenance;
DROP TABLE RepairHistory;
DROP TABLE RepairFacility;
PURGE RECYCLEBIN;


--Create all the tables

CREATE TABLE Boat
(
	BoatID NUMBER(5) CONSTRAINT Boat_PK PRIMARY KEY,
	OwnerID NUMBER(5),
	BoatSize VARCHAR2(50),
	BoatDimension NUMBER(25,2) CONSTRAINT BoatDim CHECK (BoatDimension BETWEEN 28 AND 44)
);

CREATE TABLE BoatEquipment
(
	BoatEquipmentID NUMBER(5) CONSTRAINT BoatEquipment_PK PRIMARY KEY,
	BoatID NUMBER(5),
	EquipmentID NUMBER(5),
	UnitCost NUMBER(25,2) CONSTRAINT BoatEquipCost CHECK (UnitCost >= 0)
);

CREATE TABLE Equipment
(
	EquipmentID NUMBER(5) CONSTRAINT Equipment_PK PRIMARY KEY,
	EquipmentType VARCHAR2(50),
	EquipemtDesc VARCHAR2(50)
);

CREATE TABLE Owner
(
	OwnerID NUMBER(5) CONSTRAINT Owner_PK PRIMARY KEY,
	OwnerFN VARCHAR2(50),
	OwnerLN VARCHAR2(50),
	OwnerPhone NUMBER(10),
	OwnerAddr VARCHAR2(150)
);

CREATE TABLE Charter
(
	CharterID NUMBER(5) CONSTRAINT Charter_PK PRIMARY KEY,
	BoatID NUMBER(5),
	ItineraryID NUMBER(5),
	CustomerID NUMBER(5),
	CharterStartDate DATE,
	CharterExpectedEndDate DATE,
	CharterEndDate DATE
);

CREATE TABLE Customer
(
	CustomerID NUMBER(5) CONSTRAINT Customer_PK PRIMARY KEY,
	CustomerFN VARCHAR2(50),
	CustomerLN VARCHAR2(50),
	CustomerEmail VARCHAR2(150),
	CustomerPhone NUMBER(10)
);

CREATE TABLE Itinerary
(
	ItineraryID NUMBER(5) CONSTRAINT Itinerary_PK PRIMARY KEY,
	StartLocation VARCHAR2(150),
	Destination VARCHAR2(150),
	Duration INTERVAL DAY TO SECOND,
	Distance_mi NUMBER(25)
);

CREATE TABLE Supply
(
	SupplyID NUMBER(5) CONSTRAINT Supply_PK PRIMARY KEY,
	SupplyDesc VARCHAR2(50),
	SupplierName VARCHAR2(150)
);

CREATE TABLE SupplyCharter
(
	SupplyCharterID NUMBER(5) CONSTRAINT SupplyChart_PK PRIMARY KEY,
	SupplyQty VARCHAR2(25),
	UnitCost NUMBER(25,2) CONSTRAINT SupplyChartCost CHECK (UnitCost >= 0),
	SupplyID NUMBER(5),
	CharterID NUMBER(5)
);

CREATE TABLE Crew
(
	CrewID NUMBER(5) CONSTRAINT Crew_PK PRIMARY KEY,
	CrewFN VARCHAR2(50),
	CrewLN VARCHAR2(50),
	CrewPosition VARCHAR2(50),
	Contract_Type VARCHAR2(25)
);

CREATE TABLE CrewHire
(
	CrewHireID NUMBER(5) CONSTRAINT CrewHire_PK PRIMARY KEY,
	HoursWorked NUMBER(5,2),
	CrewID NUMBER(5),
	CharterID NUMBER(5)
);

CREATE TABLE Review
(
	ReviewID NUMBER(5) CONSTRAINT Review_PK PRIMARY KEY,
	CharterID NUMBER(5),
	ReviewSummary VARCHAR2(255),
	Rating NUMBER(1) CONSTRAINT Rating_Range CHECK (Rating BETWEEN 0 AND 5)
);

CREATE TABLE Maintenance
(
	MtceID NUMBER(5) CONSTRAINT Maintenance_PK PRIMARY KEY,
	BoatID NUMBER(5),
	RepairHistoryID NUMBER(5),
	RepFacID NUMBER(5),
	MtceType VARCHAR2(50),
	MtceDesc VARCHAR2(255)
);

CREATE TABLE RepairHistory
(
	RepairHistoryID NUMBER(5) CONSTRAINT RepairHistory_PK PRIMARY KEY,
	StartDate DATE,
	EndDate DATE,
	RepairDesc VARCHAR2(50)
);

CREATE TABLE RepairFacility
(
	RepFacID NUMBER(5) CONSTRAINT RepairFacility PRIMARY KEY,
	RepFacStreet VARCHAR2(50),
	RepFacState CHAR(2),
	RepFacCity VARCHAR2(50),
	RepFacZip NUMBER(5)
);



-- Add table referential constraints

ALTER TABLE Boat
ADD CONSTRAINT BoatOwner_FK FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID);

ALTER TABLE BoatEquipment
	ADD CONSTRAINT BoatEqBoat_FK FOREIGN KEY (BoatID) REFERENCES Boat(BoatID);
ALTER TABLE BoatEquipment
	ADD CONSTRAINT BoatEquipID_FK FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID);

ALTER TABLE Charter
	ADD CONSTRAINT CharterBoat_FK FOREIGN KEY (BoatID) REFERENCES Boat(BoatID);
ALTER TABLE Charter
	ADD CONSTRAINT CharterItinerary_FK FOREIGN KEY (ItineraryID) REFERENCES Itinerary(ItineraryID);
ALTER TABLE Charter
	ADD CONSTRAINT CharterCustomer_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE SupplyCharter
	ADD CONSTRAINT SupplyChartSply_FK FOREIGN KEY (SupplyID) REFERENCES Supply(SupplyID);
ALTER TABLE SupplyCharter
	ADD CONSTRAINT SupplyChartChart_FK FOREIGN KEY (CharterID) REFERENCES Charter(CharterID);

ALTER TABLE CrewHire
	ADD CONSTRAINT CrewHireCrew_FK FOREIGN KEY (CrewID) REFERENCES Crew(CrewID);
ALTER TABLE CrewHire
	ADD CONSTRAINT CrewHireChart_FK FOREIGN KEY (CharterID) REFERENCES Charter(CharterID);

ALTER TABLE Review
	ADD CONSTRAINT ReviewChart_FK FOREIGN KEY (CharterID) REFERENCES Charter(CharterID);

ALTER TABLE Maintenance
	ADD CONSTRAINT MaintenanceBoat_FK FOREIGN KEY (BoatID) REFERENCES Boat(BoatID);
ALTER TABLE Maintenance
	ADD CONSTRAINT MaintenanceHistory_FK FOREIGN KEY (RepairHistoryID) REFERENCES RepairHistory(RepairHistoryID);
ALTER TABLE Maintenance
	ADD CONSTRAINT MaintenanceFacility_FK FOREIGN KEY (RepFacID) REFERENCES RepairFacility(RepairFacilityID);
