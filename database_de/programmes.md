# Programme (programmes)

Die Programm-Einträge sind als Liste von `programme`-Kindelementen in das `allprogrammes`-Tag eingebettet.

```XML
<allprogrammes>
	<programme id="54084557-4497-48d5-8e3a-6a6c987ebb26" product="1" licence_type="1" tmdb_id="0" imdb_id="tt0114746" creator="">
		<title>
			<de>11 Donkeys</de>
			<en></en>
		</title>
		<title_original>
			<de>12 Monkeys</de>
			<en>Twelve Monkeys</en>
		</title_original>
		<description>
			<de>[1|Full] als potentieller Weltretter...</de>
			<en></en>
		</description>
		<staff>
			<member index="0" function="1">85341df9-bd8f-4fd0-9f80-c9ab44ca0829</member>
			<member index="1" function="2">2b6af8c4-7775-44da-820e-1ce9c55d8cd9</member>
			<member index="2" function="2">1312b7b5-3215-40fd-92c8-fb0a16a2aebe</member>
			<member index="3" function="2">6773978f-3667-4c03-813b-0fbc01b8135c</member>
		</staff>
		<groups target_groups="0" pro_pressure_groups="0" contra_pressure_groups="0" />
		<data country="USA" year="1995" distribution="1" maingenre="16" subgenre="" flags="0" blocks="3" price_mod="0.67" />
		<ratings critics="42" speed="28" outcome="51" />
	</programme>
</allprogrammes>
```

Der US-amerikanische (`country`) Science-Fiction(`maingenre`)-Film (`product`) 11 Donkeys (`title`) wurde 1995 (`year`) für das Kino (`distribution`) produziert, ist 3 Stunden lang (`blocks`) aber wenig temporeich (`speed`).
Die Bewertung durch Kritiker (`critics`) und das kommerzielle Ergebnis (`outcome`) waren durchschnittlich.
Es ist keine speziell angesprochene Zielgruppe angegeben (`target_groups`).
Es gab einen Regisseur (`member index 0`) und 3 Hauptdarsteller (`member index 1-3`).
Die Einzellizenz (`licence_type`) ist preiswert zu haben (`price_mod`).

