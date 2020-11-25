# Brainstorming produktionsrelevante Attribute

Ziel dieses Dokuments ist, die Attribute festzulegen, die für die Ermittlung der Qualität einer Produktion benötigt werden.
Ausgangspunkt der Überlegungen ist das Problem, dass die aktuellen Darstellerattribute allgemein zu gering sind und die Tendenz besteht, die Darstellerattribute komplett zu ignorieren und allein auf die Erfahrung zu setzen, da diese eine übermäßige Bedeutung an der Qualität der Produktion zu haben scheint.

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
* Scandalizing(?)

Kraft, Humor, Charisma, Aussehen sind für mich aktuell genre-/berufsunabhängige Eigenschaften.
Wenn jemand als Schauspieler Charisma hat, hat er das auch als Regisseur oder Moderator.
Bekanntheit ist für die "Qualität" der Produktion direkt nicht wichtig, hat aber auf die "Zuschauerresonanz" des Ergebnisses einen Einfluss.

Aus meiner Sicht die kritischen Attribute sind Fertigkeit und Erfahrung.
Diese beiden hat man nämlich nicht global, sondern immer in Bezug auf etwas.
Auch sind sie in Realität nicht *komplett* unabhängig voneinander.
Wiederholung von Tätigkeit steigert typischerweise Erfahrung und Fertigkeit.
Oder aber die Erfahrung bleibt mit steigendem Alter, aber die Fertigkeit nimmt wieder ab (fehlende Übung, körperliche Einschränkung).

Umso wichtiger ist also die Frage, genau welche Bedeutung/Interpretation diese beiden für TVTower bekommen sollen.

An sich müssten Erfahrung und Fertigkeit vom Genre und vom Beruf abhängen.
Es dürften also keine globalen Werte sein (es ist nicht realistisch, dass jemand der 50 mal Nebendarsteller aber nie Regisseur war, dadurch ein besserer Regisseur ist als jemand, der "erst" 5 mal Regie geführt hat).

Diese Abhängigkeit komplett abzubilden dürfte aber viel zu aufwändig sein.
Eine Möglichkeit wäre meiner Ansicht nach, Erfahrung als Eigenschaft zu interpretieren, wie oft jemand schon an einer Produktion teilgenommen hat und wie leicht es ihm fällt, seine sonstigen Fähigkeiten einzubringen.
(Für TVT würde ich nicht der Argumentation folgen, dass ein erfahrener Schauspieler jede Rolle übernehmen kann.
Das mag in der Realität zu einem bestimmten Grad korrekt sein, würde aber für das Spiel bedeuten, dass die Attribute Kraft/Humor/Aussehen etc. komplett irrelevant sind, da sie immer komplett durch Erfahrung kompensiert werden können.)
Zusammengefasst: die Erfahrung ist ein "Faktor", der beeinflusst welcher Anteil der eigenen Eigenschaften (Kraft, Humor, ...) einfließt.

Die Fertigkeit wiederum ist ein Maß, wie gut jemand den aktuellen Job grundsätzlich umsetzen kann (Regisseur, Moderator, ...).
Je öfter man einen Job gemacht hat, desto größer ist die Fertigkeit (zwischen min und max).
Wenn die schon gemachten Jobs gespeichert sind, könnte die Fertigkeit aus der Anzahl abgeleitet werden (da es ja keine einfache globale Eigenschaft wäre, sondern eine Map Job-Typ->Fertigkeit)

## Attributanforderungen

Ein Genre definiert fix, wie wichtig jede Eigenschaft ist.
Bei Genre-Kombination könnte ein gewichteter Durchschnitt gebildet werden (z.B. Hauptgenre 70%, Zweitgenre 30%).

Genre    |Kraft|Humor|Charisma|Aussehen
---------|-----|-----|--------|--------
Komödie  |   10|   60|      10|      20
Drama    |   20|   20|      60|      20
...
(in einer der XML-Konfigurationen?)

Damit es nicht zu langweilig ist, definiert das Drehbuch basierend auf diesen Basiswerten eigene Anforderungen (Modifkationen in gewissem Rahmen - die eine Komödie braucht mehr Aussehen, die andere mehr Kraft?).
Ggf. vom Drehbuch sogar Anforderungen pro zu besetzender Rolle vergeben.
So könnte z.B. ein Sidekick-Nebendarsteller (deutlich mehr Humor als eigentlich vom Genre gefordert) im Drehbuch vorkommen, oder ein besonders schöner Nebendarsteller nötig sein.

Die Jobs selbst haben, wie Du vorgeschlagen hast auch ihre Sonderforderungen.
Regisseur besonders viel Charisma, Moderator Charisma und Aussehen...

Je nach Beruf ist auch die Gewichtung von Fertigkeit/Erfahrung unterschiedlich (es ist schlimmer, wenn ein Regisseur keine Ferigkeit/Erfahrung hat als ein Nebendarsteller).

Beim "Klonen" eines Scripttemplates (oder Umschreiben eines Drehbuchs, wenn es das mal geben sollte), werden die drehbuchspezifischen Anpassungen neu gewürfelt.

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

TODO vollständige Tabelle

Oder die Werte stehen fest im Code.

(Bekanntheit, Fertigkeit, Erfahrung sind nicht genrespezifisch)

## Job

Markierung besonders relevanter oder irrelevanter Eigenschaften?
Aussehen, Charisma für Moderator/Reporter wichtig
Charisma für Regisseur wichtig, Aussehen unwichtig
Gast Bekanntheit wichtig

Ob hier was zu persistieren ist, oder das im Code fest eingebaut werden kann, ist mir nicht klar.

## Drehbuch

Pro zu besetzender "Rolle" Anforderung pro Attribut(, die sich aus Genre/Job ergebenden Basisanforderungen + Modifikation ergeben).
D.h. bei der Berechnung werden dann ausschließlich die Drehbuchwerte verwendet.
Die Anforderungen werden beim "Schreiben" des Drehbuchs (zusammen mit Potential ...) festgelegt.

## Person

### Erfahrung

"globaler" Wert, steigt mit Anzahl der Produktionen, verbessert die genre-/jobspezifischen Eigenschaften
(Schauspieler mit Humor ist gut, Schauspieler mit Humor und Erfahrung ist noch besser)
unabhängig von Job und Genre 

### Fertigkeit

Min- und Max-Wert fest.

Basisfertigkeit vorhanden, steigt mit der Anzahl der bereits durchgeführten Jobs vom aktuellen Typ auf einen Maximalwert.
Bei längeren Pausen kann die Fertigkeit auch wieder sinken

### Bekanntheit

kein Einfluss auf Qualität, aber auf Zuschauerzahl.

### Scandalizing

noch keine Vorstellung wofür (Trash, Shows, für Gäste/Musiker wichtig?), eher globales Attribut

### "Genre"-Attribute

* Kraft
* Aussehen
* Charisma
* Humor

Änderbar mit Min- und Max-Wert.
Aktueller Wert wird für Qualitätsermittlung herangezogen.
Einfluss je nach Genre/Job.
TODO: News, Events etc. definieren, wann sich die Werte wie ändern können

### Würfeln der Attribute

An welcher Stelle werden die Attribute gewürfelt (bei Spielstart)?
Wie kann sichergestellt werden, dass es eine hinreichend interessante Verteilung von Attributkombinationen gibt, so dass es interessante Besetzungsmöglichkeiten gibt?
