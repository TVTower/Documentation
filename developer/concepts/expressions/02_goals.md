# Ziele der Überarbeitung

* einheitlichere Syntax
* Lesbarkeit beibehalten
* mehr Referenzierungsmöglichkeiten in den Texten
* Vereinheitlichung (Angleichung) was in gamescriptexpression und gameinformation ausgewertet werden kann
* Auswertung von Bedingungen, durch die Datenbankeinträge kürzer schreibbar sind
* Ball flach halten - wir brauchen keine vollständige Programmiersprache

# Stichpunkte

## Auswertungskontext

Es gibt Ausdrücke, die sich global ohne weiteren Kontext auswerten lassen (`${.timeGameDay}`) oder solche, die nur in einem Kontext auswertbar sind (`${.cast:1:Full}` benötigt das Drehbuch oder die Lizenz; `${var1}` benötigt die an dieser Stelle verfügbaren Variablen).
Das spielt insb. für die Auswertung eine Rolle, da die Basisscript-Engine wahrscheinlich keinen Zugriff auf alle GameCollections bekommen soll (kann wegen zyklischer Abhängigkeiten).
D.h. ein Teil der Auswertung muss lokal germacht werden und dann je nach Funktion den allgemeinen Teil ansprechen.

Für Drehbuchvorlagen wäre es wünschenswert, wenn die Rollen-ID gewürfelt werden könnte.
Das würde ermöglichen, dass unterschiedliche Besetzungen für eine Drehbuchvorlage verwendet werden (Geschlecht wird übernommen).
Achtung: falls die Lokalisierung von Namen möglich wird, dürfen Rollenvariablen für das finale Programm noch nicht ersetzt werden.

## erwünschte Funktionen

* die existierenden globalen Auswertungsmöglichkeiten sollen bestehen bleiben
* die Ausdrucksmöglichkeiten für Bedingungen sollen erweitert werden (siehe auch Syntaxvorschläge)
* globale Referenzierung einer Person nach GUID `${.person:person-ronny-001:Full}` (Full, First, Last, (Nick))
* globale Referenzierung einer Rolle nach GUID `${.role:role-ronny-231:First}` (Full, First, Last)
* globale Referenzierung eines Programms nach GUID `${.programme:series-ronny-1:Title}` (Title, CastX, RoleX), wobei Cast und Role die jeweilte GUID zurückliefern
* kontextbezogene Besetzung mit Index `${.cast:1:Last}` (Scripttemplate, Programm)
* kontextbezogene Rolle mit Index `${.castRole:2:Full}` (Scripttemplate, Programm)
* csv-Element per Index referenzieren `${.csv:1:separierter Text}` - ggf. in Varianten, wo man das Trennzeichen definieren kann (erster Parameter ist als Zahl parsebar, dann ";" ansonsten `${.csv:,:2:abc,def,xy}`?)
* minimale Manipulation (Satzanfänge) `${.ucFirst:text}`