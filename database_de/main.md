# Die TVTower-Datenbank

Die für TVTower verwendeten Daten befinden auf mehrere Dateien aufgeteilt sich im Verzeichns `res/database/`.
Die Daten sind in einer [XML-Struktur](main.md#allgemeiner-Aufbau-eines-Elements) hinterlegt.
Der typische Start in die Erstellung eigener Einträge dürfte darin bestehen, vorhandene Elemente aus dem einem bekannten Spielgeschehen zu suchen, die dem gewünschten Verhalten besonders nahe sind, diese zu kopieren und anzupassen.
Es empfielt sich, eigene Inhalte in einer neuen Datei im `user`-Unterverzeichnis zu sammeln.

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

## von mehreren Elementen verwendete Strukturen

Manche Eigenschaften oder Kindunterstrukturen kommen an verschiedenen Stellen vor.
Die folgenden Beschreibungen werden dann von anderen Stellen der Dokumentation aus referenziert.

### Standardeigenschaftem

#### id

`id` (manchmal auch `guid`) ist die Eigenschaft, mit der ein Element global eindeutig identifiziert wird.
Ein für die Eindeutigkeit hilfreiches Schema ist `Autor-Typ-Titel` (z.B. `jim-news-homerun` oder `david-programme-Yfiles-season1-episode3`).

Technisch wird zwischen einer programminternen numerischen ID und einer textbasierten GUID unterschieden.
In der Datenbank wird die GUID definiert, weshalb in der Dokumentation vereinfachend oft nur ID steht.
Beispiel: `... id="jim-news-homerun"...`

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

Die aktuell verwendeten Sprachen sind Deutsch (de) und Englisch (en).
Langfristig muss es dabei aber nicht bleiben.
Spracheinträge können auch Variablen enthalten - diese werden aber in einem [separaten Abschnitt](main.md#Variablen) beschrieben.

### Standardkindelemente

#### title

Der `titel`-Knoten enthält Titel von Drehbuchvorlagen, Filmen etc.
Es werden unterschiedliche Sprachen und [Variablen](main.md#Variablen) unterstützt.

```XML
<title>
	<de>Reise nach %WHERE%</de>
	<en>Voyage to %WHERE%</en>
</title>
```

#### description

Der `description`-Knoten enthält eine Beschreibung - wieder in unterschiedlichen Sprachen und mit Unterstützung von [Variablen](main.md#Variablen).
Beispiel:

```XML
<description>
	<de>Wie analysiere ich die Industriekraft...</de>
	<en>How to analyse the industrial power...</en>
</description>
```

#### text

Der `text`-Knoten enthält einen Text.
Auch hier werden unterschiedliche Sprachen und [Variablen](main.md#Variablen) unterstützt.

#### availability

Siehe [Verfügbarkeit](time.md#Verfügbarkeit) in der Beschreibung von Zeitdefinitionen.

#### targetgroupattractivity

Hier kann  für einzelne Zielgruppen ein genauer Attraktivitätsfaktor angegeben werden.
Durch den suffix `_male` und `_female` an der Zielgruppe kann zusätzlich auf die männlichen/weiblichen Vertreter eingeschränkt werden.
Die Zielgruppennamen sind: `teenagers`, `managers`, `housewives`, `employees`, `women`, `men`, `pensioners`, `unemployed`.

Beispiel: `<targetgroupattractivity teenagers_male="0.7" pensioners="1.6" />` - geringere Attraktivität für männliche Jugendliche, höhere Attraktivität für Rentner.

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

### Variablen

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
| 8 | Ausstrahlungsanzahl wird bei Rückgabe an Händler zurückgesetzt |
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
| 256 | hat beschränkte Ausstrahlungshäufigkeit |
| **512** | immmer Live |
| 1024 | Schwierigkeitslevel wird ignoriert |
| **2048** | von Betty ignoriert |
| 4096 | von Erfolgen ignoriert |
| 8192 | exlusiv für einen Spieler |
| 16384 | Live-Zeitpunkt ist fest |
| **32768** | Begrenzung der Ausstrahlungszeit beibehalten |

(Quellcode: `TVTBroadcastMaterialSourceFlag`)

Die meisten Ausstrahlungsflags sind nur programmintern sinnvoll verwendbar.
Einige sind aber auch für die Definition in der Datenbank interessant.
Eine Begrenzung der Ausstrahlungszeit (time-slot) gilt standardmäßig nur für die Erstausstrahlung. Soll die Beschränkung immer gelten, muss Flag 32768 gesetzt werden.

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
| AUS | Australien |
| BE | Belgien |
| BM | Bermudas |
| BOL | Bolivien |
| CDN | Kanada |
| CH | Schweiz |
| CN | China |
| CS | CSSR |
| D | Deutschland | 
| DDR | DDR |
| DK | Dänemark |
| E | Spanien |
| F | Frankreich |
| GB | Vereinigtes Königreich |
| H | Ungarn |
| HK | Hongkong |
| I | Italien |
| IL | Israel |
| IND | Indien |
| IRL | Irland |
| J | Japan |
| NL | Niederlande |
| PL | Polen |
| RM | Republik Molvanien |
| ROK | Südkorea |
| S | Schweden |
| SCO | Schottland |
| SU | UDSSR |
| USA | USA |
| ZA | Südafrika |

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
