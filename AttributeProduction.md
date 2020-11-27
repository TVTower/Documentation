#TODOs

* Abgleich mit den Vorschlägen und Hinweisen aus https://github.com/TVTower/TVTower/issues/130

# Brainstorming produktionsrelevante Attribute

Ziel dieses Dokuments ist, die Attribute festzulegen, die für die Ermittlung der Qualität einer Produktion benötigt werden.
Ausgangspunkt der Überlegungen ist das Problem, dass die aktuellen Darstellerattribute allgemein zu gering sind und die Tendenz besteht, die Darstellerattribute komplett zu ignorieren und allein auf die Erfahrung zu setzen, da diese eine übermäßige Bedeutung an der Qualität der Produktion zu haben scheint.

Es handelt sich um eine Diskussionsgrundlage.
Anpassungen und Erläuterungen, die sich aus Antworten und Kommentaren von Ronny Otto ergeben haben, sind mit (RO) markiert.
Es handelt sich dabei nicht um wörtliche Zitate.

## involvierte Entitäten

Folgende Entitäten haben grundsätzlich einen Einfluss

* Genre
* Drehbuch
* Regisseur (Person)
* Darsteller (Person)
* Produktionsattribute (Kulisse,...)

## Grundsatzfragen zu Attributen

* Typ (int/float/...)
* Wertebereich (von, bis)
* global oder berufs-/genreabhängig
* änderbar (ja/nein)
** wenn ja wodurch
** ggf. Minimalwert, Maximalwert

Ob man int von 0 bis 100 oder float von 0 bis 1 nimmt, spielt von der Konzeption eine untergeordnete Rolle (bei den Berechnungen muss man natürlich aufpassen).

Attribute als grundsätzlich änderbar vorzusehen, hat den Vorteil, dass eine Person nicht dauerhaft (un)interessant für eine Besetzung ist.
Beispiel: Event Fitnessestudio steigert Kraft->Besetzung für Abenteuer/Western nun denkbar.
Minimal-/Maximalwerte können dabei einschränken, wie stark eine Person "dazulernen" oder "vergessen" kann.

Um das Spiel interessant zu halten, sollten Min/Max aber nicht in der Oberfläche zu sehen sein.
Das Potential einer Person, muss der Spieler schon selbst herausfinden.

Sollten komplexe Attribute als eigener Datentyp modelliert werden (z.B. anstatt 3 primitiver Typen, Kapselung von Berechnungen)?

### Personenattribute

existierende Attribute:
* (Erfahrung schreibe ich hier mal dazu, da sie für die Diskussion wichtig ist)
* Fertigkeit
* Kraft
* Humor
* Charisma
* Aussehen
* Bekanntheit
* Scandalizing

Kraft, Humor, Charisma, Aussehen sind für mich aktuell genre-/berufsunabhängige Eigenschaften.
Wenn jemand als Schauspieler Charisma hat, hat er das auch als Regisseur oder Moderator.
 
Bekanntheit (im Gegensatz zur Popularität): Welcher Anteil der Bevölkerung kennt die Person? (RO)

Scandalizing ist ein Maß dafür, wie wahrscheinlich Skandale um die Person sind.
Das betrifft Klatsch-Nachrichten aber auch Reibereien während einer Produktion (Streit, Produktion dauert länger, schlechtere Qualität wegen unzufriedenem Team).
Das Attribut ist aktuell noch nicht in Benutzung. (RO)

Aus meiner Sicht die kritischsten Attribute sind Fertigkeit und Erfahrung.
Ihre Bedeutung und ihr Einfluss muss möglichst genau festgelegt werden

Fertigkeit ist die allgemeine Fähigkeit, sich anzupassen und Neues aufzuschnappen (RO).
In dieser Interpretation kann auch die Fertigkeit als eine genre-/berufsunabhängige Eigenschaft eingeordnet werden.

Die Erfahrung ist ein Maß dafür, wie häufig eine Aufgabe ausgeübt wurde - wie gut jemand im Training ist.
Sie sollte damit berufsabhängig und in gewissem Rahmen auch genreabhängig sein (und sich aus den Jobs/Produktionen der Person berechnen).
Erfahrung als Nebendarsteller erhöht auch die Erfahrung als Hauptdarsteller (nur viel, viel weniger als andersrum).
Es wäre auch nicht realistisch, dass jemand der 50 mal Nebendarsteller aber nie Regisseur war, dadurch ein besserer Regisseur ist als jemand, der "erst" 5 mal Regie geführt hat.
TODO: Matrix erstellen

(Für TVT würde ich nicht der Argumentation folgen, dass ein erfahrener Schauspieler jede Rolle übernehmen kann.
Das mag in der Realität zu einem bestimmten Grad korrekt sein, würde aber für das Spiel bedeuten, dass die Attribute Kraft/Humor/Aussehen etc. komplett irrelevant sind, da sie immer komplett durch Erfahrung kompensiert werden können.)

Die Erfahrung könnte ein Multiplikator für die restlichen Eigenschaften (Kraft, Humor) sein. Komplett ohne Erfahrung wirken sie einfach, mit steigender Erfahrung können sie aber umso effizienter eingesetzt werden (platt gesprochen Eigenschaft + XP*Eigenschaft).

Fertigkeit (auch) als Lernfähigkeit zu interpretieren, führt zu dem Schluss, dass mit höherer Fertigkeit schneller Erfahrung gesammelt werden kann.
Wichtig wird hier, den genauen Zusammenhang zwischen Fertigkeit, Erfahrung, Qualität des Programms und der Steigerung der Erfahrung nach Abschluss einer Produktion festzulegen.

## Attributanforderungen

### Genre

