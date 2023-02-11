# Eigenproduktionen

Das Ergebnis von Eigenproduktionen (Programme) soll nicht anders behandelt werden als direkt in der Datenbank definierte Programme.
Da hier aber nochmal viele neue Faktoren hinzukommen, bekommen sie ein eigenes Kapitel.

## zu berücksichtigende Aspekte

* Drehbuchattribute (Qualität, Potential, Preis, Blöcke)
* gewählte Besetzung/Produktionsfirme
* gewählte Punktverteilung
* Senderimage/Sympathie
* Anzahl möglicher Produktionen
* resultierender Produktionspreis
* resultierende Produktionszeit
* resultierende Attribute des Programms (Qualität, Preis)

## Beobachtungen Ist-Stand

Grundbeobachtung: Eigenproduktionen mit guten Drehbüchern und guter Besetzung liefern verlässlich hohe Einschaltquoten und einen Verkaufspreis, der deutlich über den Kosten liegt.
Einige Drehbücher stechen hier besonders heraus (Don Rons...)

### Was stört?

* Drehbücher vergleichsweis zu billig
* Drehbuchkauf/-verkauf ermöglicht schnelles Auswechseln des Angebots (bis was gutes dabei ist)
* Fokuspunktkosten steigen liniear (Punktpreis * Anzahl vergebener Punkte)
* "Erfolgsgarantie": Drehbuch OK, Cast OK = Ergebnis gut (gute Einschaltquoten und hoher Verkaufspreis)
* zu geringer Einfluss der Besetzung/Firma auf das Ergebnis (wenig Potential = selbst bei bester Besetzung schlechtes Ergebnis; hohes Potential = selbst bei schlechtester Besetzung brauchbares Ergebnis)

### Drehbuchpreise

Persönlich glaube ich nicht, dass die Drehbuchpreise grundsätzlich massiv steigen müssen.
Die Kosten und den Einfluss der Besetzung halte ich für den wichtigeren und besseren Hebel.
Eigenproduktionen sollen auch im frühen Spiel eine Möglichkeit sein, an gute Programme zu kommen (statt eben einfach Geld für einen Film auszugeben, dessen Güte man an den Attributen erahnen kann).

Im Gegensatz zu den Filmen, bei denen sich der Preis aus den Attributen und einem Modifier berechnen, wird bei den Drehbuch**vorlagen** eine Preisspanne in der Datenbank festgelegt.
Hier kann es natürlich Anpassungen geben.

Oder anders ausgedrückt: Die Schere Kauf+Produktionskosten=2 Mio aber Verkaufspreis 20 Mio lässt sich nicht schließen, indem man den Drehbuchpreis anpasst.
Es kann natürlich in der Datenbank teurer gemacht werden, aber Hauptansatzpunkt sollte ein besseres Balancing von Produktionsattributen nach Produktionsergebnis sein.
Wenn dann die maximale Aktualität nach Erstausstrahlung sinkt, ist die Schere zum Verkaufspreis schon geringer.

Andere Automatismen für Drehbuchpreise (berühmte Buchvorlage, Skandalgeschichte, Sequel) würde ich nicht im Spiel umsetzen.
Das kann direkt über den in der Datenbank gesetzten Preis erledigt werden.

### Castverfügbarkeit

Aktuell ist es möglich, dieselben Personen in mehreren Studios gleichzeitig zu beschäftigen.
Das vollständig zu verhindern, wird schwer.
Der eigentliche Dreh beginnt ja erst im Studio, man kann aber schon viele Konzeptionen vorbereitet haben.

Mögliche Ansatzpunkte wären

* gelegentlicher Urlaub, der Personen nicht verfügbar macht
* Umstellung auf "voraussichtliche Produktionszeit", so dass die Zeit erst beim Start der Produktion ermittelt wird (wieviele sind gerade beschäftigt -> verlängert die neu gestartet)
* Nachricht: X mit Erschöpfung im Krankenhaus - Drehzeiten verlängern sich

