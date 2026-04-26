# unbeliebte Genre

Ein eigener Problemkomplex sind zielgruppenspezifische Genre.
Bestimmte Genre sind für große Zielgruppen unattraktiv was zu niedrigen Gesamteinschaltquoten führt.
Damit verbunden sind niedrigere Werbeeinnahmen aber auch Imageverlust, wodurch entsprechende Filme gar nicht erst im Fundus landen.

Hinzu kommt, dass zielgruppenspezifische Werbung aktuell noch nicht überproportionale Einnahmen abwirft.
Der Faktor hängt schon ungefähr an der Größe der Zielgruppe (weniger Bonus, wenn die Zielgruppe 50% der Bevölkerung ausmacht als wenn es 10% sind).
Insgesamt dürfte Zielgruppenwerbung aber eher als Ersatz als unspezifische Werbung mit mehr Zuschauern eingesetzt werden. (statt einer Werbung für 1Mio Zuschauer, die gerade nicht da war, verwende ich Männerwerbung mit 500K Zuschauern)

In Version 0.8.2 gibt es erste Anpassungen: Berücksichtigung von Subgenres, Anpassung der Genrepopularität durch (Nicht-)Ausstrahlung.

Erste Werbung mit Genre-Beschränkung gibt es seit 0.8.2.

## Zielgruppenwerbung

"Echte" Zielgruppenwerbung hat aktuell einen hohen Risikofaktor bei wenig Gewinnchancen.
Sie ist nur unter bestimmten Voraussetzungen wirklich attraktiv:

* die (Mehr!)Einnahmen pro Zuschauer sind hoch
* die Einschaltquote der Zielgruppe ist hoch
* die Mindestzuschauerzahl liegt nur wenig unterhalb der tatsächlichen Zuschauerzahl

Insbesondere der letzte Punkt ist kritisch!
Ist die Mindestzuschauerzahl 50K, die tatsächliche Zuschauerzahl aber 100K, verpufft selbst ein hoher Mehreinnahmefaktor sofort.

## Ziel

Es sollte auch möglich sein, zumindest teilweise (tageszeitabhängig) "Spartenprogramm" attraktiv zu gestalten.
Dafür gibt es meiner Ansicht nach zwei Haupthinderungsgründe

* Image - geringe Einschaltquote in großen Zielgruppen führt potentiell zu Imageverlust (Extrembeispiel: 100% Kinder, 0 Prozent Rest - Imageverlust trotz tollen Kinderprogramms)
* Risikofaktor Zielgruppenwerbung: siehe oben
* fehlende sonstige Anreize (Genre-Sammy - SciFi-Tag; Boss verlangt mindestens 6 Stunden Kinderprogramm...)

## mögliche Ansätze

* mehr mit der Zuschauerverteilung spielen (wochentagspezifisch); Anteil der Kinder Sonntag vormittag deutlich höher -> Kinderprogramm mit hoher Kindereinschaltquote wirft wesentlich mehr ab
* aktuell ist der Faktor pro Zielgruppe festgelegt; diese Faktoren könnten nochmal geprüft werden (nicht nur Größe der Zielgruppe, sondern auch Erreichbarkeit - ganzen Tag, nicht in Prime-Time...)
* Werbung für Zielgruppe+Genre (für ungünstige Kombinationen) wären denkbar, decken aber so wenige Fälle ab, dass es vermutlich den Aufwand nicht lohnt

### Non-Prime-Time-Zielgruppenwerbung:

* nur zwischen 2 und 18 Uhr (oder 2 und 15 Uhr)
* ein Zielgruppe festgelegt (Männer/Frauen würde ich tatsächlich ausschließen - zu generisch)
* keine Mindestzuschauerzahl
* Einnahmen pro (1000) Zuschauer (aber natürlich abhängig von der Zielgruppe - und analog Call-In muss der Wert mit steigender Reichweite stark abnehmen)

Analog ggf. für Non-Prime-Genrewerbung.
Problematisch an diesem Ansatz könnte aber die stark variierende potentielle Zuschauerzahl sein.
Denn auch im Vorabendprogramm steigt diese stark und würde die Werbung dann am attraktivsten machen (Preis pro Zuschauer von der Sendezeit abhängig machen; hier könnte der erwartete Anteil an der Gesamtreichweite Berücksichtigung finden).

Dieser Ansatz hätte den Charme, dass er den Anreiz erhöht auch sehr gute zielgruppenspezifische Filme zur Nicht-Prime-Zeit zu senden - zur Prime wären sie Verschwendung (niedrige Gesamteinschaltquote, jede Komödie wäre besser), im "Spartenprogramm" erzielt sie aber eine hohe Zielgruppeneinschaltquote, die sich direkt (und vollständig) in Einnahmen widerspiegelt.

Hinweis zu Ronnys Anmerkung "1,1 Mio Zuschauer, 1 Mio Anforderung" bringt mehr als ein "1,1 Mio Werbespot-auf-Tausenderkontaktpreis": Jein. Wenn die 1,1 Mio alle Jugendliche sind, soll und muss eine solche Zielgruppenwerbung mehr einbringen als eine allgemeine Werbung.
Der Anreiz soll ja gerade darin bestehen, ein zielgruppenspezifisches Programm zu senden um mit attraktiver Werbung mehr Einnahmen erziehlen zu können.
Das Problem der aktuellen Zielgruppenwerbung ist ja der Zuschauerdeckel, der eine bestimmte Werbung nur für eine sehr begrenzte Zuschauerverteilung attraktiv macht.

### "Hochprozentige" Werbung nur als Zielgruppenwerbung

Eine besonders radikale und unpopuläre Änderung wäre, Werbung mit hohem Ertrag (aktuell hoher Zuschauerzahl - also attraktive Primetimewerbung) nur noch als Zielgruppenwerbung anzubieten (nicht Männder/Frauen); ggf. in Kombination mit Image/Spielstärke.
Oder der Modus der Werbung schaltet ab einem bestimmten Image um (aus allgemeiner Werbung wird Zielgruppenwerbung), was allerdings einen Eingriff in die Datenbank verlangt (kein automatisches Ermitteln der Zielgruppe für eine Werbung möglich).

### stärker variierende Genrepopularität

Wird ein Genre nicht gesendet, erhöht sich sein Attraktivität (Umsetzung in 0.8.2).
Jede Ausstrahlung eines Genres verringert seine Attraktivität (Umsetzung in 0.8.2).
Wenn man immer nur Komödien sendet, sinken die Einschaltquoten auch bei voller Aktualität.

TODO: siehe TGenrePopularity#changeTrend und finishBroadcast

Vorgeschlagen wurde, Genrebeliebtheiten per Nachrichtenupdate bekanntzugeben.
Im "Backlog" ist immer noch "Im Trend" (Lizenz zum Kaufen/Show zum Produzieren?), wo man nach der Ausstrahlung Infos zum Beliebtheitsverlauf bekommt.