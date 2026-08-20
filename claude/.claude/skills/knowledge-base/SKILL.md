---
name: knowledge-base
description: Yannics persönliche Knowledge-Base unter ~/knowledge-base-bruegger-yannic lesen und pflegen (OKF v0.2 + Quartz). Verwenden, wenn in einer Sitzung wiederverwendbares Wissen entsteht — eine teuer erkaufte Erkenntnis, eine Entscheidung samt Begründung, ein wiederholbarer Ablauf, ein Fakt über Yannics Setup, Werkzeuge, Projekte oder Vorlieben — und es festgehalten werden soll. Ebenso verwenden, wenn nach vorhandenem Wissen gesucht wird ("weiß ich das schon?", "was habe ich damals entschieden?", "steht das in meiner Knowledge-Base?"), wenn eine Notiz geändert, als überholt markiert oder verlinkt werden soll, und wenn die Quartz-Site gebaut, geprüft oder deployt wird. Gilt rechnerweit, in jedem Projekt und jedem Chat.
---

# Knowledge-Base

Ort: `~/knowledge-base-bruegger-yannic` (Kürzel unten: `$KB`).
Format: OKF v0.2 — ein Verzeichnis Markdown-Dateien mit YAML-Frontmatter, eine Datei pro Konzept,
Verlinkung über gewöhnliche Markdown-Links. Veröffentlicht mit Quartz.

```bash
KB=~/knowledge-base-bruegger-yannic
```

## Suchen

```bash
rg -il "<begriff>" $KB/content                     # Dateien finden
rg -n "<begriff>" $KB/content --type md -C2        # Fundstellen im Kontext
cat $KB/content/index.md                           # Bereichsübersicht
sed -n '1,40p' $KB/content/<bereich>/index.md      # Inhalt eines Bereichs
```

Beim Zitieren den Pfad nennen. Fehlt in einer Notiz das Feld `verified:`, ist sie von einem
Agenten geschrieben und ungeprüft — das gehört dazugesagt.

## Neu anlegen

Erst vorschlagen, dann anlegen. Nie stillschweigend ins Repo schreiben.

```bash
cd $KB
OKF_ACTOR=claude-code/claude-opus-5 scripts/okf-new.sh <bereich> "<Titel>"
```

Bereiche: `konzepte`, `projekte`, `werkzeuge`, `runbooks`, `entscheidungen`, `menschen`, `references`.
Das Skript gibt den Pfad der erzeugten Datei aus. Danach Frontmatter füllen und den Body schreiben:

* `title`, `description` (ein Satz) und `tags` immer setzen — die `description` landet in den Indizes.
* `status: draft` der Vorlage auf `stable` ändern, sobald die Notiz steht.
* Bei alterndem Wissen `stale_after` setzen: eigene Setups ~12 Monate, Fremdsoftware/Preise/Rollen
  ~6 Monate, zeitlose Fakten gar nicht.
* Externes Wissen bekommt `sources:` mit mindestens `resource:` je Eintrag.
* Mindestens ein Link hinaus und einer herein, absolut: `[Quartz](/werkzeuge/quartz.md)`.
* Struktur schlägt Prosa: Überschriften, Tabellen, Listen, Codeblöcke.

Dann:

```bash
cd $KB && npm run validate && npm run index
```

Und eine Zeile in `content/log.md` unter dem heutigen Datum, mit Link auf die Notiz.

## Ändern

Inhalt anpassen, `generated.at` aktualisieren. Hat sich die Aussage inhaltlich geändert, ein
vorhandenes `verified:` **entfernen** — eine alte Bestätigung gilt nicht für neuen Text.
Bei rein redaktionellen Korrekturen bleibt es stehen.

## Grenzen

* **Niemals `verified: human:yannic` setzen.** Das ist Yannics Signatur; er vergibt sie beim
  Gegenlesen selbst.
* **Nichts löschen.** Überholtes bekommt `status: deprecated` und einen Verweis auf den Nachfolger.
* **Keine Geheimnisse** — Tokens, Passwörter, Schlüssel, Kundendaten. Alles auf `main` ist
  potenziell öffentlich.
* **Keine privaten Daten Dritter** in `menschen/`; nur beruflich Relevantes.
* **Kuration läuft über `main`.** Was gemerged ist, ist veröffentlicht. Committe nicht ungefragt
  auf `main`; im Zweifel Branch anlegen und nachfragen.

## Site

```bash
cd $KB
npm run serve            # http://localhost:8080, Live-Reload
npm run build            # nach public/
npm run deploy           # prüfen, bauen, rsync (braucht .env.deploy)
scripts/setup-quartz.sh  # Quartz installieren/aktualisieren
```

Details: `$KB/README.md`, `$KB/CLAUDE.md`,
`$KB/content/runbooks/wissen-erfassen.md`, `$KB/content/konzepte/open-knowledge-format.md`.
