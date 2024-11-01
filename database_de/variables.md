# Variablen und Funktionsaufrufe

Für die Version 0.8.3 wurde die Verarbeitung von Variablen und anderen dynamischen Inhalten überarbeitet.
Ziel war eine einheitlichere Syntax und gleichzeitig mehr Flexibilität.
Folgende grundsätliche Konzepte gibt es weiterhin

* eigene Variablendefinitionen
* Alternativen in Vorlagen, von denen (z.B. für eine konkrete Nachricht) eine ausgewählt wird
* vom Spiel bereitgestellte dynamische Inhalte

Ergänzt wurden

* Verwendung von Bedingungen nicht nur im Script für die Verfügbarkeit sondern überall wo Variablen erlaubt sind
* Funktionen, die Zugriff auf andere Datenbankelemente erlauben (z.B. Referenz auf Personen, die nicht Teil der Besetzung sind)
* Funktionen, die eine kompaktere Schreibweise für dynamische Inhalte erlauben

Haupteinsatzgebiet von Variablen ist die Erzeugung von Varianz in Texten (Nachrichten, Drehbüchern) aber auch die Referenz z.B. auf Personen, ohne deren Namen fest in den Texten zu hinterlegen.
Das kann z.B. sinnvoll sein, wenn z.B. Anpassungen an Personen- oder Rollendefinitionen in der Datenbank gemacht werden.
Filmtitel oder Beschreibungen müssen dann nicht entsprechend korrigiert werden.
Typischerweise werden Variablen an allen Stellen verwendet, an denen es sprachspezifische Texte gibt.

```XML
...
	<title>
		<de>Es tanzt ${animal}</de>
		...
	</title>
...
	<variables>
		<animal>
			<de>der Bär|die Maus</de>
			...
		</animal>
	</variables>
...
```

## Syntaxgrundlagen

Da wir es nicht mehr nur mit einfachen Variablen und Zugriff auf Werte aus dem Spiel mittels Konstanten zu tun haben, sprechen wir von *Ausdrücken*.
Der grundsätzliche Aufbau eines erst zur Zeit des Spiels ausgewerteten Ausdrucks ist `${auszuwerten}`.
Er beginnt mit `${` und endet mit `}`.
`auszuwerten` kann wie im obigen Beispiel der Name einer selbst definierten Variable sein oder aber eine komplexere Struktur haben kann, z.B. selbst wieder Ausdrücke enthalten.

* `${einfacheVariable}`
* `${variablenPraefix_${suffixZuerstAusgewertet}}`
* `${.funktionsName:parameter1:parameter2...}`

### Variablendefinition

Eine Reihe von Datenbankstrukturen erlauben die Definition von Variablen, um z.B. für Texte und Beschreibugnen mehr Varianz zu erlauben.
Die Variablen selbst und ihre möglichen Belegungen werden im Hauptknoten `variables` definiert, wobei für jede Variable wieder mehrere Sprachvarianten erlaubt sind.
Unterschiedliche Möglichkeiten für die Ersetzung der Variable verden durch senkrechte Striche `|` voneinander getrennt.


```XML
	<variables>
		<animal>
			<de>der Bär|die Maus|das Kamel</de>
			<en>the bear|the mouse|the camel</en>
		</animal>
		<rndcity>${.stationmap:"randomcity"}</rndcity>
		<city>Berlin|Bonn|Trier|${.stationmap:"randomcity"}</city>
	</variables>
```

