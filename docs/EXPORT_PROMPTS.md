# Claude Code export prompts — populate the GitHub repo from your sessions

You have the repo scaffold (this folder). The scaffold has everything *except* the actual analysis code, the exact provenance, the derived tables, and the pinned environments — those live in the Claude Code / Claude Science sessions that ran each arm. Paste the prompt below into **each session**, changing only the `ARM SLUG` line, and it will write that arm's files into the right place. Then run `assemble_local.sh`, commit, and push.

**Point every session at the same local copy of the repo** (e.g. clone/unzip it once, then open each session with that folder available), so they all write into one tree.

---

## Prompt A — per-session export (paste into each arm's session)

> We're packaging this project for a **public GitHub submission** (Claude Science Hackathon 2026, research track). This session produced one arm of the analysis. A repo scaffold exists at the path I'll point you to, with this structure:
>
> ```
> code/            analysis code, one subfolder per module
> arms/<slug>/     results, methods, figures, provenance for one arm
> data/derived/    small aggregated, non-identifiable CSVs (these ARE committed)
> data/download/   scripts that fetch public raw data (raw data is NOT committed)
> environment/     pinned dependencies
> ```
>
> **ARM SLUG for this session:** `<SLUG>`   ← set this (see the slug list I'll give you)
>
> Do the following using **only what actually exists in this session**. Do **not** invent, infer, or reconstruct anything you did not actually run; if something isn't present, say so explicitly instead of guessing. Use only **public, non-identifiable** data — never write any patient-level rows.
>
> 1. **Code.** Collect every script and function this session used to produce its results and figures. Write them into `code/<SLUG>/` as clean, runnable files (`.py` and/or `.R`), each with a one-line header comment naming the figure/table it produces. Strip dead scratch and replace any absolute paths to my machine with a `DATA_DIR` variable read from an env var or a config at the top. Add `code/<SLUG>/README.md` mapping each figure/result → its script → the exact command to run it.
> 2. **Provenance.** Write `arms/<SLUG>/PROVENANCE.md` listing every input dataset this session fetched, with the exact **accession / URL / version / retrieval-date / checksum** you actually recorded (the fetched-or-flagged verification entries). Do **not** type any accession from memory — copy only what the session verified, and flag anything you cannot verify.
> 3. **Derived tables.** Copy the small, aggregated, non-identifiable summary tables this arm produced (per-allele or per-gene summaries — no patient-level rows) into `data/derived/` with clear names, and list them in `arms/<SLUG>/README.md`.
> 4. **Environment.** Emit the exact versions this session used: for Python, write `environment/requirements.<SLUG>.txt` (a real `pip freeze`, or the specific imports with versions); for R, write `environment/r_session_info.<SLUG>.txt` from `sessionInfo()`. Note any external binary used (NetMHCpan, dNdScv, EvoEF2, LOHHLA, MSIsensor/MANTIS) and its version.
> 5. **Fetch line.** If this arm fetched a public dataset, give me the exact `curl`/download command (with the accession/URL you used) so I can confirm it against `data/download/fetch_public_data.sh`.
>
> Write the files into the paths above. Keep it reproducible and honest. **End with a short checklist** of what you wrote, plus anything you could NOT export (e.g. code that only ran inside a Claude Science session, or an input you can't re-verify) so I know what still needs attention.

---

## Slug list — which session gets which `<SLUG>`

Set the `ARM SLUG` line to the slug for whatever that session worked on:

| Session worked on… | `<SLUG>` |
|---|---|
| Engageability metric / crest footprint / master | `engageability` |
| TCR-repertoire-diversity test | `engageability_tcr_diversity` |
| HED (breadth) | `hed` |
| HED positive control (design-capability) | `hed_positive_control` |
| Presentation capacity (C4) + decomposition | `capacity` |
| Peptide selection (C3) | `peptide_selection` |
| Allele-frequency floors | `allele_frequency` |
| α3 / CD8 engagement | `alpha3_cd8` |
| Cancer-favorability arm | `cancer` |
| Autoimmune-risk arm | `autoimmune_risk` |
| Two-arm trade-off | `tradeoff` |
| Drug-HSR | `drug_hsr` |
| Infection / viral-control | `infection_control` |
| HLA-LOH (loss preference, S10, S11, negative controls) | `loh` |
| MSK-50k internal arm | `msk50k_internal` |
| Somatic APM selection (dN/dS) | `somatic_selection_apm` |
| Identifiability theory note | `identifiability` |

**Do NOT run this for the cancer-mimic / viral-mimicry demo session** — that work is excluded from the submission.

**R note:** the `somatic_selection_apm` session is R (dNdScv). For step 4 there, write `sessionInfo()` to `environment/r_session_info.somatic_selection_apm.txt`; skip the `pip freeze` step.

---

## Prompt B — final consolidation (run ONCE, in any session that has the whole repo)

> This repo now has per-arm code, provenance, derived tables, and per-arm environment files exported from each session. Do a consolidation pass, **changing no results**:
>
> 1. Merge the per-arm `environment/requirements.<slug>.txt` into a single deduplicated, version-pinned `environment/requirements.lock.txt` (keep the tightest common version; flag any genuine conflicts rather than silently picking one).
> 2. Verify the headline numbers in `README.md` against the committed `data/derived/` tables (engageability⟂HED r ≈ −0.02; B\*58:01 fraction-lost 0.665 / FDR 0.003; B2M dN/dS). Report any mismatch; do not edit results to match — flag them for me.
> 3. Check that every figure in `docs/FIGURE_INDEX.md` maps to a script in `code/`. List any figure with no source script.
> 4. Confirm no file under `data/derived/` contains patient-level rows (only aggregated per-allele/per-gene summaries). Flag anything that looks per-patient.
> 5. Output a `REPRODUCE.md` at the repo root: the exact ordered commands to go from a clean clone → fetched public data → each headline figure.
>
> End with a punch-list of anything unresolved.
