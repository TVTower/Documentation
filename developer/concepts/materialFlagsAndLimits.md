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

# Anwendungs- und Testfälle für Livesendungen

## historisches Einmalevent (Programm)

z.B. Ariane-Start oder Abschiedskonzert Rolling Bricks

* Live-Termin = Release-Datum
* Always-Live: nein
* Ausstrahlungslimit, Ausstrahlungzeitbegrenzung nach Bedarf

## mehrfach (live) ausstrahlbare Shows (Programm)

z.B. TED, Sportschau

Da grundsätzlich nur die Erstausstrahlung live sein kann, muss die Live-Ausstrahlung von Folgesendungen anders erreicht werden.
Eine Ausstrahlungszeitbegrenzung (Samstagabendshow) ist nicht wirklich möglich.
Hierfür sollten lieber Drehbuchvorlagen verwendet werden.
Perspektivisch wäre auch denkbar, den Programme-Producer für die regelmäßige Produktion solcher Programme einzusetzen.

**Variante 1:** Always-Live: ja, Ausstrahlungslimit 1, Lizenzflag 4+8 (Rückgabe bei erreichtem Limit + Ausstrahlungsanzahl zurücksetzen). Da nur einmal ausgestrahlt werden kann, die Anzahl aber wieder zurückgesetzt wird, muss das Programm immer wieder neu erworben werden, ist aber immer Live.

**Variante 2:** Serie mit mehreren Folgen, die jeweils live sind, damit man sofort nicht nur eine sondern mehrere Shows senden kann. Aber auch hier wäre ein Ausstrahlungslimit sinnvoll.

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

**Variante 2:** Episodes>1, Always-Live ja (sonstige Begrenzungen nach Bedarf); es werden mehrere Show-Folgen (mit eine Serien-Header) produziert

**Variante 3:** Kindelemente explizit definieren; in diesem Fall sollte es sogar möglich sein, für jedes Kind einen eigenen festen Live-Termin zu geben

## aktuell nicht umsetzbar

Samstagabendshow von 2 Blöcken soll nur samstags zwischen 19 und 23 Uhr live ausgestrahlt werden können.

Der erste Punkt sollte aktuell oder gar komplett zurückgestellt werden.
Wenn eine "Samstag"-Sendung nicht Samstag gesendet wird, ist sie einfach nicht live.
Dem zweiten Punkt könnte man sich annähern, wenn Live-Zeitpunkt und Ausstrahlungseinschränkung doch nicht komplett voneinander entkoppelt sind, handelt sich dann aber wieder Sonderbehandlungsprobleme ein.

# Hintergrund

Im folgenden sollen Überlegungen zu Flags und Limits für Filme und Drehbuchvorlagen ausgeführt werden, die zu der obigen Zusammenfassung geführt haben.
Es geht insbesondere um die Konfigurationsmöglichkeiten zu den Themen

* live
* beschränkte Ausstrahlungszahl (`broadcast_limit`)
* beschränkte Ausstrahlungszeit (`broadcast_slot`)
* Produktionshäufigkeit (`production_limit`)
* Anzahl der Folgen (`episodes`) / "Kinder"

Die Anforderungen unterscheiden sich nach Typ der Sendung.
Daher erfolgt eine Aufschlüsselung nach

* Film
* Serie
* Show/Event
* Feature

(Für Nachrichtensondersenungen gibt es noch keinen wirklich passenden Typ).

# Gedanken zu Konfigurationsparametern

## Flag AlwaysLive

In der "alten" Interpretation bedeutet das gesetzte Flag, dass ein Programm niemals vom Ausstrahlungsstatus `live` in den Status `live_on_tape` übergeht.
Es gibt aber keinen relevanten Anwendungsfall, für den das benötigt wird (bzw. diese Fälle können auch anders abgebildet werden).
Wenn eine konkrete Sendung einmal ausgestrahlt wurde, ist sie einfach nicht mehr live.
Ein Programm hat kein explizites Feld für den Live-Termin existiert und verwendet dafür das Release-Datum.
Um auch kein weiteres Feld einführen zu müssen, bekommt das (zuvor in der Datenbank nicht verwendete) Always-Live-Flag eine neue Interpretation: kein fester Live-Termin, die Erstausstrahlung ist live, wann immer sie stattfindet.

