# Hintergrund

Im folgenden sollen Überlegungen zu Flags und Limits für Filme und Drehbuchvorlagen ausgeführt werden, die zu den zusammengefassten Grundsätzen für Live-Programme geführt haben.
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

## Flag Live/AlwaysLive

Wenn Programme mehrfach live ausgestrahlt werden können sollen, muss man genau über Änderungen der Flags nachdenken.
* Wenn das Live-Flag nach Ausstrahlung gelöscht wird, wird es dann immer bei Rückgabe an den Händler wieder gesetzt?
* Ändert sich nur das Lizenzflag, damit das Datenflag für das Wiederherstellen herangezogen werden kann?

Ein möglicher Implementierungsansatz lässt die Live-Flags komplett unveränderlich.
Stattdessen wird die Ausstrahlungshäufigkeit für die Ermittlung des Zustands herangezogen (Flag=Konfiguration, Getter=Zustand).
Mit dem Reset-Broadcast-Limit-Flag könnte dann gesteuert werden, ob die Ausstrahlungszahl bei Rückgabe zurückgesetzt werden soll oder nicht.

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

Der Einfachheit halber sollten sich das Angeben der Folgenzahl und die Definition expliziter Kindelemente ausschließen (Ticket #402).
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

## Reset Broadcast-Limit

Möglicher Ansatz:
Für Live-Produktionen wird das Reset-Flag interpretiert als: setze die Anzahl der Ausstrahlungen auf 0 zurück.
Auf diese Weise können Programme aus der Datenbank mehrfach live ausgestrahlt werden (z.B. TED oder andere Showformate).
Für Drehbücher ist dieses Flag nicht sinnvoll, da Drehbücher ohnehin mehrfach erworben und damit die jeweiligen Programme immer wieder live gesendet werden.

Er wird momentan nicht weiterverfolgt.
Das Reset-Flag setzt nicht die Anzahl der Ausstrahlungen zurück sondern die Anzahl der möglichen Ausstrahlungen.
Daran wird sich zunächst nichts ändern.

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
(Oder man interpretiert live-Date=0 als alwaysLive - aktuelle Umsetzung ist aber entweder Flag oder live-Date)

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

# Diskussion

## AlwaysLive-Flag entfällt

**Ronny:** Empfand ich anfaenglich als Unding - aber dein Dokument stellt das ja ganz gut klar.
Und ja, das wird wohl mit TED am Morgen etc gekommen sein. Also ein Flag der ein einzelnes Programm (was nicht per Drehbuch produziert wird - sondern als "Programmlizenz" erworben wird) derart konfiguriert, dass es beliebig ausgestrahlt werden kann (ausser es hat Ausstrahlungszeitraeume definiert) und immer "live" ist.

Das Problem ist also - zusammengefasst: das dies (mit fertigen Programmlizenzen und nicht per Drehbuch->Eigenproduktion) ohne den Flag (derzeit) nicht abgebildet werden kann.

**Alex:** Grundsätzlich würde ich sagen, dass man genau prüfen sollte, ob eine vergleichsweise komplizierte Logik für einen einzigen Fall wirklich gerechtfertigt ist (wirklich nötig/alternativ umsetzbar/abgeschwächt...)
Wenn ich mich richtig erinnere, konnte man den TED original auch nur einmal einsetzen und musste die Sendung dann neu erwerben.
Mit den vorgeschlagenen Änderungen lässt sich das ohne das Flag umsetzen:

* Live-Flag
* nur einmal ausstrahlbar
* Flag: Rückgabe setzt Ausstrahlungsanzahl zurück

Damit wäre das Programm bei jeder Ausstrahlung live (und niemand könnte es den anderen dauerhaft wegnehmen)

**Ronny:** Hmm denke damit koennte ich klarkommen. Fuer Programme die bspweise 5x live auggestrahlt werden koennen, wuerde es dann entsprechend statt der Ausstrahlungsanzahl 5 Episoden geben muessen. Vorteil: "Serien" (bzw Dinge mit Episoden) sollen (es ist angedacht und glaube noch nicht umgesetzt) vom "Serieneffekt" profitieren (also "treues Fan-Gefolge"). Nachteil: fuer TED am Morgen gibt es dann keine Fan-Basis :-)

**Alex:** Beispiele entsprechend aufgeführt


## Live-Time/Live-Date