Im diesem Beispiel werden drei Variablen definiert: `animal`, `rndcity` und `city`.
Typischerweise wird es innerhalb der Definition Tags für unterschiedliche Sprachen geben, so dass sprachspezifische Texte erstellt werden können.
Für `animal` gibt es eine deutsche und eine englische Variante.
Diese Definition enthält Alternativen (`Variante 1|Variante 2|Variante 3`), die durch `|` voneinander getrennt sind.
Zur Auswertungszeit wird für die Variable einmalig eine Zahl gewürfelt (je nach Anzahl der Alternativen) und dann für alle Sprachen verwendet.
Leere Alternativen sind erlaubt (`<de>||große </de>` - nur in einem Drittel der Fälle würde das Adjektiv erscheinen).
Wird also die 2 gewürfelt, wäre der Wert von `animal` im Deutschen `die Maus` und im Englischen `the mouse`.

Soll der Text aber immer für alle Sprachen genau gleich sein, kann seit Version 8.3.0 auf das Sprachtag verzichtet werden.
`<rndcity>${.stationmap:"randomcity"}</rndcity>` macht für alle Sprachen einen einmalig erzeugten Stadtnamen (für die vom Spiel zur Verfügung gestellten Funktionen siehe unten) unter dem Variablennamen `rndcity` verfügbar.

### einfache Variablen

Der Zugriff auf eine so definierte Variable erfolgt im einfachsten Fall über den Ausdruck `${variablenname}`.
Für die oben definierten Variablen wären das die Ausdrücke `${animal}`, `${rndcity}` und `${city}`.
Sie können im Titel, der Beschreibung aber auch in anderen Variablendefinitionen verwendet werden.
Bevor der Wert einer Variable feststeht, werden zunächst alle Ausdrücke in der Definition vollständig ausgewertet.
(Variablendefinitionen dürfen also nicht auf sich gegenseitig verweisen.)

### wichtiger Hinweis zu kopierten Spracheinträgen

Soll z.B. der Titel eines Drehbuchs zufällig erzeugt werden und mehrere Varianten unterstützen, kann folgendes Schema verwendet werden:

```XML
...
	<title>
		<de>${theTitle}</de>
		<en>${theTitle}</en>
	</title>
...
	<variables>
		<theTitle>
			<de>Die Saga von ...|Das Geheimnis von ...</de>
			<en>The Saga of ...|The Secret of ...</en>
		</theTitle>
	</variables>
...
```

Selbst wenn die Spracheinträge für `title` für alle Sprachen gleich sind und nur aus der Variablenreferenz bestehen, kann die verkürzte Schreibweise `<title>${theTitle}</title>` nicht verwendet werden.
In dem Fall würden nämlich alle Sprachen denselben Titel bekommen - der Ausdruck wird nur einmal ausgewertet und dann für alle Sprachen verwendet.

Aus demselben Grund würde man auch nicht folgende Variablendefinition verwenden:

```XML
	<variables>
		<city>
			<de>Lissabon|${.stationmap:"randomcity"}</de>
			<en>Lisbon|${.stationmap:"randomcity"}</en>
		</city>
	</variables>
```

Wird zur Spielzeit die Alternative zwei gewürfelt, würde sowohl für Deutsch als auch für Englisch ein zufälliger Städtename ermittelt.
In den Texten würden dann also unterschiedliche Städte erscheinen, was vermutlich nicht dem gewünschten Ergebnis entspricht.
Richtig wäre

```XML
	<variables>
		<rndcity>${.stationmap:"randomcity"}</rndcity>
		<city>
			<de>Lissabon|${rndcity}</de>
			<en>Lisbon|${rndcity}</en>
		</city>
	</variables>
```

Da `rndcity` sprachunabhängig definiert ist und der Wert einer Variablen nur einmalig ermittelt wird, liefert die zeite Alternative von `city` wie gewünscht dieselbe Stadt.

### geschachtelte Variablen

Da Ausdrücke selbst wieder Ausdrücke enthalten können, die von innen nach außen ausgewertet werden, können geschachtelte Variablen verwendet werden `${varpraefix_${variant}}`.
Hird zunächst die Variante aufgelöst und bestimmt damit, welche "Hauptvariable" Verwendung findet.

