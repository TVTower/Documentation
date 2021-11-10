# Drehbuchvorlagen (scripttemplates)

Die Drehbuchvorlageneinträge sind als Liste von `scripttemplate`-Kindelementen in das `scripttemplates`-Tag eingebettet.

```XML
<scripttemplates>
	<scripttemplate product="1" licence_type="1" guid="scripttemplate-random-ron-foodformealtime01">
		<title>
			<de>%FOOD% zum %MEALTIME%</de>
			<en>%FOOD% for %MEALTIME%</en>
		</title>
		<description>
			<de>...</de>
			<en>...</en>
		</description>

	<variables>
			<food>
				<de>Kinder|Liebe|Joghurt</de>
				<en>Children|Love|Joghurt</en>
			</food>
			<mealtime>
				<de>Frühstück|Mittagessen|Abendessen|Brunch</de>
				<en>breakfast|lunch|dinner|brunch</en>
			</mealtime>
		</variables>

		<jobs>
			<job index="0" function="1" required="1" />
			<job index="1" function="2" required="1" gender="2" />
			<job index="2" function="2" required="1" gender="1" />
			<!-- there might be up to 2 additional roles without further specifications -->
			<job index="3" function="32" required="0" role_guid="script-roles-ron-001" />
			<job index="4" function="32" required="0" />
		</jobs>
		<genres maingenre="15" subgenres="5" />
		<blocks min="2" max="3" slope="30" />
		<price min="12000" max="17000" slope="60" />
		<potential min="50" max="70" slope="45" />
		<outcome min="25" max="35" slope="40" />
		<review min="45" max="65" slope="40" />
		<speed min="35" max="65" slope="50" />
	</scripttemplate>
```

