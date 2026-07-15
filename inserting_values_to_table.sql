use airline_flight_booking;

INSERT INTO Airports (airport_code, airport_name, city, country)
VALUES
('KTM', 'Tribhuvan International Airport', 'Kathmandu', 'Nepal'),
('DEL', 'Indira Gandhi International Airport', 'Delhi', 'India'),
('DXB', 'Dubai International Airport', 'Dubai', 'UAE'),
('BKK', 'Suvarnabhumi Airport', 'Bangkok', 'Thailand'),
('DAC', 'Hazrat Shahjalal International Airport', 'Dhaka', 'Bangladesh'),
('SIN', 'Changi Airport', 'Singapore', 'Singapore'),
('DOH', 'Hamad International Airport', 'Doha', 'Qatar');

INSERT INTO Airlines (airline_code, airline_name, country)
VALUES
('NA', 'Nepal Airlines', 'Nepal'),
('QA', 'Qatar Airways', 'Qatar'),
('EK', 'Emirates', 'UAE'),
('TG', 'Thai Airways', 'Thailand'),
('BG', 'Biman Bangladesh Airlines', 'Bangladesh');


INSERT INTO Flights (flight_name, price, departure_airport, arrival_airport, airline_code, departure_time, arrival_time)
VALUES
('NA101', 15000.00, 'KTM', 'DEL', 'NA', '2026-08-01 08:00:00', '2026-08-01 09:30:00'),
('NA102', 15500.00, 'DEL', 'KTM', 'NA', '2026-08-01 11:00:00', '2026-08-01 12:30:00'),
('QA202', 45000.00, 'KTM', 'DOH', 'QA', '2026-08-02 02:15:00', '2026-08-02 05:45:00'),
('EK303', 48000.00, 'KTM', 'DXB', 'EK', '2026-08-03 03:30:00', '2026-08-03 07:00:00'),
('TG404', 32000.00, 'KTM', 'BKK', 'TG', '2026-08-04 14:00:00', '2026-08-04 18:30:00'),
('BG505', 20000.00, 'KTM', 'DAC', 'BG', '2026-08-05 10:00:00', '2026-08-05 12:00:00'),
('EK306', 55000.00, 'DXB', 'SIN', 'EK', '2026-08-06 09:00:00', '2026-08-06 18:00:00'),
('QA204', 47000.00, 'DOH', 'KTM', 'QA', '2026-08-07 20:00:00', '2026-08-07 23:30:00');


INSERT INTO Passengers (passenger_name, passport_number, passenger_email, passenger_phone, passenger_address)
VALUES
('Krishma Adhikari', 'N1234567', 'rajesh.sharma@example.com', '9841000001', 'Kathmandu, Nepal'),
('Anita Gurung', 'N2345678', 'anita.gurung@example.com', '9841000002', 'Pokhara, Nepal'),
('Bibek Thapa', 'N3456789', 'bibek.thapa@example.com', '9841000003', 'Lalitpur, Nepal'),
('Sunita Rai', 'N4567890', 'sunita.rai@example.com', '9841000004', 'Biratnagar, Nepal'),
('Amit Verma', 'P5678901', 'amit.verma@example.com', '9812345678', 'Delhi, India');

INSERT INTO Bookings (passenger_id, flight_id, status)
VALUES
(1, 1, 'Booked'),
(2, 3, 'Booked'),
(3, 4, 'Checked-in'),
(4, 5, 'Booked'),
(5, 6, 'Cancelled'),
(1, 7, 'Booked'),
(2, 8, 'Checked-in');


INSERT INTO Seats (flight_id, seat_number, seat_class, is_available)
VALUES
(1, '1A', 'Business', FALSE),
(1, '12A', 'Economy', TRUE),
(1, '12B', 'Economy', TRUE),
(3, '1A', 'Business', FALSE),
(3, '14C', 'Economy', TRUE),
(4, '2A', 'Business', FALSE),
(4, '15D', 'Economy', TRUE),
(5, '3A', 'Business', FALSE),
(6, '10A', 'Economy', TRUE),
(7, '1B', 'Business', TRUE),
(8, '11C', 'Economy', FALSE);

INSERT INTO Payments (booking_id, amount, payment_method, payment_status)
VALUES
(1, 15000.00, 'Card', 'Paid'),
(2, 45000.00, 'Wallet', 'Paid'),
(3, 48000.00, 'Card', 'Paid'),
(4, 32000.00, 'Cash', 'Pending'),
(5, 20000.00, 'Card', 'Failed'),
(6, 55000.00, 'Wallet', 'Paid'),
(7, 47000.00, 'Card', 'Paid');
