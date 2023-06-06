# Skript zur Einrichtung der Serversicherheit

*Lesen Sie dies in anderen Sprachen: [Русский](README.md), [English](README.en.md), [Deutsch](README.de.md)*

---

## Skriptbeschreibung

Dieses Skript ist in der Bash (Bourne Again SHell) für die Kommandozeile geschrieben und dient der automatischen Einrichtung der Serversicherheit auf einem Linux-Server.

Das Skript führt eine Reihe von Operationen aus, darunter Systemupdates, Konfiguration des Webservers, Installation und Konfiguration verschiedener Sicherheitstools, Erstellung eines Nicht-Root-Benutzers und Anwendung entsprechender Sicherheitseinstellungen.

---

## Anwendung

Um dieses Skript anzuwenden, benötigen Sie Zugriff auf einen Linux-Server mit Root-Berechtigungen. Befolgen Sie diese Schritte:

1. Laden Sie das Skript auf Ihren Server herunter. Sie können dies beispielsweise mit dem `scp`-Befehl oder `wget` tun, wenn das Skript zum Download aus dem Internet verfügbar ist.
2. Machen Sie das Skript ausführbar, indem Sie den Befehl `chmod +x script.sh` ausführen, wobei `script.sh` der Name der Skriptdatei ist.
3. Führen Sie das Skript mit dem Befehl `sudo ./script.sh` aus (falls Sie nicht Root sind) oder `./script.sh` (falls Sie bereits Root sind).

---

## Optionen für die Kommandozeile

Dieses Skript unterstützt die `-i`-Option für die Kommandozeile, die das Skript im interaktiven Modus ausführt.

In diesem Modus fordert das Skript vor der Ausführung jeder Operation eine Bestätigung des Benutzers an.

Beispiel: `sudo ./script.sh -i` führt das Skript im interaktiven Modus aus.

---

## Funktionalität des Skripts

Das Skript führt eine Reihe von Operationen aus, um die Serversicherheit automatisch einzurichten. Hier ist, was in der Funktionalität enthalten ist:

- Systemupdates: Das Skript beginnt mit der Aktualisierung der Paketliste in den Repositorys Ihrer Linux-Distribution und aktualisiert dann alle installierten Pakete auf die neuesten Versionen. Dadurch wird sichergestellt, dass Ihr Server die neuesten Sicherheitsupdates enthält.

- Konfiguration des Webservers: Das Skript konfiguriert den Webserver. Es installiert und konfiguriert den Apache Webserver, einschließlich der Einrichtung bestimmter Sicherheitsparameter.

- Installation und Konfiguration von Sicherheitstools: Das Skript installiert und konfiguriert mehrere Sicherheitstools, darunter fail2ban (zur Verhinderung von Brute-Force-Angriffen auf Passwörter), UFW (zur Firewall-Verwaltung) und ClamAV (zur Virenerkennung).

- Erstellung eines Nicht-Root-Benutzers: Zur Verbesserung der Sicherheit erstellt das Skript einen neuen Benutzer mit eingeschränkten Rechten (Nicht-Root) und legt ein Passwort fest. Dadurch wird verhindert, dass potenzielle Angriffe über das Root-Konto erfolgen.

- Konfiguration der SSH-Sicherheit: Das Skript konfiguriert auch die SSH-Sicherheit, indem der Root-Anmeldungen deaktiviert und andere Einstellungen festgelegt werden, um das Risiko von Angriffen zu verringern.

- iptables-Konfiguration: Das Skript konfiguriert iptables und legt Firewall-Regeln fest, um unerwünschten Datenverkehr zu verhindern.

- Konfiguration des Audit-Systems: Das Skript installiert und konfiguriert ein Audit-System, das alle Aktionen und Ereignisse im System zur Sicherheit und Problembehebung verfolgt.

- Einrichtung der Dateiintegritätsüberwachung: Das Skript installiert und konfiguriert ein System zur Überwachung der Dateiintegrität, wie z.B. AIDE (Advanced Intrusion Detection Environment). Dadurch können Sie unerwartete oder verdächtige Änderungen an Dateien auf Ihrem Server überwachen, die auf einen Angriff oder eine andere Sicherheitsbedrohung hinweisen könnten.

- Einrichtung eines Intrusion Detection Systems (IDS): Das Skript installiert und konfiguriert auch ein IDS wie Snort, das verdächtige Aktivitäten erkennen kann, die auf einen Angriffsversuch hindeuten könnten.

---