**Ronny:** Live-Time war dafuer angedacht, nur eine Uhrzeit zu definieren ("18 Uhr") aber dies wurde ja mit der Moeglichkeit der Sendezeitbeschraenkung theoretisch obsolet. Allerdings ist fuer Drehbuecher mit "Zufalls-Blockanzahl" die Live-Ausstrahlungszeit (Uhrzeit, nicht "Tag") nun nicht mehr genau definierbar.
Will man ein Programm unbedingt nur 20 Uhr ausstrahlen lassen, waere ein "timeslots 20-22 Uhr" bei 2 Bloecken eindeutig (passt nur 20 Uhr). Wenn aber der Zufall das Drehbuch auf 1 Block oder 3 Bloecke umstellt, dann kann 20 oder 21 Uhr ausgestrahlt werden (1 Block) oder aber es passt nirgends (3 Bloecke).

**Alex:** Einerseits stellt sich die Frage, ob man das wirklich braucht (Ausstrahlung genau 20 Uhr).
Andererseits ließe sich das relativ leicht mit vorhandenen Mitteln implementieren:

* Datenbank setzt variable Blockgröße und **nur** Start-Slot 20 Uhr
* beim Erstellen des Scripts wird konkrete Blockzahl festgelegt; wenn Start-Slot vorhanden, aber End-Slot fehlt, wird dieser anhand der Blockzahl gesetzt.

**Ronny:** Gute Idee. Alternativ kann auch mit "wenn start = ende und start <> -1" gearbeitet werden. Kommt wohl drauf an, was "verstaendlicher" in der Interpretation durch den Nutzer ist. Reine "Formsache".

**Alex:** Ich finde start=ende weniger intuitiv! Es stimmt ja nicht, dass Start- und Endezeit übereinstimmen. Nur Startzeit oder nur Endezeit sagen genau das, was man erreichen will und sind auch flexibler (Konzert soll 23 Uhr enden - Schallschutz).

**Ronny:** Mit dem "Schallschutz" hast Du ein gutes Beispiel/Argument gefunden. 


## Live-Date bei Drehbucherstellung festlegen

**Ronny:** Das sollte immer nur fuer Drittparteienereignisse gelten. Ein Drehbuch ist ja erstmal nur eine Art "Ablaufplan". Wann nun die grosse Show der Volksmusikanten tatsaechlich "aufgezeichnet" (ich meine Live ausgestrahlt :D) wird, ist ja von den Sendern relativ frei definierbar. Raketenstarts und Live-Band-Aid-Uebertragungen hingegen haben feste "Termine". Hier waere aber auch weniger von einem "Drehbuch" zu sprechen als von einem "Uebertragungskonzept" (bzw gleich innewohnend die "Lizenz" um eben ein Konzert uebertragen zu koennen).

**Alex:** Genau das meinte ich mit der Unterscheidung live-date in der Datenbank definiert oder nicht.
Live-date definiert = Drittparteiereignis mit "festem" Termin.
Ohne live-date ist es eine "Eigenproduktion" die, wann immer sie ausgestrahlt wird, live ist.
Ich würde für diese Unterscheidung aber eben kein neues Konzept einführen (Liveübertragungsrecht).
Für den Spieler ist es einfach ein Drehbuch mit einem festen Live-Ausstrahlungstermin.

**Ronny:** Ich wollte auch kein neues Konzept einfuehren - ich wollte nur beschreiben, was "gedanklich" bei dererlei Ereignissen dahintersteckt. Die Frage bleibt aber fuer mich aber noch, wie ich dann "MeinTV - Samstag Nacht" oder "Sonntagsbrunch" produzieren koennte. Der reine "timeslot" kann zwar ein Uhrzeitfenster vorgeben, aber keinen "Tag". Dies war ja gedanklich ueber das dann fixierte "live_date" geplant. Vielleicht sollte man neben den timeSlots noch einen "allowedDaysCode" einfuehren (Tag 1-7, 8 = nur Wochenende, 9 = nur werktags, 10 ...). Allerdings waere es schoener, wenn es "ohne" die Einfuehrung eines neuen Felds moeglich waere.

**Alex:** "Samstag irgendwann zwischen 9 und 12 live" lässt sich nicht definieren, wohl aber "Samstag 10 Uhr" (Typ 3).
Und meiner Ansicht nach reicht das auch (fast) aus. Für einen konkreten Wochentag ließe sich Typ 3 auch erweitern, um neben "kommender Samstag" auch "übernächster Samstag" zu definieren - wenn der erste Parameter bezüglich "div" und "modulo" 7 ausgewertet wird. Modulo (zwischen 0 und 6) gibt den Wochentag, div die Anzahl der Wochen, die draufgerechnet wird (7=Montag in einer Woche, 15=Dienstag in mindestens 14 Tagen).