## Eigenschaften von programme

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| id | Pflicht | [ID](main.md#id) |
| product | Pflicht  | [Programmtyp](main.md#Programmtyp) |
| licence_type | Pflicht | [Lizenztyp](main.md#Lizenztyp) |
| fictional | optional | [Standardeigenschaft](main.md#fictional) |
| tmdb_id | optional | [Standardeigenschaft](main.md#tmdb_id) |
| imdb_id | optional | [Standardeigenschaft](main.md#imdb_id) |
| creator | Metadaten optional | [Standardeigenschaft](main.md#creator) |
| created_by | Metadaten optional | [Standardeigenschaft](main.md#created_by) |

## Kindelemente von programme

Standardelemente für Titel [title](main.md#title) und Beschreibung [description](main.md#description) sind sindvollerweise zu definieren.
Analog zum Titel kann der urspüngliche Titel unter `title_original` angegeben werden.
Die aus Nachrichten oder Drehbüchern bekannten Variablen kommen bei Programmen aktuell nicht vor, aber der Spezialfall [Besetzungsvariablen](main.md#Besetzungsvariablen) um Namen direkt aus der Besetzung in Titel und Beschreibung zu übernehmen.

Ebenfalls benötigt werden Daten (`data`) und die Bewertung des Programminhalts (`ratings`).

### Mitwirkende (staff)

Im Hauptknoten `staff` kann eine Liste von Mitwirkenden (`member`) definiert werden.
Im Normalfall wird es sich um eine Referenz auf in der Datenbank definierte Personen handeln.
Die Eigenschaft `index` gibt die Position (0,1,2,...) an, um die Einträge in Variablen referenzieren zu können, `function` definiert den [Beruf](main.md#Job).
Wenn eine Besetzung komplett zufällig erzeugt werden soll, kann sie auch mittels `generator` definiert werden.

* `<member index="1" function="2">person-0815</member>` - die Person mit der ID `person-0815` ist als Schauspieler in der Besetzung
* `<member index="2" function="64" generator="es,0"></member>` - spanischer Gast männlich oder weiblich

### Ziel- und Lobbygruppen (groups)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| target_groups | Pflicht | definitiv verwendete [Zielgruppe](main.md#Zielgruppe) |
| target_groups_optional | optional | möglicherweise verwendete [Zielgruppe](main.md#Zielgruppe) |
| pro_pressure_groups | optional | angesprochene [Lobbygruppe](main.md#Lobbygruppe) |
| contra_pressure_groups | optional | abgeschreckte [Lobbygruppe](main.md#Lobbygruppe) |

Beispiel: `<groups target_groups="128" pro_pressure_groups="8" contra_pressure_groups="4" />` - Zielgruppe Frauen, Pazifisten zufrieden, Waffenlobby verärgert.

### Zielgruppenattraktivität (targetgroupattractivity)

Siehe [Standardkindelement](main.md#targetgroupattractivity).

### Bewertung (ratings)

Dies ist die entscheidende Stelle für die Definition der Qualität eines Programms - die Werte für Tempo (`speed`), Kritikermeinung (`critics`) und kommerzieller Erfolg (`outcome`).
Die möglichen Werte sind jeweils zwischen 0 und 100.

Beispiel: `<ratings critics="45" speed="30" outcome="40" />`

### Daten (data)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| country | Pflicht | produziert in [Land](main.md#Länder) | 
| year | optional | Produktionsjahr |
| distribution | optional | Verbreitungsweg siehe unten |
| maingenre | Pflicht | [Hauptgenre](main.md#Genre) des Programms |
| subgenre | optional  | [Untergenre](main.md#Genre) des Programms |
| flags | optional | [Programmflags](main.md#Programmflags) |
| licence_flags | optional | [Lizenzflags](main.md#Lizenzflags) |
| blocks | optional | Länge in Stunden (default 1) | 
| price_mod | optional | Faktor für die Preisberechnung |
| broadcast_time_slot_start | optional | Frühester Start des ersen Blocks |
| broadcast_time_slot_end | optional | Spätestes Ende des letzten Blocks |
| broadcast_limit | optional | Anzahl der möglichen Ausstrahlungen |
| broadcast_flags | optional | [Ausstrahlungsflags](main.md#Ausstrahlungsflags) |

`country` und `maingenre` sind Pflicht für "Hauptprogramme", für Serienfolgen werden die Werte des Elternelements übernommen.
`year` sollte angegeben werden.
Wenn man allerdings zum Spielstart relative Jahre oder genauere Daten angeben möchte, kann man `year` weglassen und den `releaseTime`-Knoten verwenden.
In Kombination mit Live-Programmen oder Einschränkung der Ausstrahlungszeit können die Ausstrahlungsflags interessant werden.

Im Code werden noch die folgenden Eigenschaften eingelesen, kommen aktuell in der Datenbank aber nicht vor:
`available`, `data_broadcast_limit` (Limit für alle mit diesen Programmdaten), `licence_broadcast_limit` (Limit für diese Lizenz). Die spezifische Definition der Ausstrahlungsflags via `data_broadcast_flags`, `licence_broadcast_flags` ist vorgesehen aber nicht 100% unterstützt.

### Veröffentlichung (releaseTime)

Die Veröffentlichung eines Programms kann auch (spiel-)taggenau angegeben werden.

Beispiel: `<releaseTime year="1986" day="4" hour="12" />` - Veröffentlichung am 4. Spieltag des Jahres 1986 um 12 Uhr.

Die Steuerung ist allerdings noch feingranularer möglich.
Folgende Eigenschaften werden unterstützt.

| Name | Bedeutung |
| -----| --------- |
| year | absolute Jahreszahl |
| year_relative | Jahre relativ zum Spielbeginn (-2, +4) |
| year_relative_min | minimale absolutes Jahr |
| year_relative_max | maximale absolutes Jahr |
| day | Tag des Jahres |
| day_random_min | minimaler Zufallstag |
| day_random_max | maximaler Zufallstag |
| day_random_slope |  |
| hour | Stunde |
| hour_random_min | minimale Zufallsstunde |
| hour_random_max | maximale Zufallsstunde |
| hour_random_slope |  |

Die relativen Jahresangaben können positiv (ab Startspieljahr) und negativ (vor Startspieljahr) sein. Beispiel `<releaseTime year_relative="-4" year_relative_min="1983" year_relative_max="1995" />` - vier Jahre vor Spielstart aber zwischen 1983 und 1995.

### Effekte

Laut Datenbankauslesecode können auch Programme Effekte haben. Das wird in der Datenbank aktuell noch nicht verwendet oder vom Editor unterstützt.

### Modifier

Siehe [modifiers](main.md#modifiers).
Mögliche Anpassungen sind

| Name | Bedeutung |
| -----| --------- |
| topicality::age| Alterung des Programms |
| price | Preis (entspricht `price_mod`) |

Beispiel: `<modifier name="topicality::age" value="1.2" />` - das Programm altert schneller als normal.

### Programmkinder (children)

Für Serien können unter dem Serienhauptknoten die Episoden 
im `children`-Knoten auch wieder als `programme` definiert werden. Beispiele siehe unten.

## spezifische Werte für programme

| **Verbreitungsweg** | Bedeutung |
| ------------------- | --------- |
| 0 | unbekannt |
| 1 | Kino |
| 2 | Fernsehen |
| 3 | Video (VHS/DVD etc.) |

(Quellcode: `TVTProgrammeDistributionChannel`)

## Wiederverwendung bestehender Programmdaten

Es ist möglich, bestehende Programmdaten wiederzuverwenden.
Das kann interessant sein, um einen "Director's Cut" oder  eine preiswertere aber dafür nur 3x ausstrahlbare Lizenz zu erstellen.
Dafür wird das zugrundeliegende Programm mit `programmedata_id` referenziert.

```XML
<programme id="myname-programme-testprogramme-limitcopy" programmedata_id="data-myname-programme-testprogramme" product="1" fictional="1" created_by="myname">
	<!--- licence_flags="4" means: remove from collection when reaching limit -->
	<data licence_flags="4" licence_broadcast_limit="3" price_mod="0.6" />
</programme>
```

## Beispiele

### minimal 

```XML
<programme id="auth-programme-test" product="1" licence_type="1" created_by="documentation">
	<title>
		<de>Reißerischer Titel</de>
	</title>
	<description>
		<de>Ansprechende Beschreibung.</de>
	</description>
	<staff>
		<member index="0" function="1">PersonID</member>
	</staff>
	<groups target_groups="32" />
	<data country="D" year="2021" distribution="2" maingenre="10" flags="16" blocks="4" />
	<ratings critics="5" speed="2" outcome="90" />
</programme>
```

Ein 2021 in Deutschland für das Fernsehen produzierter, langer Trash-Fantasyfilm, der insb. Manager anspricht.
Obwohl Kritiker nicht überzeugt waren und der Film totlangweilig ist, war er ein ziemlicher kommerzieller Erfolg; und das obwohl es keine Darsteller sondern nur einen Regisseur gab.

### Serie

```XML
<programme id="7ad20bf5-c4c6-4237-b52a-b7b189ede0bf" product="7" licence_type="3" tmdb_id="0" imdb_id="" creator="5578" created_by="Ronny">
	<title>
		<de>Rolf Krall besucht...</de>
		<en></en>
	</title>
	<description>
		<de>Der bekannte Moderator [1|Full] ...</de>
		<en></en>
	</description>
	<staff>
		<member index="0" function="1">3bb46451-4b1c-4ae7-90a4-8dbbe66f3bd1</member>
		<member index="1" function="2">a6055f37-ab53-425e-9332-14e0dfabc424</member>
	</staff>
	<groups target_groups="64" pro_pressure_groups="0" contra_pressure_groups="0" />
	<data country="D" distribution="2" maingenre="6" subgenre="" flags="4" blocks="1" price_mod="0.85" />
	<releaseTime year_relative="-1" year_relative_min="1985" year_relative_max="1990" />
	<ratings critics="20" speed="42" outcome="35" />
	<children>
		<programme id="8258fb18-d138-49b4-b07c-0519eec12d2c" product="7" licence_type="2" tmdb_id="0" imdb_id="" creator="5578" created_by="Ronny">
			<title>
				<de>Rolf Krall besucht... Madame Krussaud</de>
				<en></en>
			</title>
			<description>
				<de>Im Schatten ihrer Schwester ...</de>
				<en></en>
			</description>
			<ratings critics="28" speed="32" />
		</programme>
		<programme ...>
		...
		</programme>
	</children>
</programme
```
Diese Fernsehdokumentation wurde ein Jahr vor Spielstart gedreht und spricht vor allem Rentner an.
Die grundsätzlichen Daten werden für die Serie (lizentyp 3) als ganzes definiert, die Einzelfolgen (children mit typ 2) überschreiben dann nur die gewünschten Werte (insb. Titel und Beschreibung).

## TODOs und Fragen

### Dokumentation

* data - weitere eingelesene Felder unterstützen und beschreiben
* mögliche Modifier in Erfahrung bringen

### Generell

* wegen der konfigurierbaren Zahl der Tage muss day aus releaseTime anders interpretiert werden
* Referenzierung von anderen Programmen im Editor umsetzen
* Sollte bei staff nicht eigentlich auch eine Rolle referenziert werden können (Yams Pond als Rolle definieren, in Filmen referenzieren; Nachrichten - neuer Yams-Pond-Film erhöht Attraktivität der Rolle und damit auch ein bisschen für ältere Filme)
* Auswirkung der Lobbygruppe klären: bei Ausstrahlung des Programms verändert sich mein Image bei der entsprechenden Lobbygruppe?