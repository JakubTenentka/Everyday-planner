# To Do App

**To Do App** to pełnoprawna aplikacja do zarządzania zadaniami, pozwalająca na wygodne organizowanie codziennych obowiązków. Projekt składa się z dwóch niezależnych modułów:

- 📱 **Frontend**: Flutter (`To_do_Flutter/`)
- 🌐 **Backend**: Spring Boot (`To_do_Java/`)

## Funkcje

- **Wyświetlanie listy zadań:** Intuicyjny widok wszystkich Twoich tasków.
- **Oznaczanie zadań jako zrobione:** Szybkie odznaczanie wykonanych pozycji.
- **Podział zadań na kategorie:** Organizacja tasków według kategorii tematycznych.

## Instalacja

### Backend (Spring Boot)
1. Zainstaluj JDK 17+.
2. Przejdź do katalogu `To_do_Java/`.
3. Skonfiguruj połączenie z bazą danych w pliku `application.properties`.
4. Uruchom serwer backendu poleceniem:
   ```bash
   ./mvnw spring-boot:run
   ```

### Frontend (Flutter)
1. Zainstaluj Flutter SDK.
2. Przejdź do katalogu `To_do_Flutter/`.
3. Zainstaluj zależności i uruchom aplikację:
   ```bash
   flutter pub get
   flutter run
   ```

## Zrzuty ekranu

<img width="1198" height="2539" alt="Screenshot_20250825_194806" src="https://github.com/user-attachments/assets/1baecae5-6656-46ef-b97f-787abb9852ee" />
<img width="1198" height="2539" alt="Screenshot_20250825_194942" src="https://github.com/user-attachments/assets/2c0f1bbf-630d-4f6d-8421-65d2f2e44ab0" />
<img width="1198" height="2539" alt="Screenshot_20250825_194956" src="https://github.com/user-attachments/assets/7bd4de53-c810-4d7f-a790-b54b85226ba1" />
<img width="1198" height="2539" alt="Screenshot_20250825_195021" src="https://github.com/user-attachments/assets/f2e89624-1a62-435d-a181-2d51ddc55f15" />





## Architektura

Aplikacja korzysta z architektury kliencko-serwerowej. Frontend (Flutter) komunikuje się z backendem (Spring Boot) za pomocą REST API.  
- Flutter → Spring Boot → Baza danych

Struktura projektu:
- `To_do_Flutter/` &ndash; aplikacja mobilna
- `To_do_Java/` &ndash; serwer backendowy

## Contributing

Chcesz rozwinąć projekt lub zgłosić błąd?  
- Utwórz Pull Request z propozycją zmiany.
- Zgłoś problem w zakładce Issues.

## Licencja

Projekt dostępny na licencji MIT.

---

**Autor:** Jakub Tenentka  
**Kontakt:** jakubtenentka@gmail.com
