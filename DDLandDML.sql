--Script File for GP#1
--Group A
--IS443/543 SP 24



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

CREATE TABLE Owner
(
	OwnerID VARCHAR2(5) CONSTRAINT Owner_PK PRIMARY KEY,
	OwnerFN VARCHAR2(50),
	OwnerLN VARCHAR2(50),
	OwnerPhone NUMBER(10),
	OwnerAddr VARCHAR2(150)
);

CREATE TABLE Equipment
(
	EquipmentID VARCHAR2(5) CONSTRAINT Equipment_PK PRIMARY KEY,
	EquipmentType VARCHAR2(50),
	EquipmentDesc VARCHAR2(50)
);

CREATE TABLE Itinerary
(
	ItineraryID VARCHAR2(5) CONSTRAINT Itinerary_PK PRIMARY KEY,
	StartLocation VARCHAR2(150),
	Destination VARCHAR2(150),
	Duration_days NUMBER(2),
	Distance_mi NUMBER(25)
);

CREATE TABLE Customer
(
	CustomerID VARCHAR2(5) CONSTRAINT Customer_PK PRIMARY KEY,
	CustomerFN VARCHAR2(50),
	CustomerLN VARCHAR2(50),
	CustomerEmail VARCHAR2(150),
	CustomerPhone NUMBER(10),
	CustomerBalance NUMBER(10,2)
);

CREATE TABLE Supply
(
	SupplyID VARCHAR2(5) CONSTRAINT Supply_PK PRIMARY KEY,
	SupplyDesc VARCHAR2(50),
	SupplierName VARCHAR2(150)
);

CREATE TABLE Crew
(
	CrewID VARCHAR2(5) CONSTRAINT Crew_PK PRIMARY KEY,
	CrewFN VARCHAR2(50),
	CrewLN VARCHAR2(50),
	CrewPosition VARCHAR2(50)
);

CREATE TABLE RepairFacility
(
	RepFacID VARCHAR2(5) CONSTRAINT RepairFacility PRIMARY KEY,
	RepFacState CHAR(2),
	RepFacCity VARCHAR2(50),
	RepFacZip NUMBER(5)
);

CREATE TABLE RepairHistory
(
	RepairHistoryID VARCHAR2(5) CONSTRAINT RepairHistory_PK PRIMARY KEY,
	StartDate DATE,
	EndDate DATE,
	RepairDesc VARCHAR2(50)
);

CREATE TABLE Boat
(
	BoatID VARCHAR2(5) CONSTRAINT Boat_PK PRIMARY KEY,
	OwnerID VARCHAR2(5),
	BoatSize VARCHAR2(50),
	BoatLength NUMBER(4,2) CONSTRAINT BoatDim CHECK (BoatLength BETWEEN 28 AND 44), --change to boatlength
	YearBuilt NUMBER(4)
);

CREATE TABLE Charter
(
	CharterID VARCHAR2(5) CONSTRAINT Charter_PK PRIMARY KEY,
	BoatID VARCHAR2(5),
	ItineraryID VARCHAR2(5),
	CustomerID VARCHAR2(5),
	CharterStartDate DATE,
	ExpectedReturnDate DATE,
	ReturnDate DATE
);

CREATE TABLE Review
(
	ReviewID VARCHAR2(5) CONSTRAINT Review_PK PRIMARY KEY,
	CharterID VARCHAR2(5),
	ReviewSummary VARCHAR2(255),
	Rating NUMBER(1) CONSTRAINT Rating_Range CHECK (Rating BETWEEN 0 AND 5)
);

CREATE TABLE BoatEquipment
(
	BoatEquipmentID VARCHAR2(5) CONSTRAINT BoatEquipment_PK PRIMARY KEY,
	BoatID VARCHAR2(5),
	EquipmentID VARCHAR2(5)
);

CREATE TABLE SupplyCharter
(
	SupplyCharterID VARCHAR2(5) CONSTRAINT SupplyChart_PK PRIMARY KEY,
	SupplyQty NUMBER(5),
	SupplyID VARCHAR2(5),
	CharterID VARCHAR2(5)
);

CREATE TABLE CrewHire
(
	CrewHireID VARCHAR2(5) CONSTRAINT CrewHire_PK PRIMARY KEY,
	HoursWorked NUMBER(5,2),
	CrewID VARCHAR2(5),
	CharterID VARCHAR2(5)
);

