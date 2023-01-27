# Beispiele für aktuelle Verwendung von Variablen

siehe auch [Variablen](../../../database_de/main.md#Variablen); Verwendung insb. in Texten in der Datenbank

* `%Name1%` um Variable in einem Eintrag zu referenzieren
* `%WORLDTIME:YEAR%` - aktuelles Jahr im Spiel
* `%WORDLTIME:GAMEDAY%` - aktueller Spieltag
* `%WORDLTIME:DAYLONG%` - Wochentag (Montag, Dienstag...)
* `%WORLDTIME:GERMANCURRENCY%` - aktuelle deutsche Währung
* `%WORLDTIME:GERMANCAPITAL%` - deutsche Hauptstadt (Berlin/Bonn)
* `%STATIONMAP:COUNTRYNAME%` - Name des Landes
* `%STATIONMAP:POPULATION%` - Einwohnerzahl
* `[<Index>|<First|Last|Full]` - Name Besetzung an Index 
* `%ROLE<nr>%` - voller Name der Rolle in Drehbuchvorlage
* `%ROLENAME<nr>%` - Vorame der Rolle in Drehbuchvorlage
* `%GENRE%` - Hauptgenre
* `%EPISODES%` - Anzahl der Episoden
* `%STATIONMAP:RANDOMCITY%` - Zufallsstadtname
* `%PERSONGENERATOR_<NAME|FIRSTNAME|LASTNAME>(<ctry>,<gender>)%` - Name einer Person

# Ausdrücke

insb. in "script="-Definitionen für availability

* `TIME_YEAR=1990` - einfacher Vergleich Jahr
* `TIME_YEAR=1987 &amp;&amp; TIME_WEEKDAY=0 &amp;&amp; TIME_HOUR>=12` - und-verknüpfte Bedingungen
* `TIME_MONTH=1 || TIME_MONTH=7` - oder-verknüpfte Bedingung

# neue Variablenmarker

Verschachtelte Variablen lassen sich mit den Prozentzeichen nicht abbilden.
Daher wurde `${Variable}` als neue Syntax eingeführt.
Dadurch werden Konstrukte wie `${VarPrefix_${ChoiceVar}}` möglich.
Zunächst wird eine Alternative von `ChoiceVar` gewürfelt und ergibt dann den finalen Variablennamen, der dann ausgewertet wird.

Aktuell lassen sich aber keine Bedingungen prüfen.
Z.B. Variable1 wenn das Spieljahr kleiner 1990 ist und Variable2 sonst