```XML
...
	<title>
		<de>${wer_${geschlecht}} und ${pronomen_${geschlecht}} ${adj}${was}</de>
	</title>
...
	<variables>
		<geschlecht>maennl|weibl</geschlecht>
		<wer_maennl>
			<de>Der Anwalt|Der Bäcker|Der König</de>
		</wer_maennl>
		<wer_weibl>
			<de>Die Lehrerin|Die Ärztin|Die Königin</de>
		</wer_weibl>
		<pronomen_maennl>
			<de>seine</de>
		</pronomen_maennl>
		<pronomen_weibl>
			<de>ihre</de>
		</pronomen_weibl>
		<adj>
			<!--erste Alternative leer - also ohne Adjektiv-->
			<de>|teuren |neusten |früheren </de>
		</adj>
		<was>
			<de>Autos|Liebschaften|Pferde|Probleme</de>
		</was>
	</variables>
...
```

Das ist eine Möglichkeit grammatisch korrekte Texte zu erstellen.
Zunächst wird einmalig das Geschlecht ermittelt wodurch aus `${wer_${geschlecht}}` entweder `${wer_maennl}` oder `${wer_weibl}` wird.
Das ist dann eine einfache Variable, die direkt aufgelöst werden kann.

Mögliche Titel wären in diesem Beispiel also
* Der Anwalt und seine turen Liebschaften
* Die Lehrerin und ihre Autos
* Der König und seine früheren Pferde

Eine weitere ab Version 0.8.3 verfügbare Möglichkeit solche komplexeren Texte zu erstellen ist die csv-Funktion - siehe weiter unten.

### Funktionsaufrufe

Neben dem Auflösen selbst definierter Variablen erlauben Ausdrücke auch das Auswerten von Funktionen.
Diese sind im Spiel fest hinterlegt und werden abhängig vom Kontext der Verwendung und dem aktuellen Zustand des Spiels ausgewertet.

Der grundsätzliche Aufbau eines Funktionsaufrufs ist `${.funktionsName:parameter1:parameter2...}`, wobei die Anzahl der Parameter und deren Typ von der Funktion und dem Kontext der Verwendung abhängt.
Mögliche Paramtertypen sind

* Zeichenkette (`"wert"` - in Anführungszeichen)
* Variable (`variablenName` - ohne Anführungszeichen)
* Zahl (`17`, `0.25`)
* Wahrheitswert (`0`,`1`,`true`,`false` - TODO prüfen)

Als Parameter kann natürlich auch wieder ein Ausdruck verwendet werden, dessen Wert zunächst ermittelt wird, bevor er als Funktionsparameter verwendet wird.

Es gibt *globale* Funktionen, die an jeder Stelle verwendet werden können.
Beispiele dafür sind das bereits verwendete Würfeln von Städtenamen, Funktionen zum ermitteln aktueller Spielzeitwerte oder Bedingungen

* `${.stationmap:"randomcity"}` - zufällig ermittelter Städtename
* `${.worldtime:"year"}` - aktuelles Jahr im Spiel
* `${.if:${.eq:${.worldtime:"weekday"}:0}:"Montag":"nicht Montag"}` - wenn der aktuelle Wochentag 0 ist (entspricht Montag) dann wird der gesamte Ausdruck zu `Montag` ausgewertetn ansonsten zu `nicht Montag`
* `${.person:"123abc":"fullname"}` - vollständiger Name der Persion mit der GUID 123abc

Andere Funktionen sind kontextabhängig, können also nur in bestimmten Datenbankobjekten verwendet werden.
`${.self:"role":1:"fullname"}` zum Beispiel liefert den vollständiger Name der Rolle mit Index 1.
Dieser Ausdruck ergibt aber nur in einem Programm oder einer Drehbuchvorlage Sinn.
In Nachrichten gibt es keine Rollen.

## Übersicht über wichtige Funktionen