Hier soll ein Film (`product`) als Einzellizenz (`licence_type`) gedreht werden können; ein Liebesfilm (`maingenre`) von zwei oder drei Stunden (`blocks`), der aber auch komödiantische Anteile hat (`subgenres`).
Der Titel könnte "Liebe zum Abendessen" aber auch "Joghurt zum Frühstück" lauten (`title` mit [Variablen](main.md#Variablen)).
Zwingend (`required=1`) werden ein Regisseur (`job index 0`), ein weiblicher und ein männlicher Hauptdarsteller benötigt (`job index 1,2`).
Es könnten aber auch noch zwei Nebendarsteller zum Drehen erforderlich sein; für einen der Nebendarsteller ist eine [Filmrolle](persons.md#Filmrollen) definiert (`role_guid`).
Der Preis (`price`) für das Drehbuch beträgt zwischen 12.000 (`min`) und 17.000 (`max`) mit leichter Tendenz zu einem höheren Preis (`slope`).
Die Bereiche für die Bewertung (Tempo etc.) sind am Ende des Eintrags definiert (durchschnittliche Kritikerbewertung und Tempo, schlechtes kommerzielles Ergebnis).
Aus dieser Vorlage wird vom Spiel dann das eigentliche Drehbuch mit konkreten Werten erzeugt, auf dessen Grundlage dann der Film gedreht werden kann.
Aus einer Vorlage können auch mehrere Drehbücher entstehen.
Wenn die Titel identisch sind, wird dieser um einen Zähler erweitert.

Der entscheidendste inhaltliche Unterschied zwischen Drehbuchvorlagen und "fertigen" Programmen ist die Verwendung von Variablen, um Varianz insb. im Titel zu erzeugen sowie die Definition der Besetzung.
Anstatt die Personen anzugeben, die beim Dreh dabei waren, werden die Anforderungen an die Besetzung definiert.
Auch werden die Bewertungskategorien (Tempo etc.) oft als Bereich angegeben.

## Eigenschaften von scripttemplate

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | [ID](main.md#id) |
| product | Pflicht  | [Programmtyp](main.md#Programmtyp) |
| licence_type | Pflicht | [Lizenztyp](main.md#Lizenztyp) |
| index | optional | Reihenfolge bei Serien |

## Kindelemente von scripttemplate

Standardelemente für Titel [title](main.md#title) und Beschreibung [description](main.md#description) sind sindvollerweise zu definieren.
Häufig werden auch Variablen [variables](main.md#Variablen) für Titel und Beschreibung eingesetzt.
Um die Verfügbarkeit des fertigen Drehbuchs einzuschränken, kann das [availability](time.md#Verfügbarkeit)-Element verwendet werden.

### Genre (genres)

Im Knoten `genres` können Hauptgenre (Pflicht) und optional Untergenres (kommasepariert) definiert werden.
Mögliche Werte sind die [Genres](main.md#Genre), die auch für Programme genutzt werden.

Beispiele:

* `<genres maingenre="4" />` Krimi
* `<genres maingenre="13" subgenres="2"/>` Monumentalfilm mit Actionelementen
* `<genres maingenre="7" subgenres="5,15"/>` komödiantisches Liebesdrama

### Benötigtes Personal (jobs)

Im Hauptknoten `jobs` kann eine Liste von Stellen (`job`) definiert werden, die für den Dreh besetzt werden müssen.
Folgende Eigenschaften sind pro `job` definierbar.

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| index | Pflicht | Reihenfolge in der Liste |
| function | Pflicht | [Job](main.md#Job) |
| required | Pflicht | Wahrheitswert; muss diese Stelle besetzt werden |
| gender | optional | Geschlecht |
| role_guid | optional | ID der [Rolle](person.md#Filmrollen) die hier besetzt wird |

Beispiele:

* `<job index="0" function="1" required="1" />` - Regisseur muss besetzt werden, Geschlecht nicht spezifiziert
* `<job index="1" function="2" gender="2" required="1" />` - weibliche Hauptdarstellerin muss besetzt werden
* `<job index="2" function="16" gender="1" required="0" />` - männlicher Gast könnte im fertigen Drehbuch dabei sein oder auch nicht

### Drehbuchdaten (data)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| flags | optional | definitiv verwendete [Programmflags](main.md#Programmflags) |
| flags_optional | optional | zufällig verwendete [Programmflags](main.md#Programmflags) |
| scriptflags | optional | Flags für diese Vorlage (ScriptFlags siehe unten) |
| production_licence_flags | optional | [Lizenzflags](main.md#Lizenzflags) |
| production_broadcast_flags | optional | [Ausstrahlungsflags](main.md#Ausstrahlungsflags) |
| production_broadcast_limit| optional | wie oft darf die Sendung ausgestrahlt werden |
| production_limit | optional | wieviele Folgen können produziert werden (z.B. Show ohne spezifizierte Folgen) |
| live_date | optional | [Zeit](time.md#Zeitattribute) der Ausstrahlung für Livesendungen |
| broadcast_time_slot_start | optional | Frühester Start des ersen Blocks |
| broadcast_time_slot_end | optional | Spätestes Ende des letzten Blocks |

Hier dürften `flags` und `flags_optional` für den Einfluss auf das Endergebnis am wichtigsten sein.
Produziert man eine Livesendung, sollte live_date definiert werden oder das Flag "immer live" gesetzt werden.

Definiert man bei Serien `flags_optional` im Haupteintrag, werden bei der eigentlichen Drehbucherstellung diese Flags einmal ermittelt und dann für alle Serienfolgen verwendet.
Bei einem optionalen Live-Flag sind dann also immer alle Folgen live oder keine.

Natürlich kann man `flags_optional` auch im `data`-Knoten eines Einzelfolge (innerhalb von `children`) definieren.
Der Zufallswert dieser Flags wird dann nur für diese Folge verwendet.
Damit kann man z.B. erreichen, dass nur eine Folge möglicherweise FSK-18 ist und nicht gleich die gesamte Serie.

### Ziel- und Lobbygruppen (groups)

Die Definition dieser Gruppen erfolgt genau so wie `groups` in den [Programmen](programmes.md#Ziel--und-Lobbygruppen-groups).

### (Zufalls-)Werte für das Drehbuch und Ergebnis

Für einige Eigenschaften kann ein fester Wert oder ein Bereich für zufällige Ermittlung definiert werden.
Der grundsätzliche Aufbau ist für feste Werte `<eigenschaft value="Wert" />` und für Zufallswerte `<eigenschaft min="MinWert" max="MaxWert" slope="SlopeWert" />`, wobei `slope` optional ist und der Zufallsverteilung zwischen minimalem und maximalem Wert steuert.
Für die folgenden Eigenschaften ist eine solche Definition möglich.

| Name | Beschreibung |
| ---- | ------------ |
| blocks | Länge des Programms in Stunden |
| price | Preis des Drehbuchs |
| potential | Potential des Drehbuchs |
| speed | Tempo |
| review | Kritikermeinung |
| outcome | kommerzieller Erfolg |
| studio_size | Größe des benötigten Studios |
| production_time | Basisdrehzeit in Minuten |
| episodes | Anzahl der Folgen bei Serien |

Beispiele:

* `<blocks value="3" />` - das Programm soll dann genau 3 Blöcke (Stunden) lang sein
* `<speed min="20" max="50" />` - das Programm soll ein Tempo zwischen 20 und 50 haben
* `<price min="10000" max="20000" slope="20" />` - der Preis soll zwischen 10.000 und 20.000 liegen aber zu billiger tendieren

`episodes` kann in zwei verschiedenen, sich ausschließenden Varianten verwendet werden.
Eine Definition in der Hauptdrehbuchvorlage schränkt die Anzahl der Folgen ein.
Man definiert also z.B. 12 mögliche Kindvorlagen und sagt aber, dass nur 5 bis 8 zu einer Serie gehören sollen.
Die erste Vorlage (für die Pilotfolge) wird dabei nie aussortiert; die Reihenfolge bleibt unverändert.
Der zweite Anwendungsfall ist die Definition von `episodes` in einer oder mehrerer Kindvorlagen.
Bei der Erstellung des eigentlichen Drehbuchs werden aus der Kindvorlage dann entsprechend viele Folgen (auch 0 ist erlaubt).

Wenn also nicht immer alle der definierten Folgen erzeugt werden sollen, hat man zwei Möglichkeiten: Einschränkung der Gesamtanzahl im Hauptknoten oder Folgen, die weggelassen werden können, mit `<episodes min="0" max="1" />` konfigurieren.


### Serienfolgen (children)

Im Hauptknoten `children` kann eine Liste Vorlagen für Folgen ( wieder als `scripttemplate`-Knoten) definiert werden. Bei diesen muss dann die Eigenschaft `index` definiert werden.

## spezifische Werte für scripttemplate

| **ScriptFlags** | Bedeutung |
| ---- | --------- |
| 1 | kann gehandelt werden |
| 2 | automatischer Verkauf wenn Produktionslimit erreicht ist |
| 4 | automatische Entfernung wenn Produktionslimit erreicht ist  |
| 8 | Produktionslimit wird bei Rückgabe zurückgesetzt |
| 16 | bei Rückgabe werden die Werte für Tempo etc. zufällig verändert|
| 32 | nach Rückgabe kann die Vorlage nicht wieder erworben werden |

(Quellcode: `TVTScriptFlag`)

## Beispiele

### Show

```XML
<scripttemplate product="3" licence_type="1" guid="scripttemplate-ron-morningshow">
			<title>
				<de>Goldene Morgenstunden</de>
			</title>
			<description>
				<de>Aufgewacht ...</de>
			</description>

			<jobs>
				<job index="0" function="1" required="1" />
				<job index="1" function="8" required="1" />
				<job index="2" function="8" required="0" />
				<job index="3" function="16" required="0" />
			</jobs>

			<genres maingenre="103" subgenres="9" />
			<blocks value="3" />
			<price min="3000" max="5000" slope="60" />
			<potential min="40" max="60" slope="45" />
			<outcome min="30" max="50" slope="40" />
			<review min="40" max="50" slope="40" />
			<speed min="45" max="60" slope="50" />
			<!-- live whenever first broadcastd -->
			<!-- licence flags: 4 + 32 (REMOVE_ON_REACHING_BROADCASTLIMIT + LICENCEPOOL_REMOVES_TRADEABILITY) -->
			<data flags="1" broadcast_time_slot_start="5" broadcast_time_slot_end="10" production_limit="4" production_broadcast_limit="1" production_broadcast_flags="512" production_licence_flags="36" />
		</scripttemplate>
```

Der interessante Teil an dieser Show (`product`) ist der `data`-Knoten.
Es handelt sich im eine Liveshow (`flags`), deren Ausstrahlung zwischen 5 Uhr und 10 Uhr stattfinden muss (`broadcast_time_slot_X`), frühestens am Folgetag (`live_date`), in diesem Zeitraum aber immer live ist (`production_broadcast_flags`).
Es können vier Sendungen (`production_limit`) produziert werden (ohne explizite Definition von `children`!), aber es darf dann je Sendung nur eine Ausstrahlung geben (`production_broadcast_limit`).
Danach verschwindet die Show und ist nie wieder verfügbar (`production_licence_flags`).

### Serie

```XML
<scripttemplate product="2" licence_type="3" guid="TheRob-script-ser-dram-TVTintern">
	<title>
		<de>TVTs: %OBJECT% im Hochhaus</de>
		<en>TVTs: %OBJECT% In A Skyscraper</en>
	</title>
	<description>
		<de>Serie über %OBJECT% im TV Tower Hochhaus</de>
		<en>Series about %OBJECT% In The TV Tower Skyscraper</en>
	</description>
	<children>
		<scripttemplate index="0" product="2" licence_type="2" guid="TheRob-script-ser-dram-TVTintern-Ep1">
			<title>
				<de>TVTs Pilot</de>
				<en>TVTs Pilot</en>
			</title>
			<blocks min="2" max="4" />
		</scripttemplate>
		...
		<scripttemplate index="2" product="2" licence_type="2" guid="TheRob-script-ser-dram-TVTintern-Ep3">
			<title>
				<de>%ATTRIBUTE% macht eine Party</de>
				<en>%ATTRIBUTE% Invites To the Party</en>
			</title>
		</scripttemplate>
		...
	</children>
	<variables>
		<attribute>
			<de>Die FR Duban|Die VR Duban</de>
			<en>The FR Duban|The VR Duban</en>
		</attribute>
		<object>
			<de>Intrigen|Hinterhalte|Wettkämpfe|...</de>
			<en>Intrigues|Ambushes|Competitions|...</en>
		</object>
	</variables>
	<jobs>
		<job index="0" function="1" required="1"  />
		<job index="1" function="2" required="1" gender="2" />
		...
		<job index="5" function="32" required="0" />
		...
	</jobs>
	<data flags="8" flags_optional="50" />
	<genres maingenre="7" subgenres="9" />
	<episodes min="9" max="12" />
	<blocks value="1" />
	<price min="95000" max="99000" />
	<potential min="50" max="90" slope="45" />
	<outcome min="75" max="95" slope="40" />
	<review min="45" max="85" slope="55" />
	<speed min="35" max="85" slope="50" />
</scripttemplate>
```

Diese Serie (`product` und `licence_type` im Hauptelement) hat mehrere Folgen (`children` mit anderem `licence_type`!).
Es ist eine Dramaserie, kann aber als Untergenre auch eine Familienserie sein.
Es ist eine Kultserie (`flags`), kann aber auch B-Movie/Trash/Animation sein (`flags_optional`).
Die Folgen können abweichende Attribute definieren (`blocks` im Pilotfilm).
Ansonsten erben sie die Daten des Hauptknotens.
(Eine Sonderstellung nimmt hier `flags_optional` ein.
Hier erbt die Folge nicht welche Flags optional sein können, sondern tatsächlich den final ermittelten zufälligen Flag-Wert.
Damit soll erreicht werden, dass die Serie konsistent ist - alle Folgen live oder Trash.
Möchte man unterschiedliche Werte für die Folgen erreichen, definiert man `flags_optional` für die Einzelfolgen.)
Die Folgen können unterschiedliche Besetzungen haben (`job reqired="0"`).
Mit einem Preis von 95.000-99.000 pro Folge ist das Drehbuch nicht gerade preiswert, dafür liegen die Bewertungen auch vergleichsweise hoch.
Aus den vorhandenen Kindvorlagen (`children`) werden 9 bis 12 für das Drehbuch ausgewählt, wobei die erste Folge immer dabei ist (`episodes`).

### Live-Programme

TODO

## TODOs und Fragen

### Generell

* im Code werden in script-data noch `keywords`, `live_time`, `production_time_mod` eingelesen; (nicht in DB verwendet, noch nicht in Grammatik)
* episodes-Anzahl auswerten (Serie ohne children definieren und Episodenanzahl angeben)