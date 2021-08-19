# Hintergrund

Ich möchte hier meine Überlegungen zu den Flags und Limits für Filme/Drehbücher zusammenfassen, damit geprüft werden kann, welche Anwendungsfälle es gibt, welche umsetzbar sind, welche (aktuell) nicht und welche Implementierungsanpassungen folglich noch nötig sind.
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

Für einige der obigen Punkte gibt es Hinweise in den Datenblättern (Drehbuch, Einkaufsliste, fertiges Programm), die sich zwischen erster oder Folgeausstrahlungen unterscheiden können.
Auch darauf soll kurz eingegangen werden.

Ziel ist ein Konzept, das so einfach wie möglich in der Konfiguration ist und dabei so viele Anwendungsszenarien wie möglich abdeckt.

# Gedanken zu Konfigurationsparametern

## Flag AlwaysLive

In der aktuellen Interpretation bedeutet das gesetzte Flag, dass ein Programm niemals vom Ausstrahlungsstatus `live` in den Status `live_on_tape` übergeht.
Ich sehe allerdings keinen Anwendungsfall, für den das sinnvoll wäre.
Wenn eine konkrete Sendung einmal ausgestrahlt wurde, ist sie einfach nicht mehr live.
Soweit ich sehen kann, wird das Flag aktuell nirgends in der Datenbank verwendet.

Der ursprüngliche Gedanke für das Flag war vielleicht die Definition eines **Programms** wie "Ted am Morgen" - eine Live-Shows die man mehrfach ausstrahlen können soll.
Für Sendungen, die immer wieder live verfügbar sein sollen, müssten meiner Ansicht nach aber eher Drehbücher mit production_limit größer 1 verwendet werden, wobei jede einzelne Sendung dann einmal live ist!

Mein Vorschlag (an diesem Punkt der Überlegungen) ist daher, die Bedeutung des Flags zu ändern: (Always)Live bei der Erstausstrahlung, egal wann diese stattfindet.

Damit kann man sehr leicht beschreiben, dass es kein spezielles "Live-Datum" oder eine spezielle "Live-Zeit" gibt.
Es stellt somit kein Problem mehr dar, eine selbstproduzierte Show irgendwann live zu senden.

## Live-Time/Live-Date

Für die Definition des Live-Zeitpunkts für ein Drehbuch sollte live_date ausreichen.
Die verfügbaren Typen erlauben auch Zeitpunkte und Zeiträume inklusive Uhrzeit anzugeben.
Sollten gewünschte Definitionsmöglichkeiten fehlen, steht ein Review der Typen ohnehin an.

Für Programme lässt sich, wenn ich es richtig sehe, aktuell der Live-Zeitpunkt gar nicht festlegen.
(TODO prüfen Release-Zeitpunkt + Live-Flag)
Live-Programme sind derzeit ausschließlich der Ariane-Start und die Sommerolympiade (beide mit festgelegten Release-Tagen, die bei Umkonfigurieren der Tage pro Saison problematisch sind).

## Episodes

Der Einfachheit halber sollten sich das Angeben der Folgenzahl und die Definition expliziter Kindelemente ausschließen.
Episodes würde ich für das automatische Erzeugen von Kindelementen (Clone des Headers) verwendet werden, wenn man nicht jedes Kind einzeln definieren möchte (Lindenstraße 380/2500).

Das Einschränken der Anzahl der in der Datenbank angegebenen Kinder durch eine kleinere Folgenzahl liefert meiner Ansicht nach zu wenig Mehrwert. (Was sollte damit erreicht werden - höherer Einzelfolgenpreis?)

## Episodes vs. Production-Limit