Einstiegspunkte für die definierten Funktionen sind `game.gamescriptexpression.bmx` für TVTower-spezifische Funktionen und `base.util.scriptexpression_ng.bmx` für allgemeine Funktionen (Bediungen etc.).
Mit einer Textsuche nach `RegisterFunctionHandler` bekommt man einen schnellen Überblick, was es so gibt und wo es definiert ist.
In der registrierten `SEFN_`-Funktion kann man dann die möglichen Parameter nachvollziehen.
Die im folgenden aufgelisteten Parameter müssen nicht vollständig sein!

### stationmap

Die Funktion `.stationmap` bietet kontextunabhängigen Zugriff auf Informationen zur gerade im Spiel verwendeten Karte (aktuell nur Deutschland).
Es muss genau ein Zeichenkettenparameter angegeben werden.

* `${.stationmap:"randomcity"}` - zufälliger Städtename
* `${.stationmap:"population"}` - Bevölkerungszahl
* `${.stationmap:"mapname"}` - Name des Landes
* `${.stationmap:"mapnameshort"}` - ISO-Ländercode

### worldtime

Die Funktion `.worldtime` bietet kontextunabhängigen Zugriff auf den aktuellen Zeitpunkt im Spiel.
Es muss genau eine Zeichenkettenparameter angegeben werden.

* `${.worldtime:"year"}` - aktuelles Jahr
* `${.worldtime:"month"}` - aktueller Monat (als Zahl)
* `${.worldtime:"day"}` - aktueller Tag (als fortlaufende Zahl)
* `${.worldtime:"dayofmonth"}` - Tag des Monats (1-31)
* `${.worldtime:"hour"}` - aktuelle Stunde des Tages (0-23)
* `${.worldtime:"minute"}` - aktuelle Minute (0-59)
* `${.worldtime:"daysplayed"}` - Anzahl fertig gespielter Tage
* `${.worldtime:"dayplaying"}` - aktueller Spieltag
* `${.worldtime:"yearsplayed"}` - Anzahl fertig gespielter Jahre
* `${.worldtime:"weekday"}` - aktueller Wochentag (als Zahl; 0=Montag)
* `${.worldtime:"season"}` - aktueller Jahreszeit (als Zahl; 1=Frühling, 4=Winter)

### persongenerator

