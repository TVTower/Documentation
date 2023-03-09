# Zusammenfassung

Viele Aspekte in TVTower beeinflussen einander, hängen vom Startjahr des Spiels, von der Reichweite des Senders, dem gewählten Schwierigkeitsgrad und anderen Faktoren ab.
Ein für alle Konstellationen konsistentes (und zufriedenstellendes) Ergebnis für den gesamten Spielverlauf zu erreichen, ist nicht leicht.

Ziel dieses Branches und seiner Dokumente ist, den Ist-Stand zusammenzufassen (Beobachtungen und Implementierungsdetails), ein Zielbild zu erarbeiten und daraus Änderungen abzuleiten, die mit vertretbarem Aufwand umgesetzt werden können.

Es wurde zwar schon eine Reihe von Maßnahmen ergriffen (Entfernung Deckel bei Werbeeinnahmen, weniger rigoroser Filmpreisanstieg bei Reichweiteausbau, Anpassung Imageberechnung, größere Antennenreichweite bei späteren Spieljahren, Anpassungen Imagevoraussetzungen bei Kabelverträgen,...), es gibt aber weiterhin grundlegende Probleme.
Aus diesem Grund soll das Gesamtkonstrukt begutachtet werden.


## zu berücksichtigende Aspekte

* Reichweite des Senders
* Filmqualität (Speed, Critics...)
* (maximale) Filmaktualität
* Ausstrahlungshäufigkeit
* Einschaltquote
* (Spieltag, Fundusgröße, Image)


## Beobachtungen Ist-Stand

### Haupteinnahmequellen

* Werbung (!)
* Verkauf Eigenproduktionen (je nach Spielverhalten)
* Call-In (je nach Spielverhalten)
* Dauerwerbesendungen (würde ich in dieser Betrachtung vernachlässigen)
* Abstoßen alter Lizenzen (würde ich in dieser Betrachtung vernachlässigen)

### Hauptausgabeposten

* laufende Senderkosten (!)
* Kauf von Lizenzen
* Senderausbau
* laufende Nachrichtenabonnements (bei aktuellen Preisen relevanter zu Beginn des Spiels als bei höherer Reichweite)
* Kauf von Nachrichten (dito)
* Studiomieten (dito)
* Produktionskosten

### Gedanken zum allgemeinen Spielverlauf

Es scheint klar, dass eine Schere zwischen laufenden Kosten und Einnahmemöglichkeiten vorhanden sein muss (mögliche Werbeeinnahmen steigen stärker als die Kosten).
Ansonsten gäbe es wenig Anreiz für den Senderausbau (nur höheres Risiko).
Allerdings bedeutet diese Schere auch, dass das Spiel nach hinten uninteressanter weil "einfacher" wird (Fundus ist da, man scheffelt nur noch Geld).
Nur den "Startpunkt", wann die Schere für den Spieler aufgeht, nach hinten zu verlagern ("nur" Programme erholen sich langsamer), löst das Grundproblem nicht und schafft potentiell andere Probleme.
Die Schere weniger weit aufgehen zu lassen, verlängert das Spiel, macht es aber nicht unbedingt interessanter.

Auch darf man den Frustfaktor nicht vergessen, der sich einstellen kann, wenn es tagelang nicht vorwärts geht.
Ziel sollte es sein, den Einstieg nicht zu schwer zu machen (weil es Strategien gibt, mit denen man einen guten Start hinlegen kann) und trotzdem Herausforderungen für den weiteren Verlauf zu bieten.

Motto: nicht die ersten 10 Tage schwierig und potentiell frustrierend machen, sondern die nächsten 30 auch interessant zu halten

### Was stört (Grobübersicht)?

* Film kann nach Erholung sehr oft gesendet werden ohne spürbare Einbußen auf Einschaltquote; wenig Anreiz großen Fundus zu "erneuern" (einmalige Kosten, dauerhafte Einnahmen)
* zu wenig Anreiz, im Tagesprogramm gute Sendungen zu bringen - da die Zahl der möglichen Zuschauer so gering ist, spielt der Unterschied zwischen 10 und 30 Prozent Einschaltquote oft keine Rolle für die möglichen Werbeeinnahmen; man verschwendet nur einen guten Film; im Ergebnis sendet man Durchschnittskram in Dauerschleife (da sich die wegen geringer Zuschauerzahl auch schnell erholen)
* Benachteiligung von "Zielgruppen"-Programmen (Gesamteinschaltquote gering - wenig Werbeeinnahmen, Imageverlust), führt zu Vernachlässigung ganzer Genres
* gleichzeitig zu großer und zu kleiner Einfluss der Aktualität (siehe weiter unten)
* gefühlt zu wenig Varianz bei der Genre-Popularität - man kann sich darauf verlassen, dass Komödie zur Prime-Time gute Einschaltquoten bringt
* Eigenproduktionen mit gutem Drehbuch erlauben bei geringen Kosten überdurchschnittliche Einschaltquoten und Verkaufspreise
* Berechnung Imagegewinn allein nach Reihenfolge (egal ob absolute oder relative Zuschauerzahl) zu naiv (Abstand zum Nächsten; Zielgruppenfilme kommen implizit schlecht weg); Einschaltquote berücksichtigt (Sieger mit 10% sollte nicht dasselbe Ergebnis liefern wie Sieger mit 60%)
* Bedeutung Ramschkiste nur in den ersten Tagen


