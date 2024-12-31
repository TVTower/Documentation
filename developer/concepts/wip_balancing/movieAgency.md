# Filmagentur

## Ramschkiste

Das Thema Unattraktivität Ramschkiste nach den ersten Spieltagen wurde an mehreren Stellen aufgeworfen.
Hypothese war, dass man sie nach wenigen Tagen nicht mehr benötigt, weil man dann einen Fundus zusammenhat, mit dem man dauerhaft Programm mit maximaler Aktualität ausstrahlen kann.
Ein Vorschlag war, sie im Laufe des Spiels für Sonderangebote zu nutzen oder periodisch (nur) ein Genre anzubieten.

Mit Version 0.8.2 wird ein deutlich größerer Fundus benötigt (langsamere Aktualitätserholung).
Ob sich das ohne Ramschkiste schaffen lässt, ist noch unklar (für Tagesprogramm nachkaufen).

Bei einer kompletten Abschaffung im späteren Spiel muss man einen möglichen KI-Bankrott berücksichtigen.
Eine neu hinzukommende KI muss wieder Zugriff zu einem preiswerten Startangebot haben (auch wenn durch mehr Startkapital teurere Filme möglich wären).

Bevor an dieser Stelle Anpassungen vorgenommen werden, sollte die Berechnung der Maximalaktualität, Aktualitätserholung und Einschaltquote in Abhängigkeit der Austrahlungsanzahl "final" sein.
Werden hier die Daumenschrauben angezogen, könnte die Ramschkiste für das Tagesprogramm (keine Verschwendung guter Prime-Time-Filme) deutlich länger von Interesse sein.

## Diskussionspunkt Qualität vs. Aktualität

Die TVTower-Datenbank spiegelt nicht die Gesamtheit aller Filme wider.
Ein Großteil der "schlechten" Filme dürfte eher den schlechten unter den guten entsprechen.
Auch mit der Vergabe des "Cult"-Flags wäre ich vorsichtig, denn Kult sind Filme typischerweise nicht sofort, wenn sie erschienen sind, sondern erst nach gewisser Zeit.
Und man kann nicht allen Filmen der Datenbank das Flag verpassen.
Es sollte den Kultfilme unter den Kultfilmen vorbehalten sein.

Worauf will ich hinaus?
TVTower ist nicht darauf angelegt, dass man jeden Film einmal und dann nie wieder sendet.
Aber es sollte schon mehr Anreiz geben, immer weiter an seinem Fundus zu arbeiten.

So lange aber (vor allem) die Aktualität eines Films (gefühlt) für die Einschaltquote verantwortlich ist, ergibt sich ein verzerrtes Bild: schlechte neue Filme sind besser als gute alte.

Seit 0.8.2 erholt sich die Aktualität viel langsamer erholt.
Zusätzlich könnte die Aktualität nach der Ausstrahlung eines "schlechten" Films auch stärker fallen und die Maximalaktualität die Qualität reflektieren.
Ziel: schlechte Filme brauchen länger, bis Zuschauer sie wieder sehen wollen.

"Miese Filme" haben dennoch einen Platz im Spiel: man kann nicht von Anfang an nur Blockbuster bringen, dafür hat man nicht genug Geld.
Mit stärkerem Einfluss der Ausstrahlungshäufigkeit möchte man vielleicht auch nicht nur gute Filme Tagesprogramm verschwenden.
Zum Reinholen der laufenden Kosten reicht auch mal Durchschnitt.

## Einschränkungen bei Lizenzen

Die Ausstrahlungshäufigkeit kann ja schon prinzipiell eingeschränkt werden.
Allerdings wird davon in der Datenbank (bei Programmen) kein Gebrauch gemacht, nur bei Drehbuchvorlagen (insb. Live-Formate).

* Level schwer - immer maximal X Ausstrahlungen
* unabhängig vom Level - Lizenzen bekommen eine Ablaufzeit (in Tagen; durch die Konfigurierbarkeit der Tageszahl pro Saison wird alles andere kompliziert)...

Bei solchen Modellen muss man sich die Preisstruktur genau anschauen.
Wenn pro Sendeblock bei voller Reichweite ca. 2 bis max 3 Mio an Werbeeinnahmen möglich sind, kann ein Film nicht 20 Mio kosten (10 Ausstrahlungen mit vollen Werbeeinahmen nötig, bevor man die Kosten rein hat; kann er natürlich - Spieler will den Film aus emotionalen Gründen, nicht aus finanziellen)

Weitere Stichpunkte:
* automatische Lizenzverlängerung (kostenpflichtig) im Archiv (alle, pro Lizenz, mehrere Regale für unterschiedliche Laufzeiten)


## Auswirkung Reichweitelevelaufstieg

Die Preisentwicklung für Lizenzen in früheren Versionen war anders:
* Level 1: 0.5*Basispreis
* Level 2: 1*Basispreis
* Level 3: 1.5*Basispreis

Im Ergebnis haben sich die Lizenzpreise am Spielanfang also sehr schnell verdreifacht.
Eine Strategie war also, sich zunächst mit halbwegs vernünftigen Lizenzen einzudecken, und diese dann bei Senderausbau in Dauerschleife zu senden.

Die aktuelle Umsetzung ist vermutlich das andere Extrem - die geringen Preisanstiege machen aufgrund der Werbemehreinnahmen gar keinen Unterschied.
(Allerdings sind die wirklich guten Filme weiterhin so teuer, dass man den Preis selbst mit mehreren Ausstrahlungen schwer einspielen kann).

ABER: Ich glaube, der erste (wichtigere) Ansatzpunkt ist, die Dauerschleifen unattraktiver zu machen (langsamere Erholung, schnelleres Absinken der Maximalaktualität, größerer Einfluss der Austrahlungsanzahl auf die Einschaltquote).

Nachlizensierungskosten bei Reichweiteerhöhung oder Abwertung des aktuellen Fundus bei Reichweiteerhöhung werden hier als Gedanke aufgenommen.

## Mögliche Maßnahmen

* Ramschkiste mit höherer Frequenz aktualisieren als "normale" Filme
* Trennlinie für "Ramsch" verschieben (Preis-/Alters-/Qualitätskriterien anpassen; ggf. auch im Spielverlauf - wenn durchschnittlich viel Geld da ist, sind auch teurere Filme "Ramsch")
* im späteren Spiel Hälfte Ramsch, Hälfte Auswahl für ein Genre
* Kauf und Verkaufsprovision; also bei Kauf immer was auf den Wert draufschlagen, bei Verkauf immer was vom Wert abziehen; ggf. auch abhängig von der Schwierigkeitsstufe