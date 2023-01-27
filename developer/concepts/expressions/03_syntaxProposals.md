# Vorschläge für Syntax

## Funktionen ohne Parameter

Syntaxvereinfachung für global verfügbare Information, die keine Parameter benötigt

* `.timeSeason` statt `${.timeSeason}` oder `${.time:Season}`

## primitive Vergleiche

Gleich, größer, kleiner, kleiner oder gleich, größer oder gleich, (ungleich?)

* `.timeSeason=1`, `.timeMont>6`, `.timeYear<=1995`

Wenn eine Bedingung nicht in einem String steht, sondern direkt im XML-Tag, muss die Funktionsschreibweise verwendet werden.

`${.gt:.timeSeason:1995}` oder `${.check:.timeSeason:gt:1995}`, was zwar länger ist, sich aber besser lesen lässt, der der Vergleichsoperator zwischen den zu vergleichenden Werten steht (gt, lt, goe, loe).

## Bedingungen

* `.and:<cond1>:<cond2>:<condn>` - und-Verknüpfung beliebig vieler anderer Bedingungen; Ergebnis 0 oder 1
* `.or:<cond1>:<cond2>:<condn>` - oder-Verknüpfung beliebig vieler anderer Bedingungen; Ergebnis 0 oder 1
* `.if:<cond>:<resultTrue>:<resultFalse>` - Fallunterscheidung: resultTrue falls Bedinung 1, resultFalse sonst (Falsewert optional, Leerstring falls Doppelpunkt weggelassen wird?)

Alternative

Ich würde davon ausgehen, dass sich die Komplexität der Bedingungen in Grenzen hält.
Bei der Verfügbarkeit wird man nicht definieren wollen ("vor 1990 zwischen Juni und Oktober, ab 1990 vor Mai").
Insbesondere bei Drehbüchern etc. wird es darauf hinauslaufen, zwischen zwei Variablen zu unterscheiden, die dann selbst weitere Bedingungen prüfen können.
Daher könnte die If-Bedingung auch abgekürzt werden: `<cond>:<ResultTrue>:<resultFalse>`, wobei der Lesbarkeit wegen die beiden Ergebnisse selbst wieder Variablendefinitionen sein könnten (sollten).
`${.gt:.timeYear:1995:${var1}:${var2}}`


## Availability Scripts

Hier muss ja ein Boolean berechnet werden, der aussagt, ob zu Zeitpunkt die Bedingung erfüllt ist oder nicht.
Außerdem ist klar, dass es sich um einen Ausdruck handelt.
Die umschließende Klammer kann also entfallen.

Die vorhandene Syntax ließe sich also umschreiben (modulo Funktionsumbenennungen) in

* `TIME_YEAR=1990` -> `.timeYear=1990`
* `TIME_YEAR=1987 &amp;&amp; TIME_WEEKDAY=0 &amp;&amp; TIME_HOUR>=12` -> `.and:.timeYear=1987:.timeWeekday=0:.timeHour>=12`
* `TIME_MONTH=1 || TIME_MONTH=7` -> `.or:.timeMonth=1:.timeMonth=7`

## Variablen ohne Sprache

Um Bedingungen in Variablendefinitionen lesbarer zu machen, könnte man überlegen, ob eine Variable einen globalen Wert für alle Sprachen haben können sollte (statt einer Belegung in der "Standardsprace").

```
<after1995>${.gt:.timeYear:1995}</after1995>

statt

<after1995>
	<de>${.gt:.timeYear:1995}</de
</after1995>

um knapper schreiben zu können

<var>${.if:${after1995}:Text1:Text2}</var>
```