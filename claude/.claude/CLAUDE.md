# Persönliche Knowledge-Base

Yannic pflegt eine Wissensbasis unter `~/knowledge-base-bruegger-yannic`
(OKF v0.2 in `content/`, git-versioniert, veröffentlicht mit Quartz).
Sie gilt **rechnerweit**, unabhängig davon, in welchem Projekt oder Chat du gerade bist.

## Achtung beim Schreiben in ~/.claude

`~/.claude` ist ein stow-Symlink nach `~/dotfiles/claude/.claude`, und dieses Repo ist
**öffentlich**. Was du hier ablegst — CLAUDE.md, Skills, Agents, Settings — ist damit potenziell
für alle sichtbar. Keine Geheimnisse, keine Kundennamen, keine internen Details.

## Nachschlagen

Bevor du über Yannics Setup, Vorlieben, Projekte, Werkzeuge oder frühere Entscheidungen
spekulierst: dort nachsehen.

```bash
rg -il "<begriff>" ~/knowledge-base-bruegger-yannic/content
```

Was du von dort übernimmst, benennst du mit Quelle, z. B.
„laut `content/entscheidungen/2026-08-20-okf-als-wissensformat.md`".
Notizen ohne `verified:`-Feld sind ungeprüft — sag dazu, wenn du dich darauf stützt.

## Hineinschreiben

Entsteht in einer Sitzung Wissen, das **über diese Sitzung und dieses Projekt hinaus**
wiederverwendbar ist — eine Erkenntnis, die spürbar Zeit gekostet hat; eine Entscheidung samt
Begründung; ein Ablauf, der sich wiederholt; ein Fakt über Yannics Kontext, den kein Agent
erraten kann — dann **schlage vor**, es dort zu erfassen, und lege es nach seinem Ja an.

Nicht erfassen: was Quellcode, `git log` oder offizielle Doku ohnehin sagen; Projektinterna,
die ins jeweilige Repo gehören; Geheimnisse jeder Art.

Zum Anlegen den Skill `knowledge-base` verwenden — er kennt Format, Ablauf und Grenzen.
Schreibende Zugriffe laufen immer über einen Vorschlag an Yannic, nie stillschweigend.
