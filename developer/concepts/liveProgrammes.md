# zusammengefasste Grundsätze

* Das Always-Live-Flag bedeutet (zukünftig) "Live, wann immer die Erstausstrahlung stattfindet - kein fester Live-Termin"
* Live kann IMMER nur die Erstausstrahlung sein, jede weitere Ausstrahlung ist (höchstens) live-on-tape
* eine Sendung hat entweder einen komplett festgelegten Live-Termin (Tag+Uhrzeit) oder ist bei der Erstausstrahlung live, wann immer diese stattfindet
* es kann nur eine Ausstrahlungszeitbegrenzung geben (entweder nur für die Erstausstrahlung oder für alle Ausstrahlungen); unterschiedliche Zeiten für Erst- und Folgeausstrahlungen gehen nicht

## Programme

* Live-Termin und Ausstrahlungsbeschränkungen (Häufigkeit, Zeitslots) sind komplett voneinander entkoppelt
* da es kein separates Feld für den Live-Termin gibt, wird das Always-Live-Flag umgewidmet (live, wann immer die Erstausstrahlung stattfindet) oder es wird wie bisher das Release-Datum als Live-Termin verwendet

## Drehbuch

* wenn nicht Always-Live wird der Livetermin (damit das Releasedatum) bei Erstellung des Drehbuch aus dem Template unveränderbar festgelegt (Datenblätter für Drehbuch, Konzept und Programm konsistent)
* Festlegen von Episodenzahl (automatisch erzeugte Kinder) und explizite Definition von Kindern schließt sich gegenseitig aus
(ist noch nicht umgesetzt, aktuell gibt es in der Datenbank noch Definitionen, aber dort wird die Episodenzahl ignoriert)
* Kann die Vorproduktion nicht mehr rechtzeitig vor einem festgelegten Live-Termin fertiggestellt werden, muss diese Liveproduktion verfallen.
(ist noch nicht umgesetzt)
* bei definiertem production_limit kann live_date nicht sinnvoll unterstützt werden

# Anwendungs- und Testfälle für Livesendungen

## historisches Einmalevent (Programm)

z.B. Ariane-Start oder Abschiedskonzert Rolling Bricks

* Live-Termin = Release-Datum
* Always-Live: nein
* Ausstrahlungslimit, Ausstrahlungzeitbegrenzung nach Bedarf

## mehrfach (live) ausstrahlbare Shows (Programm)

Wird nicht umgesetzt.
Hierfür müssen Drehbuchvorlagen verwendet werden.
Perspektivisch wäre auch denkbar, den Programme-Producer für die regelmäßige Produktion solcher Programme einzusetzen.

Eine Live-Serie mit mehreren Einzelfolgen ist (ggf. Always-Live) ist trotzdem nur einmal live ausstrahlbar.

## "Einzel-Live-Übertragung" (Drehbuch)

z.B. Rolling Bricks in <Variable> ("Fremdveranstaltung" - Termin steht fest)

* Live-Date mit Variabler Datumsdefinition (in 3 Tagen, nächsten Samstag...)

## Einzel-Show (Drehbuch)

z.B. Spendengala ("Eigenveranstaltung" - wir haben Live-Termin in der Hand)

* Always-Live: ja
* Ausstrahlungslimit, Ausstrahlungzeitbegrenzung nach Bedarf

## Show-Serie (Drehbuch)

z.B. Sportschau, Morgenshow

**Variante 1:** Production-Limit>1, Always-Live ja (sonstige Begrenzungen nach Bedarf); die Show kann mehrfach produziert werden; es gibt mehrere Einzelshows ohne Header

**Variante 2:** Episodes>1, Always-Live ja (sonstige Begrenzungen nach Bedarf); es werden mehrere Show-Folgen (mit eine Serien-Header) produziert (noch nicht umgesetzt)

**Variante 3:** Kindelemente explizit definieren; in diesem Fall sollte es sogar möglich sein, für jedes Kind einen eigenen festen Live-Termin zu geben

## aktuell nicht umsetzbar

Samstagabendshow von 2 Blöcken soll nur samstags zwischen 19 und 23 Uhr live ausgestrahlt werden können.

Der erste Punkt sollte aktuell oder gar komplett zurückgestellt werden.
Wenn eine "Samstag"-Sendung nicht Samstag gesendet wird, ist sie einfach nicht live.
Dem zweiten Punkt könnte man sich annähern, wenn Live-Zeitpunkt und Ausstrahlungseinschränkung doch nicht komplett voneinander entkoppelt sind, handelt sich dann aber wieder Sonderbehandlungsprobleme ein.