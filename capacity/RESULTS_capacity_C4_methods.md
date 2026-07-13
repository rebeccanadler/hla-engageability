# Methods & Provenance — Presentation-Capacity Axis (C4)

*Companion to `RESULTS_capacity_C4.md`. Frozen inputs, scoring definitions, source-coherence items, invariants, and machine-readable outputs. Sourced from `methods_capacity_C4.md` (§1/§3/§9) and each input's own verification column. Nothing rederived.*

## Predictor, run, catalog
- **NetMHCpan 4.1b**, called directly, flags `-p -BA`. A printed "4.2" is a hardcoded-path artifact; resolved truth is 4.1b.
- Grid: 676/676 alleles (A 218 / B 331 / C 127), 2,028 tasks, 0 errors, 17.86 h. Seed **20260709** throughout.
- Source CSV: `per_allele_summary.csv` (sha256 `be9d5a2e…`), 676 rows, 24-col schema, `neo/self/sim_units_N = 2000/2000/500` on every row. Tarball `06f2c9f2`.
- Assembled master: `capacity_axis_master.csv` — the 676-allele join of capacity + HED + engageability + frequency/supertype, plus per-allele Wilson CIs and `train_status` ∈ {PRESENT (158), ABSENT_FROM_TRAINING (518)}.

## What the axis is (methods §1)
Capacity = per-allele fraction of a fixed antigen set an allele presents, scored by best-window predicted affinity. Deliberately **not novel**: a per-allele analog of the residue-centric PHBR presentation score (Marty et al. 2017, *Cell* 171:1272, doi 10.1016/j.cell.2017.09.050). Decomposition headline = *known presentation axis (capacity) vs. novel recognition axis (engageability)*. **Not PHBR recomputed** — PHBR uses %Rank (correct for genotype-vs-fixed-mutation); capacity compares alleles over a fixed mutation set, for which %Rank is graded against each allele's own random-peptide background and is the wrong unit. Same construct, different unit, different correct scoring.

## Two scoring definitions (methods §3)
- **PRIMARY — affinity (`-BA`)**: binder iff best window ≤ **500 nM**. `capacity = binder_fraction`.
- **SECONDARY — %Rank** (eluted-ligand SB+WB): descriptive only, not composited, not promoted. `(rank_SB+rank_WB)/units_N`.
- Affinity-primary rationale: %Rank binder fraction ≈ its threshold by construction for every allele (random-proteome ≈ the per-allele background), so it cannot express cross-allele capacity.

## ⚠ Carried flagged, NOT asserted — 500 nM / Sette-1994 (methods §3, Open item 1)
The 500 nM threshold is *understood* to be A\*02:01-derived (Sette 1994, transgenic A\*0201 mice, A\*0201-motif HBV peptides). This attribution is **memory-typed — not recorded in any tracked document — verify against the primary source before it is quotable.** Carried here flagged, not asserted. It is load-bearing (one of two mechanisms behind the zero-neo alleles; feeds check ii).

## Antigen sets (methods §4)
- **Neoepitope**: TCGA MC3 open-access MAF (GDC), GRCh37/GENCODE, `FILTER==PASS`, unique non-synonymous SNV, N = 2,000.
- **Self**: UniProt Swiss-Prot reviewed human, release 2026_02 (20,431 canonical), proteome-residue unit, N = 2,000.
- **Null**: MC3-derived 96-channel trinucleotide null (no imposed COSMIC signature), N_sim = 500 (= N/4). Supports a **rank correlation across the catalog only — never per-allele**. Declared one-sided in advance.
- Windows: every 8/9/10/11-mer over the mutated/sampled residue (38 windows); exhaustive tiling, **no length mix imposed**.

