# Video Submission Script — 3:00 exact
**HLA Class I Engageability · Built with Claude: Life Sciences (research track)**

Timing target ≈ 150 words/min (≈ 2.5 words/sec). Full narration ≈ 450 words. Segment clocks are cumulative. Read at a steady pace; the [VISUAL] cues are the on-screen figure at that moment (numbers match `SUBMISSION_framing_and_figures.md`).

---

### 0:00 – 0:20 · The question
[VISUAL: Fig 1 — hypothesis schematic]

> Every HLA allele your immune system carries is a trade-off. The same molecule that helps your T-cells kill a tumor might also drive autoimmune disease. We asked a simple question: is there a single axis of HLA "immune potency" that's good against cancer but risky for autoimmunity — and can we measure it from sequence alone?

### 0:20 – 0:42 · A new tool
[VISUAL: Fig 2 — TCR-facing crest surface → Fig 3 — engageability vs HED]

> So we built one. We call it **engageability**: how permissively an allele's TCR-facing surface admits *diverse* T-cell receptors. We scored all 676 class I alleles from crystal structures. It recovers the known TCR contact residues exactly, and — critically — it's **orthogonal to HED**, the established breadth metric, at r of −0.02. A genuinely new, independent dimension.

### 0:42 – 1:05 · Potency is not one number
[VISUAL: Fig 4 — HED vs engageability side-by-side → Fig 5 — capacity vs HED]

> And that changes the picture. Run through the *same* cancer analysis, breadth and engageability point in **opposite directions** — one negative and significant, one positive and not. Add presentation capacity and CD8 engagement, and "potency" stops being a single number. It's a **multi-axis decomposition** — several independent immunological dials, not one.

### 1:05 – 1:35 · The honest turn
[VISUAL: Fig 6 — non-identifiability curves → Fig 7 — blind power curve]

> Here's where we were rigorous instead of lucky. The germline trade-off, tested directly, came back null — but we can prove *why*. Mathematically, regressing outcome on potency **cannot** separate immune escape from immune killing; the arms are non-identifiable. And on public data the effective sample size is about eight independent points. Our pre-registered power analysis never reaches 80%. The null isn't a finding — it's the data telling us it can't answer this question.

### 1:35 – 2:15 · Follow the power → the finding
[VISUAL: Fig 9 — dN/dS mismapping diagnostic → Fig 11 — Bradley–Terry loss preference → Fig 12 — negative control]

> So we followed the statistical power to where the data *is* deep: somatic immune escape across fifty thousand tumors. Our pipeline first recovers the known control — loss-of-function selection on **B2M**, with a built-in negative control passing exactly as it should. Then the new result. Across the HLA-B locus we find a robust loss-and-retention hierarchy, and at its loss-prone extreme one allele stands out: **B\*58:01 is preferentially lost** — fraction 0.67, FDR 0.003. It survives a four-check adversarial review; it's **not** a mapping artifact, **not** haplotype-driven, and **not** in the cohort's own paper.

### 2:15 – 2:35 · The method
[VISUAL: Fig 13 — reproduced positive control; provenance / pre-registration montage]

> And none of it was cherry-picked. Every arm was pre-registered. The pipeline caught its *own* false positives three separate times and retracted them on honest controls. Every number traces to fetched primary data. This is disciplined, reproducible science with Claude.

### 2:35 – 3:00 · Why it matters, and what's next
[VISUAL: translational schematic — "deleted = high-pressure targets / escape risk" vs "retained = durable TCR-T restriction elements" → title card]

> And it points somewhere. HLA loss is how tumors escape — so the allele a tumor *refuses* to delete is one it can't easily flee, a **durable restriction element for TCR-based therapy**. The alleles it *does* delete flag the peptides it fears most. So the next step writes itself — and it's one we can take straight to the bench: map what B\*58:01 and the retained alleles present, and prioritize the escape-proof targets. A new axis of immune potency, a proof of what public data can answer, and a reproducible lead to build the next therapy on. That's the work.

---

## Production notes
- **Total narration ≈ 450 words → ~3:00 at 150 wpm.** The clinical "so what" and future-work now have a dedicated closing beat (2:35–3:00) instead of a tacked-on clause. If you run long, the single trimmable sentence is "It recovers the known TCR contact residues exactly, and —" in *0:20–0:42*; speaking at 155–160 wpm also absorbs any overage.
- **The therapy logic in one line for the slide:** *deleted alleles (B\*58:01) = high-immune-pressure peptides + escape liability; retained alleles (B\*07:02, B\*08:01, A\*01:01) = escape-durable TCR-T restriction elements.* The 2:35 visual should show exactly this two-column contrast.
- **Numbers said aloud are rounded** (0.67, r −0.02, FDR 0.003, ~8 points, 80%) — exact values live on the slides, not in the voiceover.
- **Framing guardrails (do not violate on screen or in voice):**
  - Don't claim engageability *causes* B\*58:01 loss — the crest→loss link dissolved to a Bw4/Bw6 KIR confound; loss mechanism (CD8 T-cell vs NK/KIR) is stated as **open**.
  - Say "B\*58:01 is the one allele individually singled out as preferentially lost, inside a locus-wide HLA-B hierarchy" — not "the only allele lost." The retained alleles (B\*07:02, B\*08:01, A\*01:01) are the significant *retention* side.
  - Don't claim the somatic finding "confirms" the germline hypothesis — different estimands, fenced apart.
- **Finding-forward alternative cut:** open cold on the 1:35 finding (B\*58:01) as a 15-second hook, then tell the engageability/decomposition story as "how we got here," and keep 2:35 as the close. Same figures, reordered.