Beide beeinflussen, wieviele Einkaufszettel man sich holen kann.
Ich sehe den wesentlichen Unterschied darin, dass Folgen inhaltlich zusammengehören und zusammen eine Einheit bilden (Zoff im Hochhaus 2/12).
Der Zweck des Production-Limit ist eher, voneinander unabhängige Sendungen eines Formats mehrfach produzieren zu können (Sportschau #34).
Dieser Unterschied könnte sich daher im Sendungsnamen (x/y vs #12) niederschlagen.
(Nochmal Testspielen, ob es bei Production-Limit einen Header gibt.)

## Broadcast-Limit

Broadcast-Limits sollten meiner Ansicht nach häufiger eingesetzt werden.
Insb. bei Shows entspren permanente Wiederholungen nicht der Realität.
Im Standardfall (für selbst produzierte Shows/Events) sollte die Lizenz dann verfallen (kein Geld zurück).
(Im Gegenzug könnten die Produktionskosten für einmalig ausstrahlbare Shows geringer als bei einem aufwändigen Film sein.)

Und gleichzeitig muss es einen stärkeren Anreiz geben, mehr selbst zu produzieren (großer Bonus für Live/Senderimage steigt; starker Popularitätsverlust der Sendung bei Wiederausstrahlungen, bzw. sofort nur eine Ausstrahlung erlauben; ab einem bestimmten Image steigt es nicht mehr, wenn man keine Eigenproduktionen/Live-Shows sendet).



# Live-Zeit und Ausstrahlungszeitbeschränkung

Zur Definition/Berechnung/Interpretation des Live-Zeitpunkts besteht aktuell noch kein Konsens.
Daher werden hier nochmal mögliche Anwendungsfälle gegenübergestellt.
Ich beschränke mich dabei auf Drehbuchvorlagen und gehe davon aus, dass eine wiederholte Ausstrahlung niemals wieder live ist.
Ist die erste Ausstrahlung erfolgt oder der berechnete Live-Zeitpunkt überschritten, ist das Programm Live-On-Tape.

## gewünschte Anwendungsfällen

* Show soll live sein, egal wann nach der Vorproduktion die Erstausstrahlung stattfindet.
* Samstagabendshow von 2 Blöcken soll nur samstags zwischen 19 und 23 Uhr live ausgestrahlt werden können
* Event soll zu einem ganz bestimmten Zeitpunkt (Spieltag+Zeit) live sein, aber ab dann jederzeit ausgestrahlt werden können

## aktuelle Konfigurationsmöglichkeiten

* AlwaysLive-Flag
* Live-Date (Typ 0-8)
* Ausstrahlungszeitbegrenzung

Ein Knackpunkt beim Live-Date ist, zu welchem Zeitpunkt die Berechnung des Live-Zeitpunkts anhand der Parameter stattfindet:

* konkretes Drehbuch wird erstellt
* Drehbuch erscheint beim Drehbuchautor (kann ja wieder verschwinden und erneut auftauchen)
* Drehbuch geht in Spielerbesitz über
* Einkaufszettel wird geholt
* Produktion wird gestartet

## Umsetzungsvorschläge

Um Konfiguration/Berechnung etc. so einfach und klar wie möglich zu halten, schlage ich vor, die Ausstrahlungszeitbegrenzung von der Live-Zeit(-Berechnung) komplett zu entkoppeln.
D.h. eine Slot-Begrenzung sagt ausschließlich aus, wann ein Programm gesendet werden darf und hat keinen Einfluss darauf, ob die Ausstrahlung Live oder Live-On-Tape stattfindet.

Damit reduziert sich die Berechnung des Live-Zeitpunkts auf das AlwaysLive-Flag und die Live-Date-Konfiguration.
Wieder im Sinne der Einfachheit sollten sich beide ausschließen (ich sehe auch keinen sinnvollen Anwendungsfall, wo beide zusammen definiert sind).
Ist das Live-Date in der Datenbank definiert (immer inkl. Zeit!, also z.B. nicht Typ 4), wird es zur Berechnung des exakten Livezeitpunkts herangezogen (Spieltag + Startzeit).
Man kann argumentieren, dass im Fall, dass das Live-Date nicht definiert ist, die Sendung bei der ersten Ausstrahlung immer live ist, das AlwaysLive-Flag also obsolet ist und komplett entfallen kann!

D.h. ob mit AlwaysLive-Flag oder ohne Live-Date-Definitionn ist die Erstausstrahlung live, egal wann sie stattfindet.
Im Datenblatt kann dann einfach "Liveausstrahlung" ohne Zeitangabe angezeigt werden.
Das Studio wird in diesem Fall zur Zeit der (Erst-)Ausstrahlung blockiert.

Folgt man dem Ansatz, dass Live-Date-Definition den genauen Live-Zeitpunkt definiert, lässt sich der Anwendungsfall "Samstag irgendwann zwischen 19 und 23 Uhr für 2 Stunden" tatsächlich nicht umsetzen.
Das halte ich aber für vertretbar! Eine solche Einschränkung ist nicht wirklich zwingend erforderlich (eine Samstagabendshow wird man von sich aus schon Samstagabend senden wollen; ggf. kann durch Ausstrahlungszeitbeschränkung die Uhrzeit erzwungen werden).

Es ist nun noch festzulegen, wann die eigentliche Berechnung der Live-Zeit für ein Programm erfolgt.
Gibt es keine Kinder/Episodes/Production-Limit größer 1, könnte die Berechnung zu jedem der oben genannten Zeitpunkte stattfinden.
Es hätte aber schon seinen Reiz, wenn man bei seiner Planung auch gezwungen wäre, die Vorproduktion rechtzeitig zu starten, damit der beim Erwerb der Lizenz festgelegte Live-Zeitpunkt eingehalten werden kann (sonst verfällt das Drehbuch und muss/kann später neu erworben werden - mit dem dann neu berechneten Live-Zeitpunkt).
Ein weiterer Vorteil wäre, dass die Angaben im Datenblatt (Drehbuch, Einkaufszettel, fertiges Programm) zu jeder Zeit konsistent und gleich bleiben (Liveausstrahlung am Tag X 20 Uhr) und die Umsetzung trivial sein dürfte.

Gibt es ein Production-Limit größer 1 oder mehrere Einzelfolgen, müsste der Zeitpunkt für jede Folge neu ermittelt werden (aktuelles Beispiel Morningshow!).
Tatsächlich würde ich aber dafür pladieren, in diesem Fall gar kein Live-Date zu erlauben.
Ich sehe aktuell keinen Anwendungsfall. Die Morgenshow käme gut mit der Ausstrahlungszeitbegrenzung und "live während der gesamten erlaubten Zeit" aus.
Zu erzwingen, dass die Ausstrahlung nicht am selben Tag erfolgen darf erscheint überflüssig.

## Zusammenfassung

Für Live-Drehbücher
* AlwaysLive-Flag entfällt; zweite Ausstrahlung immer LiveOnTape
* kein Live-Date definiert - Erstausstrahlung live (unabhängig von Ausstrahlungszeitpunkt), Datenblatt "Liveausstrahlung"
* mehrere Folgen/Production-Limit > 0 - Live-Date nicht unterstützt
* Live-Date definiert
    * Definition inklusive Uhrzeit
    * Live-Zeit wird bei Drehbucherstellung festgelegt
    * Datenblatt "Liveausstrahlung" mit Zeitangabe
    * ist zum Live-Zeitpunkt die Vorproduktion noch nicht abgeschlossen, verfällt das Drehbuch; neue Instanz aus Drehbuchvorlage kann später wieder erscheinen

# Anwenungsfälle nach Typ der Sendung

| **Film**          | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | nein                |                    |
| broadcast_slot    | eher nein           | (FSK?), ich sehe kein sinnvolles Beispiel|
| broadcast_limit   | ja                  | Ausnahmefall (preiswerte Lizenz Einmalausstrahlung) |
| production_limit  | nein (unterbinden)  | Fortsetzung/Remake mit neuem Drehbuch |
| episodes/children | nein                | ggf. Gegenargument Herr der Ringe/Starwars? |


| **Serie**         | sinnvoll einsetzbar | Beispiel/Kommentar |
| ----------------- | ------------------- | ------------------ |
| live              | nein                | ich sehe zumindest kein sinnvolles Beispiel |
| broadcast_slot    | ja                  | "Die Nachteulen"; aber Ausnahme |
| broadcast_limit   | ja                  | analog Film |
| production_limit  | nein (unterbinden)  | analog Film |
| episodes/children | ja                  | siehe oben |


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