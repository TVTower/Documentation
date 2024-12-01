# Lokalisierung

Ab Version 0.8.1 ist es möglich Personen- und Rollendaten zu lokalisieren.
Analog zu Filmtiteln ist es damit möglich, sprachspezifische Schreibweisen oder Namensvarianten zu definieren.
Die Lokalisierung erfolgt in separaten Dateien und nicht in den "Hauptdateien" der Datenbank.

Ab Version 0.8.3 gibt es zusätzlich die Möglichkeit der Definition globaler Variablen.
Das ermöglicht einheitliche Benennungen (z.B. für Markennamen), ohne dass an jeder Stelle dieselben festen Texte hinterlegt werden müssen.
Die Referenzierung erfolgt analog der eintragsspezifischen [Variablen](variables.md) - `${nameGlobaleVariable}`.
Die Standardsprache ist Englisch, d.h. in der Sprachdatei für Englisch werden sämtliche globale Variablen hinterlegt.
Falls es sprachspezifische, abweichende Werte geben sollte, werden entsprchende Variablen in der passenden Sprachdatei überschrieben.

Pro Sprache gibt es eine Datei `<Sprachkürzel>.xml` im Verzeichnis `lang`, welches sich im Basisverzeichnis der Datenbank befindet (z.B. `res/database/Default/lang/en.xml` für Englisch oder `res/database/Default/lang/fr.xml` für Französisch).
Die Sprachkürzel sind dabei dieselben, die auch für die Properties-Dateien unter `res/lang` oder in den Sprachtags für Filmtitel/Variabelen verwendet werden.

Englisch ist die Standardsprache.
Das heißt, dass für jeden Lokalisierungseintrag, der für eine Sprache erstellt wird, auch einer für Englisch existieren muss.

Die Personeneinträge sind als Liste von `person`-Kindelementen in das `persons`-Tag eingebettet, die Rolleneintraäge als List von `programmerole`-Kindelementen in das `programmeroles`-Tag.

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

## Eigenschaften von programmerole

| Name | Art | Beschreibung |
| ---- | --- |------------- |
| guid | Pflicht | Referenz einer existierenden Personen-ID |
| first_name | Optional | Vorname |
| last_name | Optional | Nachname |
| nick_name | Optional | Spitzname |
| title | Optional | Titel |

Fehlende/leere Einträge führen auch zum Überschreiben des Originalwerts.
Es ist also nicht möglich, einfach nur den Vornamen zu überschreiben und den Nachnamen unverändert zu lassen.

## Globale Variablen

Abgesehen von der Stelle, an der sie definiert sind, ähneln globale Variablen den eintragsspezifischen Variablen.
Sie haben einen Namen und einen ("sprachunabhängigen") Wert `<name>wert</name>`.
Aufgrund der Aufteilung der Dateien nach Sprache, gibt es hier keine sprachspezifischen Untertags.
Auf die Variablen kann von überall zugegriffen werden, wo Ausdrücke überhaupt erlaubt sind, nicht nur dort, wo auch Variablen definiert werden können.

In Werbeeinträgen kann man z.B. keine Variablen definieren, wohl aber auf globale Variablen zugreifen.
Die Syntax entspricht dem Zugriff auf normale Variablen - `${name}` für den Zugriff auf die Variable von oben.

Es gibt allerdings einen wichtigen Unterschied zu eintragsspezifischen Variablen.
Globale Variablen unterstützen keine Alternativen `a|b|c`, wobei einer der Werte bei der Auswertung zufällig ausgewählt wird.
Das widerspräche auch dem Zweck globaler Variablen - der datenbankweit konsistenten Benennung.
Bedingungen etc. sind erlaubt.

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
		<programmerole guid="script-roles-ron-001" first_name="Vincent" last_name="Graf" title="" />
	</programmeroles>
	<globalvariables>
		<macrohard>Macrohard</macrohard>
		<germanCurrency>${.gte:${.worldtime:"year"}:2002:"Euro":"DM"}</germanCurrency>
	<globalvariables>
</tvtdb>
```