## Faustregeln (die möglichst immer erfüllt sein sollten)

* keine Sonderbehandlung Eigenproduktion vs. Film aus der Datenbank (Berechnung Preis, Einschaltquote etc.)
* Imagegewinn und gute Einschaltquoten müssen **im späteren Spiel** schwieriger werden (höhere Erwartungen der Zuschauer)
* Imagegewinn/verlust nicht nur von Rang bei der Einschaltquoten abhängig machen
* alles andere gleich: je häufiger ausgestrahlt desto niedriger die Einschaltquote
* alles andere gleich: je älter desto niedriger die Einschaltquote
* alles andere gleich: je geringer die Qualität desto niedriger die Einschaltquote
* alles andere gleich: je geringer die Aktualität desto niedriger die Einschaltquote

### Einfluss Aktualität und Qualität auf Einschaltquote

Gefühlt sollte die Qualität langfristig einen stärkeren Einfluss auf die Einschaltquote haben als die Aktualität.
Einen neuen Film schauen sich alle an.
Wenn er aber schlecht war, schauen ihn sich wenige nochmal an.

Wie soll aber das Verhältnis sein, wenn Film A Qualtität 80 und maximale Aktualität 30 hat, Film B aber Qualität 30 und maximale Aktualität 80 (beide einmal ausgestrahlt)?
Vielleicht sollte hier die Sendezeit eine Rolle spielen - Aktualität zur Prime-Time wichtiger, gute Filme bringen aber tagsüber bessere Quoten.

## mögliche (Sofort-) Maßnahmen

* erste Ausstrahlung verursacht grundsätzlich Verlust der Maximalaktualität
* höherer Einfluss der Ausstrahlungshäufigkeit auf die Einschaltquote (je häufiger desto niedriger) - insb. zur Primetime!!
* höherer Einfluss der Ausstrahlungshäufigkeit auf das Tempo der Erholung (je häufiger desto langsamer)
* höherer Einfluss der Ausstrahlungshäufigkeit auf die maximale Aktualität (je häufiger desto niedriger)
* höherer Einfluss einer Genrepopularität auf die Einschaltquote - diese sinkt bei der Ausstrahlung einer Sendung (egal welcher Sender) und erholt sich dann wieder
* stärkerer Einfluss der Qualität auf die (maximale) Aktualität; Erholungsgeschwindigkeit
* grundsätzlich langsameres Erholen der Aktualität (ggf. auch abhängig von der Spielstärke des aktuellen Lizenzbesitzers)
* Anpassung der Werte in den Schwierigkeitsstufen (alle ein wenig anziehen, bei Schwer mehr Inflation bei Senderkosten, Werbeeinnahmen runter)

### Einführung weiterer Fixkostenpunkte

* Gehälter für Chef, Nachrichtensprecher, Archivar
* Raummiete auch für's erste Studio
* Kosten für erste Antenne nicht frei (ggf. reduziert oder für Zeit X subventioniert und dann steigend)
* Versicherungskosten für Filmfundus (prozentual zum Wert)

Zu bedenken ist bei solchen Kosten, dass auch sie vermutlich nur bei Spielbeginn relevant sind (Ausnahme Versicherungskosten).

## Sonstiges zum Thema Langzeitspielspaß

### neue Raumfunktionen

Räume mit zusätlzichen Funktionen (Sportwetten, Speziallizenzen, Getränkeautomat, Juwelier etc.) können Abwechslung bringen, bedeuten aber auch Implementierungsaufwand.

### Aufgaben vom Chef

* "Wir wollen kein X (Genre) mehr"
* "Wir wollen mehr X"

### Genre- oder Zielgruppen-Sammys

Neben Kultur auch "SciFi"-Sammy oder Kinderprogramm-Sammy.

### Ronny

* ausbaufähiges Archiv (Kapazitätsgrenze; Ausbaustufen kosten Miete)
* News-Abostufen von Chefimage oder anderen Kriterien abhängig