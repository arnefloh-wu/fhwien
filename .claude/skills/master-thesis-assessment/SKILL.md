---
name: master-thesis-assessment
description: Assess master theses (Masterarbeiten) in communication management and related fields against predefined criteria using the German Excel marking sheet (Gutachten). Use when the user needs to evaluate/grade/mark/assess a master thesis, complete the Gutachten marking sheet, or provide substantiated evaluations across the ten criteria sections. Unlike the bachelor sheet, the master sheet is in German, is oriented toward empirical work (Empiriearbeit), and adds two empirical criteria sections: Empirisches Design and Empirische Ergebnisse. Supports extraction of thesis metadata, structured evaluation writing, and Excel template completion.
---

# Master Thesis Assessment (Masterarbeit-Gutachten)

This skill streamlines the assessment of master theses against predefined academic criteria using the German Excel marking sheet ("Gutachten"). It is the master-level counterpart to the `bachelor-thesis-assessment` skill.

## How the master sheet differs from the bachelor sheet

Before starting, note the key differences so cell references and expectations are correct:

- **Language**: The marking sheet is entirely in **German** (labels, criteria, dropdowns). Write substantiation text in **German** by default to match the sheet, unless the user explicitly asks for another language.
- **Orientation**: The default orientation is **Empiriearbeit** (empirical work), reflected in cell `B3` ("Ausrichtung der Arbeit").
- **Two additional sections**: The master sheet has **nine** graded criteria sections plus the minimum criteria (the bachelor sheet has seven). The two extra sections cover the empirical part:
  - **Empirisches Design** (empirical design / methodology)
  - **Empirische Ergebnisse** (empirical results)
- **Overall grade formula**: The final grade averages **nine** section grades instead of seven.
- **Program**: `B1` is pre-set to "MA Kommunikationsmanagement".

## Workflow

### Step 1: Extract basic information

From the thesis PDF, extract and fill into the template:

| Field | Cell | Source |
|-------|------|--------|
| Titel der Arbeit (title) | `B4` | Title page |
| Name der VerfasserIn (author) | `B5` | Title page |
| Name der BetreuerIn (supervisor) | `B6` | Title page |
| Datum des Gutachtens (assessment date) | `B7` | Current date (format `DD.MM.YYYY`) |

Cells `B1` (Studienbereich), `B2` (Art und Termin der Arbeit), and `B3` (Ausrichtung der Arbeit) are pre-filled in the template. Only change them if the user's case differs — they are dropdown cells (see "Dropdowns" below).

### Step 2: Complete the criteria sections

For each section, write substantiation text into the merged cell in **Column B** and, when the user provides a mark, set the part grade in **Column C**.

The sheet has these sections (top row of each is the section header; criteria items sit in the rows beneath):

| # | Section | Substantiation cell (Col B) | Part-grade cell (Col C) | Suggested word count |
|---|---------|------------------------------|--------------------------|----------------------|
| — | **Mindestkriterien** (minimum criteria) | `B12` | `C12` | 150 (only substantiate if negative/5) |
| 1 | **Fokus** | `B18` | `C18` | 100 |
| 2 | **Struktur** | `B23` | `C23` | 150 |
| 3 | **Theorie** | `B28` | `C28` | 150 |
| 4 | **Empirisches Design** | `B33` | `C33` | 150 |
| 5 | **Empirische Ergebnisse** | `B38` | `C38` | 150 |
| 6 | **Conclusio** | `B43` | `C43` | 150 |
| 7 | **Anspruch** | `B48` | `C48` | 100 |
| 8 | **Literatur** | `B53` | `C53` | 100 |
| 9 | **Formalia** | `B58` | `C58` | 100 |

Each substantiation cell is the first cell of a merged range (e.g. `B18:B20`); writing to the top-left cell (`B18`) fills the whole merged block. The same applies to the Column C grade cells.

Write substantiation text that:
- Addresses all criteria items listed in the section (see "Criteria items per section" below)
- Balances strengths (Stärken) and weaknesses (Schwächen)
- Uses academic evaluation language (see the German phrasing bank below)
- Is specific and evidence-based — reference page numbers, chapters, tables, and figures where relevant
- Meets the target word count for the section