Ein Genre definiert fix, wie wichtig jede Eigenschaft ist, und zwar für jede Eigenschaft zwischen 0 und 100.
Bei Genre-Kombination könnte ein gewichteter Durchschnitt gebildet werden (z.B. Hauptgenre 70%, Zweitgenre 30%).

Genre    |Kraft|Humor|Charisma|Aussehen
---------|-----|-----|--------|--------
Komödie  |   20|  100|      50|      80
Drama    |   20|   60|      90|      60
...
(in einer der XML-Konfigurationen?)

### Job

Die Jobs selbst haben, wie Du vorgeschlagen hast auch ihre Sonderforderungen.
Regisseur besonders viel Charisma und Aussehen egal, Moderator Charisma und Aussehen, Gast Scandalizing-Bonud...

Je nach Beruf ist auch die Gewichtung von Erfahrung unterschiedlich. Es ist schlimmer, wenn ein Regisseur keine Erfahrung hat als ein Nebendarsteller).
Wichtig ist aber auch, es darf nicht dazu führen, dass man mit ausschließlich Erfahrung die besten Ergebnisse erziehlt.

### Drehbuchanforderungen

Angenommen es gäbe gar keine Zufallseinflüsse, könnte die optimale Besetzung aus Genre und Job abgeleitet werden, da die Faktoren, mit denen die Eigenschaften eingehen immer gleich sind.
Um das aufzubrechen, kann ein Drehbuch diese Basisanforderungen modifizieren (beim erzeugen/klonen/umschreiben/des Drehbuchs gewürfelt), ggf. sogar pro zu besetzender Rolle.
Die eine Komödie braucht mehr Aussehen, die andere mehr Kraft...
So könnte z.B. ein Sidekick-Nebendarsteller (deutlich mehr Humor als eigentlich vom Genre gefordert) im Drehbuch vorkommen, oder ein besonders schöner Nebendarsteller nötig sein.

Die Visualisierung dieser Spezialanforderungen könnte meiner Ansicht nach sogar schon mit aktuellen Mitteln erfolgen (wenn es überhaupt gemacht werden sollte).
Bei der Personenauswahl werden ja jetzt schon relevante Attribute hervorgehoben.
Das kann verallgemeinert werden.
Wenn die Attributanforderung für die Besetzung einen bestimmten Wert überschreiten, werden sie hervorgehoben (wenn sie nicht hervorgehoben werden, heißt es aber nicht, dass sie gar nicht in die Wertung eingehen).

Diese Drehbuchanforderungen sind abwärtskompatibel implementierbar.
(Anpassung=0 für alle Genre- und Job-Anforderungen).

## Zufallseinflüsse

Neben den "Faktoren", die sich aus den Attributanforderungen von Genre/Drehbuch zusammen mit den Personeneigenschaften ergeben, gibt es Zufallseinflüsse.
* Besetzung mit anderem Geschlecht keine Katastrophe sondern Geniestreich
* gestandener Schauspieler baut mal Mist
* "Entdeckung" eines neuen Talents
...

Man kann langfristig auch darüber nachdenken, ob bestimmte Personen besser oder gar nicht miteinander können (Freund-, Feind-, Partnerschaften).

## Abgrenzung Qualität einer Produktion, Änderung von Attributen

Die Qualität einer Produktion sollte von den zum Zeitpunkt des Drehs geltenden Werten bestimmt sein.
Wie, warum und in welchem Ausmaß sich Attributwerte anschließend ändern, ist ein anderes Thema.

# Konsequenz für die Persistenzschicht

## Datentyp, Wertebereich

??

## Genre

Basisforderungen im XML konfigurierbar.
Muss für Speicherstände aber auch ins Modell.
Basiswert pro Genre für
* Humor
* Kraft
* Charisma
* Aussehen
* Fertigkeit

TODO vollständige Tabelle

Oder die Werte stehen fest im Code.

(Bekanntheit, Fertigkeit, Erfahrung sind nicht genrespezifisch)

## Job

Markierung besonders relevanter oder irrelevanter Eigenschaften?
Aussehen, Charisma für Moderator/Reporter wichtig
Charisma für Regisseur wichtig, Aussehen unwichtig
Gast Bekanntheit, (Scandalizing) wichtig...

Ob hier was zu persistieren ist, oder das im Code fest eingebaut werden kann, ist mir nicht klar.

## Drehbuch

Pro zu besetzender "Rolle" Anforderung pro Attribut(, die sich aus Genre/Job ergebenden Basisanforderungen + Modifikation ergeben).
D.h. bei der Berechnung werden dann ausschließlich die Drehbuchwerte verwendet.
Die Anforderungen werden beim "Schreiben" des Drehbuchs (zusammen mit Potential ...) festgelegt.

(abwärtskompatibel implementiertbar - Modifikation überall 0)

## Person

### Erfahrung

* berechnet aus Produktionen, an denen die Person teilgenommen hat
* kann bei Nichtbesetzung auch wieder sinken
* job-/genreabhängig
* "Multiplikator" für die geforderten Eigenschaften

### Basis-Attribute

* Fertigkeit
* Kraft
* Aussehen
* Charisma
* Humor
* (Scandalizing)

Änderbar mit Min- und Max-Wert.
Aktueller Wert wird für Qualitätsermittlung herangezogen.
Einfluss je nach Genre/Job.
TODO: News, Events etc. definieren, wann sich die Werte wie ändern können

### Würfeln der Attribute

An welcher Stelle werden die Attribute gewürfelt (bei Spielstart)?
Wie kann sichergestellt werden, dass es eine hinreichend interessante Verteilung von Attributkombinationen gibt, so dass es interessante Besetzungsmöglichkeiten gibt?