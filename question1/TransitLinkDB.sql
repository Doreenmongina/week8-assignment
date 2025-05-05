CREATE DATABASE IF NOT EXISTS TransitLinkDB;
USE TransitLinkDB;

-- Create the 'customers' table
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone_no VARCHAR(20) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  address VARCHAR(255)
);

-- Create the 'buses' table
CREATE TABLE buses (
  bus_id INT PRIMARY KEY AUTO_INCREMENT,
  bus_no VARCHAR(20) NOT NULL,
  bus_type VARCHAR(50) NOT NULL,
  seat_capacity INT NOT NULL,
  current_status VARCHAR(50) NOT NULL
);

-- Create the 'routes' table
CREATE TABLE routes (
  route_id INT PRIMARY KEY AUTO_INCREMENT,
  departure_location VARCHAR(255) NOT NULL,
  destination_location VARCHAR(255) NOT NULL,
  distance_km DECIMAL(10, 2) NOT NULL,
  estimated_travel_time INT NOT NULL
);

-- Create the 'stops' table
CREATE TABLE stops (
  stop_id INT PRIMARY KEY AUTO_INCREMENT,
  route_id INT,
  stop_name VARCHAR(255) NOT NULL,
  stop_order INT NOT NULL,
  FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

-- Create the 'drivers' table
CREATE TABLE drivers (
  driver_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  phone_no VARCHAR(20) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  licence_no VARCHAR(50) NOT NULL
);

-- Create the 'schedules' table
CREATE TABLE schedules (
  schedule_id INT PRIMARY KEY AUTO_INCREMENT,
  bus_id INT,
  driver_id INT,
  route_id INT,
  fare INT NOT NULL,
  departure_date_time DATETIME NOT NULL,
  arrival_date_time DATETIME NOT NULL,
  available_seats INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
  FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
  FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

-- Create the 'seats' table
CREATE TABLE seats (
  seat_id INT PRIMARY KEY AUTO_INCREMENT,
  bus_id INT,
  schedule_id INT,
  seat_no INT NOT NULL,
  seat_type VARCHAR(50) NOT NULL,
  FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
  FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id),
  UNIQUE (bus_id, seat_no)
);

-- Create the 'bookings' table
CREATE TABLE bookings (
  booking_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  schedule_id INT,
  booking_date DATETIME NOT NULL,
  payment_status VARCHAR(50) NOT NULL,
  booking_status VARCHAR(50) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
);

-- Create the 'booked_seats' table
CREATE TABLE booked_seats (
  booked_seat_id INT PRIMARY KEY AUTO_INCREMENT,
  booking_id INT,
  seat_id INT,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
  FOREIGN KEY (seat_id) REFERENCES seats(seat_id),
  UNIQUE (booking_id, seat_id)
);

-- Create the 'payments' table
CREATE TABLE payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  booking_id INT,
  amount INT NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  transaction_date DATETIME NOT NULL,
  transaction_status VARCHAR(50) NOT NULL,
  transaction_id VARCHAR(255) NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Insert sample data into customers table
INSERT INTO customers (name, phone_no, email, address) VALUES
('John Kamau', '+254712345678', 'johnkamau@gmail.com', 'Westlands, Nairobi'),
('Mary Wanjiku', '+254723456789', 'marywanjiku@gmail.com', 'Kilimani, Nairobi'),
('Peter Omondi', '+254734567890', 'peteromondi@gmail.com', 'Nyali, Mombasa'),
('Sarah Akinyi', '+254745678901', 'sarahakinyi@yahoo.com', 'Kileleshwa, Nairobi'),
('James Wafula', '+254756789012', 'jameswafula@gmail.com', 'Bamburi, Mombasa'),
('Lucy Muthoni', '+254767890123', 'lucymuthoni@gmail.com', 'Nakuru Town'),
('David Kiprop', '+254778901234', 'davidkiprop@yahoo.com', 'Eldoret Town'),
('Jane Njeri', '+254789012345', 'janenjeri@gmail.com', 'Rongai, Nairobi'),
('Michael Otieno', '+254790123456', 'michaelotieno@gmail.com', 'Tudor, Mombasa'),
('Grace Wangari', '+254701234567', 'gracewangari@yahoo.com', 'Kahawa, Nairobi');

-- Insert sample data into buses table
INSERT INTO buses (bus_no, bus_type, seat_capacity, current_status) VALUES
('KCA 123J', 'Luxury', 45, 'Active'),
('KDB 456K', 'Executive', 38, 'Active'),
('KCZ 789L', 'Standard', 52, 'Active'),
('KDD 012M', 'VIP', 32, 'Maintenance'),
('KCF 345N', 'Standard', 52, 'Active'),
('KDG 678P', 'Luxury', 45, 'Active'),
('KCH 901Q', 'Executive', 38, 'Active'),
('KDJ 234R', 'VIP', 32, 'Active'),
('KCK 567S', 'Standard', 52, 'Maintenance'),
('KDL 890T', 'Luxury', 45, 'Active');

-- Insert sample data into routes table (Nairobi to Mombasa)
INSERT INTO routes (departure_location, destination_location, distance_km, estimated_travel_time) VALUES
('Nairobi', 'Mombasa', 485.00, 480), -- 8 hours
('Mombasa', 'Nairobi', 485.00, 480), -- 8 hours
('Nairobi', 'Mombasa via Voi', 505.00, 540), -- 9 hours
('Mombasa', 'Nairobi via Voi', 505.00, 540), -- 9 hours
('Nairobi', 'Mombasa via Machakos', 520.00, 600); -- 10 hours

-- Insert sample data into stops table
INSERT INTO stops (route_id, stop_name, stop_order) VALUES
(1, 'Nairobi CBD', 1),
(1, 'Athi River', 2),
(1, 'Mtito Andei', 3),
(1, 'Voi', 4),
(1, 'Mombasa CBD', 5),
(2, 'Mombasa CBD', 1),
(2, 'Voi', 2),
(2, 'Mtito Andei', 3),
(2, 'Athi River', 4),
(2, 'Nairobi CBD', 5),
(3, 'Nairobi CBD', 1),
(3, 'Kitengela', 2),
(3, 'Emali', 3),
(3, 'Voi', 4),
(3, 'Mariakani', 5),
(3, 'Mombasa CBD', 6);

-- Insert sample data into drivers table
INSERT INTO drivers (name, phone_no, email, licence_no) VALUES
('George Mwangi', '+254712345671', 'georgemwangi@gmail.com', 'KEN-DL-78901'),
('Stephen Kimani', '+254723456782', 'stephenkimani@gmail.com', 'KEN-DL-78902'),
('Samuel Njoroge', '+254734567893', 'samuelnjoroge@gmail.com', 'KEN-DL-78903'),
('Daniel Mutuku', '+254745678904', 'danielmutuku@gmail.com', 'KEN-DL-78904'),
('Patrick Odera', '+254756789015', 'patrickodera@gmail.com', 'KEN-DL-78905'),
('Joseph Kariuki', '+254767890126', 'josephkariuki@gmail.com', 'KEN-DL-78906'),
('Martin Wekesa', '+254778901237', 'martinwekesa@gmail.com', 'KEN-DL-78907'),
('Brian Mwenda', '+254789012348', 'brianmwenda@gmail.com', 'KEN-DL-78908');

-- Insert sample data into schedules table
INSERT INTO schedules (bus_id, driver_id, route_id, fare, departure_date_time, arrival_date_time, available_seats, status) VALUES
(1, 1, 1, 1500, '2025-05-05 08:00:00', '2025-05-05 16:00:00', 45, 'Scheduled'),
(2, 2, 2, 1500, '2025-05-05 09:00:00', '2025-05-05 17:00:00', 38, 'Scheduled'),
(3, 3, 1, 1200, '2025-05-05 20:00:00', '2025-05-06 04:00:00', 52, 'Scheduled'),
(6, 4, 2, 1800, '2025-05-05 21:00:00', '2025-05-06 05:00:00', 45, 'Scheduled'),
(7, 5, 3, 1600, '2025-05-06 07:00:00', '2025-05-06 16:00:00', 38, 'Scheduled'),
(8, 6, 4, 2000, '2025-05-06 08:00:00', '2025-05-06 17:00:00', 32, 'Scheduled'),
(10, 7, 5, 1700, '2025-05-06 22:00:00', '2025-05-07 08:00:00', 45, 'Scheduled');

-- Insert sample data into seats (just for bus_id 1)
INSERT INTO seats (bus_id, schedule_id, seat_no, seat_type) VALUES
(1, 1, 1, 'Window'),
(1, 1, 2, 'Middle'),
(1, 1, 3, 'Aisle'),
(1, 1, 4, 'Window'),
(1, 1, 5, 'Middle'),
(1, 1, 6, 'Aisle'),
(1, 1, 7, 'Window'),
(1, 1, 8, 'Middle'),
(1, 1, 9, 'Aisle'),
(1, 1, 10, 'Window');

-- Insert sample data into bookings
INSERT INTO bookings (customer_id, schedule_id, booking_date, payment_status, booking_status) VALUES
(1, 1, '2025-05-01 10:15:23', 'Paid', 'Confirmed'),
(2, 1, '2025-05-01 11:30:45', 'Paid', 'Confirmed'),
(3, 2, '2025-05-01 14:20:10', 'Paid', 'Confirmed'),
(4, 3, '2025-05-02 09:45:32', 'Paid', 'Confirmed'),
(5, 4, '2025-05-02 16:10:05', 'Pending', 'Reserved');

-- Insert sample data into booked_seats
INSERT INTO booked_seats (booking_id, seat_id) VALUES
(1, 1), -- John Kamau booked seat 1 on bus 1
(1, 2), -- John Kamau also booked seat 2 on bus 1
(2, 3), -- Mary Wanjiku booked seat 3 on bus 1
(2, 4); -- Mary Wanjiku also booked seat 4 on bus 1

-- Insert sample data into payments
INSERT INTO payments (booking_id, amount, payment_method, transaction_date, transaction_status, transaction_id) VALUES
(1, 3000, 'M-Pesa', '2025-05-01 10:16:30', 'Completed', 'MPESA123456789'),
(2, 3000, 'Credit Card', '2025-05-01 11:32:15', 'Completed', 'CC123456789'),
(3, 1500, 'M-Pesa', '2025-05-01 14:21:05', 'Completed', 'MPESA234567890'),
(4, 2400, 'Debit Card', '2025-05-02 09:46:22', 'Completed', 'DC345678901');

