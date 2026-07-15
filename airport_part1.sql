CREATE DATABASE airline_flight_booking;
USE airline_flight_booking;

CREATE TABLE airports (
    airport_code CHAR(3) PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE airlines (
    airline_code CHAR(2) PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL
);

CREATE TABLE flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    departure_airport CHAR(3) NOT NULL,
    arrival_airport CHAR(3) NOT NULL,
    airline_code CHAR(2) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    FOREIGN KEY (departure_airport) REFERENCES airports(airport_code),
    FOREIGN KEY (arrival_airport) REFERENCES airports(airport_code),
    FOREIGN KEY (airline_code) REFERENCES airlines(airline_code)
);

CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_name VARCHAR(100) NOT NULL,
    passport_number VARCHAR(50) UNIQUE NOT NULL,
    passenger_email VARCHAR(50) UNIQUE NOT NULL,
    passenger_phone VARCHAR(50) NOT NULL,
    passenger_address VARCHAR(50)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Booked' NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    CHECK (status IN ('Booked', 'Cancelled', 'Checked-in'))
);

CREATE TABLE seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT NOT NULL,
    seat_number VARCHAR(3) NOT NULL,
    seat_class VARCHAR(20) DEFAULT 'Economy' NOT NULL,
    is_available BOOL DEFAULT TRUE NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    UNIQUE (flight_id, seat_number),
    CHECK (seat_class IN ('Economy', 'Business', 'First'))
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20) DEFAULT 'Cash' NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CHECK (payment_method IN ('Card', 'Cash', 'Wallet')),
    CHECK (payment_status IN ('Paid', 'Pending', 'Failed'))
);