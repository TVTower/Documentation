# Nachrichten (news)

Die Nachrichteneinträge sind als Liste von `news`-Kindelementen in das `allnews`-Tag eingebettet.

```XML
<allnews>
		<news id="X-news-geld1" thread_id="X-news-geld" type="0">
			<title>
				<de>Straßenfeger findet 1.000 Mark</de>
				<en>Street sweeper finds 1,000 marks</en>
			</title>
			<description>
				<de>Besser hätte der Morgen ...</de>
				<en>The morning couldn't ...</en>
			</description>
			<effects>
				<effect trigger="happen" type="triggernews" news="X-news-geld2" time="1,10,15" />
			</effects>
			<data genre="4" price="1.4" quality="19" />
			<availability year_range_from="-1" year_range_to="2001" />
		</news>
</allnews>
```

Diese bis 2001 verfügbare (`year_range_to`) überteuerte (`price`) Tagesgeschehennachricht (`genre`) von niedriger Qualität (`quality`) hat deutsche und englische Titel und Nachrichtentexte (`title`, `description`) und stößt (`effect`) in 10 bis 15 Stunden (`time`) die Nachfolgenachricht mit der ID X-news-geld2 an.
(In diesem aus der Datenbank leicht angepassten Beispiel hätte man auch die Jahresbeschränkung weglassen und stattdessen die Währung über die globale Währungsvariable verwenden können.)

