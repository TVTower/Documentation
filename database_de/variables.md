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
* Wahrheitswert (`0`,`1`,`true`,`false`)

Als Parameter kann natürlich auch wieder ein Ausdruck verwendet werden, dessen Wert zunächst ermittelt wird, bevor er als Funktionsparameter verwendet wird.
Wird ein Stringparameter erwartet, dessen Wert aber von einer Variable abhängt, kann die Variablenauflösung innerhalb von Anführungszeichen erfolgen `${.funktion:"${variableOderAusdruck}"}`.

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
Die im folgenden aufgelisteten Funktionen und Parameter müssen nicht vollständig sein!

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
* `${.worldtime:"season"}` - aktueller Jahreszeit (als Zahl; 1=Frühling, 4=Winter), wobei Frühling März bis Mai ist

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

### locale

Die Funktion `.local` bietet kontextunabhängigen Zugriff auf die Übersetzungsdateien (`res/lang/...`).
Es können allerdings keine dort verwendeten Parameter übergeben oder wie im Spiel verwendete Zufallsvarianten gewählt werden.
Neben dem Schlüssel kann optional das Länderkürzel angegeben werden (ansonsten wird die gerade im Spiel eingestellte Sprache verwendet).

* ${.locale:"HOUR"} - Auflösung des Schlüssels "HOUR" aus `genSettings_...` - Stunde auf Deutsch, heure auf Französisch
* ${.locale:"MOVIES","es"} - Auflösung des Schlüssels "MOVIES" aus `programme_es.txt` -  Peliculas

Da sich zwischen Spielversionen die Lokalisierungsdateien ändern können, die Datenbank aber im Spielstand hinterlegt ist, sollte man darauf achten, keine Schlüssel in der Datenbank zu verwenden, bei denen ein Entfallen/Umbenennen in zukünftigen Versionen wahrscheinlich ist.

### Referenz auf eigene Besetzung

In Programmen kann auf die Namen der eigenen Besetzung, in Programmen und Drehbuchvorlagen auf die Rollen zugegriffen werden.
Der grundsätzliche Funktionsaufbau ist immer gleich `${.self:"Typ":Index:"Attribut":inklusiveTitel}`.
`.self` ist der Indikator dafür, dass die Auswertung im Kontext des definierenden Objekts erfolgt.
Typ kann `cast` (nur Programme, da in einem Drehbuch die tatsächliche Besetzung noch nicht feststeht) oder `role` für die Rolle sein.
Index ist die Stelle des gewünchten Wertes in der Besetzungs-/Jobliste in der Datenbank und sollte mit dem an dem Eintrag definierten index-Attributs übereinstimmen (Index 0 ist der erste Eintrag der Liste).
Ein Index der außerhalb der Anzahl der Besetzungen liegt, führt zu einem Fehler.
Der Wahrheitswert `inklusiveTitel` ist optional und gibt bei einem Nachnamen oder vollen Namen an, ob dieser mit Titel zurückgegeben werden soll (Standardfall ist nein).

Die wichtigste möglichen Werte für `Attribut` entsprechen (nahezu) den Werten für zufällige Namen
* `firstname` - Vorname
* `lastname` - Nachname
* `fullname` - vollständiger Name
* `tilte` - Titel
* `nickname` - Spitzname (Vorname, falls kein Spitzname definiert ist)

Wird für Drehbuchvorlagen eine Rolle referenziert, die in der Jobliste nicht explizit hinterlegt ist (kein `role_guid`-Attribut), wird automatisch eine Rolle erzeugt, d.h. bei jeder Erstellung eines Drehbuchs aus der Vorlage eine neue Rolle mit neuem Namen.
Auf diese Weise muss man nicht unbedingt selbst mittels Personengenerator oder verschiedenen Variablen Namen selbst erfinden.
Bei fertigen Programmen darf man natürlich nur in der Datenbank hinterlegte Rollen refernzieren

Angenommen mit Index 0 ist immer der Regisseur definiert, und alles weitere sind Schauspieler ergeben sich folgende Beispiele