CREATE TABLE Maintenance
(
	MtceID VARCHAR2(5) CONSTRAINT Maintenance_PK PRIMARY KEY,
	BoatID VARCHAR2(5),
	RepairHistoryID VARCHAR2(5),
	RepFacID VARCHAR2(5),
	MtceType VARCHAR2(50),
	MtceDesc VARCHAR2(255)
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
	ADD CONSTRAINT MaintenanceFacility_FK FOREIGN KEY (RepFacID) REFERENCES RepairFacility(RepFacID);





-- Insert values into all tables

--Owner Table

INSERT INTO Owner (OwnerID, OwnerFN, OwnerLN, OwnerPhone, OwnerAddr) VALUES ('OW001', 'Shawn', 'Carter', 3200001234, 'Boston, MA');
INSERT INTO Owner (OwnerID, OwnerFN, OwnerLN, OwnerPhone, OwnerAddr) VALUES ('OW002', 'Nia', 'Long', 3200011234, 'Los Angeles, CA');
INSERT INTO Owner (OwnerID, OwnerFN, OwnerLN, OwnerPhone, OwnerAddr) VALUES ('OW003', 'Peter', 'Parker', 320002123, 'Saint Paul, MN');
INSERT INTO Owner (OwnerID, OwnerFN, OwnerLN, OwnerPhone, OwnerAddr) VALUES ('OW004', 'Nina', 'Simone', 3200031234, 'Miami, FL');
INSERT INTO Owner (OwnerID, OwnerFN, OwnerLN, OwnerPhone, OwnerAddr) VALUES ('OW005', 'John', 'Doe', 3200041234, 'Baltimore, MD');
INSERT INTO Owner (OwnerID, OwnerFN, OwnerLN, OwnerPhone, OwnerAddr) VALUES ('OW006', 'Lucy', 'Liu', 3200051234, 'River St, NY');

--Equipment Table

INSERT INTO Equipment (EquipmentID, EquipmentDesc, EquipmentType) VALUES ('EQ001', 'Radio', 'fixed');
INSERT INTO Equipment (EquipmentID, EquipmentDesc, EquipmentType) VALUES ('EQ002', 'Sail', 'peripheral');
INSERT INTO Equipment (EquipmentID, EquipmentDesc, EquipmentType) VALUES ('EQ003', 'Compass', 'fixed');
INSERT INTO Equipment (EquipmentID, EquipmentDesc, EquipmentType) VALUES ('EQ004', 'Life Jacket', 'peripheral');
INSERT INTO Equipment (EquipmentID, EquipmentDesc, EquipmentType) VALUES ('EQ005', 'Refrigerator', 'fixed');

--Boat table

INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0101', 'OW001', 'medium', 35, 2008);
INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0102', 'OW004', 'large', 44, 2018);
INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0103', 'OW005', 'small', 28.5, 2012);
INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0104', 'OW003', 'large', 42.35, 2017);
INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0105', 'OW003', 'medium', 38, 2010);
INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0106', 'OW002', 'small', 29.3, 2019);
INSERT INTO Boat (BoatID, OwnerID, BoatSize, BoatLength, YearBuilt) VALUES ('B0107', 'OW004', 'small', 31.2, 2013);
	
--Boat Equipment Table

INSERT INTO BoatEquipment (BoatEquipmentID, BoatID, EquipmentID) VALUES ('BE001', 'B0101', 'EQ004');
INSERT INTO BoatEquipment (BoatEquipmentID, BoatID, EquipmentID) VALUES ('BE002', 'B0105', 'EQ001');
INSERT INTO BoatEquipment (BoatEquipmentID, BoatID, EquipmentID) VALUES ('BE003', 'B0103', 'EQ002');
INSERT INTO BoatEquipment (BoatEquipmentID, BoatID, EquipmentID) VALUES ('BE004', 'B0104', 'EQ003');
INSERT INTO BoatEquipment (BoatEquipmentID, BoatID, EquipmentID) VALUES ('BE005', 'B0107', 'EQ005');

--Itinerary Table

INSERT INTO Itinerary (ItineraryID, StartLocation, Destination, Duration_days, Distance_mi) VALUES ('IT101', 'Miami, FL', 'Key West, FL', 3, 160);
INSERT INTO Itinerary (ItineraryID, StartLocation, Destination, Duration_days, Distance_mi) VALUES ('IT102', 'Annapolis, MD', 'Baltimore, MD', 1, 30);
INSERT INTO Itinerary (ItineraryID, StartLocation, Destination, Duration_days, Distance_mi) VALUES ('IT103', 'Fort Lauderdale, FL', 'Bahamas', 7, 200);
INSERT INTO Itinerary (ItineraryID, StartLocation, Destination, Duration_days, Distance_mi) VALUES ('IT104', 'Seattle, WA', 'San Juan Islands, WA', 4, 85);
INSERT INTO Itinerary (ItineraryID, StartLocation, Destination, Duration_days, Distance_mi) VALUES ('IT105', 'Charleston, SC', 'Savannah, GA', 3, 100);

--Customer Table

INSERT INTO Customer (CustomerID, CustomerFN, CustomerLN, CustomerEmail, CustomerPhone, CustomerBalance) VALUES ('CU101', 'Lauryn', 'Hill', 'lauryn.hill@mail.com', 3201230000, 75);
INSERT INTO Customer (CustomerID, CustomerFN, CustomerLN, CustomerEmail, CustomerPhone, CustomerBalance) VALUES ('CU102', 'Pablo', 'Emilio', 'pablo.emilio@mail.com', 3201230001, 0);
INSERT INTO Customer (CustomerID, CustomerFN, CustomerLN, CustomerEmail, CustomerPhone, CustomerBalance) VALUES ('CU103', 'Kenny', 'Lamar', 'kenny.lamar@mail.com', 3201230002, 0);
INSERT INTO Customer (CustomerID, CustomerFN, CustomerLN, CustomerEmail, CustomerPhone, CustomerBalance) VALUES ('CU104', 'Margot', 'Robbie', 'margot.robbie@mail.com', 3201230003, 150);
INSERT INTO Customer (CustomerID, CustomerFN, CustomerLN, CustomerEmail, CustomerPhone, CustomerBalance) VALUES ('CU105', 'Jermaine', 'Cole', 'jermaine.cole@mail.com', 3201230004, 150);

--Charter Table

INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC101', 'B0103', 'IT102', 'CU105', '28-Jan-22', '29-Jan-22', '31-Jan-22');
INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC102', 'B0101', 'IT101', 'CU101', '15-Feb-22', '18-Feb-22', '19-Feb-22');
INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC103', 'B0104', 'IT104', 'CU103', '03-Mar-22', '07-Mar-22', '07-Mar-22');
INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC104', 'B0105', 'IT105', 'CU104', '22-Apr-22', '25-Apr-22', '27-Apr-22');
INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC105', 'B0102', 'IT103', 'CU102', '09-May-22', '16-May-22', '16-May-22');
INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC106', 'B0106', 'IT105', 'CU104', '15-Jun-22', '18-Jun-22', '18-Jun-22');
INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate) VALUES ('MC107', 'B0107', 'IT102', 'CU103', '25-Jul-22', '26-Jul-22', '26-Jul-22');

