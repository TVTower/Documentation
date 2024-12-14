# Erfolge (achievement)

Die Erfolgseinträge sind als Liste von `achievement`-Kindelementen in das `allachievements`-Tag eingebettet.

```XML
<allachievements>
	<achievement guid="tvt-gameachievement-audience1" creator="5578" created_by="Ronny">
		<title>
			<de>Lokalsender</de>
			<en>Regional broadcaster</en>
		</title>
		<tasks>
			<task guid="tvt-gameachievement-task-audience1" creator="5578" created_by="Ronny">
				<title>
					<de>Erreiche 250.000 Zuschauer</de>
					<en>Reach an audience of 250.000</en>
				</title>
				<text>
					<de>Strahle ein Programm aus und erreiche damit mindestens 250.000 Zuschauer.</de>
					<en>Broadcast a programme and reach an audience of at least 250.000.</en>
				</text>
				<data type="reachAudience" minAudienceAbsolute="250000" checkMinute="5" />
			</task>
		</tasks>
		<rewards>
			<reward guid="tvt-gameachievement-reward-audience1" creator="5578" created_by="Ronny">
				<data type="money" money="50000" />
			</reward>
		</rewards>
		<data flags="0" group="1" category="1" index="1" sprite_finished="gfx_datasheet_achievement_img_level1" sprite_unfinished="gfx_datasheet_achievement_img_level0" />
	</achievement>
</allachievements>
```

Für das Erfüllen einer oder mehrerer Aufgaben (`task`) gibt es eine Belohnung (`reward`).
Der Erfolg (`achievement`) selbst hat oft keine Beschreibung (`text`), da diese aus der Aufgabe erstellt wird.
Im obigen Fall muss während einer Sendung (`checkminute` + `category`) eine Zuschauerzahl (`reachAudience`) von 250.000 (`minAudienceAbsolute`) erreicht werden.
Dann gibt es eine Belohnung von 50.000 Geld (`type`+`money`).

