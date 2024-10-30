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
| thread_id | optional | ID des Nachrichtenthemas - Nachrichten die zusammengehören |
| creator | Metadaten optional | [Standardeigenschaft](main.md#creator) |
| created_by | Metadaten optional | [Standardeigenschaft](main.md#created_by) |
| comment |  informativ  |[Standardeigenschaft](main.md#comment) |

### Bedeutung der `thread_id`

Bis Version 0.8.0 war der Wert rein informativ und wurde nicht ausgewertet
Eine (identische) `thread_id` wurde typischerweise für Nachrichten einer zusammengehörigen Nachrichtenkette mit Startnachricht und Nachfolgenachrichten vergeben.
Ab Version 0.8.1 bekommt die `thread_id` eine weitere wichtige Bedeutung.

Nachrichten sind analog Drehbuchvorlagen eigentlich Vorlagen, aus denen die eigentlich ausstrahlbaren Nachrichten erzeugt werden.
Das Spiel markiert eine Vorlage, um sie nicht zu schnell wiederzuverwenden.
Ab Version 0.8.1 wird zusätlich die `thread_id` markiert.

Wenn sich also zwei Startnachrichten dieselbe `thread_id` teilen, blockiert die Auswahl der einen Nachricht die andere.
Auf diese Weise kann erreicht werden, dass nicht zu viele Nachrichten zum selben Thema gleichzeitig erscheinen.

## Kindelemente von news

Standardelemente für Titel [title](main.md#title), Beschreibung [description](main.md#description) sind sindvollerweise zu definieren, Variablen [variables](variables.md) sind nötig, wenn sie in Titel oder Beschreibung verwendet werden sollen und mit (zeitlicher) Verfügbarkeit [availability](time.md#Verfügbarkeit) kann man steuern, wann die Nachrichten veröffentlicht werden können.

Ab Version 0.8.1 werden die Variablen an angestoßene Nachrichten weitergegeben.
Das erlaubt es, Nachrichtenketten abwechslungsreicher zu gestalten, da gewürfelte Namen etc. damit auch in späteren Nachrichten konsistent verwendet werden können.
Dafür sollten alle verwendeten Variablen in der Startnachricht definiert werden.
Wenn die Variablendefinitionen der aktuellen und der Vorgängernachricht nicht zusammen passen, kann es zum Programmabruch kommen.

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
Die Syntax ist für Nachrichten-/Programm-/Drehbucheffekte gleich ([Effekte](main.md#effects)).

Für Nachrichteneffekte werden die folgenden Trigger unterstützt

* `happen`- der Effekt tritt in jedem Fall ein; z.B. Nachfolgenachrichten erscheinen, selbst wenn niemand die Nachricht gesendet hat.
* `broadcast` - der Effekt tritt zu Beginn *jeder einzelnen* Ausstrahlung ein
* `broadcastDone` - der Effekt tritt am Ende *jeder einzelnen* Ausstrahlung ein
* `broadcastFirstTime` - der Effekt tritt ein, sobald die Nachricht das erst Mal gesendet wird
* `broadcastFirstTimeDone` - der Effekt tritt am Ende der ersten Ausstrahlung ein (pro gestarteter Nachrichtenkette, also nicht nur einmal über die gesamte Spielzeit)

`broadcastFirstTime` würde man beispielsweise nutzen, wenn Nachfolgenachrichten nur verfügbar sein sollen, wenn der Auslöser gesendet wurde ("Bürger reagieren schockiert auf die Meldung...").
Wenn dieselbe Ursprungsnachricht zu einem späteren Zeitpunkt wieder erscheint, greift `broadcastFirstTime`-Effekt erneut.

`broadcast` könnte man nutzen, wenn sich eine Genreattraktivität bei jeder Ausstrahlung ändern soll.

Beispiel:

```
	<effects> 
		<effect trigger="happen" type="triggernews" time="1,2,3" news="ronny-news-drucktaste-02b1" />
		<effect trigger="happen" type="modifyNewsAvailability" enable="0" news="ronny-news-drucktaste-1" />
	</effects>
```

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

### Nachrichtenkette mit weitergegeben Variablen

Eine Hauptnachricht stößt eine Nachfolgenachricht an.
Die definierten Variablen werden an die Nachfolgenachrichten weitergegeben und bereits durchgeführte Ersetzungen konsistent verwendet.
Wird die Hauptnachricht später erneut gesendet, wird neu gewürfelt.

```
<news id="carStrike_0" thread_id="carStrike" type="0">
	<title>
		<de>${brand} schreibt Verluste</de>
		<en>${brand} records losses</en>
	</title>
	<description>...
	</description>
	<effects>
		<effect trigger="happen" type="triggernews" news="carStrike_1" time="1,8,12" />
	</effects>
	<data genre="3" price="1.0" quality="19" />
	<variables>
		<brand>
			<de>Fort|Bucki|Admiral Motors|Lilaccats|Abraham|Evade</de>
		</brand>
		<jobs>
			<de>4.000|5.000|6.000|7.500</de>
			<en>4,000|5,000|6,000|7,500</en>
		</jobs>
	</variables>
</news>
<news id="carStrike_1" thread_id="carStrike" type="2">
	<title>
		<de>${brand} will ${jobs} Stellen streichen</de>
		<en>${brand} to cut ${jobs} jobs</en>
	</title>
	<description>
		<de>Der Amerikanische Autokonzern will aufgrund der hohen Verluste ${jobs} Mitarbeiter entlassen.</de>
		<en>The American car company plans to lay off ${jobs} employees due to the high losses.</en>
	</description>
	...
</news>
```

Ein weiteres Beispiel für die Verwendung Variablen sind die Börsennachrichten (ID `news-stockexchange-generic`) in `user/kieferer.xml`.
Diese stoßen sich selbst wieder an.
In diesem Fall ist es zulässig, dass die Nachfolgenachrichten Variablendefinitionen enthalten.

## TODOs und Fragen

### Dokumentation

* Klären, welche Modifiers es überhaupt gibt und welche für Nachrichten unterstützt werden. (Ronny: über Modifier Wirkung einer Ausstrahlung auf X Stunden begrenzen)

### DB-Cleanup

* Es gibt viele Nachrichten, die nur einmalig verfügbar sind. Hier sollte nochmal analysiert werden, welche sich für häufigeres Senden eignen würden.
* Newsgenre prüfen (der Outline des Editors eignet sich, leicht das Genre zu erkennen)

### Generell

* Es gibt wenige Nachrichten, welche die Attraktivität von Genre oder Personen anpassen. Wenn Filmrollen mehr Verwendung finden würden, könnte auch die Attraktivität von Rollen angepasst werden (neuer Yams Pond-Film, Yams Pond-Darsteller verstorben) - (es werden bereits Ankündigungen für Kinofilme erzeugt)
* Verwendung von News-Flag 64 prüfen: Wenn eine Nachricht "unique" ist, kann sie ohnehin kein zweites Mal erscheinen, falls sie nicht "unique" ist, muss eine ggf. gesetzte happen_time nach der ersten Veröffentlichung in jedem Fall gelöscht werden (Flag redundant?)
* News-Flag 16/32 in Klärung, ob Flags zu einem zusammengefasst werden können; unterschiedliche Standardbehandlung für Initial- und Nachfolgenachrichten.