## Design SE (methods §5)
N = 2,000 → max binomial SE = 0.5/√2000 = **1.118 pp**. (The frozen "≥100 expected binders" floor was unsatisfiable — p_min = 0 at every rung — and corrected to the distribution-free bound 0.5/√N ≤ δ, δ = 0.0125 ⇒ N_min = 1,600; N = 2,000 with round-number margin. δ's value scales the frozen ratio-spread by observed p̄ = 0.1585 — stated, not eliminated.)

## Zeros (methods §6)
Observed at grid: **7 neo, 6 self, 12 null** alleles at binder_count = 0. Each carried at capacity = 0, units_N = 2,000, rule-of-three upper 0.0015. Never dropped/imputed/floored. The 7 zero-neo: B\*08:02, B\*51:07, B\*51:22, C\*07:04, C\*07:12, C\*18:01, C\*18:02.

## HED projection (check iii lock) — rebuilt, gate-checked
Frozen lock: `freqweighted_median` PRIMARY, `freqweighted_mean` sensitivity only. The delivered `hed_per_allele.csv` carried only unweighted mean/median, so the projection was rebuilt (user-directed, no re-scrape) from `hed_pairwise_{A,B,C}.csv` × `afnd_freqs_676.json`:

> `freqweighted_median_HED(i)` = freq_median-weighted mean of allele i's pairwise HED to same-locus partners; self excluded; partners with freq_median = 0 carry zero weight but every allele still receives a projection (335 zero-median alleles handled per `hed_freqweight_quarantine.csv`; quarantine match verified True, freq_mean abs-diff 0.0).

**Hard gate:** mean **7.05** (exact), range **4.00–11.14** (exact); SD full-precision **1.3848** — a rounding-boundary straddle 0.0002 below 1.385. Mean + both endpoints exact rule out the two named failure modes (zero-weight handling; bad join). r(capacity, HED) is scale-invariant, so SD does not enter it. **Gate cleared by the author.** Output: `hed_freqweighted_projection.csv`.

## Independence unit (methods §9) — supertype
For the **capacity** correlation the clustering unit is the **Sidney/Sette supertype** (capacity is a pocket-motif binding quantity; supertype groups alleles by pocket motif), NOT the allele and NOT the engageability profile. Per-locus this leaves A and B with ~5–6 supertype units each. **HLA-C has no clean supertype scheme, so its capacity correlation is arithmetically unavailable — stated, not shown.**

## Bounds carried (methods §9)
- MC3 PASS variants come from surviving tumors → passengers carry weak residual immunoediting; the null replicate (check iv) is the one-sided check on it.
- Antigen processing (proteasome, TAP) not modeled. Proteome sample is a crude self-proxy → self-capacity noisier than neo-capacity. Capacity precisely measured for all 676 (max SE ≤ 1.118 pp), zeros included.

---

## Source-coherence items (resolved)
1. **`methods_capacity_C4.md`** — supplied; §1/§3/§9 carried verbatim. Provenance no longer reconstructed from the CSV column.
2. **500 nM / Sette-1994** — carried flagged, not asserted (see above); a pre-submission verification item.
3. **HLA-C engageability-profile count** — the "2 profiles" figure is a Grantham-ε=6 quantity on a different axis (catalog also gives 1 contact-triple / 19 raw values). Per methods §9 this granularity-dependent count is **not** the basis for C's exclusion from check (iii) — the missing supertype scheme is. Carried that way; the number is not reconciled because it is not the basis.

## Frozen invariants — confirmation
- **Order:** (i)→(ii)→(iii)→(iv) then descriptives.
- **Affinity-primary, no rescoring:** every number on the delivered 4.1b affinity/‑BA output; %Rank secondary/descriptive; nothing rescored.
- **Projection lock:** freqweighted_median primary, freqweighted_mean sensitivity only.
- **Supertype df:** check (iii) graded against A = 6, B = 6 supertypes; never n = 676.
- **Leave-A\*02:01-out:** run on every reported statistic; max |Δ| 0.015.
- **One-sided substrate declaration:** made before the number; concordance branch.
- **Zeros as rows:** 7 neo / 6 self / 12 null, rule-of-three 0.0015.
- **Fetched-or-flagged:** `capacity_axis_master.csv` carries per-row `verification` + `train_status`.

## Statistical conventions
Spearman ρ throughout (capacity, HED, support are non-normal). Per-allele CIs are Wilson 95%. Partial correlations via rank-residual regression. Supertype-clustered permutation: 20,000 draws, seed 20260709, HED permuted between supertypes.

---

## Machine-readable outputs

| file | contents |
|---|---|
| `capacity_axis_master.csv` | 676-allele join, two scorings, Wilson CIs, verification + train_status |
| `provenance_ledger.md` | full §1/§3/§9-anchored provenance |
| `hed_freqweighted_projection.csv` | rebuilt locked HED projection (both columns) |
| `variance_table.csv` | check (i) full grid |
| `train_support_confound_a.csv`, `..._b_partial.csv`, `leave_A0201_out_deltas.csv`, `zero_neo_train_support_descriptive.csv` | check (ii) |
| `hed_nonredundancy_allele_and_panel.csv`, `hed_supertype_collapsed_points.csv`, `hed_supertype_graded_r.csv`, `hed_supertype_clustered_permutation.csv` | check (iii) |
| `substrate_check.csv` | check (iv) |
| `neo_self_correlation.csv`, `per_length_breakdown.csv` | descriptives |
| `capacity_C4_checksums.sha256` | sha256 of every emitted artifact |

**STOP.** Admission to E-ORTH is the author's call and is not made here. This document reports the actual numbers, including all nulls and zeros, and characterizes the result as neither positive nor negative.
