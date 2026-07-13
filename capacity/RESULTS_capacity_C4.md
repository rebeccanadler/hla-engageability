# Results — Presentation-Capacity Axis (C4)

*Per-allele HLA class I presentation capacity, NetMHCpan 4.1b. Allele-level analysis on the full 676-allele common class I catalog (A 218 / B 331 / C 127). N = 2,000 antigens/arm, N_sim = 500, seed 20260709.*

**What this arm asks.** Is per-allele *presentation capacity* — the fraction of a fixed antigen set an allele binds — a distinct, admissible axis for the cancer/autoimmunity trade-off, or is it redundant with HLA evolutionary divergence (HED)? Capacity is deliberately **not novel**: it is a per-allele analog of the published PHBR presentation measure (Marty et al. 2017, *Cell* 171:1272). The novel axis in this project is *engageability* (TCR-docking permissiveness); capacity is the third, known axis that engageability and HED are tested against.

Capacity is admitted to the orthogonality analysis (E-ORTH) only if it clears three checks **in order** — variance, training-support confound, non-redundancy with HED — each pre-registered. A fourth, one-sided substrate check bounds the immunoediting confound but does not decide admission. **This document reports the numbers; the admission decision is the author's and is not made here.** The result is characterized as neither positive nor negative.

Companion methods/provenance and full tables: `RESULTS_capacity_C4_methods.md`. Machine-readable outputs: the per-check CSVs listed at the end. All figures are 300 dpi.

---

## Two scoring definitions, carried in parallel

| definition | rule | role |
|---|---|---|
| **Affinity-capacity** (`-BA`) | binder = best window binds ≤ **500 nM**; `capacity = binder_fraction` | **PRIMARY** |
| **%Rank-capacity** (eluted-ligand) | `(rank_SB + rank_WB) / units_N` | secondary, descriptive only |

The two are never composited, and %Rank is never promoted after seeing which carries more spread. Neo- and self-capacity are likewise kept as two separate features throughout.

---

## Check (i) — Variance: affinity-capacity is a real axis, %Rank is not

Per-locus between-allele SD and distinct-value count, both arms × both scorings. The design fixes the maximum per-allele binomial SE at **1.118 pp** (0.5/√2000); the realized max is 1.118 pp exactly. Zeros are retained as rows (capacity = 0, units_N = 2,000, rule-of-three upper 0.0015). The engageability axis, for scale, has per-locus SD **A 0.796 / B 0.579 / C 0.298** (unitless z-scores).

| arm | scoring | locus | SD (pp) | mean (pp) | distinct values | min–max (pp) | n_zero |
|---|---|---|--:|--:|--:|--:|--:|
| neo | affinity | A | **14.21** | 23.50 | 128 | 1.05–58.10 | 0 |
| neo | affinity | B | **10.88** | 12.39 | 225 | 0.00–58.10 | 3 |
| neo | affinity | C | **10.64** | 11.33 | 80 | 0.00–41.40 | 4 |
| self | affinity | A | 13.54 | 21.19 | 134 | 0.95–54.05 | 0 |
| self | affinity | B | 10.26 | 12.01 | 220 | 0.00–52.65 | 2 |
| self | affinity | C | 9.57 | 10.78 | 79 | 0.00–38.05 | 4 |
| neo | %Rank | A | 5.37 | 55.65 | 121 | 41.80–65.50 | 0 |
| neo | %Rank | B | 5.58 | 58.76 | 202 | 44.80–69.05 | 0 |
| neo | %Rank | C | 3.59 | 63.34 | 72 | 54.95–70.70 | 0 |
| self | %Rank | A | 6.40 | 53.43 | 116 | 39.30–67.05 | 0 |
| self | %Rank | B | 5.43 | 59.54 | 198 | 46.10–72.95 | 0 |
| self | %Rank | C | 3.54 | 62.65 | 68 | 53.05–73.35 | 0 |

- **Affinity-capacity varies.** Per-locus SD 10.6–14.2 pp is ~10–13× the 1.118 pp per-allele SE, across 80–225 distinct values/locus. This is a wide, well-resolved axis, not flat-with-tight-CIs. It should be treated as a real axis.
- **%Rank-capacity is compressed** (SD 3.5–6.4 pp, means clustered at 53–63%). This is the pre-registered **per-allele %Rank normalization**: the %Rank binder fraction ≈ its threshold by construction, because each allele's %Rank is graded against its own random-peptide background. Reported as methods, not as two biologies disagreeing — which is exactly why affinity is primary.
- **Seven zero-neo alleles** (B\*08:02, B\*51:07, B\*51:22, C\*07:04, C\*07:12, C\*18:01, C\*18:02) carry capacity = 0 with 95% Wilson upper 0.00192 and rule-of-three upper 0.0015 — retained as rows in every statistic, never dropped or imputed.

