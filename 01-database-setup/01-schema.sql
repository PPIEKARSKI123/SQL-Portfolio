/*
Skrypt inicjalizujący bazę danych: System Car-Sharingowy
Baza zaprojektowana do zaawansowanej analizy wykorzystania floty, zachowań użytkowników oraz rentowności.
Silnik: PostgreSQL
*/

-- 1. Tabela Użytkowników (Klienci)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    driving_license_status VARCHAR(20) DEFAULT 'VERIFIED'
);

-- 2. Tabela Floty (Samochody)
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    plate_number VARCHAR(15) UNIQUE NOT NULL,
    category VARCHAR(20) NOT NULL, -- np. 'Economy', 'Premium', 'Cargo'
    status VARCHAR(20) DEFAULT 'AVAILABLE' -- np. 'AVAILABLE', 'IN_USE', 'MAINTENANCE'
);

-- 3. Tabela Przejazdów (Transakcyjna - Serce systemu)
CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    distance_km DECIMAL(5,2),
    status VARCHAR(20) DEFAULT 'COMPLETED' -- np. 'COMPLETED', 'CANCELLED'
);

-- 4. Tabela Płatności 
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    rental_id INT REFERENCES rentals(rental_id),
    payment_date TIMESTAMP NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    payment_method VARCHAR(30), -- np. 'CREDIT_CARD', 'BLIK'
    payment_status VARCHAR(20) DEFAULT 'PAID'
);