* `${.self:"cast":0:"fullname":true}` - vollständiger Name des Regisseurs inklive Titel (in einer Programmdefinition)
* `${.self:"cast":2:"firstname"}` - Vorname des Schauspielers mit Index 2
* `${.self:"role":1:"nickname"}` - Spitzname der Rolle, die für Index 1 hinterlegt ist (oder ggf. erzeugt wird)

### Bedingungen

Bedingungen werden insbesondere für die Verfügbarkeitsscripte benötigt, um z.B. zu prüfen, ob schon genügend Spieltage vergangen sind, bevor eine Drehbuchvorlage verfügbar wird.
Sie kann aber auch für die Erzeugung von Texten hilfreich sein.
In früheren Versionen mussten z.B. mehrere Nachrichtenketten definiert werden, um sich im Laufe der Zeit ändernde Währungen oder Städtenamen zu unterstützen.
Nun könnten diese Texte dynamisch durch Bedingungen erzeugt werden.

Wichtigster Startpunkt für Fallunterscheidungen ist `${.if:Bedinung:ErgebnisWennJa:ErgebnisWennNein}`.
Die Ergebnisparameter sind optional und wenn sie fehlen wird der jeweilte Wahrheitswert der Bedingungn zurückgegeben.

* `${.if:${.worldtime:"year"}==2000:"zweitausend":"nicht 2000"}` - wenn das aktuelle Jahr 2000 ist, kommt "zweitausend" raus, ansonsten "nicht 2000"
* `${.if:"${var}"=="foo":"bar":"karte"}` - wenn die Variable `var` zu `foo` ausgewertet wird, kommt "bar" raus, ansonsten "karte"
* `${.if:${.gt:${.worldtime:"hour"}:21}:"spät":"nicht spät"} - Wenn es nach 22 Uhr ist, kommt "spät" raus, ansonsten "nicht spät"
* `${.if:var:"nicht leer":"leer"}` - wenn die Variable `var` zu einer leeren Zeichenkette ausgewertet wird, kommt "leer" raus, ansonsten "nicht leer"

Das letzte Beispiel zeigt, wie sich Auswertungsergebnisse über gut Variablennamen weitergeben lassen.

```XML
<variables>
	<geschlecht>m|f</geschlecht>
	<maennl>${.if:"$geschlecht}"=="m"}:"true":""}</maennl>
	<artikel>
		<de>
			${.if:maennl:"Der:"Die"}
		</de>
	</artikel>
...
```
Das Geschlecht wird gewürfelt.
Wenn `f`rauskommt, ist der Inhalt der Variable `maennl` leer und liefert bei der If-Prüfung den Wahrheitswert falsch.

Für Vergleiche stehen mehrere Funktionen bereit.
Oben wurde eine Gleichheit mit `==` geprüft.
Da die Verwendung spizter Klammern in XML außer für Tags nicht wirklich empfehlenswert ist, wird von der Verwendung der normalen Operatoren (`<`,`<=`,`>`, `>=`,`<>`) abgeraten.
Stattdessen sollten die entsprechenden Vergleichsfunktionen für den Vergleich von `p1`und `p2`verwendet werden.

* `${.eq:p1:p2}` - wahr gdw (genau dann, wenn) p1 gleich p2 ist
* `${.neq:p1:p2}` - wahr gdw p1 ungleich p2 ist
* `${.gt:p1:p2}` - wahr gdw p1 größer als p2 ist
* `${.gte:p1:p2}` - wahr gdw p1 größer als oder gleich p2 ist
* `${.lt:p1:p2}` - wahr gdw p1 kleiner als p2 ist
* `${.lte:p1:p2}` - wahr gdw p1 kleiner als oder gleich p2 ist

Mit `${.not:bedingung}` kein eine Bedingung negiert werden.
Und- und Oder-Verknüpfungen von zwei oder mehr Bedingungen sind auch möglich.

* `${.and:b1:b2}` - wahr gdw alle Bedinungen (b1 und b2) wahr sind
* `${.and:b1:b2:b3:b4}` - wahr gdw alle Bedinungen (b1 bis b4) wahr sind
* `${.or:b1:b2}` - wahr gdw mindestens eine der Bediungenen (b1 oder b2) wahr sind
* `${.or:b1:b2:b3:b4}` - wahr gdw mindestens eine der Bedingungen wahr sind

Es versteht sich von selbst, dass die Parameter der Vergleiche etc. selbst wieder komplexe Ausdrücke (mit dem richtigen Typ) sein können.

### csv

Bislang konnten grammatisch korrekte Sätze ausschließlich mit verschachtelten Variablen umgesetzt werden.
Mit Funktionen gibt es nun eine zusättliche Möglichkeit, die zu einer besseren Lesbarkeit in der Datenbank führen kann.
Die Grundidee ist, dass man eine Liste von Datensätzen zur Verfügung stellt, von denen jeder einzelne alle nötigen Informationen enthält.
Die Funktion `.csv` erlaubt dann den Zuriff auf die einzelnen Elemente des Datensatzes.
Der grundsätzliche Aufbau des Funktionsaufrufs ist `${.csv:"Datensatz":Index:"Separator":LeerzeichenEntfernen}`.
Pflichtparameter sind der Datensatz (Zeichenkette) und Index (welcher Teil des Datensatzes wird zurückgegeben).
Wenn der Separator im Datensatz nicht das Semikolon ist (`;`), kann optional der Separator mitgegeben werden.
Normalerweise werden automatisch Leerzeichen, Tabulatutoren etc. vor und hinter dem Gesamtdatensatz entfernt.
Das kann mit dem vierten Parameter (Wahrheitswert) unterbunden werden.

Einfache Beispiele:
* `${.csv:"a;b;c":0}` liefert `a`
* `${.csv:"a;b;c":2}` liefert `c`
* `${.csv:"a,b,c":1:","}` liefert `b`

Das folgende Beispiel soll illustrieren, was mit der Kombination aus Alternativen, verschachtelten Variablen und csv-Datensätzen möglich ist.

```XML
...
	<title>
		<de>${wer_${geschlecht}} und ${pron_nom_${geschlecht}} ${adj}${was}</de>
	</title>
	<description>
		<de>Wie alle ${wer_plural_${geschlecht}} kämpft ${name} mit ${pron_gen_${geschlecht}} Vorliebe für ${was}.</de>
	</description>
...
	<variables>
		<geschlecht>m|f</geschlecht>
		<name>${.persongenerator:"firstname":"de":geschlecht}</name>
		<werData>
			<!--Für die bessere Lesbarkeit kommt jeder Datensatz auf eine eigene Zeile.
			    Dafür auch das automatische Entfernen von Leerzeichen vor und nach dem Datensatz.
			-->
			<de>
				Anwalt;Anwälte;Anwältin;Anwältinnen|
				Bäcker;Bäcker;Bäckerin;Bäckerinnen|
				König;Könige;Königin;Königinnen|
				Lehrer;Lehrer;Lehrerin;Lehrerinnen|
				Arzt;Ärzte;Ärztin;Ärztinnen
			</de>
		</werData>
		<wer_m>
			<de>Der ${.csv:werData:0}</de>
		</wer_m>
		<wer_f>
			<de>Die ${.csv:werData:2}</de>
		</wer_f>
		<wer_plural_m>
			<de>${.csv:werData:1}</de>
		</wer_plural_m>
		<wer_plural_f>
			<de>Die ${.csv:werData:3}</de>
		</wer_plural_f>
		<pron_nom_m>
			<de>seine</de>
		</pron_nom_m>
		<pron_gen_m>
			<de>seiner</de>
		</pron_gen_m>
		<pron_nom_f>
			<de>ihre</de>
		</pron_nom_f>
		<pron_gen_f>
			<de>ihrer</de>
		</pron_gen_f>
		<adj>
			<de>|teuren |neusten |früheren </de>
		</adj>
		<was>
			<de>Autos|Liebschaften|Pferde|Probleme</de>
		</was>
	</variables>
...
```

Alternativ kann man auch grammatische Information in den Datensätzen doppeln sowie Bedingungen verwenden und so mit weniger Variablen auskommen.

```XML
...
	<title>
		<de>${wer} und ${pron_nom} ${adj}${was}</de>
	</title>
	<description>
		<de>Wie alle ${wer_plural} kämpft ${name} mit ${pron_dat} Vorliebe für ${was}.</de>
	</description>
...
	<variables>
		<werData>
			<!--Für die bessere Lesbarkeit kommt jeder Datensatz auf eine eigene Zeile.
			    Dafür auch das automatische Entfernen von Leerzeichen vor und nach dem Datensatz.
			-->
			<de>
				Anwalt;Anwälte;m|
				Anwältin;Anwältinnen;f|
				Bäcker;Bäcker;m|
				Bäckerin;Bäckerinnen;f|
				König;Könige;m|
				Königin;Königinnen;f|
				Lehrer;Lehrer;m|
				Lehrerin;Lehrerinnen;f|
				Arzt;Ärzte;m|
				Ärztin;Ärztinnen;f
			</de>
		</werData>
		<maennl>${.if:${.eq:"${.csv:werData:2}":"m"}:"true":""}</maennl>
		<wer>
			<de>${.if:maennl:"Der":"Die"} ${.csv:werData:0}</de>
		</wer>
		<name>${.persongenerator:"firstname":"de":"${.csv:werData:2}"}</name>
		<wer_plural>
			<de>${.csv:werData:1}</de>
		</wer_plural>
		<pron_nom>
			<de>${.if:maennl:"seine":"ihre"}</de>
		</pron_nom>
		<pron_dat>
			<de>${.if:maennl:"seiner":"ihrer"}</de>
		</pron_dat>
		<adj>
			<de>|teuren |neusten |früheren </de>
		</adj>
		<was>
			<de>Autos|Liebschaften|Pferde|Probleme</de>
		</was>
	</variables>
...
```

Mit der Verwendung von Bedingungen in den Ausdrücken könnten weitere Variablen eingespart werden.

### globale Referenz auf Datenbankobjekte

Von beliebigen Stellen aus kann auf Personen, Rollen und Programme über deren in der Datenbank vergebenen GUID zugegriffen werden.
Hier nur ein paar Beispiele.
In `game.gamescriptexpression.bmx` kann man nachschauen, ob die vielleicht benötigte Information schon jetzt verfügbar ist.

* `${.person:"836b4aa3-b5c6-4529-b30d-4501594cdf13":"nickname"}` - Spitzname der Person mit der gegebenen ID
* `${.person:"3342a0e3-66f3-4f30-922c-ebe1b0611a00":"age"}` - Alter der Person
* `${.programme:"04439fd1-e89f-4922-a48e-6f8ddf96f7ab":"episodecount"}` - Anzahl Folgen der Serie
* `${.programme:"35190c1d-aa55-4e84-967f-72a374e84dcf":"year"}` - Erscheinungsjahr des Programms
* `${.programme:"02d0dfa5-dbcf-40b5-abb4-7e20a58d8efa":"cast":1:"fullname"}` - vollständiger Name der Besetzung mit Index 1 (wie bei den Referenzen auf die eigene Besetzung ist Index 0 typischerweise der erste Eintrag der Liste)
* `${.programme:"a61e7775-7565-48cd-ab4a-e5faea09d70d":"title"}` - Titel des Programms
* `${.role:"1d1f05ea-43ff-4399-81d9-f00239460700":"fullname"}` - vollständiger Name der Rolle
1d1f05ea-43ff-4399-81d9-f00239460700



### Zeichenkettenoperationen

Mit `.ucfirst:parameter` kann mann den ersten Buchstaben des Parameters in einen Großbuchstaben umwandeln.
Das ist hilfreich, wenn man Wörter für Satzanfang und Satzinneres nicht in zwei Varianten definieren möchte.