## Live-Time/Live-Date

Live-Time ist obsolet und entfällt komplett.
Ausstrahlungszeitpunktbeschränkungen lassen sich mit den `broadcast_slot`s umsetzen, ein fester Live-Zeitpunkt ist über das Live-Date (sinnvolle Zeitdefinitionen aus Typ 0-8) definierbar.
Sollten gewünschte Definitionsmöglichkeiten fehlen, steht ein Review der Typen ohnehin an (ich denke z.B. an eine Erweiterung des Typ 3, um neben kommenden Samstag auch übernächsten Samstag definieren zu können).

Um die Startzeit (oder Endezeit) auch bei variabler Blockanzahl festnageln zu können, müsste die Implementierung nur so angepasst werden, dass die jeweils noch nicht definierte Slotzeit automatisch aufgrund der Blockanzahl und des definierten Slots ergänzt wird.

## Episodes

Der Einfachheit halber sollten sich das Angeben der Folgenzahl und die Definition expliziter Kindelemente ausschließen.
Episodes werden für das automatische Erzeugen von Kindelementen (Clone des Headers) verwendet, wenn man nicht jedes Kind einzeln definieren möchte (Lindenstraße 380/2500).

Das Einschränken der Anzahl der in der Datenbank angegebenen Kinder durch eine kleinere Folgenzahl liefert keinen Mehrwert. (Was sollte damit erreicht werden - höherer Einzelfolgenpreis?)

## Episodes vs. Production-Limit

