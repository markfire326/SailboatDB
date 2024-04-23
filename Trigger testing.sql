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
