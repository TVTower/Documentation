# Funktionen des TVTower-Datenbankeditors

Der Editor soll dabei unterstützen strukturell korrekte Einträge zu erstellen.
Das Datenbankformat selbst ist in einer separaten [Dokumentation](../../database_de/main.md) beschrieben.

## Validierung

Syntaxfehler, ungültige Enumwerte, nicht unterstützte Wertkombinationen etc. werden farblich markiert (Textunterstreichung, Marker am linken und rechten Editorrand) und es wird bei Hover ein Fehlertext angezeigt.
Eine Übersicht der Fehler wird auch im `Problems`-View gegeben (ggf. über Quickaccess `Strg-3` Suche nach "pro" öffnen).

Spätestens beim Speichern einer Datei erfolgt eine Validierung.
Wenn sich das Plugin mal verschluck haben sollte, kann man im Hauptmenü `Project`->`Clean` das Gesamtprojekt zurücksetzen und prüfen lassen.

## Autovervollständigung

Die Autovervollständigung wird mit `Strg-Leertaste` angestoßen.
Sie bietet (wenn verfügbar) eine Auswahl der möglichen Werte an der aktuellen Position.
Für die möglichen XML-Tags sollte sie nach der öffnenden spitzen Klammer angestoßen werden, für Attributnamen nach einem Leerzeichen innerhalb des XML-Knotens.

Bei Tags oder Listenwerten wird bei Auswahl eines vorgeschlagenen Eintrags der entsprechende Wert übernommen.
Bei Flags werden die Möglichkeiten zwar angezeigt aber nicht übernommen, da ja ggf. mehrere Werte gewünscht sind - hier muss man selbst addieren.

### Templates

Neben "Einzelwortvorschlägen" können auch ganze strukturelle Bausteine vorgeschlagen werden.
Sie erscheinen bei der normalen Autovervollständigung als Einträge mit einem grünen Punkt markiert.
Wenn man ein Template auswählt, welches Variablen enthält, kann man 
* für diese Variablen wieder die Autovervollständigung anstoßen
* mit `Tabulator`/`Shift-Tabulator` zwischen den Variablen navigieren
* mit Enter die Bearbeitung des Template-Inhalts abschließen

Einige Templates werden mit dem Editor ausgeliefert.
Man kann aber auch eigene Templates definieren (Hauptmenü `Window`->`Prefernces`->`TVTower Database`->`Templates`).

## Hover

Wenn verfügbar wird Information über ein Objekt (typischerweise ein Attributwert) angezeigt, wenn man den Mauszeiger darüber fährt.

* gesetzte Flags bei Flag-Attributen
* lesbare Version bei Zeitdefinitionen
* Enumwerte (Genre etc.)
* Info zu verknüpftem Objekt
    * Titel von getriggerten Nachrichten
    * Name von Personen bei Programmbesetzungen

## Outline 

Der Outline-View zeigt eine gekürzte Baumstruktur der aktuellen Datei.
Für Nachrichten werden die Nachrichtenthreads "umstrukturiert" - angestoßene Nachrichten werden als Kindelemente angezeigt.

Wenn der Outline-View noch nicht offen ist, kann man ihn über den Quickaccess (`Strg-3` Suche nach "out") suchen und öffnen.

Mit `Strg-o` lässt sich im Editor außerdem ein durchsuchbares Quick-Outline-Fenster öffnen.

## Navigation

Mit `F3` kann man zu verknüpften Objekten springen (z.B. bei News-Triggern zu den Nachfolgenachrichten oder bei Programmbesetzungen zur Personendefinition).
Dafür muss der Textcursor auf dem referenzierenden Attributwert stehen.

Mit `Strg-Shift-g` kann man prüfen welche Referenzen es (noch) auf das aktuelle Objekt gibt (z.B. wo wird die a).
Dafür muss der Textcursor auf einem referenzierenden Attributwert stehen oder auf der Objekt-ID, die für die Referenzierung verwendet wird.

## New-File-Wizard

Wenn man eine neue Datenbankdatei erstellen möchte, kann man sich die Grundstruktur vorbereiten lassen.
Im `Package-Explorer`
1. selektiert man das gewünschte Verzeichnis
1. öffnet das `New-File-Menü` (entweder `Strg-n` oder Kontextmenü `New`->`Other`)
1. wählt den Eintrag `TVTower Database`->`TVTower Database File`
1. trägt im sich öffnenden Dialog Dateinamen ein und wählt die Hauptpunkte, die definiert werden sollen

## Standard-Editor-Funktionen

* `Strg-f` - Suchen/Ersetzen in der Datei
* `Strg-c`/`Strg-v` - Copy/Paste
* `Strg-l` - gehe zu Zeile
* `Alt-Pfeiltaste-Hoch`/`Alt-Pfeiltaste-Runter` - aktuelle Zeile bzw. Auswahl nach oben/unten verschieben