--Supply Table

INSERT INTO Supply (SupplyID, SupplyDesc, SupplierName) VALUES ('SU101', 'Navigation Books', 'Columbus and Co');
INSERT INTO Supply (SupplyID, SupplyDesc, SupplierName) VALUES ('SU102', 'Tide tables', 'Tommy Cruise');
INSERT INTO Supply (SupplyID, SupplyDesc, SupplierName) VALUES ('SU103', 'Bath Towels', 'Bath Kings Ltd');
INSERT INTO Supply (SupplyID, SupplyDesc, SupplierName) VALUES ('SU104', 'Safety Equipment', 'Safety Gear Supplies');
INSERT INTO Supply (SupplyID, SupplyDesc, SupplierName) VALUES ('SU105', 'Luxury Linens', 'Fine Linen Boutique');

--SupplyCharter Table

INSERT INTO SupplyCharter (SupplyCharterID, SupplyQty, SupplyID, CharterID) VALUES ('SC001', 2, 'SU102', 'MC103');
INSERT INTO SupplyCharter (SupplyCharterID, SupplyQty, SupplyID, CharterID) VALUES ('SC002', 5, 'SU105', 'MC104');
INSERT INTO SupplyCharter (SupplyCharterID, SupplyQty, SupplyID, CharterID) VALUES ('SC003', 2, 'SU103', 'MC105');
INSERT INTO SupplyCharter (SupplyCharterID, SupplyQty, SupplyID, CharterID) VALUES ('SC004', 4, 'SU105', 'MC106');
INSERT INTO SupplyCharter (SupplyCharterID, SupplyQty, SupplyID, CharterID) VALUES ('SC005', 1, 'SU101', 'MC104');

--Crew Table