### Step 3: Set part grades (Teilnoten)

Each section's grade cell (Column C) is a dropdown that accepts `1`–`5` (or "klicken + auswählen" when unset). Grades follow the Austrian scale:

| Value | Meaning |
|-------|---------|
| 1 | Sehr gut |
| 2 | Gut |
| 3 | Befriedigend |
| 4 | Genügend |
| 5 | Nicht genügend |

Set a numeric value only when the user provides the mark, or when the user asks you to propose grades. The **Gesamtnote** (cells `C62`/`C63`) is computed automatically by a formula — do **not** overwrite it. It rounds the average of the nine section grades, and returns 5 ("Nicht genügend") if any section is graded 5.

The **Mindestkriterien** grade cell (`C12`) uses a different dropdown: "Mindestkriterien erfüllt" or `5`.

### Step 4: Insert text into Excel

Use openpyxl. Write to the top-left cell of each merged range:

```python
import openpyxl
wb = openpyxl.load_workbook(template_path)
ws = wb.active

# Metadata
ws['B4'] = title
ws['B5'] = author
ws['B6'] = supervisor
ws['B7'] = assessment_date  # 'DD.MM.YYYY'

# Substantiation (write to top-left of each merged block)
ws['B18'] = fokus_text
ws['B23'] = struktur_text
ws['B28'] = theorie_text
ws['B33'] = empirisches_design_text
ws['B38'] = empirische_ergebnisse_text
ws['B43'] = conclusio_text
ws['B48'] = anspruch_text
ws['B53'] = literatur_text
ws['B58'] = formalia_text

# Part grades (only if provided) — leave the Gesamtnote formula untouched
ws['C18'] = 2  # e.g.

wb.save(output_path)
```

Always start from `assets/template_blank.xlsx` so dropdowns, merged cells, and the Gesamtnote formula are preserved.

### Step 5: Save and present