## Eigenschaften von achievement

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | [GUID](main.md#guid), insb. für Referenzierung bei Nachfolgenachrichten |
| creator | Metadaten optional | [Standardeigenschaft](main.md#creator) |
| created_by | Metadaten optional | [Standardeigenschaft](main.md#created_by) |
| comment |  informativ  |[Standardeigenschaft](main.md#comment) |

## Kindelemente von achievement

Das Standardelement Titel [title](main.md#title) muss angegeben werden, ein beschreibender Text [text](main.md#text) ist optional und wird typischerweise automatisch aus der Aufgabe erstellt.

### Aufgaben (tasks)

Im Hauptknoten `tasks` kann eine Liste von Einzelaufgaben `task` definiert werden, die erfüllt werden müssen.
Typischerweise ist es genau eine Aufgabe.
Die Standardkindelemente `title` und `text` sind optional (und werden vermutlich gar nicht verwendet).
Eine Aufgabe hat dieselben Standardeigenschaften `id`, `creator` und `created_by` wie auch der Elternknoten auch.

Das entscheidende Kindelement sind die Aufgabendaten `data`.
Daraus ermittelt das Programm, wann die Aufgabe erfüllt ist.
Man muss die `type`-Eigenschaft (siehe unten) definieren.
Welche anderen dann benötigt werden, hängt vom Typ ab.

#### type="reachAudience"

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| minAudienceAbsolute | optional | absolute Zuschauerzahl |
| minAudienceQuote | optional | Einschaltquote (0.2 entspricht 20%)|
| limitToGenres | optional | Aufgabe gilt nur für Ausstrahlungen dieses Genres |
| limitToFlags | optional | Aufgabe gilt nur für Ausstrahlungen mit diesen Flags |
| checkMinute | optional | Minute in der geprüft wird |
| checkHour | optional | Stunde in der geprüft wird |

Durch das Angeben der Minute kann man bestimmen, ob die Zuschauerzahl während einer normalen Sendung oder einer Nachrichtensendung erreicht werden soll.
Aber selbst Zuschauerzahl oder Quote sind optional, so könnte man z.B. über Genre und Flags den Spieler belohnen, der zuerst eine Kultur-Sendung ausstrahlt.

`<data type="reachAudience" minAudienceAbsolute="1000000" checkMinute="5" checkHour="3">` - Um 3:05 Uhr müssen 1 Mio. Zuschauer eingeschaltet haben.

#### type="reachBroadcastArea"

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| minReachAbsolute | optional | absolut zu erreichende Zuschauerzahl im Sendegebiet |
| minReachPercentage | optional | prozentuale Abdeckung des gesamten Sendegebiets |

`<data type="reachBroadcastArea" minReachAbsolute="20000000">` - Das Sendegebiet muss 20 Mio. Zuschauer erreichen können.

#### type="BroadcastNewsShow"

Hier können für jeden Nachrichtenslot Genre (`genre`), Schlüsselwort (`keyword`), minimale Qualität (`minQuality`) und maximale Qualität (`maxQuality`) gefordert werden.
Der Slot wird als Zahl zwischen 1 und 3 an den Bezeichner gehängt.

`<type="BroadcastNewsShow" genre1="5" keyword2="weatherforecast" minQuality3="80">` - Nachrichtensendung mit Kulturnachricht im ersten Slot, Wetterbericht im zweiten und einer Nachricht mit Qualität mindestens 80 im dritten.

### Belohnung (rewards)

Im Hauptknoten `rewards` kann eine Liste von Einzelbelohnungen `reward` definiert werden, die der Spieler bei Erfüllung der Aufgabe erhält.
Aktuell gibt es nur Geldbelohnungen.
Eine Belohnung hat dieselben Standardeigenschaften `id`, `creator` und `created_by` wie auch der Elternknoten auch.
Die Standardkindelemente `title` und `text` für die Beschreibung der Aufgabe sind optional und können automatisch aus den Belohnungsdaten ermittelt werden.

Das entscheidende Kindelement sind die Belohnungsdaten `data`.
Der `data`-Knoten hat folgenden Eigenschaften:

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| type | Pflicht | Typ der Belohnung (aktuell nur money) |
| money | optional | Betrag der Geldbelohnung|

Wenn man in einer Belohnung dieselbe `id` nochmal verwendet, kann man die Daten der zuvor definierten Belohnung "wiederverwenden".

### Daten (data)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| category | Pflicht | AchievementCategory (siehe unten) |
| group | Pflicht? | Zahl für die Gruppierung von Erfolgen |
| index | Pflicht | Position innerhalb der Gruppe |
| flags | optional | Flags (siehe unten) 0 und 2 am häufigsten |
| sprite_finished | optional | ID für das Bild, wenn der Erfolg erreicht wurde |
| sprite_unfinished | optional | ID für das Bild, wenn der Erfolg noch nicht erreicht wurde |

Die Sprites definiert man vorrangig dann, wenn es Gold-, Silber- und Bonzeversion desselben Erfolgs gibt. (siehe in `config/gfx.xml` den Abschnitt zu Achievements)

## spezifische Werte achievement

| **AchievementCategory** | Bedeutung |
|------------------------ | --------- |
| 0 | alle |
| 1 | Programm |
| 2 | Nachrichten |
| 4 | Sendegebiet |
| 8 | Sonstiges |

| **TaskType** | Bedeutung |
|------------- | --------- |
| reachAudience | bei einer Ausstrahlung eine bestimmte Zuschauerzahl/-Quote erreichen |
| reachBroadcastArea | eine bestimmte Größe des Sendegebiets erreichen |
| BroadcastNewsShow | einen bestimmten Nachrichtenmix senden |

Siehe `game.achievements.bmx` die RegisterCreators-Definitionen am Ende der Datei.

| **AchievementFlag** | Bedeutung |
|-------------------- | --------- |
| 1 | kann schief gehen (Einmal-Erfolg) |
| 2 | nur erster, der die Aufgabe erfüllt, gewinnt |

Aktuell sind nur 0 und 2 in der Datenbank in Verwendung. 1 könnte eher für spontane Erfolge innerhalb des Spiels verwendet werden.

## Beispiele

## TODOs und Fragen

### Dokumentation

Wenn man mehrere Tasks definieren würde, müssen die dann am selben Tag erfüllt werden? Beispiel dreimal reachAudience für checkHour 6, 7, 8 um eine bestimmte Quote im Frühstücksfernsehen zu prüfen; oder Kulturprogramm während der gesamten Prime-Time.

### Generell

* Wenn es schon einen Reward-Typ gibt, wäre es dann nicht sinnvoller den Wert generisch zu machen? (type="money" value="50000", type="betty" value="5", type="image" value="1")
* Achievement-Flags noch nicht in der Konstantenklasse
* Die aktuelle Definition von checkHour könnte zu restriktiv sein. Damit scheint sich nämlich nicht prüfen zu lassen "zur Primetime" also zwischen 19 und 23 Uhr. (Erste Kultursendung zur besten Sendezeit)