INSERT INTO Crew (CrewID, CrewFN, CrewLN, CrewPosition) VALUES ('CR101', 'James', 'Taylor', 'Captain');
INSERT INTO Crew (CrewID, CrewFN, CrewLN, CrewPosition) VALUES ('CR102', 'Maria', 'Lopez', 'First Mate');
INSERT INTO Crew (CrewID, CrewFN, CrewLN, CrewPosition) VALUES ('CR103', 'Sam', 'Wilson', 'Deckhand');
INSERT INTO Crew (CrewID, CrewFN, CrewLN, CrewPosition) VALUES ('CR104', 'Anita', 'Kumar', 'Chef');
INSERT INTO Crew (CrewID, CrewFN, CrewLN, CrewPosition) VALUES ('CR105', 'John', 'Clarke', 'Engineer');

--CrewHire Table

INSERT INTO CrewHire (CrewHireID, HoursWorked, CrewID, CharterID) VALUES ('CH001', 5, 'CR102', 'MC103');
INSERT INTO CrewHire (CrewHireID, HoursWorked, CrewID, CharterID) VALUES ('CH002', 11, 'CR105', 'MC104');
INSERT INTO CrewHire (CrewHireID, HoursWorked, CrewID, CharterID) VALUES ('CH003', 12, 'CR104', 'MC105');
INSERT INTO CrewHire (CrewHireID, HoursWorked, CrewID, CharterID) VALUES ('CH004', 8, 'CR102', 'MC106');
INSERT INTO CrewHire (CrewHireID, HoursWorked, CrewID, CharterID) VALUES ('CH005', 7, 'CR101', 'MC101');

--Review Table

INSERT INTO Review (ReviewID, CharterID, ReviewSummary, Rating) VALUES ('FB101', 'MC102', 'great trip', 4);
INSERT INTO Review (ReviewID, CharterID, ReviewSummary, Rating) VALUES ('FB102', 'MC103', 'comfortable boats', 5);
INSERT INTO Review (ReviewID, CharterID, ReviewSummary, Rating) VALUES ('FB103', 'MC104', 'Exceptional service', 5);
INSERT INTO Review (ReviewID, CharterID, ReviewSummary, Rating) VALUES ('FB104', 'MC105', 'Beautiful scenery', 4);
INSERT INTO Review (ReviewID, CharterID, ReviewSummary, Rating) VALUES ('FB105', 'MC106', 'Well-planned itinerary', 5);

--RepairFacility Table

INSERT INTO RepairFacility (RepFacID, RepFacState, RepFacCity, RepFacZip) VALUES ('FAC01', 'CA', 'San Francisco', 94112);
INSERT INTO RepairFacility (RepFacID, RepFacState, RepFacCity, RepFacZip) VALUES ('FAC02', 'MD', 'Baltimore', 21218);
INSERT INTO RepairFacility (RepFacID, RepFacState, RepFacCity, RepFacZip) VALUES ('FAC03', 'FL', 'Miami', 33133);
INSERT INTO RepairFacility (RepFacID, RepFacState, RepFacCity, RepFacZip) VALUES ('FAC04', 'WA', 'Seattle', 98199);
INSERT INTO RepairFacility (RepFacID, RepFacState, RepFacCity, RepFacZip) VALUES ('FAC05', 'RI', 'Newport', 02840);

--RepairHistory Table

INSERT INTO RepairHistory (RepairHistoryID, StartDate, EndDate, RepairDesc) VALUES ('RH101', '20-Apr-21', '22-Apr-21', 'Structural Repair');
INSERT INTO RepairHistory (RepairHistoryID, StartDate, EndDate, RepairDesc) VALUES ('RH102', '15-Jun-21', '17-Jun-21', 'Electrical System Fix');
INSERT INTO RepairHistory (RepairHistoryID, StartDate, EndDate, RepairDesc) VALUES ('RH103', '10-Aug-21', '12-Aug-21', 'Engine Overhaul');
INSERT INTO RepairHistory (RepairHistoryID, StartDate, EndDate, RepairDesc) VALUES ('RH104', '25-Oct-21', '30-Oct-21', 'Water System Update');
INSERT INTO RepairHistory (RepairHistoryID, StartDate, EndDate, RepairDesc) VALUES ('RH105', '05-Dec-21', '07-Dec-21', 'Sail Replacement');

--Maintenance Table

