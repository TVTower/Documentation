# Schritte um andere KI-Implementierung zu verwenden

Die DEV.xml liefert ganz unten zwar schon einen Hinweis, dass man die `Sample.lua` anpassen kann.
Es dürfte aber ziemlich aufwändig sein, eine KI komplett neu zu implementieren.
Der naheliegende Ansatz ist, Anpassungen an der Bestandsimplementierung vorzunehmen und dann die beiden Varianten gegeneinander spielen zu lassen, um die Anpassungen zu evaluieren.

## Vorbereitung der Anpassungen

**Kopieren des ursprünglichen Codes:** das Verzeichnis `res/ai/DefaultAIPlayer` nach `res/ai/OriginalAIPlayer` kopieren.
Damit gibt es zunächst zwei identische Implementierungen.
Die eigentlichen Anpassungen erfolgen in den Dateien in `res/ai/DefaultAIPlayer`, denn wenn sie erfolgreich sind, kann die Kopie einfach wieder gelöscht werden.

**Beide KIs verwenden:** Anpassung von `config/DEV.xml`, damit beide Implementierungen verwendet werden.
Unten in der Datei gibt es die auskommentierte Zeile `<!-- <PLAYERAISCRIPT2 value="res/ai/Sample/Sample.lua" /> -->`.
Nach diesem Schema kann für alle vier Spieler festgelegt werden, welche KI-Implementierung verwendet werden soll.

```
	<PLAYERAISCRIPT2 value="res/ai/OriginalAIPlayer/DefaultAIPlayer.lua" />
	<PLAYERAISCRIPT4 value="res/ai/OriginalAIPlayer/DefaultAIPlayer.lua" />
```
Mit dieser Konfiguration würde man sagen, dass Spieler 2 und 4 von der zuvor kopierten KI gesteuert werden (und Spieler 1 und 3 weiterhin von der Implementierung in `res/ai/DefaultAIPlayer`).

**minimale Anpassung der kopierten KI:** Zwei kleine Änderungen in `res/ai/OriginalAIPlayer/DefaultAIPlayer.lua` machen die KI lauffähig und in den Debug-Ausgaben identifizierbar.
In Zeile 37 (oder in der Nähe) wird der Pfad der eingebundenen Dateien definiert `local scriptPath =`.
Der Wert muss auf das kopierte Verzeichnis zeigen (`local scriptPath = "res/ai/OriginalAIPlayer/"`).
In Zeile 96 (oder in der Nähe) am Anfang der Funktion `function DefaultAIPlayer:initializePlayer()` steht eine Log-Ausgabe (`debugMsg("Initialisiere ...`).
Wenn man hier `debugMsg("Initialisiere OriginalAIPlayer-KI ...")` verwendet, kann man in den Log-Dateien für die einzelnen Spieler leicht erkennen, dass die erwartete Implementierung verwendet wurde.

## KI-Spiele

Nun kann man ein neues Spiel starten (für sich selbst Spieler 1 wählen).
Um alle Spieler durch die KI steuern zu lassen, geht man unmittelbar nach Spielstart in die Debug-Ansicht (Tabulator).
Dort wechselt man zu `Player Commands` und aktiviert die KI für Spieler 1 mit `Enable AI`.

Im besten Fall kann man nun die KIs bei einer hohen Geschwindigkeit (Zahlentasten 5-8) gegeneinander spielen lassen.