Der Debugger kann genutzt werden, um z.B. die Stellen zu identifizieren, an denen Segmentation Faults fliegen.
Siehe auch Diskussion in https://github.com/TVTower/TVTower/pull/496.

## Vorbedingungen

* gdb (GNU Debugger) ist installiert
* im Homeverzeichnis ist die Datei `.gdbinit` angelegt mit Inhalt
```
handle SIGPWR nostop noprint
handle SIGXCPU nostop noprint
```
* damit werden Programmunterbrechungen unterdrückt, die durch die Sound-Bibliothek verursacht werden

## Spiel für Debugging kompilieren und starten

* in Blitzmax bei den Developer-Options den Haken bei `GDB Debug Generation` setzen; beim Compilieren wird dann eine TVTower.debug erzeugt
* im Terminal im TVTower-Verzeichnis `gdb TVTower.debug` starten
* wenn der Debugger soweit ist `r`(für run) eingeben, damit das Spiel startet
* bei mir fliegt dann zunächst ein Segmentation Fault im Garbage-Collector (mit `c` für continue fortfahren)
* danach läuft dann das Spiel