Ich würde hier also nicht über ein neues Feld nachdenken, sondern eher über die zusätzlich benötigten Zeit-Definitionen.
Den Fall "an einem bestimmten Tag, aber die Zeit ist mir egal" würde ich komplett ignorieren wollen.
Eine strikte Trennung von Live-Zeitpunkt und broadcast-slot macht die Implementierung wesentlich übersichtlicher.
(Ein möglicher Ausweg hier wäre eine Sonderbehandlung, wenn sich die Live-Zeit und die Slots widersprechen: Livezeit-Definition Samstag 1 Uhr, Slot 20-23 Uhr -> Liveausstrahlung wäre nicht möglich, daher Release-Datum nur für "available ab" verwendet. Allerdings, wäre dann auch eine Ausstrahlung am Folgetag ungewollt live...)

**Ronny:**
> "Samstag irgendwann zwischen 9 und 12 live" lässt sich nicht definieren, wohl aber "Samstag 10 Uhr" (Typ 3).

Aber waere das nicht dann am Ende doch moeglich? "Live" festlegen mit "Wochentag" (Samstag) und per "Ausstrahlungszeitraum" 9-12 Uhr definieren? Wenn "2 Ausstrahlungen", waere die Wiederholung ja dann (wenn nicht anders definiert) ohne den Ausstrahlungszeitraum und nicht mehr live - oder?


## Live-Date Morningshow

( Zu erzwingen, dass die Ausstrahlung nicht am selben Tag erfolgen darf erscheint überflüssig.)

**Ronny:** Ja, das ist organisch gewachsen - und einiges laesst sich nun sicher auch anders "abbilden". Bei all zu grossen Zeitfenstern (1 Block-Show und Zeitraum 10-20 Uhr) koennte es aber zu einer mehrfachen Ausstrahlung fuehren. Diesen Sonderfall koennen wir aber denke ich der Einfachheit halber ignorieren.

**Alex:** Genau - ignorieren.
Bei der Morningshow funktioniert das nämlich aktuell auch nicht (so richtig).
Macht man zwei Vorproduktionen unmittelbar hintereinander, ist der Live-Zeitpunkt am selben Tag und kann auch am selben Tag ausgestrahlt werden (aber nur einmal live).
Daher der vereinfachende Vorschlag: Production-Limit>1 -> kein Live-Datum möglich
(Ausstrahlungszeiteinschränkung ausreichend)

**Ronny:**
OK.

## Film - broadcast_slot

**Ronny:** Hmm man koennte theoretisch Filme fuer bestimmte Tage verbieten (Das Leben des Brian - an Pfingsten/Ostern). Aber das ist ein exotisches Beispiel. Genauso wie Speziallizenzen bei denen man Indy immer 23 Uhr auf Schatzjagd schicken muesste

**Alex:** Das Verbieten der Ausstrahlung an bestimmten Tagen geht aktuell ja nicht.
Das würde ich auch nicht wollen.
(Eine Option wären hier keywords für Programme, die dann bestimmte Ereignisse triggern. "christian" gibt Bonus zu Ostern/Pfingsten/Weihnachten, "blaspheme" verursacht Malus... Aber das hat für mich sehr niedrige Priorität)

Speziallizenzen (Superfilme zu Schnäppchenpreis mit beschränkter Ausstrahlungshäufigkeit und Ausstrahlungszeit) hatte ich auch im Hinterkopf.
Ich finde, die sollten aber nicht in der Datenbank hinterlegt werden *müssen*, sondern vom Programm immer mal wieder automatisch generiert werden!

**Ronny:**
Ja die sollten normalerweise nicht in der DB hinterlegt werden. Vor allem, da die DB ja eigentlich "ProgrammeData" definiert und nicht "ProgrammeLicence".

## Feature - production_limit

**Ronny:** Reportagen aus dem Sendegebiet Folge 212
Panda, Kaninchen und Co ...
Also generell so dieses "guenstige Nachmittagsprogramm"?

**Alex:** Es steht ja auch "eher nein" da.
Mit den Tabellen wollte ich versuchen, die typischen Kombinationen zu visualisieren.
Echte Verbote sehe ich kaum (production_limit und episodes/children schließen sich aus).
Für die von Dir genannten Fälle, könnte man auch "4-8 episodes" verwenden.
Das wäre dann eine neue Reportagen-Staffel mit bis zu 8 Folgen.
Wenn einem das nicht reicht, holt man sich später ein neues Drehbuch.

Zu bedenken ist ja auch, dass bei production_limit kein Header angelegt wird.
Alle Sendungen tauchen also einzeln auf.
Das macht bei vielen Sendungen auch keinen Spaß.
Persönlich würde ich production_limit daher auch immer im Zusammenhang mit broadcast_limit sehen.

**Ronny:**
Stimmt, wenn daraus keine "Serie" wird sondern Einzelelemente, dann macht das wirklich weniger Sinn.
