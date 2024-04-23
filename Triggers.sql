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