![Variance and per-allele CIs]({{artifact:art_d0a4e74e-28ce-41df-ac97-c3d7c0b5408f}})
**Figure 1.** (a) Between-allele SD per locus, both arms × both scorings, against the 1.118 pp design SE. (b) Per-allele neo affinity-capacity sorted within locus with 95% Wilson CIs; zero-capacity alleles ringed at baseline.

---

## Check (ii) — Training-support confound: capacity is not a NetMHCpan artifact

NetMHCpan predicts affinity worse for sparsely-trained alleles, so capacity could be tracking training density rather than biology. Three frozen defenses test this.

**(a) Correlation with training support.** Capacity is weakly correlated with `train_support_n` — near zero overall and at A/B, but not zero everywhere: at HLA-C the affinity correlation is **+0.13** (neo ρ = +0.135, self ρ = +0.131), the largest per-locus value.

| scope | neo-aff ρ | p | self-aff ρ | p |
|---|--:|--:|--:|--:|
| overall | −0.053 | 0.172 | −0.046 | 0.228 |
| A | −0.021 | 0.763 | −0.025 | 0.711 |
| B | −0.086 | 0.119 | −0.075 | 0.174 |
| C | **+0.135** | 0.131 | **+0.131** | 0.142 |

No correlation reaches significance (all p > 0.11), and the overall relationship is negligible (ρ = −0.05) — but the honest bound is per-locus **|ρ| ≤ 0.14 (max at C)**, not ≤0.09.

**(b) Partial correlations.** Conditioning capacity's downstream relationships (with HED and engageability) on `train_support_n` barely moves them — |Δρ| ≤ 0.011 everywhere. The capacity–HED and capacity–engageability signals are not training-support artifacts.

| downstream | capacity | scope | r_raw | r_partial | Δ |
|---|---|---|--:|--:|--:|
| HED (fw_median) | neo-aff | overall | −0.132 | −0.127 | +0.005 |
| HED (fw_median) | neo-aff | A | −0.447 | −0.447 | +0.000 |
| HED (fw_median) | neo-aff | B | −0.123 | −0.112 | +0.011 |
| engageability_A | neo-aff | overall | +0.082 | +0.086 | +0.004 |

**(c) Leave-A\*02:01-out (mandatory).** A\*02:01 sits at the 99.9th percentile of training support (n = 13,025). Removing it re-runs every reported statistic with **max |Δ| = 0.015** — nothing collapses; no result is A\*02:01-carried.

**Descriptive prediction (not a test).** The A\*02:01-calibration mechanism predicts the zero-neo alleles should be lowest on training support. They are: **6 of 7 have `train_support_n = 0`**. But the catalog is saturated at zero — **81.4%** of alleles have `train_support_n = 0` and **84.9%** have `train_support_ba_n = 0` — so "lowest support" is a large tie most of the catalog shares. Reported as **consistent-but-weakly-discriminating, not a demonstration.**

![Training-support confound]({{artifact:art_056730a6-7f6b-488e-866b-870836493409}})
**Figure 2.** (a) Capacity vs training support — weak overall (ρ = −0.05), per-locus |ρ| ≤ 0.14 with the maximum at HLA-C. (b) Leave-A\*02:01-out Δ for every re-run statistic (max |Δ| = 0.015). (c) The 7 zero-neo alleles against the catalog's support distribution — 6/7 at ba_n = 0, where 84.9% of the catalog also sits.

---

## Check (iii) — Non-redundancy with HED: significant at allele level, vanishes at the supertype unit

Does capacity carry information beyond HED? The projection is frozen: **`freqweighted_median` primary**, `freqweighted_mean` a labeled sensitivity line. Critically, the **independence unit is the Sidney/Sette supertype**, not the allele — capacity is a pocket-motif binding quantity and the supertype groups alleles by pocket motif. Significance is graded against supertypes (A = 6, B = 6), **never** against n = 676.

**Allele-level correlations** (shown for completeness, three distinct numbers, not graded against n):

| scope | all-676 ρ | (p) | f≥0.001 panel ρ | (p) | panel n | fw_mean (sens.) |
|---|--:|--:|--:|--:|--:|--:|
| overall | −0.132 | (6e-4) | −0.175 | (0.007) | 236 | −0.110 |
| A | −0.447 | (2e-11) | −0.456 | (2e-4) | 64 | −0.411 |
| B | −0.123 | (0.026) | −0.112 | (0.198) | 133 | −0.206 |
| C | −0.085 | (0.344) | −0.055 | (0.738) | 39 | −0.132 |

**Graded against the supertype independence unit** (the frozen test):

| locus | n supertypes | ρ(cap, HED) | p | clustered-perm. p |
|---|--:|--:|--:|--:|
| A | 6 | −0.657 | 0.156 | 0.337 |
| B | 6 | +0.371 | 0.469 | 0.702 |
| A+B pooled | 12 | −0.434 | 0.159 | — |

**Nothing is significant at the supertype level, and the sign flips between A (−0.66) and B (+0.37).** Both grading methods agree — collapse-to-supertype and a supertype-clustered permutation (20,000 draws) give A p = 0.34, B p = 0.70. This is the real ceiling: grading against ~5–6 independent contrasts per locus leaves almost nothing significant, and that ceiling is the finding.

