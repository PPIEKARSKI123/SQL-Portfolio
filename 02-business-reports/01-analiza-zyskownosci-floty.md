### Raport 1: Analiza zyskowności floty (Economy vs Premium)

**Problem biznesowy:**
Firma chce zoptymalizować budżet na zakup nowych samochodów. Celem raportu jest wyłonienie modeli i kategorii aut (Economy vs Premium), które generują największy przychód w przeliczeniu na każdy przejechany kilometr, odrzucając przy tym przejazdy anulowane i nieopłacone.

**Zapytanie SQL:**
```sql
SELECT 
    v.brand || ' ' || v.model AS vehicle, 
    v.category,
    SUM(p.amount) AS total_amount,
    SUM(r.distance_km) AS total_distance,
    ROUND(SUM(p.amount) / NULLIF(SUM(r.distance_km), 0), 2) AS amount_per_distance
FROM vehicles v
INNER JOIN rentals r ON v.vehicle_id = r.vehicle_id
INNER JOIN payments p ON p.rental_id = r.rental_id
WHERE p.payment_status = 'PAID'
    AND r.status = 'COMPLETED'
GROUP BY v.category, vehicle
ORDER BY amount_per_distance DESC;
```

**Kluczowe decyzje analityczne:**
*   **Zabezpieczenie przed Division by Zero:** Zastosowano funkcję `NULLIF(SUM(r.distance_km), 0)`. W przypadku awarii modułu GPS sprzętu (dystans = 0), skrypt nie wywoła błędu krytycznego silnika, lecz zwróci wartość NULL.
*   **Filtrowanie statusów transakcyjnych:** Ograniczono zbiór wyłącznie do przejazdów fizycznie zrealizowanych (`COMPLETED`) i skutecznie opłaconych (`PAID`), odrzucając szum informacyjny z porzuconych rezerwacji.
*   **Optymalizacja pod kątem biznesu:** Zastosowano konkatenację (`||`), łącząc markę i model w jedną kolumnę `vehicle` dla łatwiejszej interpretacji raportu.

**Wynik działania skryptu (Output):**
![Wynik zyskowności floty](output-01.png)
