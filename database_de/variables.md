**TODO überarbeiten**

#### selbst definierte Variablen

Variablen sind ein gute Möglichkeit, Varianz zu erzeugen.
So kann der Kripoeinsatz in unterschiedlichsten Orten stattfinden.

```XML
...
	<title>
		<de>Kripo %CITY%</de>
	</title>
...
	<variables>
		<city>
			<de>Berlin|Bonn|Trier|%STATIONMAP:RANDOMCITY%</de>
		</city>
	</variables>
...
```

Die Variablenverwendung wird durch zwei den Variablennamen umschließende Prozentzeichen markiert `%VARIABLEN_NAME%`.
Die Variablen selbst und ihre möglichen Belegungen werden im Hauptknoten `variables` definiert, wobei für jede Variable wieder mehrere Sprachvarianten erlaubt sind.
Die unterschiedlichen Möglichkeiten für die Ersetzung der Variable verden durch senkrechte Striche `|` voneinander getrennt.
Im obigen Beispiel könnte das Ergebnis als "Kripo Berlin", "Kripo Bonn", "Kripo Trier" sein; oder der Name der Stadt wir zufällig erzeugt (siehe unten).
Das Beispiel zeigt, dass Variablendefinition selbst wieder Variablen enthalten können.

Ab Version 0.7.4 wird eine zweite Variablensyntax unterstützt `${VARIABLEN_NAME}`.
Diese hat den Vorteil, dass Beginn und Ende eindeutig unterscheidbar sind, was verschachtelte Variablen erlaubt `${varpraefix_${variant}}`.
Hird zunächst die Variante aufgelöst und bestimmt damit, welche "Hauptvariable" Verwendung findet.

```XML
...
	<title>
		<de>${wer_${variant}} und ${pronomen_${variant}} ${adj}${was}</de>
	</title>
...
	<variables>
		<variant>
			<de>maennl|weibl</de>
		</variant>
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