- Save the completed file as `Gutachten_[Nachname].xlsx` (author's last name).
- Copy to `/mnt/user-data/outputs/` for user access.
- Present the file to the user and summarize the proposed grades if any.

## Criteria items per section

These are the exact criteria items in the master sheet. Address each within the section's substantiation text.

- **Mindestkriterien** (`A12`–`A15`): Keine Täuschungsabsicht durch Plagiat oder Ghostwriting; Einhaltung der Standards guter wissenschaftlicher Praxis; Einhaltung des vereinbarten Umfangs; Vollständigkeit und Verständlichkeit der Arbeit.
- **Fokus** (`A18`–`A20`): Prägnanz des Haupttitels, Klärung des Forschungszugangs und -gegenstandes im Untertitel; Klärung wissenschaftlicher und praktischer Relevanz, fokussierte Problemstellung; Realistische, nutzenorientierte Zielsetzung, methodisch bearbeitbare Forschungsfrage(n).
- **Struktur** (`A23`–`A25`): Kompakte Darlegung von Problemstellung, Vorgehen und Ergebnisdiskussion im Abstract; Zielführender Aufbau im Sinne der Beantwortung der Forschungsfrage(n); Ausgewogene Gewichtung der Abschnitte, Vermeidung von Längen und Exkursen.
- **Theorie** (`A28`–`A30`): Definition und Diskussion zentraler Begriffe; Passung, Aktualität und Tiefgang verwendeter Theorieansätze und Modelle; Stringente Verknüpfung von Begriffen, Ansätzen und Modellen.
- **Empirisches Design** (`A33`–`A35`): Methodologische Ausrichtung an Grundannahmen bzw. Hypothesen aus Theorie; Begründete Auswahl von Feldauswahl und Stichprobe; Begründete Auswahl des Erhebungsverfahrens und -instruments.
- **Empirische Ergebnisse** (`A38`–`A40`): Begründete Auswahl und nachvollziehbare Dokumentation des Auswertungsverfahrens; Methodisch angemessene und schlüssige Darstellung der Ergebnisse; Überlegte und nachvollziehbare Interpretation der Ergebnisse.
- **Conclusio** (`A43`–`A45`): Erschöpfende Beantwortung der Forschungsfrage(n); Kritische Diskussion der Ergebnisse im Lichte der aktuellen Debatte; Besprechung von Einschränkungen der eigenen sowie Ausblick auf weiterführende Forschung.
- **Anspruch** (`A48`–`A50`): Eigenständigkeit und Neuheitsanspruch; Kritische Reflexionsfähigkeit; Wissenschaftlicher Schreibstil.
- **Literatur** (`A53`–`A55`): Anzahl der Quellen; Qualität und Aktualität der Quellen; Ausgewogenheit und Variation im Quelleneinsatz.
- **Formalia** (`A58`–`A60`): Logische und ansprechende Gliederung, Verzeichnisse, Abbildungen und Tabellen; Einheitliche Einhaltung der vereinbarten Zitierregeln; Durchgängige Berücksichtigung von Rechtschreibung, Grammatik und Gendering.

## Dropdowns (data validation)

The template preserves the original dropdowns. If you need to set these programmatically:

- `B1` (Studienbereich): list from `$B$69:$B$87` — pre-set to "MA Kommunikationsmanagement".
- `B2` (Art und Termin): list from `$B$93:$B$98` — e.g. "Masterarbeit zur Erstvorlage", "Masterarbeit zur Wiedervorlage".
- Section grades `C18`–`C60`: list `1`–`5` (from `$A$73:$A$78`).
- Mindestkriterien grade `C12`: "Mindestkriterien erfüllt" or `5` (from `$A$83:$A$85`).

## German academic evaluation language

Write substantiation in German to match the sheet. Useful phrasing:

### Positive (Stärken)
- "zeugt von einem fundierten Verständnis"
- "bietet eine umfassende und differenzierte Analyse"
- "belegt methodisch souverän"
- "wird nachvollziehbar und schlüssig hergeleitet"
- "folgt einer stringenten, zielführenden Argumentation"
- "entspricht den Anforderungen auf Masterniveau"

### Critical (Schwächen)
- "bleibt an der Oberfläche"
- "wäre durch ... zu vertiefen"
- "ist nicht hinreichend begründet"
- "lässt die notwendige kritische Distanz vermissen"
- "weist methodische Schwächen auf"
- "erschließt sich nur teilweise"

### Balanced (ausgewogen)
- "Während ... überzeugt, wäre ... zu verbessern."
- "Die Arbeit leistet ..., allerdings bleibt ... hinter den Erwartungen zurück."
- "... ist solide umgesetzt; gleichwohl würde ... die Arbeit deutlich stärken."

### Empirical sections — specific vocabulary
- **Empirisches Design**: Forschungsdesign, Methodologie, quantitativ/qualitativ, Hypothesen, Operationalisierung, Stichprobe(nziehung), Feldzugang, Erhebungsinstrument (Fragebogen/Interviewleitfaden), Gütekriterien (Reliabilität, Validität, intersubjektive Nachvollziehbarkeit).
- **Empirische Ergebnisse**: Auswertungsverfahren (z. B. Regressionsanalyse, Strukturgleichungsmodell, qualitative Inhaltsanalyse, Codierung), Dokumentation, Darstellung (Tabellen, Abbildungen), Interpretation, Bezug zu den Hypothesen bzw. Forschungsfragen.

See `references/evaluation_examples.md` for full worked examples, including the two empirical sections.

## Word count management

Verify word counts after writing and adjust:
- **Over**: remove filler, combine sentences, eliminate redundancy.
- **Under**: add specific evidence (page/chapter references), expand observations.

```python
word_count = len(text.split())
print(f"Word count: {word_count}")
```

## Assets

The `assets/` directory contains:
- `template_blank.xlsx` — the blank master Gutachten template (dropdowns, merged cells, and Gesamtnote formula intact). Always start from this file.

The `references/` directory contains:
- `evaluation_examples.md` — German worked examples of substantiation text for each section.
