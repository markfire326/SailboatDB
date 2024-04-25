--Testing statements

--Trigger 1 test:

		SELECT * FROM Charter; --check if an open booking exists for B0106

--		This statement inserts a new charter for a boat that is not already booked for the selected dates
		INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
		VALUES ('MC108', 'B0106', 'IT101', 'CU101', '20-Jul-24', '25-Jul-24', NULL);


		SELECT * FROM Charter; --show that an open booking exists for B0106, therefore the new booking in the insert query below wont work


--		This statement attempts to insert a new charter for a boat that is already booked for the selected dates
		INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
		VALUES ('MC109', 'B0106', 'IT102', 'CU102', '22-Jul-24', '24-Jul-24', NULL);



--Trigger 2 test:

			SELECT * FROM Charter; --see charter table before testing
			SELECT * FROM Customer; --see customer balance before penalty is applied

--			This statement updates a Charter's ReturnDate to a date later than ExpectedReturnDate, triggering a late return penalty
			UPDATE Charter
			SET ReturnDate = '06-Aug-24'
			WHERE CharterID = 'MC108';


			SELECT * FROM Charter; -- see charter table before testing
			SELECT * FROM Customer; -- see balance for customer on MC104 charter before the refund is applied in test below

--			This statement updates a Charter's ReturnDate to a date earlier than ExpectedReturnDate, triggering a refund
			UPDATE Charter
			SET ReturnDate = '24-APR-22'
			WHERE CharterID = 'MC104';


--Trigger 3 test:

			SELECT * FROM Customer; --see customer table for CU105, check current balance

-- 			This statement should not violate the customer balance rule because the customer's unpaid balance is within the allowed limit
			INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
			VALUES ('MC110', 'B0107', 'IT102', 'CU105', '05-AUG-24', '07-AUG-24', NULL);


			SELECT * FROM Customer; --see customer balance for CU101 to see if they qualify for a booking

-- 			This statement should violate the customer balance rule because the customer's unpaid balance exceeds $400
			INSERT INTO Charter (CharterID, BoatID, ItineraryID, CustomerID, CharterStartDate, ExpectedReturnDate, ReturnDate)
			VALUES ('MC111', 'B0107', 'IT102', 'CU101', '08-AUG-24', '10-AUG-24', NULL);