### Produktionsergebnis

* stärkere Kopplung der Cast-Attribute an das Ergebnis
* stärkere Kopplung der vergebenen Fokuspunkte an das Ergebnis

## Faustregeln (die möglichst immer erfüllt sein sollten)

* alles andere gleich: mehr Blöcke = höhere Produktionskosten (wahrscheinlich sowohl Produktionsfirma als auch Cast)
* alles andere gleich: mehr Blöcke = längere Produktionszeit
* alles andere gleich: eine Besetzung mit besseren Attributen = besseres Produktionsergebnis (höhere Qualität)
* alles andere gleich: Produktionsfirma mit mehr Erfahrung = besseres Produktionsergebnis
* alles andere gleich: mehr vergebene Punkte in einem relevanten Bereich (z.B. Stunts) = besseres Produktionsergebnis

### Drehbuch-Produktions-Fit

Wenn ein Drehbuch gute Qualität und gutes Potential hat, sollte auch gefordert sein, dass eine gute Produktion stattfindet!
Unterdurchschnittliche Besetzung und zu wenige Fokuspunkte sollten bestraft werden (gute Ausgangsbasis durch schlechte Produktion - erst recht mies).

Dann kann man sich mit einem guten Drehbuch nicht einfach ein "ordentliches" Ergebnis erkaufen.
Man muss Zeit und Geld in eine ordentliche Produktion investieren.

Die Formel: Ergebnis = Drehbuchpotential * Produktionsqualität ist zu naiv.

### Serien

* Wenn in einer Serie für eine Besetzung eine Rolle definiert ist, sollte es Abzug geben, wenn dieselbe Rolle in den Folgen unterschiedlich besetzt ist (offen - Auswirkung auf Qualität oder erst bei Zuschauerquotenberechnung)

### "Dauerformate"

Mit der Einführung von Drehbuchvorlagen mit sehr vielen möglichen Produktionen wird der Aspekt "Gewohnheitszuschauer" interessanter.

* Wenn Autor gecastet werden muss: starker Einfluss der Autorenqualitäten auf das Ergebnis (mehr Autoren mit unterschiedlichen Attributen nötig; Preise müssten wohl steigen)
* Wenn Moderator gecastet werden muss: Abzug, wenn der Moderator ständig wechselt (bei Einschaltquote oder Qualität)
* Wenn Gäste gecastet werden: Abzug wenn immer wieder dieselben Gäste kommen (bei Einschaltquote oder Qualität)

## mögliche (Sofort-) Maßnahmen

* Review der Drehbuchpreise - in der Datenbank können Spannen angegeben werden, einige Preise können durchaus höher sein
* automatische Anpassung (wenn die Qualitätswerte gewürfelt werden, weiteren Faktor berechnen - höhere Qualität/Potential nochmal Preis erhöhen)
* Kosten für den Cast nicht nach Blockanzahl sondern nach Produktionsdauer (ggf. abhängig vom Job)

### komplettes Review der Einflüsse auf das Produktionsergebnis

* siehe auch prodAttributes-Branch
* TODO Verweis auf Empire-TV-Tycoon nachgehen (Drehbücher von Scriptwritern produzieren lassen!?)

### Drehbuchaktualisierung

Unabhängig von allem anderen kann das Durchprobieren der Drehbücher erschwert werden.

* Drehbuchverkauf verbieten (nur entsorgen im Studio geht)
* Drehbuch nur mit massivem Abschlag zurückgeben (nur 25% des Kaufpreises zurück; das Drehbuch landet dann zum Normalpreis wieder in der "Refill-Liste"
* beim Auffüllen (nach Kauf) werden nur Drehbücher mit einer gedeckelten Attraktivität verwendet (max. Durchschnittsqualität, kein hohes Potential); allein mein turnusmäßigen Refresh wird die gesamte Drehbuchbandbreite berücksichtigt (höherer Anteil "neuer" Drehücher?)