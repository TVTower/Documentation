# Lokalisierung

Ab Version 0.8.1 ist es möglich Personen- und Rollendaten zu lokalisieren.
Analog zu Filmtiteln ist es damit möglich, sprachspezifische Schreibweisen oder Namensvarianten zu definieren.
Die Lokalisierung erfolgt in separaten Dateien und nicht in den "Hauptdateien" der Datenbank.
Pro Sprache gibt es eine Datei `<Sprachkürzel>.xml` im Verzeichnis `lang`, welches sich im Basisverzeichnis der Datenbank befindet (z.B. `res/database/Default/lang/en.xml` für Englisch oder `res/database/Default/lang/fr.xml` für Französisch).
Die Sprachkürzel sind dabei dieselben, die auch für die Properties-Dateien unter `res/lang` oder in den Sprachtags für Filmtitel/Variabelen verwendet werden.

Englisch ist die Standardsprache.
Das heißt, dass für jeden Lokalisierungseintrag, der für eine Sprache erstellt wird, auch einer für Englisch existieren muss.

Die Personeneinträge sind als Liste von `person`-Kindelementen in das `persons`-Tag eingebettet, die Rolleneintraäge als List von `role`-Kindelementen in das `programmeroles`-Tag.

## Eigenschaften von person

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | Referenz einer existierenden Personen-ID |
| first_name | Optional | Vorname |
| last_name | Optional | Nachname |
| nick_name | Optional | Spitzname |
| title | Optional | Titel |

Fehlende/leere Einträge führen auch zum Überschreiben des Originalwerts.
Es ist also nicht möglich, einfach nur den Vornamen zu überschreiben und den Nachnamen unverändert zu lassen.

## Eigenschaften von role

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | Referenz einer existierenden Personen-ID |
| first_name | Optional | Vorname |
| last_name | Optional | Nachname |
| nick_name | Optional | Spitzname |
| title | Optional | Titel |

Fehlende/leere Einträge führen auch zum Überschreiben des Originalwerts.
Es ist also nicht möglich, einfach nur den Vornamen zu überschreiben und den Nachnamen unverändert zu lassen.

## Beispiel einer Lokalisierungsdatei

```XML
<?xml version="1.0" encoding="utf-8"?>
<tvtdb>
	<persons>
		<person guid="common-amateur-actors" last_name="Laiendarsteller" nick_name="Laiendarsteller" />
		<person guid="common-amateur-director" first_name="" last_name="Regiepraktikant" nick_name="Regiepraktikant" />
/>
	</persons>
	<programmeroles>
		<role guid="script-roles-ron-001" first_name="Vincent" last_name="Graf" title="" />
	</programmeroles>
</tvtdb>
```