-- Task 1: Flights departing from Kathmandu priced above 20,000
SELECT * FROM flights
WHERE departure_airport = 'KTM' AND price > 20000;

-- Task 2: List all passengers whose email contains "example"
SELECT * FROM passengers
WHERE passenger_email LIKE '%example%';

-- Task 3: Show all flights sorted by price, cheapest first
SELECT * FROM flights ORDER BY price ASC;

-- Task 4: Show all bookings with status 'Cancelled'
SELECT * FROM bookings
WHERE status = 'Cancelled';

-- Task 5: Show all available seats in Economy class
SELECT * FROM seats
WHERE is_available = TRUE;

-- Task 6: Show each flight along with its airline name
SELECT flight_name, price, departure_time, airline_name
FROM flights
JOIN airlines ON flights.airline_code = airlines.airline_code;

-- Task 7: Show each flight with its departure city and arrival city names
SELECT 
    f.flight_name, 
    f.price, 
    dep.city AS departure_city, 
    arr.city AS arrival_city
FROM flights f
JOIN airports dep ON f.departure_airport = dep.airport_code
JOIN airports arr ON f.arrival_airport = arr.airport_code;

-- Task 8: Show each booking with the passenger's name and the flight number they booked
SELECT p.passenger_name, f.flight_name, b.status
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id;

-- Task 9: Show each payment with the passenger's name and amount
SELECT p.passenger_name, pay.amount
FROM payments pay
JOIN bookings b ON pay.booking_id = b.booking_id
JOIN passengers p ON b.passenger_id = p.passenger_id;

-- Task 10: Count how many flights each airline operates
SELECT airline_code, COUNT(*) AS total_flights
FROM flights
GROUP BY airline_code;

-- Task 11a: Revenue breakdown by payment status
SELECT payment_status, SUM(amount) AS total_revenue
FROM payments
GROUP BY payment_status;

-- Task 11b: True total revenue collected (only successful payments)
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid';

-- Task 12: Passengers who booked more than 1 flight
SELECT passenger_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY passenger_id
HAVING COUNT(*) > 1;

-- Task 13: View combining passenger name, flight number, airline, and payment status
CREATE VIEW booking_summary AS
SELECT 
    p.passenger_name,
    f.flight_name AS flight_number,
    a.airline_name,
    pay.payment_status
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id
JOIN airlines a ON f.airline_code = a.airline_code
JOIN payments pay ON pay.booking_id = b.booking_id;

SELECT * FROM booking_summary;