# Aufsetzen der Entwicklungsumgebung für den Datenbank-Editor

Die Installation erfolgt analog des Aufsetzens für die Verwendung (siehe [Anleitung](installation.md)) mit folgenden Anpassungen
* benötigt wird ein JDK
* für Java-8-Kompatibilität wählt man als Produkt am besten das Eclipse IDE for Java Developers in der Version 2020-06; insb. wenn man auch das Editor-Produkt bauen möchte.
* als Oomph-Setup verwendet man `https://raw.githubusercontent.com/TVTower/TVTDatabaseEditor/master/TVTDbEditor_Dev.setup`.
    * dieses Setup installiert Xtext, klont das Editor-Git-Repository (aber nicht das TVTower-Repository!), importiert die Plugin-Projekte
* als Target-Platform wählt man auf der Variablenseite ebenfalls 2020-06

Direkt nach der Installation und dem erforderlichen Neustart sollten im Package-Explorer eine Reihe von `org.tvtower.db`-Projekten (noch mit Fehlermarkierung) vorhanden sein.

## Generierung

Initial einmal und immer wenn es Änderungen an der Grammatik gegeben hat, muss der Xtext-Generator angeworfen werden.
Bei einfachen Erweiterungen im Java-Code kann dieser Schritt entfallen.

* In der `Run`-Aktion den Punkt `Generate Database...` anklicken
* oder Im Projekt `org.tvtower.db` das Kontextmenü für die Datei `src/org.tvtower.db/GenerateDatabase.mwe2` öffnen und `Run As -> MWE2 Workflow` wählen.

Wenn sich ein Dialog öffnet, der darauf hinweist, dass noch Fehler existieren, kann man bestätigen dass das in Ordnung ist.
Nun läuft der Generator los und baut aus der Xtext-Grammatik den Parser und haufenweise Infrastrukturcode. In der Console sieht man den Fortschritt. Nach einer Weile sollte dort dann `... - Done.` stehen, die Konsole als `<terminated>` markiert sein und der Java-Build starten (`Building: (x%)` in der Statusleiste).

Nach Abschluss des Builds ist der Editor gebaut und es sollte in keinem der Projekte mehr ein Fehler sein (es sei denn man hat inkompatible Grammatikänderungen vorgenommen, die nun repariert werden müssen).


## Runtime-Eclipse starten

Um den Editor in Aktion zu sehen, wird ein Runtime-Eclipse gestartet, in dem dann der Editor verfügbar ist.
In der `Run`-Aktion den Punkt `Launch Runtime Eclipse` anklicken.

(Es kann hier zu Problemen führen, wenn die plattformspezifischen Plugins nicht passen.
Für diesen Fall unter `Run Configurations` in der `Run`-Aktion die Konfiguration öffnen und `Plugins`-Reiter nicht alle Plugins selektieren, sondern nur die Workspace-Plugins und dann rechts die `required plungins` ergänzen.
Die Fehlermeldungen beim Start helfen, die noch fehlenden Plugins nach und nach zu ergänzen.)

Im Runtime-Eclipse (einmalig, danach ist das Projekt bei jedem Neustart schon da)
* Git-Repositories-View öffnen (ggf. via Quickaccess `Strg-3` den View suchen)
* Importieren des (zuvor selbst geklonten) TVTower-Repositories (Kontext-Menü im Repositories-View)
* Im Kontextmenü des `Working Tree`-Knotens des TVTower-Repositories den Punkt `Import Projects` wählen. Dort sollte in der mittleren Box TVTower selektiert sein (Import as Eclipse project); mit `Finish` abschließen.
* Im Project Explorer sollte jetzt das TVTower-Projekt erschienen sein.
Beim allerersten Öffnen einer `res/database/default`-Datenbankdatei wird man noch gefragt, ob das Projekt in ein Xtext-Projekt konvertiert werden soll.
Das muss bestätigt werden.