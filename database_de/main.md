# Die TVTower-Datenbank

Die für TVTower verwendeten Daten befinden auf mehrere Dateien aufgeteilt sich im Verzeichns `res/database/`.
Grundsätzlich könnten mehrere Datenbanken unterstützt werden.
Die Standarddatenbank befindet sich im Unterverzeichnis `Default`.
Die Daten sind in einer [XML-Struktur](main.md#allgemeiner-Aufbau-eines-Elements) hinterlegt.
Der typische Start in die Erstellung eigener Einträge dürfte darin bestehen, vorhandene Elemente aus dem einem bekannten Spielgeschehen zu suchen, die dem gewünschten Verhalten besonders nahe sind, diese zu kopieren und anzupassen.
Es empfielt sich, eigene Inhalte in einer neuen Datei im `user`-Unterverzeichnis zu sammeln.

Kurzer Hinweis zu Titeln, Personennamen etc.: diese sind für das Spiel - soweit nicht ohnehin frei erfunden - absichtlich abgeändert, um rechtlichen Problemen aus dem Weg zu gehen.
Zur Suche, Wiedererkennung und Vermeidung von Dopplungen in der TVTower-Datenbank sind aber zum Teil Filmdatenbank-IDs und Originalnamen hinterlegt.

Für die Version 0.8.3 hat ein großer Umbau bezüglich [Variablen](variables.md) stattgefunden.
Zukünftige Versionen unterstützen das alte Format nicht mehr und eigene Datenbank-Dateien müssen auf das neue Format umgestellt werden.

## Grundsätzliche Struktur einer TVTower-Datenbankdatei

```XML
<?xml version="1.0" encoding="utf-8"?>
<tvtdb>
	<version value="3" comment="optionaler Kommentar"/>
	<!-- nun folgen die eigentlichen Daten-->

	<!-- Nachrichten -->
	<allnews>
		...
	</allnews>

	<!-- Werbung -->
	<allads>
		...
	</allads>

	<!-- Programme -->
	<allprogrammes>
		...
	</allprogrammes>

	<!-- usw.-->
</tvtdb>
```

Nach dem XML-Header sind alle Elemente im `tvtdb`-Tag eingebettet.
Nach einem Knoten für die Versionsinformation folgen die möglichen Kindlisten.
Jede Kindliste kann - muss aber nicht - in einer Datei vorkommen.
Diese Dokumentation beschreibt das Format der aktuell verwendeten Datenbankversion 3.

### Kindelemente von tvtdb

Die folgende Tabelle enthält alle möglichen Hauptknoten einer Datenbank.
Die Struktur ihrer Kindelemente ist separat dokumentiert.

| Tag | Link zur Dokumentation |
| --- | ---------------------- |
| allads | [Werbung](ads.md) |
| allnews | [Nachrichten](news.md) |
| allachievements | [Erfolge](achievements.md) |
| allprogrammes | [Programme](programmes.md)
| scripttemplates | [Drehbuchvorlagen](scripts.md)
| celebritypeople | [Hauptpersonen](persons.md#Hauptpersonen) - mit vielen hinterlegten Daten |
| insignificantpeople | [Nebenpersonen](persons.md#Nebenpersonen) - nur mit den notwendigsten Daten|
| programmeroles | [Filmrollen](persons.md#Filmrollen)|

Jeder dieser Hauptknoten ist optional, d.h. eine Datenbankdatei kann nur Werbung enthalten oder aber sämtliche Daten.

## Sprachspezifische Namen

Die Übersetzung von Titeln und Beschreibungen erfolgt direkt in der jeweiligen Datenbankstruktur.
Das Datenbankformat für Personen und Rollen erlaubt das nicht analog.
Wenn im Einzelfall Übersetzungen nötig sein sollten, können die in [separaten Dateien](lang.md) hinterlegt werden.

## von mehreren Elementen verwendete Strukturen

Manche Eigenschaften oder Kindunterstrukturen kommen an verschiedenen Stellen vor.
Die folgenden Beschreibungen werden dann von anderen Stellen der Dokumentation aus referenziert.

### Standardeigenschaftem

#### guid

`guid` ist die Eigenschaft, mit der ein Element global eindeutig identifiziert wird.
Ein für die Eindeutigkeit hilfreiches Schema ist `Autor-Typ-Titel` (z.B. `jim-news-homerun` oder `david-programme-Yfiles-season1-episode3`).

Technisch wird zwischen einer programminternen numerischen ID und einer textbasierten GUID unterschieden.
In der Datenbank wird die GUID definiert, weshalb in der Dokumentation vereinfachend oft nur ID steht.

#### creator

`creator` ist eine optionale, informative Eigenschaft, die den (oder die) Ersteller des Eintrags identifiziert.
Verwendet wird hier die Forums-ID.
Beispiel: `... creator="5578" ... `

#### created_by

`created_by` ist die optionale Eigenschaft, die einen lesbaren Namen des Erstellers enthält.
In der `DEV.xml`-Konfiguration, die für den Start eines neuen Spiels verwendet wird, kann eingeschränkt werden, welche Elemente von welchem Ersteller eingelesen oder ausgeschlossen werden sollen.
Beispiel: `... created_by="Ronny" ...`

#### comment

`comment` ist die optionale, informative Eigenschaft, in der man einen Kommentar hinterlegen kann.
Beispiel: `... comment="ist mir beim Duschen eingefallen" ...`

#### fictional

`fictional` ist ein Wahrheitswert und sagt aus, ob es sich um einen ausgedachten Eintrag handelt.
Mögliche Werte sind `1` (ja ausgedacht) und oder `0` (nein real).
Beispiel: `... fictional="1" ...`

In manchen Fällen ist die Information eher informativ, in anderen hat sie Auswirkung auf das Spielverhalten (z.B. kein Randomisieren der Geburtsdaten echter Personen).

#### tmdb_id

`tmdb_id` ist die ID des Programms oder der Person in der Filmdatenbank [The Movie Database](https://www.themoviedb.org/).

#### imdb_id

`imdb_id` ist die ID des Programms oder der Person in der Filmdatenbank [IMDb](https://www.imdb.com/).

### Aufbau von "Sprache"-Einträgen

Für Daten in unterschiedlichen Sprachen werden als Kindelemente des Hauptknotens die jeweiligen Übersetzungen angegeben.
Allgemein sieht ein Eintrag wie folgt aus:

```XML
<tag>
	<sprache1>Text in Sprache 1</sprache1>
	<sprache2>Text in Spraceh 2</sprache2>
</tag>
```

oder am Beispiel eines Filmtitels

```XML
<title>
	<de>Die Locken Horror Show</de>
	<en>The curly horror show</en>
</title>
```

Die aktuell verwendeten Sprachen sind Deutsch (de), Englisch (en) und Polnisch (pl).
Langfristig muss es dabei aber nicht bleiben.
Spracheinträge können auch Variablen enthalten - diese werden aber in einem [separaten Abschnitt](variables.md) beschrieben.

Seit der Umstellung ab Version 0.8.3 auf die neue Variablensyntax (`${...}` statt `%...%`) sind Alternativen (`Variante 1|Variante 2`) nur noch in Variablendefinitionen und nicht mehr direkt im Titel der in der Beschreibung erlaubt.

### Standardkindelemente

#### title

Der `title`-Knoten enthält Titel von Drehbuchvorlagen, Filmen etc.
Es werden unterschiedliche Sprachen und [Variablen](variables.md) unterstützt.

```XML
<title>
	<de>Reise nach ${WHERE}</de>
	<en>Voyage to ${WHERE}</en>
</title>
```

Soll ein Title in allen Sprachen komplett identisch sein kann die verkürzte Schreibweise ohne Einzelsprachtags verwendet werden.

```XML
<title>[li3o9n8e0l1]</title>
```

Achtung: sind Variablen involviert, die für verschiedene Sprachen unterschiedliche Werte liefern sollen, kann die verkürzte Schreibweise **nicht** verwendet werden.
`<title>${showname}</title>` würde in allen Sprachen denselben Wert liefern, auch wenn die Variablendefinition Übersetzungen enthält.
Hier muss die ausführliche Variante verwendet werden.

```XML
<title>
	<de>${showname}</de>
	<en>${showname}</en>
</title>
```

#### description

Der `description`-Knoten enthält eine Beschreibung. Beispiel:

```XML
<description>
	<de>Wie analysiere ich die Industriekraft...</de>
	<en>How to analyse the industrial power...</en>
</description>
```

Auch hier gelten die Hinweise zu [Variablen](variables.md) und Kurzschreibweise wie beim Titel.

#### text

Der `text`-Knoten enthält einen Text.
Auch hier werden unterschiedliche Sprachen und [Variablen](variables.md) unterstützt.

#### availability

Siehe [Verfügbarkeit](time.md#Verfügbarkeit) in der Beschreibung von Zeitdefinitionen.

#### targetgroupattractivity

Hier kann  für einzelne Zielgruppen ein Attraktivitätsfaktor (zwischen 0 und 2) angegeben werden.
Durch den suffix `_male` und `_female` an der Zielgruppe kann zusätzlich auf die männlichen/weiblichen Vertreter eingeschränkt werden.
Die Zielgruppennamen sind: `teenagers`, `managers`, `housewives`, `employees`, `women`, `men`, `pensioners`, `unemployed`.

Beispiel: `<targetgroupattractivity teenagers_male="0.7" pensioners="1.6" />` - geringere Attraktivität für männliche Jugendliche, höhere Attraktivität für Rentner.

Die aus den Basiswerten für Genre, Zeit etc. berechnete Zielgruppenattraktivität wird zuletzt mit diesem Wert multipliziert.
Zu beachten ist, dass nicht allein die Attraktivität die Zuschauerzahl bestimmt.
Setzt man den Faktor auf 0, bedeutet das nicht, dass es keine Zuschauer dieser Gruppe geben wird, nur sehr viel weniger.

#### modifiers

Im Hauptknoten `modifiers` kann eine Liste von `modifier`-Elementen angegeben werden, die je nach Elternknoten verschiedene Anpassungen definieren können.
Jeder `modifier` hat dabei einen Namen `name` und einen Wert `value`, die angeben was wie angepasst wird.

```XML
<modifiers>
	<!-- altert schneller als normal -->
	<modifier name="topicality::age" value="1.5" />
	<!-- billiger als normal -->
	<modifier name="price" value="0.7" />
</modifiers>
```

Die unterstützten Modifier hängen vom Hauptelement ab.
Zu beachten ist, dass 0 nicht immer "0" als Ergebnis hat, da in der Berechnung Minimalwerte angesetzt sein können.

#### effects

Im Hauptknoten `effects` kann eine Liste von `effect`-Elementen angegeben werden, die je nach Elternknoten verschiedene Anpassungen definieren können.

Für alle Effekttypen können die folgenden Eigenschaften definiert werden:

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| trigger | Pflicht | siehe unten |
| type | Pflicht | mögliche Werte siehe unten; am häufigsten "triggernews" - Nachfolgenachricht anstoßen |
| time | optional | wann findet der Effekt statt; Format siehe [Zeitsteuerung](time.md#Zeitattribute) |
| probability | optional | Wahrscheinlichkeit für das Eintreten dieses Effekts |

Ein `effect`-Knoten hat immer die Eigenschaft `trigger`, die steuert, unter welcher Bedingung der Effekt eintritt. Die anderen Felder hängen vom Effekttyp `type` ab.
ACHTUNG: time wird aktuell nur beim Auslösen von Nachrichten ausgewertet.
Bei anderen Typen (Beliebtheit, Verfügbarkeit) hat der Wert keine Auswirung.
Der Effekt tritt immer sofort ein.
Die häufigsten Zeitsteuerungsvarianten sind 1 (`"1,3,7"` - in 3 bis 7 Stunden), 2 (`"2,1,2,6,14"` - in 1 bis 2 Tagen zwischen 6 und 14 Uhr).
Die `probability` liegt zwischen 0 und 100 (falls nicht definiert, wird 100 angenommen).

##### trigger

Die Eigenschaft `trigger` hat einen je nach Hauptelement (Nachrichten, Programme etc.) einen festen Wertebereich.
Typische Werte sind

* `happen`- der Effekt tritt in jedem Fall ein
* `broadcast` - der Effekt tritt zu Beginn *jeder einzelnen* Ausstrahlung ein
* `broadcastDone` - der Effekt tritt am Ende *jeder einzelnen* Ausstrahlung ein
* `broadcastFirstTime` - der Effekt tritt zu Beginn der ersten Ausstrahlung ein
* `broadcastFirstTimeDone` - der Effekt tritt am Ende der ersten Ausstrahlung ein

Beispiel: `... trigger="happen" ... `

##### `type="triggernews"`

Es wird *eine* Nachfolgenachricht angestoßen.
Der Wert von `news` (für diesen Typ Pflicht) enthält die ID der angestoßenen Nachfolgenachricht.

`<effect trigger="happen" type="triggernews" news="ronny-news-drucktaste-02b1" />`

##### `type="triggernewschoice"`

Um unterschiedliche Verläufe in Nachrichtenketten zu ermöglichen kann man mit diesem Effekttyp *eine* der aufgelisteten Nachrichten anstoßen.
Je Nachricht kann eine Wahrscheinlichkeit angegeben werden.

`<effect trigger="happen" type="triggernewschoice" choose="or" news1="newsId1" probability1="30" news2="newsId2 probability2="70" />`

Im aktuellen Datenbestand werden bis zu vier Nachfolgenachrichten verwendet (`news1...news4, probability1...probability4`).
Laut Quellcode `Init:TGameModifierNews_TriggerNews` könnten auch unterschiedliche Triggerzeiten (`time1...time4`) angegeben werden.
Davon wird aktuell aber kein Gebrauch gemacht (Fallback auf dieselbe Zeite `time` für alle Nachfolgenachrichten.)

##### `type="modifyPersonPopularity"`

Es wird die Beliebtheit der referenzierten Person angepasst.

* `<effect trigger="happen" type="modifyPersonPopularity" referenceGUID="personId" valueMin="0.1" valueMax="0.2" />` - 
die Beliebtheit von der Persion mit der ID personId wird unabhängig von der Ausstrahlung der Nachricht um einen Wert zwischen 0.1 und 0.2 angepasst.
* `<effect trigger="broadcast" type="modifyPersonPopularity" referenceGUID="personId" valueMin="0.02" valueMax="0.05" />` - 
die Beliebtheit von der Persion mit der GUID personId wird bei jeder Ausstrahlung der Nachricht um einen Wert zwischen 0.02 und 0.05 angepasst.

##### `type="modifyMovieGenrePopularity"`

Es wird die Beliebtheit des angegebenen Genres angepasst.

* `<effect trigger="happen" type="modifyMovieGenrePopularity" genre="13" valueMin="0.5" valueMax="2.0" />`- die Beliebtheit von Monumentalfilmen wird unabhängig von der Ausstrahlung der Nachricht um einen Wert zwischen 0.5 und 2 angepasst.
* `<effect trigger="broadcastFirstTime" type="modifyMovieGenrePopularity" genre="3" valueMin="0.2" valueMax="0.7" />`- die Beliebtheit von Trickfilmen wird bei der ersten Ausstrahlung der Nachricht um einen Wert zwischen 0.2 und 0.7 angepasst.

##### `type="modifyNewsAvailability"`

Es wird der Verfügbarkeitsstatus einer Nachricht angepasst.

* `<effect trigger="happen" type="modifyNewsAvailability" enable="1" news="ronny-news-drucktaste-1" />`- die Eigenschaft `available` (verfügbar) der Nachricht mit der ID "ronny-news-drucktaste-1" wird auf Ja gesetzt.
* `<effect trigger="happen" type="modifyNewsAvailability" enable="0" news="ronny-news-drucktaste-1" />`- die Eigenschaft `available` (verfügbar) der Nachricht mit der ID "ronny-news-drucktaste-1" wird auf Nein gesetzt.

##### `type="modifyProgrammeAvailability"`

Es wird der Verfügbarkeitsstatus einer Programmlizenz angepasst.

* `<effect trigger="broadcastFirstTime" type="modifyProgrammeAvailability" enable="1" guid="ronny-programme-livereportage-raketenstart1" />`- bei Beginn der ersten Ausstrahlung wird die Eigenschaft `available` (verfügbar) der Lizenz mit der ID "ronny-programme-livereportage-raketenstart1" auf Ja gesetzt. `enable="1"` kann dabei auch weggelassen werden. Falls das Attribut nicht gesetzt ist, wird es automatisch als "ja" angenommen.

* `<effect trigger="broadcastFirstTimeDone" type="modifyProgrammeAvailability" enable="0" news="ronny-programme-livereportage-raketenstart1" />`- bei Ende der ersten Ausstrahlung wird die Eigenschaft `available` (verfügbar) der Lizenz mit der ID "ronny-programme-livereportage-raketenstart1" auf Nein gesetzt.

##### `type="modifyScriptAvailability"`

Es wird der Verfügbarkeitsstatus einer Drehbuchvorlage angepasst.

* `<effect trigger="broadcast" type="modifyScriptAvailability" enable="1" guid="scripttemplate-ron-musiksterneamabend" />`- bei Beginn jeder Ausstrahlung wird die Eigenschaft `available` (verfügbar) der Drehbuchvorlage mit der ID "scripttemplate-ron-musiksterneamabend" auf Ja gesetzt. `enable="1"` kann dabei auch weggelassen werden. Falls das Attribut nicht gesetzt ist, wird es automatisch als "ja" angenommen.

* `<effect trigger="broadcastDone" type="modifyProgrammeAvailability" enable="0" news="scripttemplate-ron-musiksterneamabend" />`- bei Ende jeder Ausstrahlung wird die Eigenschaft `available` (verfügbar) der Drehbuchvorlage mit der ID "scripttemplate-ron-musiksterneamabend" wird auf Nein gesetzt.

### Variablen

Mit dem Umbau der Variablenauflösung und der Erweiterung auf Funktionsauswertung bekommt dieses Thema sein eigenes [Hauptkapitel](variables.md).

## Standardwertebereiche

Syntaktisch sind Werte von Eingenschaften immer in doppelten Anführungszeichen eingeschlossene Zeichenketten.
Damit ein Wert tatsächlich gültig ist, kann er allerdings weiteren Einschränkungen unterliegen.
Möglich sind unter anderem 

* feste Listen von Werten wie z.B.
    * "1", "2" oder "3"
    * "reachAudience", "money"
    * Wahrheitswerte - "0" für nein, "1" für ja
* Datentypen
    * natürliche Zahlen (
    * Faktor: Zahl mit Kommastellen um 1 herum ("0.7", "1", "1.00" ,"1.3")
* IDs, die an anderer Stelle in der Datenbank definiert sind
* Flags, d.h. natürliche Zahlen bei der jedes Bit in der Binärdarstellung eine besondere Bedeutung hat. Eine Zahl repräsentiert die Kombination der Eigenschaften der aktivierten Bits.
* [Zeitattribute](time.md)

Die folgenden Abschnitte listen von mehreren Elementen verwendete Wertebereiche auf.
Im Quellcode sind in `game.gameconstants.bmx` definiert.

### Genre

| Wert | Bedeutung |
| ---- | --------- |
| 0 | Sonstiges |
| 1 | Abenteuer |
| 2 | Action |
| 3 | Trickfilm |
| 4 | Krimi |
| 5 | Komödie |
| 6 | Dokumentation |
| 7 | Drama |
| 8 | Erotik |
| 9 | Familie |
| 10 | Fantasy |
| 11 | Historisch |
| 12 | Horror |
| 13 | Monumental |
| 14 | Mystery |
| 15 | Liebesfilm |
| 16 | SciFi |
| 17 | Thriller |
| 18 | Western |
| 100 | Show |
| 101 | Polittalk |
| 102 | Musikshow |
| 103 | Talkshow |
| 104 | Spielshow |
| 200 | Event |
| 201 | Politik |
| 202 | Musik und Gesant |
| 203 | Sport |
| 204 | Showzi |
| 300 | Reportage |
| 301 | Boulevard |
| 400 | Infomercial |
| 401 | Nachrichtensondersendung |

(Quellcode: `TVTProgrammeGenre`)

### Programmtyp

| Wert | Bedeutung |
| ---- | --------- |
| 0 | undefiniert |
| 1 | Film |
| 2 | Serie |
| 3 | Show |
| 4 | Feature (Reportage) |
| 5 | Infomercial (Dauerwerbesendung) |
| 6 | Event |
| 7 | Sonstiges |

(Quellcode: `TVTProgrammeProductType`)

### Programmflags

Die Programmflags sind ein Flagwert, d.h. in einer Zahl können mehrere Werte kodiert werden.
Dafür addiert man die Werte auf.

| Wert | Bedeutung | Auswirkung |
| ---- | --------- |----------- |
| 1 | Livesendung | allgemeiner Bonus |
| 2 | Trickfilm | Bonus bei Kindern / Jugendlichen. Malus bei Rentnern / Managern. |
| 4 | Kultur | Bonus bei Betty und bei Managern |
| 8 | Kult | Filmalter weniger schlecht, Bonus bei Rentnern, höhere Serientreue |
| 16 | Trash | Bonus bei Arbeitslosen und Hausfrauen. Malus bei Arbeitnehmern und Managern. Bonus morgens und mittags |
| 32 | B-Movie | deutlich geringerer Preis, Filmalter weniger schlecht, Bonus bei Jugendlichen, Malus bei allen anderen, Bonus nachts |
| 64 | FSK 18 | Bonus bei Jugendlichen, Arbeitnehmern, Arbeitslosen, (Männern). Kleiner Malus bei Kindern, Hausfrauen, Rentner, (Frauen) |
| 128 | Call-In-Shows | |
| 256 | Serie | |
| 512 |"gestellt" | |
| 1024 | im Spiel produziert | |
| 2048 | unsichtbar | nicht im Programmplaner angezeigt |
| 4096 | RE-Live | Livesendung später nochmal ausgestrahlt |

(Quellcode: `TVTProgrammeDataFlag`)

`flags="12"` würde eine Kult-Kultursendung beschreiben.

### Lizenztyp

| Wert | Bedeutung |
| ---- | --------- |
| 0 | unbekannt |
| 1 | Einzellizenz |
| 2 | Episode einer Serie |
| 3 | Serie |
| 4 | Sammlung |
| 5 | Element einer Sammlung |
| 6 | Franchise |

(Quellcode: `TVTProgrammeLicenceType`)

Sammlung: Lizenzpaket - allerdings nicht von sonstigen einzeln stehenden Programmlizenzen.
Ein Sammlung `die ultimative Betty-Sammlung` könnte als Kindelemente Einträge enthalten, welche Programme mit Betty als Hauptdarstellerin referenzieren.

Franchise: Filme/Serien desselben "Zugpferds" ("Spa Wars")

Die Typen 4, 5 und 6 sollten im Moment noch nicht verwendet werden, da sich hier noch Änderungen ergeben könnten.

### Lizenzflags

Die Lizenzflags sind ein Flagwert, d.h. in einer Zahl können mehrere Werte kodiert werden.
Dafür addiert man die Werte auf.

| Wert | Bedeutung |
| ---- | --------- |
| 1 | kann gehandelt werden |
| 2 | automatischer Verkauf wenn Ausstrahlungslimit erreicht ist |
| 4 | automatische Entfernung wenn Ausstrahlungslimit erreicht ist  |
| 8 | Ausstrahlungsanzahl wird bei Rückgabe an Händler zurückgesetzt (wenn das Limit erreicht ist) |
| 16 | Aktualität wird bei Rückgabe an Händler wieder auf Maximum gesetzt |
| 32 | nach Rückgabe an Händler kann das Programm nicht wieder erworben werden |

(Quellcode: `TVTProgrammeLicenceFlag`)

`licence_flags="37"` wäre eine initial handelbare Lizenz, die aber nach Erreichen der maximalen Ausstrahlungsanzahl automatisch ohne Rückgeld an den Händler zurückgeht und dann nicht wieder erworben werden kann.

### Ausstrahlungsflags

Die Ausstrahlungsflags sind ein Flagwert, d.h. in einer Zahl können mehrere Werte kodiert werden.
Dafür addiert man die Werte auf.

| Wert | Bedeutung |
| ---- | --------- |
| 0 | unbekannt |
| 1 | Material einer dritten Partei |
| 2 | nicht steuerbar |
| 4 | Erstausstrahlung  |
| 8 | besondere Erstausstrahlung |
| 16 | Erstausstrahlung erfolgt |
| 32 | besondere Erstausstrahlung erfolgt |
| 64 | nicht verfügbar |
| 128 | Preis verstecken |
| 256 | beschränkte Ausstrahlungshäufigkeit aktiviert |
| **512** | immmer Live |
| 1024 | Schwierigkeitslevel wird ignoriert |
| **2048** | von Betty ignoriert |
| 4096 | von Erfolgen ignoriert |
| 8192 | exlusiv für einen Spieler |
| 16384 | obsolet - (war Live-Zeitpunkt ist fest) |
| **32768** | Begrenzung der Ausstrahlungszeit beibehalten |

(Quellcode: `TVTBroadcastMaterialSourceFlag`)

Die meisten Ausstrahlungsflags sind nur programmintern sinnvoll verwendbar.
Einige sind aber auch für die Definition in der Datenbank interessant.
Standardmäßig gilt die Begrenzung der Ausstrahlungszeit nur für die Erstausstrahlung.
Soll sie auch für Folgeausstrahlungen gelten, muss zusätzlich Flag 32768 gesetzt sein.

### Geschlecht

| Wert | Bedeutung |
| ---- | --------- |
| 0 | nicht definiert |
| 1 | männlich |
| 2 | weiblich |

(Quellcode: `TVTPersonGender`)

### Job

Der Job ist ein Flagwert, d.h. in einer Zahl können mehrere Berufe kodiert werden.
Dafür addiert man die Werte der zutreffenden Berufe auf.

| Wert | Bedeutung |
| ---- | --------- |
| 0 | unbekannt |
| 1 | Regisseur |
| 2 | Schauspieler |
| 4 | Drehbuchautor |
| 8 | Moderator/Gastgeber |
| 16 | Musiker |
| 32 | Nebendarsteller |
| 64 | Gast |
| 128 | Reporter |
| 256 | Politiker |
| 512 | Maler |
| 1024 | Autor |
| 2048 | Model |
| 4096 | Sportler |

(Quellcode: `TVTPersonJob`)

`job="18"` würde also Schauspieler und Musiker bedeuten.

### Länder

Aktuell kommen folgende Länder in der Datenbank vor (Herkunftsländer von Personen, Länder in denen Programme produziert wurden).
Achtung diese Werte sind nicht zu verwechseln mit den Sprachkürzeln.

| Kürzel | Land |
| ------ | ---- |
| A | Österreich |
| AFG | Afghanistan |
| AM | Armenien |
| AUS | Australien |
| B | Belgien |
| BG | Bulgarien |
| BIH | Bosnien und Herzegowina |
| BM | Bermudas |
| BOL | Bolivien |
| BR | Brasilien |
| BW | Botswana |
| C| Kuba |
| CDN | Kanada |
| CH | Schweiz |
| CHN | China |
| CL | Sri Lanka |
| CO | Kolumbien |
| CS | CSSR |
| CZ | Tschechische Republik |
| D | Deutschland |
| DDR | DDR |
| DK | Dänemark |
| E | Spanien |
| F | Frankreich |
| FL | Liechtenstein |
| GB | Vereinigtes Königreich |
| GH | Ghana |
| GR | Griechenland
| H | Ungarn |
| HK | Hongkong |
| HR | Kroatien |
| I | Italien |
| IL | Israel |
| IND | Indien |
| IRL | Irland |
| J | Japan |
| KN | Grönland |
| KSA | Saudi-Arabien |
| L | Luxemburg |
| LT | Litauen |
| M | Malta |
| MA | Marocco |
| MEX | Mexiko |
| N | Norwegen |
| NL | Niederlande |
| NZ | Neuseeland |
| P | Portugal |
| PA | Panama |
| PE | Peru |
| PL | Polen |
| RA | Argentinien |
| RC | Taiwan |
| RM | Republik Molvanien |
| RO | Rumänien |
| ROK | Südkorea |
| RP | Philippinen |
| RUS | Russland |
| S | Schweden |
| SCO | Schottland |
| SU | UDSSR |
| T | Thailand |
| TN | Tunesien |
| TR | Türkei |
| USA | USA |
| YU | Jugoslawien|
| ZA | Südafrika |
| ZW | Simbabwe |

Basis für die Vereinheitlichung beim Datenbankaufräumen war die Liste der Autokennzeichen (https://de.wikipedia.org/wiki/Liste_der_Kfz-Nationalit%C3%A4tszeichen).
Bei Koproduktionen werden die Länder durch Schrägstrich und ohne Leerzeichen getrennt (`F/CDN`).

### Zielgruppe

Die Zielgruppe ist ein Flagwert, d.h. in einer Zahl können mehrere Zielgruppen kodiert werden.
Dafür addiert man die Werte der zutreffenden Gruppen auf.

| Wert | Bedeutung |
| ---- | --------- |
| 0 | alle |
| 1 | Kinder |
| 2 | Jugendliche |
| 4 | Hausfrauen |
| 8 | Arbeitnehmer |
| 16 | Arbeitslose |
| 32 | Manager |
| 64 | Rentner |
| 128 | Frauen |
| 256 | Männer |

(Quellcode: `TVTTargetGroup`)

`target_group="65"` würde also Kinder und Rentner umfassen.

Ist eine Gruppe als Zielgruppe definiert (z.B. bei Werbung oder Programmen), wird bei der Berechnung der Zuschauerzahl für diese Gruppe ein leicht erhöhter Attraktivitätswert als normal zugrunde gelegt.

### Lobbygruppe

Die Lobbygruppe ist ein Flagwert, d.h. in einer Zahl können mehrere Lobbygruppen kodiert werden.
Dafür addiert man die Werte der zutreffenden Gruppen auf.

| Wert | Bedeutung |
| ---- | --------- |
| 0 | keine |
| 1 | Raucher |
| 2 | Nichtraucher |
| 4 | Waffenlobby |
| 8 | Pazifisten |
| 16 | Kapitalisten |
| 32 | Kommunisten |

(Quellcode: `TVTPressureGroup`)

`pro_pressure_group="9"` wären Raucher und Pazifisten.

## allgemeiner Aufbau eines Elements

```XML
<tag eigenschaft1="Wert1" eigenschaft2="Wert2">
	<kindTag1 e1="w1" w2="w2" />
	<kindTag2 e="w">
		<enkelTag />
		<enkelTag />
	</kindTag2>
</tag>
```

Ein Tag (oder auch Knoten) beginnt mit einer öffnenden spitzen Klammer und dem Tagnamen (`<tagname ...`).
Es folgt eine Liste von Eigenschaften mit einem Wert (`... e1="w1" e2=w2"...`), wobei die möglichen Eigenschaften und Wertebereiche vom Tag abhängig sind.
Die Eigenschaften können verpflichtend oder optional sein - im ersten Fall müssen sie angegeben werden im zweiten kann man sie angeben aber auch weglassen.
Wenn das Tag keine Kindelemente enthält, kann es direkt abgeschlossen werden (`.../>`).
Das heißt, auf die öffnende spitze Klammer folgt nach Name und Eigenschaften ein Schrägstrich gefolgt von der schließenden spitze Klammer.
Wenn Kindelemente vorhanden sind, wird das Tag zunächst mit einer schließenden spitzen Klammer abgeschlossen (`...>`), dann folgen die Kindelemente und das gesamte Tag wird mit einem schließenden Tag beendent (`</tagname>`).

Kindknoten werden zur besseren Lesbarkeit eingerückt.
Die übergeordneten Knoten bestimmen, ob ein Kindknoten optional (muss nicht vorkommen) oder verpflichtend (muss vorkommen) ist und ob er höchstens einmal (einfacher Kindknoten) oder mehrfach (Liste) vorkommen darf.
Im Fall einer Liste kann es also mehrere Tags mit demselben Namen geben.

## TODOs und Fragen

### Dokumentation

* typische Flags fett markieren?
* id durch GUID ersetzen?
* modifiers ist sehr generisch gehalten; wie bekommt man am besten verfügbare Modifier raus?

### Generell

* Genre 401 scheint noch gar keine Lokalisierung zu haben. Ist das überhaupt schon im Code behandelt?
