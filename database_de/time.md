# Zeitsteuerung

## Zeitattribute

Zeitattribute haben als Wert eine kommaseparierte Liste von Zahlen.
Dabei definierte die erste Zahl die Art der Zeitberechnung und welche Bedeutung die nachfolgenden Werte haben.
Wenn nicht alle erwarteten Werte angegeben werden, werden die fehlenden hinteren Werte mit Standardwerten belegt.
(Definition in game.world.worldtime.bmx, Methode CalcTime_Auto)

Typischerweise beziehen sich die folgenden Möglichkeiten zur Zeitdefinition auf die Spielzeit, d.h. das Jahr und den Spieltag, die im Spiel sichtbar sind sowie die Zeit, die im Spiel vergeht.
"In 5 Stunden" bedeutet also in etwa nach 5 Sendeblöcken.
Lediglich die Typen 4 und 5, die sich auf vollständige Datumsdefinitionen (Jahr, Monat, Tag) beziehen, werden leicht anders interpretiert.
Da ein Spieljahr typischerweise nicht 365 Spieltage hat, wird ein reales Jahr auf die verfügbaren Spieltage aufgeteilt und ein definiertes Datum wird auf den entsprechenden Spieltag abgebildet.

### Zeittyp 0

Keine weiteren Werte - "Sofort".

### Zeityp 1

Zwei weitere Werte a und b - "in 'a',..., oder 'b' Stunden.
Beispiel `time="1,3,7"` in 3, 4, 5, 6 oder 7 Stunden

### Zeittyp 2

Vier weitere Werte a, b, c und d - "in 'a' bis 'b' Tagen zwischen c:00 und d:00 Uhr".
Beispiel `time="2,1,2,13,19"` - in ein bis zwei Tagen zwisch 13 und 19 Uhr.

### Zeittyp 3

Drei weitere Werte a, b, c - "am nächsten Wochentag a zwischen b:00 und c:00 Uhr". Montag=0, Sonntag=6.
Beispiel `time="3,5,12,14"` - am nächsten Samstag zwischen 12 und 14 Uhr.

### Zeittyp 4

Drei weitere Werte y, m, d - "exaktes Datum Jahr y, Monat m, Tag, d".
Beispiel `time="4,1990,11,13"` - Spieltag, auf den der 13.11.1990 fällt.

Wenn das Jahr kleiner als 1000 ist, wird es nicht als Jahreszahl sondern als relative Angabe ("aktuelles Jahr + y") interpretiert: `time="4,2,12,24"` - Spieltag in zwei Jahren, auf den der 24.12. fällt.
Achtung: bei Jahr=0 kann der berechnete Zeitpunkt also auch in der Vergangenheit liegen (früheres Datum im aktuellen Jahr).

### Zeittyp 5

Sechs weitere Werte y1, y2, m1, m2, d1, d2 - zwischen zwei exakten Daten (Variablenbenennung analog Zeittyp 4).
Beispiel `time="5,1990,1993,3,5,12,17"` - zwischen den Spieltage, auf die der 12.3.1990 unde der 17.5.1993 fallen.

### Zeittyp 6

Vier weitere Werte y, D, h, m - "im Jahr y am Spieltag D um h:m Uhr".
Beispiel `time="6,1993,4,13,38"` - am vierten Spieltag 1993 um 13:38 Uhr.

### Zeittyp 7

Acht weitere Werte y1, y2, D1, D2, h1, h2, m1, m2 - zwischen zwei Zeiten analog Zeittyp 6.
Beispiel `time="7,1993,1993,3,5,12,8,6,22"` - im Jahr 1993 zwischen Spieltag 3 12:06 Uhr und Spieltag 5 8:22 Uhr.

### Zeittyp 8

Fünf weitere Werte d, h1, h2, m1, m2 - "an einem Arbeitstag (Mo-Fr) mindestens d Tag ab jetzt zwischen h1:m1 Uhr und h2:m2 Uhr".
Beispiel `time="8,2,11,13,30,45"` - falls heute Dienstag ist am Donnerstag zwischen 11:30 Uhr und 13:45 Uhr, falls heute Freitag ist dann Dienstag zwischen diesen Zeiten.

## Verfügbarkeit

Der `availability`-Knoten definiert zu welchem Zeitpunkt/in welchem Zeitraum ein Element verfügbar ist.

Als Eigenschaften stehen `year_range_from`, `year_range_to` und `script` zur Verfügung.
Bei year wird die Jahreszahl angegeben (ggf. -1 für nicht beschränkt), so dass ein (offenes) Intervall festgelegt werden kann.

* `...year_range_from="1985" year_range_to="1987"` - von 1985 bis 1987
* `...year_range_from="-1" year_range_to="1991"` - bis 1991
* `...year_range_from="2000" year_range_to="-1"` - 
ab 2000

`script` erlaubt eine (zusätzliche) feinere Steuerung mit [Bedingungen](variables.md#Bedingungen) und [Zeitfunktionen](variables.md#worldtime).
Wenn möglich sollten Jahresprüfungen für Optimierungen im Programm aber mit den obigen Range-Attributen gemacht werden.
Typische Anwedungsfälle sind jahreszeitabhängige Nachrichten oder solche, die nur an bestimmten Wochentagen erscheinen sollen oder aber Drehbücher, die erst nach einer gewissen Spielzeit zur Verfügung stehen sollen.
Da in den Funktionsaufrufen doppelte Anführungszeichen für Zeichenkettenparameter verwendet werden, ist das script-Attribut typischerweise mit einfachen Anführungszeichen umschlossen.

* `script='${.eq:${.worldtime:"weekday"}:6}'` - verfügbar, wenn Sonntag ist (Montag=0, ..., Sonntag=6)
* `script='${.and:${.eq:${.worldtime:"weekday"}:2}:${.gte:${.worldtime:"hour"}:18}}'` - Mittwoch ab 18 Uhr
* `script='${.gt:${.worldtime:"daysplayed"}:12}'` - mehr als 12 Tage gespielt
* `script='${.or:${.eq:${.worldtime:"month"}:1}:${.eq:${.worldtime:"month"}:7}}'` - im Januar oder im Juli