INSERT INTO Maintenance (MtceID, BoatID, RepairHistoryID, RepFacID, MtceType, MtceDesc) VALUES ('MT001', 'B0103', null, 'FAC05', 'Oil Change', 'PM Oil change');
INSERT INTO Maintenance (MtceID, BoatID, RepairHistoryID, RepFacID, MtceType, MtceDesc) VALUES ('MT002', 'B0104', 'RH103', 'FAC03', 'Repair', 'Part replacement');
INSERT INTO Maintenance (MtceID, BoatID, RepairHistoryID, RepFacID, MtceType, MtceDesc) VALUES ('MT003', 'B0105', 'RH104', 'FAC02', 'Cleaning', 'Detailed interior clean');
INSERT INTO Maintenance (MtceID, BoatID, RepairHistoryID, RepFacID, MtceType, MtceDesc) VALUES ('MT004', 'B0106', 'RH105', 'FAC04', 'Engine Tuning', 'Engine performance boost');
INSERT INTO Maintenance (MtceID, BoatID, RepairHistoryID, RepFacID, MtceType, MtceDesc) VALUES ('MT005', 'B0107', 'RH102', 'FAC01', 'System Upgrade', 'Navigation system update');


--Creating the Triggers

-- Trigger 1: Prevent Overbooking

CREATE OR REPLACE TRIGGER no_overbooking
BEFORE INSERT ON Charter
FOR EACH ROW
DECLARE
    boat_status VARCHAR2(10);
BEGIN
    -- Check if the boat is already booked for the selected dates
    BEGIN
	    SELECT 'Booked'
	    INTO boat_status
	    FROM Charter
	    WHERE BoatID = :new.BoatID
	    AND (:new.CharterStartDate BETWEEN CharterStartDate AND ExpectedReturnDate
	        OR :new.ExpectedReturnDate BETWEEN CharterStartDate AND ExpectedReturnDate);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		-- Throw exception when no charters are found
			NULL;

 	END;       
    -- If the boat is booked, raise an error
    IF boat_status = 'Booked' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Sorry, this boat is already booked for the selected dates.');
    END IF;
END;
/

-- Trigger 2: Late Return Penalty and Early Return Refund

-- First, we create a column for customer balance on the customer table

CREATE OR REPLACE TRIGGER penalty_and_refund
AFTER UPDATE OF ReturnDate ON Charter
FOR EACH ROW
DECLARE
    v_penalty NUMBER(10, 2);
    v_refund NUMBER(10, 2);
BEGIN
    IF :new.ReturnDate > :old.ExpectedReturnDate THEN
        v_penalty := (:new.ReturnDate - :old.ExpectedReturnDate) * 75;
        UPDATE Customer
        SET CustomerBalance = CustomerBalance + v_penalty
        WHERE CustomerID = :new.CustomerID;
    ELSIF :new.ReturnDate < :old.ExpectedReturnDate THEN
        v_refund := (:old.ExpectedReturnDate - :new.ReturnDate) * 20;
        UPDATE Customer
        SET CustomerBalance = CustomerBalance - v_refund
        WHERE CustomerID = :new.CustomerID;
    END IF;
END;
/


--Trigger 3: Check Customer Balance

CREATE OR REPLACE TRIGGER check_customer_balance
BEFORE INSERT ON Charter
FOR EACH ROW
DECLARE
    v_customer_balance NUMBER(10, 2);
BEGIN
    SELECT CustomerBalance INTO v_customer_balance
    FROM Customer
    WHERE CustomerID = :new.CustomerID;

    IF v_customer_balance > 400 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Customer cannot rent a boat. Your balance exceeds $400');
    END IF;
END;
/


--Testing statements

--Trigger 1 test:
--		This statement inserts a new charter for a boat that is not already booked for the selected dates
		INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
		VALUES ('MC108', 'B0106', 'IT101', 'CU101', '20-Jul-24', '25-Jul-24', NULL);

--		This statement attempts to insert a new charter for a boat that is already booked for the selected dates
		INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
		VALUES ('MC109', 'B0106', 'IT102', 'CU102', '22-Jul-24', '24-Jul-24', NULL);



--Trigger 2 test:
--			This statement updates a Charter's ReturnDate to a date later than ExpectedReturnDate, triggering a late return penalty
			UPDATE Charter
			SET ReturnDate = '06-Aug-24'
			WHERE CharterID = 'MC108';

--			This statement updates a Charter's ReturnDate to a date earlier than ExpectedReturnDate, triggering a refund
			UPDATE Charter
			SET ReturnDate = '24-APR-22'
			WHERE CharterID = 'MC104';;


--Trigger 3 test:
-- 			This statement should not violate the customer balance rule because the customer's unpaid balance is within the allowed limit
			INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
			VALUES ('MC110', 'B0107', 'IT102', 'CU105', '05-AUG-24', '07-AUG-24', NULL);

-- 			This statement should violate the customer balance rule because the customer's unpaid balance exceeds $400
			INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
			VALUES ('MC111', 'B0107', 'IT102', 'CU101', '08-AUG-24', '10-AUG-24', NULL);

