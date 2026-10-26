---
name: leseprobe-feedback
description: Write short German feedback (200–300 words, plain text) on a Leseprobe (reading sample / draft chapter) of a Bachelor or Master thesis. Use when the user uploads or points to a PDF or Word file (.pdf, .docx, .doc, .odt) and asks for "Feedback zur Leseprobe", feedback on a thesis draft, a Probekapitel, Exposé-Kapitel or Zwischenstand of a Bachelorarbeit/Masterarbeit. Checks the contribution to the research question, the logical flow of arguments, grammar, citation, sources and writing style. Not for full grading with the Excel Gutachten (use bachelor-thesis-assessment or master-thesis-assessment for that).
---

# Feedback Leseprobe (Bachelor- / Masterarbeit)

Formative feedback on a draft excerpt of a thesis. The goal is to help the student improve the next draft, not to grade. The output is a single block of German plain text of **200–300 words**.

## Workflow

### 1. Extract the text

```bash
.claude/skills/leseprobe-feedback/scripts/extract_text.sh "<file>" > /tmp/leseprobe.txt
wc -w /tmp/leseprobe.txt
```

PDF → `pdftotext`, Word/ODT → `pandoc`. If the PDF yields no text (scan), say so and use OCR (see the `pdf` skill). Read the **full** extracted text before writing; for long samples read it in parts, but never judge from the first pages alone.

### 2. Establish the context

Identify from the sample (or ask only if it cannot be inferred and matters):

- **Level**: Bachelor or Master (title page, "Bachelorarbeit"/"Masterarbeit", degree). Default to the level the user names. Master theses are held to a higher standard of theoretical depth, critical discussion of literature and methodological rigour.
- **Forschungsfrage**: Quote or paraphrase it if stated. If the sample does not state it, infer the likely question from title and introduction and note in the feedback that it should be made explicit.
- **Which part** of the thesis the sample is (Einleitung, Theorie, Methode, Ergebnisse, Diskussion). Judge it against what that part has to achieve.

### 3. Analyse along six dimensions

Work through each dimension and collect concrete evidence (page/section, short quotes). Only the most important points go into the final text.

| Dimension | Guiding questions |
|---|---|
| **Beitrag zur Forschungsfrage** | Does every section serve the research question? Are there descriptive passages, digressions or textbook knowledge without link to the question? Is the relevance (theoretical/practical) clear? |
| **Argumentationslogik** | Is there a red thread (roter Faden)? Do paragraphs build on each other, with transitions and interim conclusions? Are claims supported? Are concepts defined before use and used consistently? Any leaps, repetitions, contradictions? |
| **Grammatik & Rechtschreibung** | Recurring errors (Kommasetzung, Kongruenz, Groß-/Kleinschreibung, dass/das, Satzbau), typos. Name the pattern with 1–2 examples, not an error list. |
| **Zitation** | Is a citation style (e.g. APA 7) applied consistently? Are all claims, figures and definitions referenced? Page numbers for direct quotes? In-text citations match the reference list? Signs of over-reliance on direct quotes or of unreferenced paraphrase (plagiarism risk)? |
| **Quellen** | Quality and currency: peer-reviewed journal articles vs. textbooks, websites, Wikipedia, grey literature. Is the key/recent literature of the field present? Breadth (not one dominant source)? International sources? For Master level: are studies discussed critically rather than summarised? |
| **Schreibstil** | Academic register: objective, precise, no colloquial or judgemental language, no unsupported superlatives, careful with "ich", appropriate sentence length, no filler phrases, consistent terminology and tense, gender-sensitive language if required by the institution. |

### 4. Write the feedback

**Format requirements (strict):**

- German, **200–300 words**. Verify with `wc -w` before returning; revise if outside the range.
- **Plain text**: no Markdown, no headings, no bullet points, no bold, no tables, no emojis. Continuous prose in 4–6 short paragraphs separated by blank lines.
- Address the student directly with **"Sie"** (switch to "du" only if the user asks).
- No grade or points unless the user explicitly asks.

**Structure of the text:**

1. Kurzer Gesamteindruck (1–2 sentences): what the sample does well overall, which part of the thesis it is.
2. Forschungsfrage und Argumentation: contribution to the research question and logical flow — the most important paragraph, usually the longest.
3. Quellen und Zitation.
4. Sprache: grammar and writing style.
5. Priorisierte nächste Schritte: the two or three most important revisions, concrete and actionable.

**Tone and content rules:**

- Balanced: start with genuine strengths, then weaknesses. Be honest about serious problems (e.g. no recognisable research question, missing references) — do not soften them into irrelevance.
- Specific: refer to sections, pages or short quoted phrases ("z. B. in Abschnitt 2.3", "etwa die Formulierung „…“"). Avoid generic remarks that would fit any thesis.
- Prioritise: with only 300 words, select the points with the greatest impact on the quality of the thesis. Do not list every typo.
- Constructive: formulate weaknesses as a recommendation ("Es empfiehlt sich …", "Prüfen Sie …", "Ergänzen Sie …").
- Do not invent: if something cannot be judged from the sample (e.g. the reference list is missing), say so briefly instead of guessing.

See `references/beispiel_feedback.md` for a phrasing bank and an example output.

### 5. Return the result

Output only the feedback text (ready to copy into an e-mail or LMS), followed by nothing else — no preamble like "Hier ist das Feedback". If the user wants a file, save it as `.txt` (UTF-8) named `Feedback_Leseprobe_<Nachname>.txt`.