Beide beeinflussen, wieviele Einkaufszettel man sich holen kann.
Der wesentliche Unterschied besteht darin, dass Folgen inhaltlich zusammengehören und zusammen eine Einheit bilden (Zoff im Hochhaus 2/12).
Der Zweck des Production-Limit ist eher, voneinander unabhängige Sendungen eines Formats mehrfach produzieren zu können (Sportschau #34).
Dieser Unterschied könnte sich daher auch im Sendungsnamen (x/y vs #12) niederschlagen.

## Broadcast-Limit

Broadcast-Limits sollten häufiger eingesetzt werden.
Insb. bei Shows entsprechen permanente Wiederholungen derselben Sendung nicht der Realität.
Im Standardfall (für selbst produzierte Shows/Events) sollte die Lizenz dann verfallen (kein Geld zurück) und dann auch nicht wieder verfügbar sein (Lizenzflag 32).
(Im Gegenzug könnten die Produktionskosten für einmalig ausstrahlbare Shows geringer als bei einem aufwändigen Film sein.)

Gleichzeitig muss es einen stärkeren Anreiz geben, mehr selbst zu produzieren (großer Bonus für Live/Senderimage steigt; starker Popularitätsverlust der Sendung bei Wiederausstrahlungen, bzw. sofort nur eine Ausstrahlung erlauben; ab einem bestimmten Image steigt es nicht mehr, wenn man keine Eigenproduktionen/Live-Shows sendet).

# Zeitpunkt der Berechnung des Live-Termins

Das ist (nur) für Drehbücher, die nicht das Flag Always-Live haben, ein kontroverser Punkt.
Mögliche Zeitpunkte sind:

* konkretes Drehbuch wird erstellt
* Drehbuch erscheint beim Drehbuchautor (kann ja wieder verschwinden und erneut auftauchen)
* Drehbuch geht in Spielerbesitz über
* Einkaufszettel wird geholt
* (Vor-)Produktion wird gestartet

**Überlegung zum Umsetzungsvorschlag**

Um Konfiguration/Berechnung etc. so einfach und klar wie möglich zu halten, sollte die Ausstrahlungszeitbegrenzung von der Live-Zeit(-Berechnung) komplett entkoppelt werden.
D.h. eine Slot-Begrenzung sagt ausschließlich aus, wann ein Programm gesendet werden darf und hat keinen Einfluss darauf, ob die Ausstrahlung Live oder Live-On-Tape stattfindet.

Damit reduziert sich die Berechnung des Live-Zeitpunkts auf das AlwaysLive-Flag und die Live-Date-Konfiguration.
Wieder im Sinne der Einfachheit sollten sich beide ausschließen.
Ist das Live-Date in der Datenbank definiert (immer inkl. Zeit!, also z.B. nicht Typ 4), wird es zur Berechnung des exakten Livezeitpunkts herangezogen (Spieltag + Startzeit).
Man kann argumentieren, dass im Fall, dass das Live-Date nicht definiert ist, die Sendung bei der ersten Ausstrahlung immer live ist, die explizite Definition des AlwaysLive-Flags in der Datenbank also unnötig ist.

D.h. ob mit AlwaysLive-Flag oder ohne Live-Date-Definitionn ist die Erstausstrahlung live, egal wann sie stattfindet.
Im Datenblatt kann dann einfach "Liveausstrahlung" ohne Zeitangabe angezeigt werden.
Das Studio wird in diesem Fall zur Zeit der (Erst-)Ausstrahlung blockiert.

Folgt man dem Ansatz, dass Live-Date-Definition den genauen Live-Zeitpunkt definiert, lässt sich der Anwendungsfall "Samstag irgendwann zwischen 19 und 23 Uhr für 2 Stunden" tatsächlich nicht umsetzen.
Das ist aber vertretbar; insb. in Hinblick auf den nötigen Aufwand, der für einen solchen Sonderfall betrieben werden müsste.
Eine solche Einschränkung ist nicht wirklich zwingend erforderlich (eine Samstagabendshow wird man von sich aus schon Samstagabend senden wollen; ggf. kann durch Ausstrahlungszeitbeschränkung die Uhrzeit erzwungen werden).

Es bleibt festzulegen, wann die eigentliche Berechnung der Live-Zeit für ein Programm erfolgt.
Gibt es keine Kinder/Episodes/Production-Limit größer 1, könnte die Berechnung zu jedem der oben genannten Zeitpunkte stattfinden.
Es hätte aber schon seinen Reiz, wenn man bei seiner Planung auch gezwungen wäre, die Vorproduktion rechtzeitig zu starten, damit der beim Erwerb der Lizenz festgelegte Live-Zeitpunkt eingehalten werden kann (sonst verfällt das Drehbuch und muss/kann später neu erworben werden - mit dem dann neu berechneten Live-Zeitpunkt).
Ein weiterer Vorteil wäre, dass die Angaben im Datenblatt (Drehbuch, Einkaufszettel, fertiges Programm) zu jeder Zeit konsistent und gleich bleiben (Liveausstrahlung am Tag X 20 Uhr) und die Umsetzung trivial sein dürfte.

Gibt es mehrere Einkaufszettel, müsste der Zeitpunkt für jede Folge neu ermittelt werden (aktuelles Beispiel Morningshow!).
Für Production-Limit größer 1 oder eine Definition der Episodenanzahl sollte keine Live-Date-Definition erlaubt sein (da sie global für alle Folgen gleich und somit unsinnig wäre.
Für definierte Einzelkinder, könnte jedes sein eigenes Live-Date haben (sinnvoll aufeinander abgestimmt; in 2 Tagen, in 4 Tagen,...)
Die Morgenshow z.B. käme gut mit der Ausstrahlungszeitbegrenzung und "live während der gesamten erlaubten Zeit" aus.
Zu erzwingen, dass die Ausstrahlung nicht am selben Tag erfolgen darf erscheint überflüssig.

Insofern ergibt sich der Vorschlag für eine einfache, eindeutige und konsistente Umsetzung: Bei Erstellung des Drehbuchs aus der Vorlage wird ein potentiell vorhandenes Live-Date ausgewertet und damit der Live-Zeitpunkt festgelegt.

## Zusammenfassung

Für Live-Drehbücher
* AlwaysLive-Flag neu interpretiert; zweite Ausstrahlung immer LiveOnTape
* kein Live-Date definiert - Erstausstrahlung live (unabhängig von Ausstrahlungszeitpunkt), Datenblatt "Liveausstrahlung"
* mehrere Folgen/Production-Limit > 0 - Live-Date nicht unterstützt
* Live-Date definiert
    * Definition inklusive Uhrzeit
    * Live-Zeit wird bei Drehbucherstellung festgelegt
    * Datenblatt "Liveausstrahlung" mit Zeitangabe
    * ist zum Live-Zeitpunkt die Vorproduktion noch nicht abgeschlossen, verfällt das Drehbuch/diese konkrete Produktion; neue Instanz aus Drehbuchvorlage kann später wieder erscheinen

# Grundsätzliche Übersicht der Kombinationen nach Typ der Sendung (Programmtyp)

| **Film**          | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | nein                |                    |
| broadcast_slot    | eher nein           | ggf. Speziallizenz |
| broadcast_limit   | ja                  | Speziallizenz      |
| production_limit  | nein (unterbinden)  | Fortsetzung/Remake mit neuem Drehbuch |
| episodes/children | nein                | ggf. Gegenargument Herr der Ringe/Starwars? |

Mit Speziallizenzen sind hier "Schnäppchen"-Lizenzen für Blockbuster gemeint, die aber Ausstrahlungsbeschränkungen haben.


| **Serie**         | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | nein                | ich sehe zumindest kein sinnvolles Beispiel |
| broadcast_slot    | ja                  | "Die Nachteulen"; aber Ausnahme |
| broadcast_limit   | ja                  | analog Film |
| production_limit  | nein (unterbinden)  | analog Film |
| episodes/children | ja                  | siehe oben |

Genauer zu prüfen wäre noch der Lizenztyp Serie mit mehreren Shows als Kinder (Show-Staffel mit aufeinander abgestimmten Live-Zeitpunkten).

| **Show**          | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | ja                  | typscherweise live, wann immer die erste Ausstrahlung stattfindet |
| broadcast_slot    | ja                  | Morgenshow, "Hier ab vier" |
| broadcast_limit   | ja                  | Anreiz für neue Drehs|
| production_limit  | ja!                 | |
| episodes/children | nein                | |


| **Event**         | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | ja                  | Live-Übertragung von Fremdveranstaltung - festgesetzter Live-Zeitpunkt |
| broadcast_slot    | eher nein           | |
| broadcast_limit   | ja                  | |
| production_limit  | eher nein           | |
| episodes/children | nein                | |


| **Feature**       | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | eher nein           | |
| broadcast_slot    | eher nein           | |
| broadcast_limit   | eher nein           | |
| production_limit  | eher nein           | für neue Reportage neues Drehbuch|
| episodes/children | ja                  | |

Diese Tabelle für Feature bezieht sich auf in der Datenbank hinterlegte Reportagen.
Wenn man Nachrichtensondersenungen als Feature umsetzt, wäre meine Einschätzung eher live ja, slot nein, broadcast_limit ja, production_limit nein, episodes nein.
Das wäre ja aber im Quellcode hinterlegt.

# Datenblatt Header vs. Einzelfolge

Sobald es mehrere Produktionen oder Folgen aus einer Drehbuchvorlage gibt, können sich die Werte der "Folgen" unterscheiden (eine schon gesendet, keine Ausstrahlungszeiteinschränkung mehr; Broadcast-Limit unterschiedlich).

Mein Vorschlag wäre, in diesem Fall für die Drehbuchvorlage (?), insb. aber beim Programmheader keine konkreten Werte ins Datenblatt zu schreiben, sondern nur "Ausstrahlungszeit beschränkt", "Ausstrahlungsanzahl beschränkt" anzugeben.
Die konkrete Information zur Live-Zeit oder zum Ausstrahlungslimit kann dann beim Einkaufszettel bzw. bei der Einzelfolge stehen.