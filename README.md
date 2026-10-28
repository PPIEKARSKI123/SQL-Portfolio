# Car-Sharing SQL Portfolio

## O projekcie
Niniejsze repozytorium zawiera symulację rzeczywistych problemów biznesowych i analitycznych w firmie z branży car-sharingowej. Projekt demonstruje cały proces pracy z danymi: od zaprojektowania architektury bazy i wygenerowania danych testowych, po przekładanie potrzeb biznesowych na zoptymalizowane zapytania SQL.

## Stack technologiczny i wykorzystane techniki
* **Baza danych:** PostgreSQL
* **Architektura (DDL/DML):** Projektowanie tabel, klucze główne/obce (PK/FK), typowanie danych, zasilanie bazy danymi testowymi.
* **Zaawansowany SQL:** Common Table Expressions (CTE), Window Functions (`DENSE_RANK`), zaawansowane łączenie tabel (Multiple `JOIN`s), funkcje daty i czasu (`EXTRACT`, standard ISO 8601).
* **Bezpieczeństwo zapytań:** Zapobieganie błędom *Division by Zero* (`NULLIF`), bezpieczne grupowanie po kluczach głównych, filtrowanie przed łączeniem.

## Struktura repozytorium

Projekt został podzielony na dwa główne etapy: konfigurację bazy danych oraz raportowanie biznesowe.

```text
📦 sql-car-sharing-portfolio
 ┣ 📂 01-database-setup
 ┃ ┣ 📜 schema.sql          # Architektura bazy (tabele, relacje, typy danych)
 ┃ ┗ 📜 mock-data.sql       # Dane testowe (zasilenie tabel)
 ┣ 📂 02-business-reports
 ┃ ┣ 📜 01-analiza-zyskownosci-floty.md
 ┃ ┣ 📜 02-ranking-lojalnosci.md
 ┃ ┗ 📜 03-analiza-anulacji.md
 ┗ 📜 README.md
```

## 📊 Modele Danych
Analizy opierają się na relacyjnej bazie danych składającej się z 4 głównych tabel:
1. `users` - dane demograficzne i kontaktowe klientów.
2. `vehicles` - ewidencja floty (marka, model, kategoria: Economy/Premium).
3. `rentals` - operacyjna historia wypożyczeń (dystans, daty, statusy: `COMPLETED`, `CANCELLED`).
4. `payments` - moduł finansowy obsługujący transakcje.

---

## Raporty Biznesowe

### 1. [Analiza zyskowności floty (Economy vs Premium)](02-business-reports/01-analiza-zyskownosci-floty.md)
* **Cel biznesowy:** Identyfikacja najbardziej rentownych modeli pojazdów w przeliczeniu na kilometr w celu optymalizacji przyszłych zakupów floty.
* **Kluczowe techniki:** `INNER JOIN`, agregacja finansowa (`NULLIF`), konkatenacja stringów.

### 2. [Segmentacja klientów weekendowych (Program lojalnościowy)](02-business-reports/02-ranking-lojalnosci.md)
* **Cel biznesowy:** Wyłonienie najaktywniejszych kierowców korzystających z usług w weekendy (sobota-niedziela) na potrzeby programu marketingowego.
* **Kluczowe techniki:** Window Functions (`DENSE_RANK() OVER()`), ekstrakcja dat bazująca na standardzie europejskim (`ISODOW`).

### 3. ["Czarna lista" użytkowników (Wskaźnik anulacji)](02-business-reports/03-analiza-anulacji.md)
* **Cel biznesowy:** Zidentyfikowanie klientów obciążających operacyjnie firmę poprzez notoryczne porzucanie rezerwacji.
* **Kluczowe techniki:** Common Table Expressions (`WITH`), wstępne filtrowanie danych (Query Cost Optimization), bezpieczna agregacja.

---

## Jak uruchomić projekt lokalnie

Aby samodzielnie przetestować zapytania analityczne w swoim środowisku PostgreSQL:
1. Utwórz nową bazę danych.
2. Uruchom skrypt `01-database-setup/schema.sql`, aby zbudować strukturę tabel.
3. Uruchom skrypt `01-database-setup/mock-data.sql`, aby zasilić tabele danymi testowymi.
4. Wykonuj zapytania SQL zawarte w plikach z katalogu `02-business-reports`.
