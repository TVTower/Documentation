# Database migration guide

## 0.8.2 -> 0.8.3

Für die Version 0.8.3 wurde die Verarbeitung von [Variablen](variables.md) umgestellt.
Es gab aber auch weitere Aufräumarbeiten bezüglich der Datenbanksyntax.
Hier eine beispielhafte Auflistung der wichtigsten Änderungen.
Typischerweise handelt es sich um die Umstellung der alten Variablensyntax auf die neue Expressionsyntax.
Eine Plausibilitätsprüfung für die Vollständigkeit der Migration ist möglich, indem man in der Ergebnisdatei nach Prozentzeichen sucht.
Diese sollten (neben Kommentaren) nur noch an den Stellen auftauchen wo das Prozentzeichen wirklich in Texten vorkommen soll.

* **Variablensyntax**: `%Varibalenname%` -> `${Variablenname}`
* **Referenzen auf Besetzung**: `[1|Full]` etc. -> `${.self:cast:1:"fullname"}` etc.
* **Referenzen auf Rollen**: `%ROLE1%` bzw. `%ROLENAME1%` -> `${.self:"role":1:"fullname"}` bzw. `${.self:"role":1:"firstname"}`
* **Personengenerator**: `%PERSONGENERATOR_NAME(de,2)%` etc. -> `${.persongenerator:"fullname":"de":"female"}` etc.
* **Zeitreferenzen**: `%WORLDTIME:XXX%` -> `${.worldtime:"xxx"}`
* **Zufallsstädtenamen**: `%STATIONMAP:RANDOMCITY%` -> `${.stationmap:"randomcity"}`

Zeitreferenzen kommen mit Vergleichen und logischen Operatoren auch in der Definition  der Verfügbarkeit von Filmen/Nachrichten/Drehbuchvorlagen vor.

* **Vergleich =**: `X=Y` -> `${.eq:X:Y}`
* **Vergleich <=**: `X<=Y` -> `${.lte:X:Y}`
* **Vergleich <**: `X<Y` -> `${.lt:X:Y}`
* **Vergleich >=**: `X>=Y` -> `${.gte:X:Y}`
* **Vergleich >**: `X>Y` -> `${.gt:X:Y}`
* **logisches oder**: `X||Y` -> `${.or:X:Y}`
* **logisches und**: `X&amp;&amp;Y` -> `${.and:X:Y}`

Weiterhin gab es Umbenennung von XML-Attributnamen, um die spielinterne numerische ID sauber von der in der Datenbank verwendeten alphanumerischen GUID zu trennen:

* `person id=` -> `person guid=`
* `programme id=` -> `programme guid=`
* `programmedata_id=` -> `programmedata_guid=`
* `news id=` -> `news guid=`
* `thread_id=` -> `thread_guid=`
* `achievement id=` -> `achievement guid=`
* `task id=` -> `task guid=`
* `reward id=` -> `reward guid=`
* `ad id=` -> `ad guid=`

Mit dem folgenden Script (Linux) können eine Reihe der Ersetzungen automatisch durchgeführt werden.
Die alte Syntax für `<availability ... script=...` muss von Hand an die neue Expressionsyntax angepasst werden!

```
#!/bin/bash
# script for migrating most old variables/expressions to the new syntax
# based on code by Ronny - see https://github.com/TVTower/TVTower/pull/1189
# availability script expressions must be updated manually
# search for "script=" in the database files

# Find all XML files in current directory and subdirectories
find . -type f -name "*.xml" | while read -r file; do
    # Replace cast references [x|y] 
    # with the correct format including specific names (fullname, lastname, etc.)
    sed -E -i '
    s/\[([0-9]+)\|([Ff]ull)\]/${.self:\"cast\":\1:\"fullname\"}/g;
    s/\[([0-9]+)\|([Ll]ast)\]/${.self:\"cast\":\1:\"lastname\"}/g;
    s/\[([0-9]+)\|([Nn]ick)\]/${.self:\"cast\":\1:\"nickname\"}/g;
    s/\[([0-9]+)\|([Ff]irst)\]/${.self:\"cast\":\1:\"firstname\"}/g
    ' "$file"

    # Replace role references (now index based so number is reduced by 1)
    # Loop through numbers 1 to 15 for ROLENAME and ROLE placeholders
    for i in $(seq 1 15); do
        # Calculate (i-1) - obsolete
        j=$((i))

        sed -E -i "s/%ROLENAME$i%/\${.self:\"role\":$j:\"firstname\"}/g" "$file"
        sed -E -i "s/%ROLE$i%/\${.self:\"role\":$j:\"fullname\"}/g" "$file"
    done

    # Replace person generator entries
    sed -E -i 's/%PERSONGENERATOR_([a-zA-Z]+)\(([uU][nN][kK]),([0-9])\)%/\${.persongenerator:\"\L\1\":\"\":\3}/g' "$file"
    sed -E -i 's/%PERSONGENERATOR_([a-zA-Z]+)\(([a-zA-Z]+),([0-9])\)%/\${.persongenerator:\"\L\1\":\"\L\2\":\3}/g' "$file"
    sed -E -i 's/\$\{.persongenerator:([^:]*):([^:]*):1\}/${.persongenerator:\1:\2:\"male\"}/g' "$file"
    sed -E -i 's/\$\{.persongenerator:([^:]*):([^:]*):2\}/${.persongenerator:\1:\2:\"female\"}/g' "$file"
    sed -E -i 's/\$\{.persongenerator:\"name\"/${.persongenerator:\"firstname\"/g' "$file"

    # Replace worldtime (incomplete!!)
    sed -E -i 's/%WORLDTIME:YEAR%/${.worldtime:\"year\"}/g' "$file"
    sed -E -i 's/%WORLDTIME:GAMEDAY%/${.worldtime:\"dayplaying\"}/g' "$file"

    # Replace random city
    sed -E -i 's/%STATIONMAP:RANDOMCITY%/${.stationmap:"randomcity"}/g' "$file"

    # Replace regular variable refrences %name% with ${name} 
    # where name can be letters, numbers, or underscores
    sed -E -i 's/%([a-zA-Z0-9_]+)%/\${\1}/g' "$file"

    # Restore replaced instances comments (usually in a URL with special characters)
    sed -E -i 's/\$\{C3\}/%C3%/g' "$file"
    sed -E -i 's/\$\{E2\}/%E2%/g' "$file"
    sed -E -i 's/\$\{C8\}/%C8%/g' "$file"

	# ID name refactoring
	sed -E -i 's/programme id=/programme guid=/g' "$file"
	sed -E -i 's/person id=/person guid=/g' "$file"
	sed -E -i 's/news id=/news guid=/g' "$file"
	sed -E -i 's/thread_id=/thread_guid=/g' "$file"
	sed -E -i 's/achievement id=/achievement guid=/g' "$file"
	sed -E -i 's/task id=/task guid=/g' "$file"
	sed -E -i 's/reward id=/reward guid=/g' "$file"
	sed -E -i 's/ad id=/ad guid=/g' "$file"
	sed -E -i 's/programme id=/programme guid=/g' "$file"
	sed -E -i 's/programmedata_id=/programmedata_guid=/g' "$file"
    echo "Processed $file"
done


#single step replacer snippets
#find . -type f -name "*.xml" -print0 | xargs -0 sed -i -e 's/%STATIONMAP:RANDOMCITY%/${.stationmap:"randomcity"}/g'
#find . -type f -name "*.xml" -print0 | xargs -0 sed -i -e 's/%\([[:alnum:]_]*\)%/${\1}/g'
```