## Eigenschaften von news

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| id | Pflicht | [ID](main.md#id), insb. für Referenzierung bei Nachfolgenachrichten |
| type | Pflicht | Nachrichtentyp; siehe unten 0=Startnachricht, 2=Nachfolgenachricht |
| thread_id | informativ | ID des Nachrichtenthemas - Nachrichten die zusammengehören |
| creator | Metadaten optional | [Standardeigenschaft](main.md#creator) |
| created_by | Metadaten optional | [Standardeigenschaft](main.md#created_by) |

## Kindelemente von news

Standardelemente für Titel [title](main.md#title), Beschreibung [description](main.md#description) sind sindvollerweise zu definieren, Variablen [variables](main.md#Variablen) sind nötig, wenn sie in Titel oder Beschreibung verwendet werden sollen und mit (zeitlicher) Verfügbarkeit [availability](time.md#Verfügbarkeit) kann man steuern, wann die Nachrichten veröffentlicht werden können.

### Daten (data)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| genre | Pflicht | Genre; Werte 0-5, siehe unten |
| price | Pflicht | Preis*faktor*; z.B. 1, 0.4, 0.9 oder 1.5 |
| quality | Pflicht* | Qualität; Werte nat. Zahlen 0-100 |
| flags | optional | siehe unten; häufigster Anwendungsfall "2": Nachricht steht nur einmalig zur Verfügung |
| happen_time | optional | Nachricht muss zur definierten [Zeit](time.md#Zeitattribute) erscheinen |
| min_subscription_level | optional | Abolevel (1,2,3), ab dem die Nachricht verfügbar ist |
| keywords | optional | Schlüsselbegriffe, die durch die KI für die Erkennung von Nachrichten von Nachrichten verwendet werden kann |
| available | optional |  Wahrheitswert - ist die Nachricht verfügbar |
| fictional | informativ | [Standardeigenschaft](main.md#fictional) |

Anstelle von `quality` können auch `quality_min`, `quality_max` und `quality_slope` definiert werden.
Dadurch erhält die Nachricht eine zufällige Qualität im Bereich zwischen min und max (siehe auch [Drehbuchwerte](scripts.md#zufalls-werte-für-das-drehbuch-und-ergebnis)).

Die Eigenschaft `available` ist im Zusammenhang mit dem Effekttyp `modifyNewsAvailability` interessant.
Man kann einen Nachrichtenstrang initial deaktiviert anlegen und ihn dann durch eine andere Nachricht aktivieren.

Im Gegensatz zur Verfügbarkeit (`availability`), die steuert, wann eine Nachricht erscheinen könnte, wird die Veröffentlichung durch `happen_time` erzwungen; ist aber nur für Erstnachrichten sinnvoll, da Nachfolgenachrichten durch die im Effekt definierte Zeit gesteuert werden können.

Beispiel: `... happen_time="4,1995,3,7,14,25"...`

`keywords` wird aktuell für die Terroristen betreffende Nachrichten und Wetterberichte verwendet.
In der Datenbank werden sie noch nicht vergeben, könnten dann für Erfolge genutzt werden.

### Effekte (effects)

Das dürfte das interessanteste Element für die Nachrichten sein, denn über die Effekte lassen sich z.B. Nachfolgenachrichten anstoßen oder die Beliebtheit von Genre oder Personen beeinflussen.
Im Hauptknoten `effects` kann eine Liste von Einzeleffekten (`effect`) definiert werden, die angestoßen werden, wenn eine Nachricht veröffentlicht wird.
Für alle Effekttypen können die folgenden Eigenschaften definiert werden:

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| trigger | Pflicht | siehe unten |
| type | Pflicht | mögliche Werte siehe unten; am häufigsten "triggernews" - Nachfolgenachricht anstoßen |
| time | optional | wann findet der Effekt statt; Format siehe [Zeitsteuerung](time.md#Zeitattribute) |
| probability | optional | Wahrscheinlichkeit für das Eintreten dieses Effekts |

Ein `effect`-Knoten hat immer die Eigenschaft `trigger`, die steuert, unter welcher Bedingung der Effekt eintritt. Die anderen Felder hängen vom Effekttyp `type` ab.
Die häufigsten Zeitsteuerungsvarianten sind 1 (`"1,3,7"` - in 3 bis 7 Stunden), 2 (`"2,1,2,6,14"` - in 1 bis 2 Tagen zwischen 6 und 14 Uhr).
Die `probability` liegt zwischen 0 und 100 (falls nicht definiert, wird 100 angenommen).

#### trigger

Die Eigenschaft `trigger` hat einen festen Wertebereich.
Folgende Werte werden unterstützt.

* `happen`- der Effekt tritt in jedem Fall ein; z.B. Nachfolgenachrichten erscheinen, selbst wenn niemand die Nachricht gesendet hat.
* `broadcast` - der Effekt tritt zu Beginn *jeder einzelnen* Ausstrahlung ein
* `broadcastDone` - der Effekt tritt am Ende *jeder einzelnen* Ausstrahlung ein
* `broadcastFirstTime` - der Effekt tritt ein sobald die Nachricht das erst Mal gesendet wird
* `broadcastFirstTimeDone` - der Effekt tritt am Ende der ersten Ausstrahlung ein (pro gestarteter Nachrichtenkette, also nicht nur einmal über die gesamte Spielzeit)

Beispiel: `... trigger="happen" ... `

`broadcastFirstTime` würde man beispielsweise nutzen, wenn Nachfolgenachrichten nur verfügbar sein sollen, wenn der Auslöser gesendet wurde ("Bürger reagieren schockiert auf die Meldung...").
Wenn dieselbe Ursprungsnachricht zu einem späteren Zeitpunkt wieder erscheint, greift `broadcastFirstTime`-Effekt erneut.

`broadcast` könnte man nutzen, wenn sich eine Genreattraktivität bei jeder Ausstrahlung ändern soll.

#### `type="triggernews"`

Es wird *eine* Nachfolgenachricht angestoßen.
Der Wert von `news` (für diesen Typ Pflicht) enthält die ID der angestoßenen Nachfolgenachricht.

`<effect trigger="happen" type="triggernews" news="ronny-news-drucktaste-02b1" />`

#### `type="triggernewschoice"`

Um unterschiedliche Verläufe in Nachrichtenketten zu ermöglichen kann man mit diesem Effekttyp *eine* der aufgelisteten Nachrichten anstoßen.
Je Nachricht kann eine Wahrscheinlichkeit angegeben werden.

`<effect trigger="happen" type="triggernewschoice" choose="or" news1="newsId1" probability1="30" news2="newsId2 probability2="70" />`

Im aktuellen Datenbestand werden bis zu vier Nachfolgenachrichten verwendet (`news1...news4, probability1...probability4`).
Laut Quellcode `Init:TGameModifierNews_TriggerNews` könnten auch unterschiedliche Triggerzeiten (`time1...time4`) angegeben werden.
Davon wird aktuell aber kein Gebrauch gemacht (Fallback auf dieselbe Zeite `time` für alle Nachfolgenachrichten.)

#### `type="modifyPersonPopularity"`

Es wird die Beliebtheit der referenzierten Person angepasst.

* `<effect trigger="happen" type="modifyPersonPopularity" referenceGUID="personId" valueMin="0.1" valueMax="0.2" />` - 
die Beliebtheit von der Persion mit der ID personId wird unabhängig von der Ausstrahlung der Nachricht um einen Wert zwischen 0.1 und 0.2 angepasst.
* `<effect trigger="broadcast" type="modifyPersonPopularity" referenceGUID="personId" valueMin="0.02" valueMax="0.05" />` - 
die Beliebtheit von der Persion mit der GUID personId wird bei jeder Ausstrahlung der Nachricht um einen Wert zwischen 0.02 und 0.05 angepasst.

#### `type="modifyMovieGenrePopularity"`

Es wird die Beliebtheit des angegebenen Genres angepasst.

* `<effect trigger="happen" type="modifyMovieGenrePopularity" genre="13" valueMin="0.5" valueMax="2.0" />`- die Beliebtheit von Monumentalfilmen wird unabhängig von der Ausstrahlung der Nachricht um einen Wert zwischen 0.5 und 2 angepasst.
* `<effect trigger="broadcastFirstTime" type="modifyMovieGenrePopularity" genre="3" valueMin="0.2" valueMax="0.7" />`- die Beliebtheit von Trickfilmen wird bei der ersten Ausstrahlung der Nachricht um einen Wert zwischen 0.2 und 0.7 angepasst.

#### `type="modifyNewsAvailability"`

Es wird der Verfügbarkeitsstatus einer Nachricht angepasst.

* `<effect trigger="happen" type="modifyNewsAvailability" enable="1" news="ronny-news-drucktaste-1" />`- die Eigenschaft `available` (verfügbar) der Nachricht mit der ID "ronny-news-drucktaste-1" wird auf Ja gesetzt.
* `<effect trigger="happen" type="modifyNewsAvailability" enable="0" news="ronny-news-drucktaste-1" />`- die Eigenschaft `available` (verfügbar) der Nachricht mit der ID "ronny-news-drucktaste-1" wird auf Nein gesetzt.

### Zielgruppenattraktivität (targetgroupattractivity)

Siehe [Standardkindelement](main.md#targetgroupattractivity).
Aktuell kommen noch keine Beispiele in der Datenbank vor.

### Wertanpassungen (modifiers)

Siehe [Standardkindelement](main.md#modifiers).
Aktuell kommen noch keine Beispiele in der Datenbank vor.

## spezifische Werte für news

| **NewsType** | Bedeutung |
|------------- | --------- |
| 0 | InitialNews - erste Nachricht einer Kette |
| 1 | InitialNewsByInGameEvent - erste Nachricht durch Spiel ausgelöst |
| 2 | FollowingNews - Nachfolgenachricht |
| 3 | TimedNews - zeitgesteuerte Nachricht |

Typ 1 wird nur spielintern verwendet und Typ 3 ist obsolet durch Möglichkeiten, die Verfügbarkeit der Nachrichten zu steuern.

| **Genre** | Bedeutung |
|---------- | --------- |
| 0 | Politik/Wirtschaft |
| 1 | Showbiz |
| 2 | Sport |
| 3 | Medien/Technik |
| 4 | Tagesgeschehen |
| 5 | Kultur |

| **NewsFlag** | Bedeutung |
|------------- | --------- |
| 1 | sendImmediately | Nachricht steht ohne Verzögerung bereit |
| 2 | uniqueEvent | einmalige Nachricht; sie wird kein zweites Mal veröffentlicht |
| 4 | unskippable | wenn niemand die Nachricht erhalten würde (Abolevel) wird sie dennoch veröffentlicht |
| 8 | sendToAll | Nachricht wird unabhängig vom Abolevel an alle verschickt |
| 16 | keepTickerTime | andere Nachrichten des Genres *nicht* verzögern (Flag insb. für Initialnachrichten)|
| 32 | resetTickerTime | andere Nachrichten des Genres *werden* verzögert (Flag insb. für Nachfolgenachrichten) |
| 64 | resetHappenTime | initial gesetzte happen_time wegen Wiederverwendbarkeit der Nachricht *dann* ignorieren |
| 128 | specialEvent | besondere Nachricht - optische Hervorhebung |
| 256 | invisibleEvent | unsichtbare Nachricht - nur Effekte werden ausgeführt |

Die Newsflags sind ein Flagwert, d.h. in einer Zahl können mehrere Werte kodiert werden.
Dafür addiert man die Werte auf.
`flags="138"` wäre eine einmalige Nachricht, die allen Spielern zur Verfügung steht, selbst wenn sie das Genre nicht abonniert haben. Sie wird zudem optisch hervorgehoben.

## Beispiele

### minimal 

Teure Kulturnachricht geringer Qualität ohne Einschränkungen der Verfügbarkeit oder Effekte.

```XML
<news id="ronny-news-tarotimwandel-01" type="0" creator="5578" created_by="Ronny">
	<title>
		<de>"Tarot im Wandel der Zeit" auf Tour</de>
		<en>"Tarot in the course of time" on tour</en>
	</title>
	<description>
		<de>Die Ausstellung der "Zunft" ...</de>
		<en>The exhibition of the "guild" ...</en>
	</description>
	<data genre="5" price="1.2" quality="23" />
</news>
```

### einfach

Eine zwischen 2001 und 2009 verfügbare Politiknachricht stößt eine Nachfolgenachricht an, deren Typ `type="2"` anzeigt, dass sie nicht beim zufälligen Ermitteln möglicher Nachrichten zur Verfügung steht.

```XML
<news id="6b1065dd-36d5-4b4b-9904-1a8b7fd1d9c1" thread_id="0328d075-c155-43c9-b0c1-e130eb972f38" type="0" creator="">
	<title>
		<de>Terrorismusbekämpfung im Weltall</de>
		<en>Fighting terrorism in the universe</en>
	</title>
	<description>
		<de>US-Präsident Baush ...</de>
		<en>For safety reasons ...</en>
	</description>
	<effects>
		<effect trigger="happen" type="triggernews" news="7c2911a9-c9b4-40d1-b4f6-02fb0025358a" />
	</effects>
	<data genre="0" price="1.0" quality="58" />
	<availability year_range_from="2001" year_range_to="2009" />
</news>

<news id="7c2911a9-c9b4-40d1-b4f6-02fb0025358a" thread_id="0328d075-c155-43c9-b0c1-e130eb972f38" type="2" creator="">
	<title>
		<de>Terrorismusbekämpfung – jetzt 2 Shuttles</de>
		<en>Fighting terrorism - now 2 shuttles</en>
	</title>
	...
</news>
```

### komplex

Eine Hauptnachricht stößt eine von vier möglichen Nachfolgenachrichten mit unterschiedlicher Wahrscheinlichkeit an.

```XML
<news id="news-jorgaeff-racing-01" type="0" thread_id="news-jorgaeff-racing" creator="8936" created_by="jorgaeff">
	<title>
		<de>Formel X: Wer holt sich die Fahrer-WM?</de>
	</title>
	<description>
		<de>Zu einem Dreikampf...</de>
	</description>
	<data genre="2" price="0.45" quality="45" fictional="True" />
	<effects>
		<!-- "möglicher Effekt: Live-Übertragung" -->
		<!-- "morgen 6-12 Uhr / News a, b, c oder d" -->
		<effect trigger="happen" type="triggernewschoice" choose="or" probability="100" time="2,1,1,6,12"
			news1="news-jorgaeff-racing-02a" probability1="30"
			news2="news-jorgaeff-racing-02b" probability2="30"
			news3="news-jorgaeff-racing-02c" probability3="30"
			news4="news-jorgaeff-racing-02d" probability4="10"
		/>
	</effects>
</news>
```

Ein Beispiel für die Verwendung Variablen sind die Börsennachrichten (ID `news-stockexchange-generic`) in `user/kieferer.xml`.

## TODOs und Fragen

### Dokumentation

* Klären, welche Modifiers es überhaupt gibt und welche für Nachrichten unterstützt werden. (Ronny: über Modifier Wirkung einer Ausstrahlung auf X Stunden begrenzen)
* data: `available` nicht verwendet oder dokumentiert, könnte aber genutzt werden, um mittels Effekt mehrere unabhängige Nachrichten als verfügbar zu markieren; eine andere Nachricht könnte diese Markierung wieder entfernen - zu klären, wie ein Effekt nur die Verfügbarkeit von Nachrichten setzen kann; siehe auch TGameModifierNews_ModifyAvailability

### DB-Cleanup

* Es gibt viele Nachrichten, die nur einmalig verfügbar sind. Hier sollte nochmal analysiert werden, welche sich für häufigeres Senden eignen würden.
* Newsgenre prüfen (der Outline des Editors eignet sich, leicht das Genre zu erkennen)
* ggf. Börsennachrichten anpassen; sauberere Trennung von initialem Anstoßen und Nachfolgenachricht (funktioniert nicht wie erwartet)

### Generell

* Es gibt wenige Nachrichten, welche die Attraktivität von Genre oder Personen anpassen. Wenn Filmrollen mehr Verwendung finden würden, könnte auch die Attraktivität von Rollen angepasst werden (neuer Yams Pond-Film, Yams Pond-Darsteller verstorben) - (es werden bereits Ankündigungen für Kinofilme erzeugt; die mir aber noch nicht aufgefallen sind...)
* News-Flag 64 ist inhaltlich redundant: Wenn eine Nachricht "unique" ist, kann sie ohnehin kein zweites Mal erscheinen, falls sie nicht "unique" ist, muss eine ggf. gesetzte happen_time ignoriert werden.
* News-Flag 16/32 in Klärung, ob Flags zu einem zusammengefasst werden können; unterschiedliche Standardbehandlung für Initial- und Nachfolgenachrichten.