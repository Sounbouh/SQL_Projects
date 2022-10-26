-- Let's conduct a police investigation. 
-- First, I want to read the crime scene reports, specifically for the crime that happened on the 28th of July, 2021, on Humphrey street.

SELECT description
FROM crime_scene_reports
WHERE year = 2021
AND month = 7
AND day = 28
AND street = 'Humphrey Street';

--> From this I gather some relevant information : the theft took place at 10:15am, and there were three witnesses.

-- Let's read the witnesses' statements.

SELECT id, transcript
FROM interviews
WHERE year = 2021
AND month = 7
AND day = 28
AND transcript LIKE '%bakery%';


--> From this I learn that the thief escaped around 10:25am in a car, he was seen withdrawing money earlier at an ATM on Leggett Street,
--> and the thief has an accumplice who he was talking on the phone with for less than a minute, asking them to book them a flight out of the city for the next morning.

-- I check the security logs to look for the getaway car
SELECT activity, license_plate
FROM bakery_security_logs
WHERE year = 2021
AND month = 7
AND day = 28
AND hour = 10
AND minute > 15
AND minute < 25;

--> 8 possible cars exiting the parking lot in this slot of time

-- I check the atm transaction on Leggett Street
SELECT id, account_number, amount
FROM atm_transactions
WHERE year = 2021
AND month = 7
AND day = 28
AND atm_location = 'Leggett Street'
AND transaction_type = 'withdraw';

--> 8 different withdraws 

-- I check the phone calls that happened on that day and that lasted less than a minute.
SELECT id, caller, receiver, duration
FROM phone_calls
WHERE year = 2021
AND month = 7
AND day = 28
AND duration <= 60;

--> 10 possible phone calls match the description.

-- I check the flight information that match my information 
SELECT destination_airport_id, hour, minute, flights.id
FROM airports, flights
WHERE airports.id = flights.origin_airport_id
AND flights.year = 2021
AND flights.month = 7
AND flights.day = 29
AND city = 'Fiftyville';

--> The earliest flight is 4|8|20, flight 36 (destination airport 4, at 8:20 am).

-- I check which airport has the id 4
SELECT * 
FROM airports
WHERE id = 4;

--> 4|LGA|LaGuardia Airport|New York City
--> The thief is going to NYC on the 8:20am flight

-- I checked the flight manifest to see who is on that flight.
SELECT passport_number, seat 
FROM passengers
WHERE flight_id = 36;

--> 8 different passengers

-- I want to find the overlap between the people who placed phone calls, with a car that left the parking lot and who are on the flight.
SELECT id, name
FROM people
WHERE license_plate IN (SELECT license_plate
FROM bakery_security_logs
WHERE year = 2021
AND month = 7
AND day = 28
AND hour = 10
AND minute > 15
AND minute < 25)
AND passport_number IN (SELECT passport_number
FROM passengers
WHERE flight_id = 36)
AND phone_number IN (SELECT caller
FROM phone_calls
WHERE year = 2021
AND month = 7
AND day = 28
AND duration <= 60);

--> I have 3 potential suspects : Sofia, Kelsey and Bruce

-- I know that the thief must have a bank account, so I checked who has one between the three.
SELECT *
FROM bank_accounts
WHERE person_id =686048;

--> Only Bruce seem to have a bank account

-- Let's check Bruce phone records 
SELECT * FROM people Where name = 'Bruce';

--> I get Bruce phone number: '(367) 555-5533'

-- Let's see who Bruce called for under a minute on that day

SELECT receiver
FROM phone_calls
WHERE caller = '(367) 555-5533'
AND year = 2021
AND month = 7
AND day = 28
AND duration < 60;

--> The potential accomplice has this phone number : (375) 555-8161

SELECT * 
FROM people 
WHERE phone_number = '(375) 555-8161';

-->  The accomplice is Robin.

--> Bruce commited the robbery, and with the help of Robin, he is planning to escape to New York City.