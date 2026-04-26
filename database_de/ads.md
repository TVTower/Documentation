# Werbung (ad)

Die Werbeeinträge sind als Liste von `ads`-Kindelementen in das `allads`-Tag eingebettet.

```XML
<allads>
	<ad guid="527e41eb-a641-49b9-a521-e921ec652e23">
		<title>
			<de>Plöpp-Bier</de>
			<en>Pop'Beer</en>
		</title>
		<description>
			<de>Prickelndes Hopfengold...</de>
			<en>Tingling hop gold...</en>
		</description>
		<conditions min_audience="1.56" min_image="4" target_group="256" pro_pressure_groups="0" contra_pressure_groups="0"/>
		<data quality="15" repetitions="3" duration="3" profit="976" penalty="1550" infomercial_profit="97" fix_infomercial_profit="1"/>
	</ad>
</allads>
```

Um diesen Werbevertrag zu erfüllen müssen dreimal (`repititions`) innerhalb von drei Tagen (`duration`) eine von der Reichweite abhängige Anzahl (`min_audience`) von Männern (`target_group`) einschalten.
Um die Werbung überhaupt angeboten zu bekommen, ist ein Image von mindestens 4% erforderlich (`min_image`).


## Eigenschaften von ads

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | [GUID](main.md#guid), insb. für Referenzierung bei Nachfolgenachrichten |
| creator | Metadaten optional | [Standardeigenschaft](main.md#creator) |
| created_by | Metadaten optional | [Standardeigenschaft](main.md#created_by) |
| comment |  informativ  |[Standardeigenschaft](main.md#comment) |

## Kindelemente von ads

Standardelemente für Titel [title](main.md#title), Beschreibung [description](main.md#description) 
sind Pflicht, genau wie die nachfolgend beschriebenen Elemente für Bedingungen ([conditions](ads.md#Bedigungen-conditions)) und werbespezifische Daten ([data](ads.md#Daten-data)).
Mit Verfügbarkeit [availability](time.md#Verfügbarkeit) kann man steuern, wann die Werbung grundsätzlich zur Verfügung steht.

### Bedingungen (conditions)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| min_audience | optional | Mindestzuschauerzahl |
| min_image | optional | Mindestsenderimage (0-100) |
| max_image | optional | Höchstsenderimage (0-100) |
| target_group | optional | [Zielgruppe(n)](main.md#Zielgruppe) für die zu erreichenden Zuschauerzahl |
| allowed_genre | optional | erlaubtes [Hauptgenre](main.md#Genre) |
| allowed_programme_flag | optional | erlaubte [Programmflags](main.md#Programmflags) |
| prohibited_programme_flag | optional | verbotene [Programmflags](main.md#Programmflags) |

Die Mindestzuschauerzahl `min_audience` bezieht sich auf die Gesamtreichweite im aktuellen Sendegebiet (in Prozent).
(Die Zuschauerquote hingegen wird aufgrund der zur jeweiligen Zeit möglichen Zuschauer ermittelt.)
Ist die Reichweite also 10 Mio, bedeuten `minaudience="2.5"` 250000 Zuschauer, was je nach Sendezeit unterschiedlich hohe Zuschauerquoten verlangen würde.

Falls Zielgruppen definiert sind, wird der Wert bezüglich der Reichweite der Zielgruppe interpretiert.
Jugendliche machen ca. 10% der Gesamtzuschauer aus.
Bei 10 Mio Zuschauer gibt es also 1 Mio Jugendliche, so dass der Wert 2.5 einer geforderten Zuschauerzahl von 25000 Jugendlichen entsprechen würde.

### Daten (data)

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| available | optional | verfügbar (Wahrheitswert) |
| type | optional | Vertragstyp (0=normal, 1=nur für Spielevents) |
| quality | optional | Qualität (Default 10) |
| repetitions | Pflicht | Anzahl Wiederhlungen |
| duration | Pflicht | Anzahl der erlaubten Tage |
| profit | Pflicht | Basis für Ertragsberechnung pro Spot |
| penalty | Pflicht | Basis für Berechnung Vertragsstrafe pro Spot|
| fix_price | optional | Wahrheitswert, Profit und Strafe skalieren nicht mit Reichweite(level) |
| infomercial | optional | als Dauerwerbesendung erlaubt (Wahrheitswert) |
| infomercial_profit | optional | Basis für Etragsberechnung Infomercial |
| fix_infomercial_profit | optional | Wahrheitswert, Einnahmen für Infomercials nicht dynamisch berechnet |
| blocks | optional | Anzahl Sendeblöcke des Infomercials |
| pro_pressure_groups | optional | angesprochene [Lobbygruppe](main.md#Lobbygruppe) |
| contra_pressure_groups | optional | abgeschreckte [Lobbygruppe](main.md#Lobbygruppe) |

`profit`/`penalty` ist der Basiswert für die Ermittlung des Erlöses bzw. der Vertragsstrafe pro Spot.
Es ist der Betrag pro 1000 Zuschauer der Mindestzuschauerzahl.
Ist also die Mindestzuschauerzahl 20000 und der Profit-Wert ist 350 ergeben sich als Einnahmen für einen Spot 20*350=700.
Mit steigender Reichweite steigt aber der Abschlag.
Geht zu Beginn des Spiels fast der volle Basiswert in de Rechnung ein, sind es bei vollem Senderausbau ca. 30% weniger.

Sofern die Werte nicht als unveränderlich markiert wurden (`fix_infomercial_profit`), wird der Wert für `infomercial_profit` noch mit einem Faktor multipliziert, der sich aus Image, Reichweite, Qualität etc. berechnet.
Deshalb kann auch bei einem hohen `infomercial_profit`-Wert ein geringerer Erlös pro Spot resultieren als bei einem 
niedrigen.

### Modifier

Syntax siehe auch [modifiers](main.md#modifiers).
Mögliche Anpassungen sind

| Name | Bedeutung |
| -----| --------- |
| topicality::infomercialRefresh | Erholung nach Ausstrahlung als Infomercial (0.8 langsamer, 1.2 schneller) |
| topicality::infomercialWearoff | Aktualitätsverlust bach Ausstrahlung als Infomercial (0.8 weniger, 1.2 mehr) |

Beispiel: `<modifier name="infomercialWearoff" value="0.7" />`

Der Einfluss der Modifier (insb. Wearoff) dürfte aber praktisch irrelevant sein, da berechneten Werte durch die geringen Zuschauerzahlen praktisch immer außerhalb der Min-Max-Grenzen liegen.

## TODOs und Fragen

### Dokumentation

* profit beeinflusst Belohnung pro Spot - genauer beschreiben
* infomercial-Profit genauer beschreiben
* data-quality=nochmal Einfluss prüfen (nicht nur Infomercial)

### Generell

* conditions:  pro_pressure_groups, contra_pressure_groups  noch nicht ausgewertet
* der Quellcode unterstützt noch Effekte und Modifiers, welche in der aktuellen Datenbank nicht vorkommt und von der Grammatik nicht unterstützt werden
* sollte allowed genre nicht eher eine Liste sein. Bei der großen Anzahl von Genres erscheint es nicht immer sinnvoll, nur ein einziges zu erlauben/verbieten. Verbotene aktuell komplett ausgebaut
* Zahlreiche definierte Werbeverträge verlangen eine Zuschauerzahl, die im Spiel überhaupt nicht erreicht werden kann.