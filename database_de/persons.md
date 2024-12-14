# Personen (person)

Personen sind in der Datenbank in drei Kategorien eingeteilt: Hauptpersonen (celebritypeople), Nebenpersonen (insignificantpeople) und Filmrollen (programmeroles).

Die Personen haben in Filmen etc. mitgewirkt und stehen für Produktionen in unterschiedlichen Berufen zur Verfügung.
Für Hauptpersonen sind dabei zahlreiche Eigenschaften in der Datenbank bereits festgelegt.
Die im Supermarkt verfügbaren Laien werden hingegen aus Nebenpersonen ausgesucht und ihre Eigenschaften werden gewürfelt.

Filmrollen (analog James Bond) sind in Filmen dargestellte Personen.

Welche der folgenden Eigenschaften und Kindelemente jeweils unterstützt werden, ist in den Abschnitten zu Hauptpersonen, Nebenpersonen und Filmrollen aufgelistet.

Im Gegensatz zu Filmtiteln etc. werden sprachspezifische Werte (z.B. andere Schreibweise eines Namens in einer anderen Sprache) nicht direkt von der Hauptdefinition unterstützt.
Die Lokalisierung von Personennamen oder Filmrollen ist in [separaten Dateien](lang.md) möglich.

## Eigenschaften von person

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | [GUID](main.md#guid), insb. für Referenzierung bei Filmen etc. |
| first_name | Pflicht* | Vorname |
| last_name | Pflicht* | Nachname |
| nick_name | optional | Spitzname |
| title | optional | Titel |
| gender | optional | [Geschlecht](main.md#Geschlecht) |
| job | optional | (aktuell) ausgeübte [Berufe](main.md#Job) |
| country | optional | [Herkunftsland](main.md#Länder) |
| first_name_original | informativ | wenn es ein echtes Vorbild gibt - der ursprüngliche Vorname |
| last_name_original | informativ |  wenn es ein echtes Vorbild gibt - der ursprüngliche Nachname |
| nick_name_original | informativ |  wenn es ein echtes Vorbild gibt - der ursprüngliche Spitzname |
| title_original | informativ |  wenn es ein echtes Vorbild gibt - der ursprüngliche Titel |
| fictional | optional | [Standardeigenschaft](main.md#fictional) |
| levelup | optional | Wahrheitswert - kann die Person eine "Hauptperson" werden (Standardwert 1) |
| castable | optional | Wahrheitswert - kann die Person generell in einer Produktion mitwirken |
| face_code | optional | definiertes Aussehen des Avatars |
| generator | optional | Anweisungen für automatischen Attributerzeugung (Name, Vorname, Herkunftsland) |
| tmdb_id | Metadaten optional |  [Standardeigenschaft](main.md#tmdb_id) |
| imdb_id | Metadaten optional | [Standardeigenschaft](main.md#imdb_id) |
| creator | Metadaten optional | [Standardeigenschaft](main.md#creator) |
| created_by | Metadaten optional | [Standardeigenschaft](main.md#created_by) |
| comment |  informativ  |[Standardeigenschaft](main.md#comment) |

Der Standardwert für `castable` (bis Version 0.8.2 `bookable`) ist "1".
Grundsätzlich sind aber nur fiktionale Personen in Eigenproduktionen einsetzbar.
Das Programm unterscheidet für die Einsatzbarkeit zwischen `castable` (grundsätzlich) und `bookable` (zum jetzigen Zeitpunkt).

`generator` wird nur selten benutzt, der Wert enthält kommasepariert ein Länderkürzel und das Geschlecht für die Bestimmung des Namens.
Beispiel `generator="de,2"` für eine deutsche Frau.
Siehe auch die Beschreibung zum Personengenerator in den [Variablen](variables.md).

## Kindelemente von person

Für die bessere Lesbarkeit sind bei [Hauptpersonen](persons.md#Hauptpersonen) manchmal auch `first_name`, `last_name`, `nick_name`, `title` und deren original-Versionen als Kindelemente angegeben.

### Details (details)

Die meisten der Felder lassen sich auch direkt als Personenattribut angeben.
Im `details`-Knoten sind sie vorrangig zur besseren Lesbarkeit bei [Hauptpersonen](persons.md#Hauptpersonen) verfügbar.

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| job | optional | (aktuell) ausgeübte [Berufe](main.md#Job) |
| gender | optional | [Geschlecht](main.md#Geschlecht) |
| birthday | optional | Geburtstag |
| deathday | optional | Todestag |
| fictional | informativ | [Standardeigenschaft](main.md#fictional) |
| country | optional |[Herkunftsland](main.md#Länder) |
| face_code | optional | definiertes Aussehen des Avatars |

Beispiel `<details job="2" gender="1" birthday="1970-08-23" deathday="1993-10-31" country="US" />` - US-amerikanischer Schauspieler, der vom 23.8.1970 bis zum 31.10.1993 gelebt hat.

Ab Version 0.8.2 werden auch relative (negative) Jahresangaben z.B. für das Geburtsjahr unterstützt.
Das ist für fiktionale Personen interessant, die unabhängig vom Startjahr des Spiels gleich alt sein sollen.
`birthday="-31-03-02"` würde also 31 Jahre vor dem Startjahr bedeuten.

### Daten (data)

Diese Daten definieren insbesondere die Werte für Eignung für eine Besetzung.
Wo nicht anders angegeben sind die möglichen Werte zwischen 0 und 100 (Prozent).

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| topgenre | optional | [Hauptgenre](main.md#Genre) |
| price_mod | optional | Preisfaktor (Zahl mit Nachkommastellen um 1 herum) |
| affinity | optional | Affinität |
| charisma | optional | Charisma |
| humor | optional | Humor |
| power | optional | Kraft |
| appearance | optional | Aussehen |
| fame | optional | Berühmtheit |
| scandalizing | optional | Tendenz Skandale zu verursachen |
| popularity | optional | Beliebtheit |
| popularity_target | optional | Langzeitbeliebtheit |

Beispiel `<data popularity="20" affinity="50" fame="20" scandalizing="0" price_mod="0.7" power="0" humor="9" charisma="11" appearance="21" topgenre="0" />`

Die Langzeitbeliebtheit wird in der Datenbank noch nicht verwendet.

## Hauptpersonen

Hauptpersonen sind als Liste von `person`-Kindelementen in das `celebritypeople`-Tag eingebettet.
Es werden alle oben genannten Eigenschaften und Kindelemente unterstützt.
Zu beachten ist, dass nur fiktive Hauptpersonen unmittelbar zum Spielbeginn in ihren Berufen für die Besetzung in Produktionen zur Verfügung stehen.

```XML
<celebritypeople>
	<person guid="TheRob-TowerTV-VeraZottova" tmdb_id="0" imdb_id="0" creator="8751" created_by="TheRob">
		<first_name>Vera</first_name>
		<last_name>Zottorova</last_name>
		<nick_name></nick_name>
		<details gender="2" fictional="1" birthday="" deathday="" country="" />
		<data popularity="5" affinity="60" fame="60" scandalizing="20" price_mod="1" power="60" humor="24" charisma="78" appearance="88" topgenre="0" />
	</person>
	<person ...
	</person>
	...
</celebritypeople>
```

## Nebenpersonen

Nebenpersonen sind als Liste von `person`-Kindelementen in das `insignificantpeople`-Tag eingebettet.
Es werden nur die wichtigsten Eigenschaften definert; insb. gibt es hier keine weiteren Kindknoten unterhalb von `person`.
Fiktive Nebenpersonen stehen als als Laien für Produktionen zur Verfügung, können im Spielverlauf dann aber zu Hauptpersonen aufsteigen.

```XML
<insignificantpeople>
	<person guid="Per_custom_Freddy_21" first_name="Sophie" last_name="McAgne" nick_name="" gender="2" country="SCO" fictional="1" />
	<person guid="ronny-people-generated-01" generator="de,2" last_name="Mueller" />
	...
</insignificantpeople>
```

Die erste Person ist eine ausgedachte Schottin, die zweite eine deutsche Frau Mueller, deren Vorname zufällig ausgewählt wird.

## Filmrollen

Filmrollen sind in Programmen dargestellte Personen.
Sie sind als Liste von `programmerole`-Kindelementen in das `programmeroles`-Tag eingebettet.

```XML
<programmeroles>
	<programmerole guid="script-roles-ron-001" first_name="Miranda" last_name="Jones" title="Dr." gender="2" />
	<programmerole guid="script-roles-ron-002" first_name="Jonathan" last_name="Spykes" gender="1" />
	...
</programmeroles>
```

Die folgendenen Felder sollten definiert werden

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | [GUID](main.md#guid), insb. für Referenzierung bei Drehbuchvorlagen etc. |
| first_name | Pflicht* | Vorname |
| last_name | Pflicht* | Nachname |
| nick_name | optional | Spitzname |
| title | optional | Titel (Dr. etc) |
| gender | optional | [Geschlecht](main.md#Geschlecht) |
| country | optional | [Herkunftsland](main.md#Länder) |
| fictional | optional | [Standardeigenschaft](main.md#fictional) |

## TODOs und Fragen

### Generell

* data klären - werden diese Werte als Basis genommen und dann gewürfelt?
* data beim Einlesen werden auch min/max-Werte (noch keine Grammatikunterstützung)