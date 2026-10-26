### Raport 2: Segmentacja klientów weekendowych (Program lojalnościowy)

**Problem biznesowy:**
Dział marketingu chce uruchomić program lojalnościowy i nagrodzić klientów, którzy najczęściej korzystają z naszych usług w weekendy. Potrzebujemy rankingu użytkowników posortowanych według liczby pomyślnie zrealizowanych przejazdów, które zostały jednoznacznie zainicjowane w weekend. Chcemy przypisać im wyraźne pozycje w rankingu (1, 2, 3...).

**Zapytanie SQL:**
```sql
SELECT
    DENSE_RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS loyalty_rank,
    u.user_id,
    u.first_name || ' ' || u.last_name AS full_name,
    COUNT(r.rental_id) AS weekend_rentals
FROM users u
INNER JOIN rentals r ON u.user_id = r.user_id
WHERE r.status = 'COMPLETED'
    AND EXTRACT(ISODOW FROM r.start_time) IN (6, 7)
GROUP BY u.user_id
ORDER BY loyalty_rank ASC;
```

**Kluczowe decyzje analityczne:**
*   **Obsługa remisów za pomocą `DENSE_RANK()`:** Wykorzystano funkcję okna `DENSE_RANK()` zamiast `ROW_NUMBER()` lub `RANK()`, aby sprawiedliwie obsłużyć sytuacje ex aequo. Użytkownicy o identycznej liczbie przejazdów otrzymują tę samą pozycję na podium, a kolejny numer miejsca nie jest pomijany (1, 1, 2 zamiast 1, 1, 3), co jest kluczowe w większości programów lojalnościowych.
*   **Standaryzacja dni tygodnia (ISO 8601):** Zastosowano `EXTRACT(ISODOW FROM ...)` zamiast standardowego `DOW`. Standard ISO jednoznacznie przypisuje wartości 6 (sobota) i 7 (niedziela), eliminując ryzyko błędnego filtrowania wynikającego z lokalnych ustawień regionalnych serwera bazy danych.
*   **Zależność funkcjonalna przy grupowaniu:** Grupowanie ograniczono wyłącznie do klucza głównego `u.user_id`. Wykorzystano mechanizm PostgreSQL, który rozpoznaje unikalność klucza i nie wymaga dublowania kolumn `first_name` oraz `last_name` w klauzuli `GROUP BY`, jednocześnie zabezpieczając raport przed scalaniem danych różnych osób o tym samym imieniu i nazwisku.
*   **Układ pod kątem odbioru biznesowego:** Kolumnę `loyalty_rank` umieszczono na początku zestawienia, a wyniki posortowano rosnąco (`ASC`), dzięki czemu raport naturalnie eksponuje liderów zestawienia od pierwszego miejsca.

**Wynik działania skryptu (Output):**

![Wynik zyskowności floty](output-02.png)