**HLA-C: arithmetically unavailable — stated, not shown.** C has no clean supertype scheme (`NULL_C_by_design`), so there is no unit to grade against. (C's engageability-profile count is a different-axis quantity and is not the basis for this exclusion — the missing supertype scheme is.)

**Alpha-3 symmetric rule (characterization, not admission):** capacity clears distinctness (item i) and shows no significant collinearity with HED at the supertype unit (this item), so on these numbers it is not a collapsed-with-HED pair. Whether that clears admission is the author's call.

![Capacity vs HED]({{artifact:art_523d8fbc-f77b-4468-9922-c6bd68c8496c}})
**Figure 3.** Capacity vs HED (freqweighted_median), per locus. Faint points = alleles; open diamonds = the 6 freq-weighted-median supertype points that carry the graded test. Panel titles show the supertype ρ and p for A and B (both n.s.); C is marked unavailable.

---

## Check (iv) — Substrate check (one-sided): concordance bounds the immunoediting confound

**Pre-declared before computing** (recorded in advance): capacity is a binding-pocket property set by pocket motif, not by which peptide library is scored, so the neoepitope substrate (TCGA MC3) and the null substrate (MC3-derived trinucleotide simulation) should rank alleles **concordantly**; immunoediting can only *flatten* the neo axis, never reverse it. Decision rule fixed in advance:

- **CONCORDANCE →** immunoediting-flattening bound demonstrated; a flat axis would be interpretable.
- **DIVERGENCE →** UNRESOLVED (null differs from MC3 in two confounded ways this design can't separate — immunoediting *and* gene composition, ρ = 0.72); substrate bound stated open.

The null is ranking-only (N_sim = 500), never per-allele. No gene-matched null (declined). **Does not bear on admission.**

| scope | ρ(neo, null) | Kendall τ | ρ(self, null) |
|---|--:|--:|--:|
| overall | **0.992** | 0.926 | 0.992 |
| A | 0.992 | 0.933 | 0.994 |
| B | 0.991 | 0.921 | 0.989 |
| C | 0.995 | 0.953 | 0.990 |

**CONCORDANCE (ρ = 0.99 every locus, all p ≈ 0).** The pre-declared branch is met: the immunoediting-flattening bound is demonstrated.

![Substrate check]({{artifact:art_d886a3f0-af15-4e00-9468-f38afb80713c}})
**Figure 4.** Neoepitope vs null substrate capacity, per allele, ranking-only. Points hug the identity line (ρ = 0.99). Pre-declared concordance, observed concordance.

---

## Descriptives

**Neo- and self-capacity** are two correlated features (ρ = 0.99 at every locus; overall Spearman 0.992, Pearson 0.993), carried separately and never composited into one score.

**Per-length breakdown** (mean neo binder fraction %, descriptive — exhaustive tiling imposed no length mix, so this does not reopen length):

| locus | 8mer | 9mer | 10mer | 11mer |
|---|--:|--:|--:|--:|
| A | 1.21 | 15.34 | 15.51 | 7.64 |
| B | 1.15 | 8.30 | 6.56 | 2.46 |
| C | 0.74 | 10.25 | 2.32 | 0.47 |
| all | 1.09 | 10.94 | 8.65 | 3.75 |

9-mers dominate overall; 10-mers are co-dominant at HLA-A; 8-mers are minimal — the canonical class I length preference expressing itself under exhaustive tiling.

![Neo/self capacity and per-length breakdown]({{artifact:art_59c7c325-5df3-4e7f-a75d-f404ed3a070c}})
**Figure 5.** (a) Neo vs self capacity, ρ = 0.99, kept as two features. (b) Per-length mean neo binder fraction by locus.

---

## Summary of the three ordered checks + substrate

| check | question | result |
|---|---|---|
| (i) Variance | does affinity-capacity vary above measurement noise? | **yes** — SD 10.6–14.2 pp vs 1.118 pp SE; %Rank compressed by design |
| (ii) Training-support | is capacity a NetMHCpan training artifact? | **no** — |ρ| ≤ 0.14, partials |Δ| ≤ 0.011, leave-A\*02:01-out |Δ| ≤ 0.015 |
| (iii) Non-redundancy w/ HED | is capacity distinct from HED at the supertype unit? | allele-level signal (A ρ = −0.45) **vanishes at supertype grain** (A p = 0.16, B p = 0.47, signs flip); C unavailable |
| (iv) Substrate (one-sided) | does immunoediting distort the axis? | **concordance** ρ = 0.99 → flattening bound demonstrated; does not bear on admission |

**Admission to E-ORTH is not decided here.** These are the numbers, including all nulls and zeros; the result is characterized as neither positive nor negative. See `RESULTS_capacity_C4_methods.md` for provenance, the three source-coherence items (methods doc, Sette-1994 flag, HLA-C profile count), the frozen invariants, and full machine-readable tables.

