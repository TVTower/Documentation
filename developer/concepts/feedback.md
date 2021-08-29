# AlwaysLive-Flag entfällt

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


# Live-Time/Live-Date

**Ronny:** Live-Time war dafuer angedacht, nur eine Uhrzeit zu definieren ("18 Uhr") aber dies wurde ja mit der Moeglichkeit der Sendezeitbeschraenkung theoretisch obsolet. Allerdings ist fuer Drehbuecher mit "Zufalls-Blockanzahl" die Live-Ausstrahlungszeit (Uhrzeit, nicht "Tag") nun nicht mehr genau definierbar.
Will man ein Programm unbedingt nur 20 Uhr ausstrahlen lassen, waere ein "timeslots 20-22 Uhr" bei 2 Bloecken eindeutig (passt nur 20 Uhr). Wenn aber der Zufall das Drehbuch auf 1 Block oder 3 Bloecke umstellt, dann kann 20 oder 21 Uhr ausgestrahlt werden (1 Block) oder aber es passt nirgends (3 Bloecke).

**Alex:** Einerseits stellt sich die Frage, ob man das wirklich braucht (Ausstrahlung genau 20 Uhr).
Andererseits ließe sich das relativ leicht mit vorhandenen Mitteln implementieren:

* Datenbank setzt variable Blockgröße und **nur** Start-Slot 20 Uhr
* beim Erstellen des Scripts wird konkrete Blockzahl festgelegt; wenn Start-Slot vorhanden, aber End-Slot fehlt, wird dieser anhand der Blockzahl gesetzt.

**Ronny:** Gute Idee. Alternativ kann auch mit "wenn start = ende und start <> -1" gearbeitet werden. Kommt wohl drauf an, was "verstaendlicher" in der Interpretation durch den Nutzer ist. Reine "Formsache".

**Alex:** Ich finde start=ende weniger intuitiv! Es stimmt ja nicht, dass Start- und Endezeit übereinstimmen. Nur Startzeit oder nur Endezeit sagen genau das, was man erreichen will und sind auch flexibler (Konzert soll 23 Uhr enden - Schallschutz).

# Live-Date bei Drehbucherstellung festlegen

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

# Live-Date Morningshow

( Zu erzwingen, dass die Ausstrahlung nicht am selben Tag erfolgen darf erscheint überflüssig.)

**Ronny:** Ja, das ist organisch gewachsen - und einiges laesst sich nun sicher auch anders "abbilden". Bei all zu grossen Zeitfenstern (1 Block-Show und Zeitraum 10-20 Uhr) koennte es aber zu einer mehrfachen Ausstrahlung fuehren. Diesen Sonderfall koennen wir aber denke ich der Einfachheit halber ignorieren.

**Alex:** Genau - ignorieren.
Bei der Morningshow funktioniert das nämlich aktuell auch nicht (so richtig).
Macht man zwei Vorproduktionen unmittelbar hintereinander, ist der Live-Zeitpunkt am selben Tag und kann auch am selben Tag ausgestrahlt werden (aber nur einmal live).
Daher der vereinfachende Vorschlag: Production-Limit>1 -> kein Live-Datum möglich
(Ausstrahlungszeiteinschränkung ausreichend)

**Ronny:**
OK.

# Film - broadcast_slot

**Ronny:** Hmm man koennte theoretisch Filme fuer bestimmte Tage verbieten (Das Leben des Brian - an Pfingsten/Ostern). Aber das ist ein exotisches Beispiel. Genauso wie Speziallizenzen bei denen man Indy immer 23 Uhr auf Schatzjagd schicken muesste

**Alex:** Das Verbieten der Ausstrahlung an bestimmten Tagen geht aktuell ja nicht.
Das würde ich auch nicht wollen.
(Eine Option wären hier keywords für Programme, die dann bestimmte Ereignisse triggern. "christian" gibt Bonus zu Ostern/Pfingsten/Weihnachten, "blaspheme" verursacht Malus... Aber das hat für mich sehr niedrige Priorität)

Speziallizenzen (Superfilme zu Schnäppchenpreis mit beschränkter Ausstrahlungshäufigkeit und Ausstrahlungszeit) hatte ich auch im Hinterkopf.
Ich finde, die sollten aber nicht in der Datenbank hinterlegt werden *müssen*, sondern vom Programm immer mal wieder automatisch generiert werden!

**Ronny:**
Ja die sollten normalerweise nicht in der DB hinterlegt werden. Vor allem, da die DB ja eigentlich "ProgrammeData" definiert und nicht "ProgrammeLicence".

# Feature - production_limit

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
