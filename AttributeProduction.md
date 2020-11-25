# Brainstorming produktionsrelevante Attribute

Ziel dieses Dokuments ist, die Attribute festzulegen, die für die Ermittlung der Qualität einer Produktion benötigt werden.
Ausgangspunkt der ÜBerlegungen ist das Problem, dass die aktuellen Darstellerattribute allgemein zu gering sind und die Tendenz besteht, die Darstellerattribute komplett zu ignorieren und allein auf die Erfahrung zu setzen, da diese eine übermäßige Bedeutung an der Qualität der Produktion zu haben scheint.

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

Ob man int von 0 bis 100 oder float von 0 bis 1 nimmt spielt von der Konzeption eine untergeordnete Rolle (bei den Berechnungen muss man natürlich aufpassen).

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
Oder aber die Erfahrung bleibt mit steigendem Alter, aber die Fertigkeit nimmt wieder ab (fehlende Übung).

Umso wichtiger ist also die Frage, genau welche Bedeutung/Interpretation diese beiden für TVTower bekommen sollen.

An sich müssten Erfahrung und Fertigkeit vom Genre und vom Beruf abhängen.
Es dürften also keine globalen Werte sein (es ist nicht realistisch, dass jemand der 50 mal Nebendarsteller aber nie Regisseur war, dadurch ein besserer Regisseur ist als jemand, der "erst" 5 mal Regie geführt hat).

Diese Abhängigkeit komplett abzubilden dürfte aber viel zu aufwändig sein.
Eine Möglichkeit wäre meiner Ansicht nach, Erfahrung als Eigenschaft zu interpretieren, wie oft jemand schon an einer Produktion teilgenommen hat und wie leicht es ihm fällt, seine sonstigen Fähigkeiten einzubringen.
(Für TVT würde ich nicht der Argumentation folgen, dass ein erfahrener Schauspieler jede Rolle übernehmen kann.
Das mag in der Realität zu einem bestimmten Grad korrekt sein, würde aber für das Spiel bedeuten, dass die Attribute Kraft/Humor/Aussehen etc. komplett irrelevant sind, da sie immer komplett durch Erfahrung kompensiert werden können.)
Zusammengefasst: die Erfahrung ist ein "Faktor", der beeinflusst welcher Anteil der eigenen Eigenschaften (Kraft, Humor, ...) einfließt.

Die Fertigkeit wiederum ist ein Maß, wie gut jemand die gerade benötigte Job umsetzen kann (Regisseur, Moderator, ...).
Je öfter man einen Job gemacht hat, desto größer ist die Fertigkeit (zwischen min und max).
* TODO weiter: Vereinfachug gleiches min/max für alle Berufe (d.h. gleiche Lernfähigkeit)?
* persistieren oder aus den bereits übernommenen Jobs berechnen (diese sind doch gespeichert oder?


## Attributanforderungen

Ein Genre definiert fix, wie wichtig bestimmte Eigenschaften.

## Abgrenzung Qualität einer Produktion, Änderung von Attributen

Die Qualität einer Produktion sollte von den zum Zeitpunkt des Drehs geltenden Werten bestimmt sein.
Wie, warum und in welchem Ausmaß sich Attributwerte anschließend ändern, ist ein anderes Thema.