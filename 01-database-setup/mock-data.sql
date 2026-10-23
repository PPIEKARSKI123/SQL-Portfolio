/*
Skrypt ładujący dane testowe (Mock Data) dla systemu Car-Sharing.
Zawiera próbną pulę użytkowników, pojazdów, historii przejazdów oraz płatności.
*/

-- 1. Dodawanie Użytkowników
INSERT INTO users (first_name, last_name, email, registration_date, driving_license_status) VALUES
('Jan', 'Kowalski', 'jan.kowalski@example.com', '2025-11-10', 'VERIFIED'),
('Anna', 'Nowak', 'anna.nowak@example.com', '2026-01-15', 'VERIFIED'),
('Piotr', 'Wiśniewski', 'piotr.w@example.com', '2026-03-20', 'VERIFIED'),
('Katarzyna', 'Wójcik', 'kasia.w@example.com', '2026-05-05', 'VERIFIED'),
('Michał', 'Kowalczyk', 'michal.k@example.com', '2026-06-12', 'PENDING');

-- 2. Dodawanie Floty Pojazdów
INSERT INTO vehicles (brand, model, plate_number, category, status) VALUES
('Toyota', 'Yaris', 'PO 1234A', 'Economy', 'AVAILABLE'),
('Skoda', 'Fabia', 'PO 5678B', 'Economy', 'IN_USE'),
('BMW', 'Series 3', 'WA 9876C', 'Premium', 'AVAILABLE'),
('Audi', 'A4', 'WA 5432D', 'Premium', 'MAINTENANCE'),
('Renault', 'Kangoo', 'GD 1122E', 'Cargo', 'AVAILABLE');

-- 3. Dodawanie Przejazdów (Transakcje obejmujące weekendy i anulacje)
INSERT INTO rentals (user_id, vehicle_id, start_time, end_time, distance_km, status) VALUES
(1, 1, '2026-09-12 10:00:00', '2026-09-12 11:30:00', 15.5, 'COMPLETED'), -- Sobota
(2, 3, '2026-09-13 14:00:00', '2026-09-13 16:00:00', 45.0, 'COMPLETED'), -- Niedziela (Premium)
(3, 2, '2026-09-15 08:00:00', '2026-09-15 08:45:00', 10.2, 'COMPLETED'), -- Wtorek
(1, 4, '2026-10-01 09:00:00', NULL, 0, 'CANCELLED'), -- Anulowany przed startem
(4, 5, '2026-10-17 12:00:00', '2026-10-17 18:00:00', 120.5, 'COMPLETED'), -- Sobota (Cargo)
(2, 1, '2026-10-20 17:00:00', '2026-10-20 17:15:00', 3.0, 'COMPLETED'),
(3, 3, '2026-10-22 19:00:00', NULL, 0, 'CANCELLED');

-- 4. Dodawanie Płatności (Tylko dla zakończonych przejazdów)
INSERT INTO payments (rental_id, payment_date, amount, payment_method, payment_status) VALUES
(1, '2026-09-12 11:35:00', 25.50, 'BLIK', 'PAID'),
(2, '2026-09-13 16:05:00', 120.00, 'CREDIT_CARD', 'PAID'),
(3, '2026-09-15 08:50:00', 18.00, 'BLIK', 'PAID'),
(5, '2026-10-17 18:10:00', 250.00, 'CREDIT_CARD', 'PAID'),
(6, '2026-10-20 17:20:00', 8.50, 'APPLE_PAY', 'PAID');