Die Funktion `.persongenerator` erlaubt kontextunabhängig länderspezifische Namen zu erzeugen.
Es ist nicht direkt möglich, eine Person zu erzeugen und dann auf die unterschiedlichen Namensbestandteile (Vorname, Nachname, Titel) zuzugreifen.
Der Grundsätzliche Aufruf ist `${.persongenerator:"Namenstyp":"Land":"Geschlecht":WahrscheinlichkeitFürTitel}.
Nur der erste Parameter Namenstyp ist Pflicht und bis auf die Wahrscheinlichkeit für den Titel (Zahl zwischen 0 und 1) sind alles Zeichenkettenparameter.

Erlaubte Namenstypen sind
* "name", "firstname" - Vorname
* "lastname" - Nachname
* "fullname" - vollständiger Name inklusive Titel
* "title"

Ist das Länderkürzel nicht angegeben, leer oder unbekannt wird ein zufälliges Land verwendet.
Einstiegspunkt für weitere Recherche ist `base.util.persongenerator.bmx`.
Aktuell bekannte Kürzel sind: aut, de, uk, cn, ru, tr, us, dk, gr, ug, es, fr, pl.
Ein paar weitere delegieren auf ähnliche Länder (sco, e, irl, nor, swe, se, sui, bra, por, mex, d).

Für das Geschlecht werden folgende Werte unterstützt

* männlich: `"m"`, `"1"`, `"male"`
* weiblich: `"f"`, `"2"`, `"female"`
* bei anderen Werten wird ein zufälliges Geschlecht ausgewählt

Beispiele:

* `${.persongenerator:"firstname"}` - beliebiger Vorname
* `${.persongenerator:"firstname":"us":"male"}` - US-amerikanischer männlicher Vorname
* `${.persongenerator:"fullname":"":"female":0.9}` - weiblicher Name mit 90%iger Wahrscheinlichkeit für einen Titel
* `${.persongenerator:"lastname":"${de|it|dk}"}` - deutscher oder italienischer oder dänischer (skandinavischer) Nachname

### Referenz auf eigene Besetzung

### csv

### Bedingungen

### globale Referenz auf Datenbankobjekte



#### vom Spiel automatisch aufgelöste Variablen

Es gibt Variablennamen und global verfügbare Werte, die von der Spiellogik automatisch aufgelöst werden können.

**globale Variablen**

* `WORLDTIME:YEAR` - aktuelles Jahr im Spiel
* `WORDLTIME:GAMEDAY` - aktueller Spieltag
* `WORDLTIME:DAYLONG` - Wochentag (Montag, Dienstag...)
* `WORLDTIME:GERMANCURRENCY` - aktuelle deutsche Währung
* `WORLDTIME:GERMANCAPITAL` - deutsche Hauptstadt (Berlin/Bonn)
* `STATIONMAP:COUNTRYNAME` - Name des Landes
* `STATIONMAP:POPULATION` - Einwohnerzahl

In Drehbuchvorlagen werden automatisch die Variablen `ROLE1`...`ROLE7` (voller Name), `ROLENAME1`...`ROLENAME7` (Vorname), `GENRE` (Hauptgenre) und `EPISODES` (Anzahl der Folgen) aufgelöst.

Beispiel: `%ROLE1% erlebt wieder viel Abenteuer in %EPISODES% Folgen der neuen %GENRE%serie.`

**vom Spiel erzeugbare Zufallswerte**

* `STATIONMAP:RANDOMCITY` erzeugt einen (fiktiven) Stadtnamen

**Personengenerator**

Zum erzeugen zufälliger Namen, hinter denen keine Person aus der Datenbank stehen muss, kann der Personengenerator verwendet werden.
Er bekommt als Argumente das Länderkürzel (Achtung - das sind nicht die Werte der [Ländertabelle](main.md#Länder),  wobei `unk` für unbekannt steht und das Geschlecht (1=männlich, 2=weiblich).

Beispiele:
* `%PERSONGENERATOR_NAME(unk,2)%` - voller Name einer Frau aus unbestimmtem Land
* `%PERSONGENERATOR_FIRSTNAME(de,1)%` - Vorname eines deutschen Mannes
* `%PERSONGENERATOR_LASTNAME(us,2)%` - Nachname einer US-Amerikanerin

Die aktuell möglichen Länderkennungen findet man in `base.util.persongenerator.bmx`, wo es für verschiedene Länder `TPersonGeneratorCountry_X`-Implementierungen gibt.

**Achtung:** wenn man dieselbe Zufallsvariable (z.B. einen Namen) an mehreren Stellen (Titel und Beschreibung), dann definiert man eine eigene Variable und verwendet die Zufallsvariable als Inhalt.
Ansonsten würde jedes Vorkommen der Variable durch einen anderen Zufallswert ersetzt.

```XML
<variables>
	<randomcity>
		<de>%STATIONMAP:RANDOMCITY%</de>
	</randomcity>
</variables>
```

#### Besetzungsvariablen

Einen Sonderfall stellen Variablen dar, die automatisch aus der Besetzung eines Programms aufgelöst werden.
Über den Index wird die Person definiert und dann kann angegeben werden, ob der volle Name, der Vorname oder der Nachname eingesetzt werden soll.
Das Format unterscheidet sich leicht: `[Index|WelcherName]`

* `[1|First]` - der Vorname der Besetzung mit Index 1
* `[2|Last]` - der Nachname der Besetzung mit Index 2
* `[3|Full]` - der volle Name der Besetzung mit Index 3