# HLA class I engageability — a new axis of immune potency, and a reproducible escape finding

**Claude Science Hackathon 2026 · Research track**
Rebecca Nadler · 4th-year MD-PhD Student · Weill Cornell / Memorial Sloan Kettering / Rockefeller

---

> **New to GitHub?** See [`HOW_TO_UPLOAD_TO_GITHUB.md`](HOW_TO_UPLOAD_TO_GITHUB.md) — no coding needed, just drag-and-drop.

## Summary

We set out to test whether a single HLA class I "immunogenic potency" axis trades cancer protection against autoimmune risk (antagonistic pleiotropy). We built a new, validated, sequence-derived measure of that potency — **engageability** — proved that potency is **not one number but several independent axes**, showed with math and power analysis **why public data cannot answer the germline trade-off**, and then followed the statistical power to where the data *can* speak: somatic immune escape across ~50,000 tumors. There we recover a clean positive control (**B2M loss-of-function selection**) and a novel, reproducible finding — a **locus-wide HLA-B loss/retention hierarchy under HLA-LOH, with B\*58:01 the one allele individually singled out as preferentially lost**.

Every arm is pre-registered, every number traces to fetched primary data, and the pipeline caught and retracted its own false positives three separate times.

## Headline results

| Result | Number | Status |
|---|---|---|
| Engageability is a new axis, orthogonal to HED | Pearson **r = −0.02** across 676 alleles | validated |
| Potency is multi-axis (same cancer spec) | HED β ≈ −0.15 (p ≈ 0.03) vs engageability β ≈ +0.07 (n.s.), opposite signs | reproducible |
| Germline trade-off is non-identifiable from outcome data | effective N ≈ 8; blind power never reaches 80% | proven |
| Positive control — B2M loss-of-function selection | truncating dN/dS ≈ 9.7 (q = 3×10⁻⁴); frameshift ≈ 30.7 (q = 1.3×10⁻¹⁰); HLA-C negative control collapses to 1.87 (CI incl. 1) | validated |
| **Finding — B\*58:01 preferentially lost under HLA-LOH** | frac-lost **0.665, FDR 0.003, n = 164**; locus-wide HLA-B Bradley–Terry LRT p = 0.0002 | novel, reproducible |

See [`docs/FRAMING.md`](docs/FRAMING.md) for the full framing, figure list, and reviewer Q&A.

## Repository map

```
docs/         Framing, figure index, reviewer Q&A, video script
prereg/       Frozen pre-registration documents (per arm) — read these first for rigor
arms/         One folder per experimental arm: results.md, methods.md, figures, derived tables
code/         Analysis code, organized by module (Python + R)
data/         download/ = scripts to fetch public inputs; derived/ = aggregated tables
figures/      Key figures used in the write-up and video
environment/  Pinned dependencies (Python, R) and external-tool notes
notebooks/    One runnable notebook reproducing a headline number end-to-end
```

## Reproducibility

All inputs are **public / open-access** — see [`DATA_ACCESS.md`](DATA_ACCESS.md) for every source and how to fetch it. No controlled-access or patient-identifiable data is used or committed.

Quickstart:

```bash
# 1. Python environment
pip install -r environment/requirements.txt
# 2. R environment (for dNdScv somatic-selection arm) — see environment/R_environment.md
# 3. Fetch public inputs
bash data/download/fetch_public_data.sh
# 4. Reproduce the headline finding (runs from the committed table; no downloads needed)
jupyter notebook notebooks/reproduce_headline.ipynb   # recomputes B*58:01 = 0.665, FDR 0.003
```

Each figure traces to the script that produced it (see [`docs/FIGURE_INDEX.md`](docs/FIGURE_INDEX.md)) and every constant traces to fetched primary text (provenance ledgers in each arm folder).

## Scope and honest limitations

Association- and sequence-level, not causal or clinical. HED and the antagonistic-pleiotropy *concept* are prior work; our contributions are the engageability metric, the orthogonality decomposition, the identifiability analysis, and the somatic findings. The somatic and germline arms measure different estimands and are not claimed to converge. The B\*58:01 finding is pan-cancer and its loss *mechanism* (CD8 T-cell escape vs NK/KIR, given B\*58:01 is Bw4) is left open. Full limitations in [`docs/FRAMING.md`](docs/FRAMING.md).

## Built with

Analyses were run in Claude Science / Claude Code sessions with per-figure code, environment, and methods captured for auditability.

## License

Code: [MIT](LICENSE). Text/figures: CC BY 4.0. Third-party data retain their own terms — see [`DATA_ACCESS.md`](DATA_ACCESS.md).
