# Bubble 'Em Up! 🧼

Dynamiczna gra typu **Action Rogue-like 2D** stworzona w silniku Godot. Projekt powstał w zaledwie 48 godzin podczas wydarzenia typu **Game Jam**, jako efekt współpracy małego zespołu deweloperskiego.

Tematyka gry nawiązuje do walki o higienę – gracz steruje postacią walczącą z falami wirusów za pomocą baniek mydlanych.

## 🛠 Technologie
* **Silnik:** Godot Engine (2D)
* **Język:** GDScript
* **Grafika:** Pixel Art (Własne assety)

## 🌟 Główne funkcjonalności
* **Auto-shooter Mechanics:** Postać automatycznie generuje pociski (bańki), a zadaniem gracza jest manewrowanie i celowanie w przeciwników.
* **System Levelowania:** Pokonani wrogowie upuszczają "Mydełka" (EXP). Zebranie odpowiedniej ilości pozwala na awans postaci.
* **Drzewko Rozwoju (RNG):** Przy każdym awansie gracz wybiera jedno z trzech losowych ulepszeń:
  * Prędkość poruszania się (Movement Speed)
  * Szybkość ataku (Attack Speed)
  * Regeneracja zdrowia (HP Regen)

## 💡 Wyzwania i "Feature" Projektu
Największym wyzwaniem był limit czasowy (48h). Z tego powodu zdecydowaliśmy się na podejście **"Power Fantasy"**.
W przeciwieństwie do gier, które karzą gracza, *Bubble 'Em Up!* pozwala na **nielimitowane skalowanie statystyk**. 
* **Ciekawostka:** Przy odpowiednio długiej rozgrywce, gracz może osiągnąć "Attack Speed" bliski zeru sekund, zamieniając się w niepowstrzymaną maszynę do produkcji baniek. Testowaliśmy granice silnika Godot przy generowaniu setek obiektów na sekundę.

## 👥 Zespół i Rola
Projekt zrealizowany zespołowo. Moja rola obejmowała:
* Implementację poruszania się postaci i fizyki pocisków.
* System zbierania doświadczenia i UI wyboru ulepszeń.

## 💻 Uruchomienie (Godot)

1. Wejdź w zakładkę Releases (po prawej stronie ekranu)
2. Kliknij "Bubble Em Up - Playable Build"
3. Pobierz ZIP'a i go rozpakuj
4. Uruchom BubbleEmUp.exe
