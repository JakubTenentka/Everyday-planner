# Everyday planner

**Everyday planner** to pełnoprawna aplikacja do zarządzania zadaniami, pozwalająca na wygodne organizowanie codziennych obowiązków. Projekt składa się z dwóch niezależnych modułów:

- 📱 **Frontend**: Flutter (`To_do_Flutter/`)
- 🌐 **Backend**: Spring Boot (`To_do_Java/`)

## ✔️ Funkcje 

- **Wyświetlanie listy zadań:** Intuicyjny widok wszystkich Twoich tasków.
- **Oznaczanie zadań jako zrobione:** Szybkie odznaczanie wykonanych pozycji.
- **Podział zadań na kategorie:** Organizacja tasków według kategorii tematycznych.

##  🎯 Planowane funkcje
- **Widok kalendarza:** Czytelny widok rozłożenia Twoich tasków na tydzień lub miesiąc.
- **Autentykacja oraz tworzenie profilu użytkownika** Możliwość tworzenia kont użytkowników i synchronizację tasków.
- **Inteligentna lista zakupów:** Szacowanie kosztu twojego koszyka sklepowego.
- **Statystyki i podsumowania:** Wizualizacje pomagające lepiej trackować swoją produktywność.

## 🛠️ Instalacja

### 🖥 Backend (Spring Boot)
1. Zainstaluj JDK 17+.
2. Przejdź do katalogu `To_do_Java/`.
3. Skonfiguruj połączenie z bazą danych w pliku `application.properties`.
4. Uruchom serwer backendu poleceniem:
   ```bash
   ./mvnw spring-boot:run
   ```

### 📱 Frontend (Flutter)
1. Zainstaluj Flutter SDK.
2. Przejdź do katalogu `To_do_Flutter/`.
3. Zainstaluj zależności i uruchom aplikację:
   ```bash
   flutter pub get
   flutter run
   ```

## Zrzuty ekranu
<img width="320" height="678" alt="dodaj_zadanie_320" src="https://github.com/user-attachments/assets/5af429ce-3fcf-4ca8-a19d-85c182aabea2" />
<img width="320" height="678" alt="zadania_320" src="https://github.com/user-attachments/assets/cdb5997a-196b-4dc0-aaf3-744a4214deb9" />
<img width="320" height="678" alt="zadania_ze_zrobionymi_320" src="https://github.com/user-attachments/assets/6e777250-4f4d-4bb3-aeb3-abf3ed63a58c" />
<img width="320" height="678" alt="tagi_320" src="https://github.com/user-attachments/assets/534ad116-165f-4b84-bc3a-fd5b785cbe1c" />
<img width="320" height="678" alt="dodawanie_tagu_320" src="https://github.com/user-attachments/assets/11e70450-3270-4b7c-bc55-f5e456f91fbb" />



## Architektura

Aplikacja korzysta z architektury kliencko-serwerowej. Frontend (Flutter) komunikuje się z backendem (Spring Boot) za pomocą REST API.  
- Flutter → Spring Boot → Baza danych

Struktura projektu:
- `To_do_Flutter/` &ndash; aplikacja mobilna
- `To_do_Java/` &ndash; serwer backendowy

## Licencja

Projekt dostępny na licencji MIT.

---

**Autor:** Jakub Tenentka  
**Kontakt:** jakubtenentka@gmail.com
