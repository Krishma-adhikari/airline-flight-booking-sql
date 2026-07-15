# ✈️ Airline Flight Booking System — SQL Project

A relational database project simulating an airline flight booking system, built in MySQL. Designed to demonstrate core relational database skills: schema design, normalization, constraints, joins, aggregation, and views.

## 📌 Project Overview

This project models a simplified airline booking platform where passengers can book flights operated by different airlines, reserve seats, and make payments. The schema is fully normalized, with foreign keys enforcing referential integrity and check constraints enforcing valid business rules (e.g. booking status, seat class, payment method).

**Tech stack:** MySQL 8, MySQL Workbench

## 🗂️ Database Schema

The database consists of 7 tables:

| Table | Description |
|---|---|
| `airports` | Airport reference data (code, name, city, country) |
| `airlines` | Airline reference data (code, name, country) |
| `flights` | Flight schedule, price, departure/arrival airports and airline |
| `passengers` | Passenger personal and contact details |
| `bookings` | Links passengers to flights they've booked, with status |
| `seats` | Seat inventory per flight, with class and availability |
| `payments` | Payment record per booking, with method and status |

### Entity Relationships

- One **airline** operates many **flights**
- One **airport** can be the departure *or* arrival point for many **flights** (two separate foreign keys on `flights`)
- One **passenger** can make many **bookings**; one **flight** can have many **bookings** (many-to-many, resolved via `bookings`)
- One **flight** has many **seats**; each seat is unique per flight (`UNIQUE(flight_id, seat_number)`)
- Each **booking** has exactly one **payment** (`UNIQUE` on `payments.booking_id`)

```
airports ─┬─< flights >─── airlines
          └─< flights (arrival)

passengers ─< bookings >─ flights ─< seats
                │
                └─< payments
```

## 🔒 Key Design Decisions

- **Composite UNIQUE constraint** on `seats(flight_id, seat_number)` — the same seat number (e.g. "12A") can exist across different flights, but never twice on the same flight.
- **CHECK constraints** enforce valid values at the database level for `bookings.status`, `seats.seat_class`, `payments.payment_method`, and `payments.payment_status` — invalid data is rejected before it ever reaches the table.
- **DEFAULT CURRENT_TIMESTAMP** on `booking_date` and `payment_date` — timestamps are generated automatically, never entered manually.
- **DECIMAL(10,2)** used for all monetary values (`price`, `amount`) instead of floating-point types, avoiding rounding errors in financial data.
- **One-to-one enforcement** between bookings and payments via a `UNIQUE` constraint on the foreign key.



## 🔍 Sample Queries

A few highlights from `queries.sql` (13 queries total, covering filtering, multi-table joins, aggregation, and views):

**Flight + airline name (JOIN)**
```sql
SELECT flight_name, price, departure_time, airline_name
FROM flights
JOIN airlines ON flights.airline_code = airlines.airline_code;
```

**Departure & arrival city per flight (self-join with aliases)**
```sql
SELECT f.flight_name, dep.city AS departure_city, arr.city AS arrival_city
FROM flights f
JOIN airports dep ON f.departure_airport = dep.airport_code
JOIN airports arr ON f.arrival_airport = arr.airport_code;
```

**Total revenue collected (aggregate + filter)**
```sql
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid';
```

**Passengers who booked more than one flight (GROUP BY + HAVING)**
```sql
SELECT passenger_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY passenger_id
HAVING COUNT(*) > 1;
```

**Reusable view combining booking, passenger, flight, and payment info**
```sql
CREATE VIEW booking_summary AS
SELECT p.passenger_name, f.flight_name AS flight_number, a.airline_name, pay.payment_status
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id
JOIN airlines a ON f.airline_code = a.airline_code
JOIN payments pay ON pay.booking_id = b.booking_id;
```


