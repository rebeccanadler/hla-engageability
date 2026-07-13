# HED × ENGAGEABILITY CORRELATION — RECONCILIATION & DISPOSITION

Reconciliation only. Every r below was recomputed this session from frozen saved inputs
(`engageability_scores.csv` v5f19dea6, `hed_per_allele.csv` vc6390124,
`hla_characterization.csv` va83c2638 — the saved companion table behind Figure 2).
No re-derivation to a target; source cells named.

## PROJECTION THE ORTHOGONALITY CLAIM IS ABOUT (stated once)
**The unweighted 676-allele catalog, HED × engageability, z-scored over that catalog.**
This is the projection of record in `axis_orthogonality_report.md` and
`engageability_coefficient_reconciliation.md` (D1). The claim is a property of the two
sequence-derived axes across the full allele catalog — NOT a property of any cohort's
allele mix.

## MASTER CROSS-TAB (statistic × weighting × projection, with effective N)

| projection | weighting | HED col | n | ESS | Pearson | p | Spearman | p |
|---|---|---|---|---|---|---|---|---|
| CATALOG-676 | unweighted | mean_HED_181scope | 676 | 676 | **−0.021** | 0.583 | −0.038 | 0.328 |
| CATALOG-676 | unweighted | mean_HED (full)   | 676 | 676 | −0.029 | 0.447 | −0.038 | 0.326 |
| COHORT-195  | unweighted | mean_HED_181scope | 195 | 195 | **+0.202** | 0.005 | +0.133 | 0.064 |
| COHORT-195  | freq-weighted | mean_HED_181scope | 195 | 43 | +0.077 | — | +0.026 | — |

Each cell: `hed_engageability_reconciliation.csv`. ESS = (Σw)²/Σw² (Kish).

## (1) THE −0.02 → +0.20 "SIGN FLIP UNDER WEIGHTING" — MISDIAGNOSED

**+0.20 is NOT a cohort-weighted correlation.** It is the **unweighted Pearson over the
195-allele cohort subset** (r=+0.2020, p=0.005), reproduced exactly from the Figure 2
lineage code (`fig_hla_characterization.png` v5cff0a9a): `pearsonr(mean_HED_181scope,
engageability_A)` on `hla_characterization.csv` rows, with frequency used only as the
scatter's COLOR, never as a weight. MANUSCRIPT.md line — "HED and engageability are
weakly correlated (Pearson r = 0.20)" — is this cohort-subset unweighted value.

The catalog value (−0.021) and the cohort value (+0.202) differ by **which alleles are in
the sample** (676 catalog → 195 cohort-present), not by weighting. The genuinely
frequency-weighted cohort correlation is **+0.077 at ESS=43** — closer to zero, not more
positive. So:
- "Sign flip under weighting" is a mislabel. The operative contrast is
  **catalog-676 vs cohort-195 (a projection/sample change)**, both unweighted.
- Actual weighting (freq) pulls the cohort value DOWN toward zero (+0.202 → +0.077).

**Where the flip lives (Figure b).** Per-locus comparison is like-for-like on
`mean_HED_181scope` (the only HED column present in the cohort table), so both projections
use the same column:
- HLA-A: **−0.456 → −0.457** — stable, column-invariant (identical on full `mean_HED`).
- HLA-B: **+0.013 → +0.203** — the flip. Column-invariant (identical on full `mean_HED`).
  The cohort retains common, positively-associated B alleles and drops the rare-B tail
  that held the catalog's B correlation near 0.
- HLA-C: **+0.249 → +0.207** on 181-scope. **Caveat:** HLA-C is the one column-sensitive
  locus — the canonical catalog value in `axis_orthogonality_report.md` is **+0.373** on
  full `mean_HED` (A and B are column-invariant; only C differs, by +0.124, because C's
  full vs 181-scope HED diverge). So the honest catalog→cohort read for C is NOT "stable":
  on the canonical full-HED basis it is **+0.373 → +0.207 (a ~0.17 drop)**; on the
  like-for-like 181-scope basis it is +0.249 → +0.207 (small). Either way C moves toward
  the cohort's positive value; it does not oppose the B-driven shift.

Overall sign of the projection change is set by HLA-B's flip (column-invariant) plus the
cohort's slightly higher B share (0.49 → 0.53). HLA-C reinforces rather than offsets it.
**Correction (prior version of this report):** the earlier text "HLA-C is similar in both
(+0.25/+0.21)" silently used 181-scope for the catalog C figure, inconsistent with the
canonical full-HED catalog value (+0.373); C is not stable on the canonical basis.

## (2) −0.04 (E-REP) vs −0.02 (Gate 1) — RESOLVED, NOT A CONFLICT
Same quantity (catalog-676, mean_HED_181scope), two statistics:
- **Pearson = −0.0212 → −0.02** (Gate 1 value).
- **Spearman = −0.0376 → −0.04** (E-REP value).
Both are correct; they are not the same statistic. The FLAG file
(`FLAG_hed_correlation_correction.md`) already recorded this: "−0.02 is PEARSON on
mean_HED_181scope only; Spearman is −0.04." For an orthogonality (monotone-independence)
claim, **Spearman −0.04 is the statistic that should enter the write-up**; Pearson −0.02
is the linear companion. |r| ≤ 0.04 under every statistic/scope — the claim is unaffected.

## (3) A*02:01 LEVERAGE HYPOTHESIS — REJECTED for the +0.20
On the COHORT-195 unweighted Pearson (the +0.20):
- Full: r = +0.2020 (p=0.0046, n=195).
- Leave-A*02:01-out: r = **+0.2041** (p=0.0043, n=194) — the value RISES slightly.
- Jackknife rank: A*02:01 is the **147th** most influential of 195 alleles; the top
  movers are rare B*57/B*73/C*08 alleles (each shifts r by ~0.01–0.02), not A*02:01.

A*02:01's HED (6.71) and engageability (0.863) sit near the cohort's positive-slope trend,
so it is on-line, not off-line leverage. **The +0.20 is a property of the cohort's allele
composition (HLA-B–driven), not one allele's leverage.** (Per instruction,
leave-A2-supertype-out was not used as a separate check — it equals leave-A*02:01-out.)

Note: the LOG file's −0.41 subset finding is a DIFFERENT object — the m_d≥2 qualifying
subset (n=13), entry-weighted — where A*02:01 does dominate. That does not transfer to the
catalog/cohort correlation, which is what the manuscript's +0.20 reports.

## DISPOSITION
Pre-committed branches, applied:

1. **Provenance of +0.20 IS recoverable** — it is the Figure 2 lineage's unweighted
   cohort-subset Pearson (v5cff0a9a → `hla_characterization.csv` va83c2638). It was never
   a cohort-weighted number; the "cohort-weighted" label in the LOG/manuscript framing is
   incorrect.
2. **A*02:01 leverage removed → +0.20 SURVIVES** (+0.204). By the pre-committed rule this
   is NOT the one-allele-leverage branch. But it is also NOT the "cohort weighting reveals
   real structure" branch, because +0.20 is unweighted; genuine weighting gives +0.077
   (ESS=43). It is the **projection-change branch**: catalog vs cohort-present alleles,
   concentrated in HLA-B.

**Consequence for the orthogonality claim (honest reading):**
- The claim is about the **catalog-676** projection and stands: |r| ≤ 0.04, p > 0.3,
  every statistic/scope.
- The manuscript's Figure-2 "r = 0.20" is a **different projection** (cohort-present
  alleles, unweighted) and is NOT evidence against catalog orthogonality — but at n=195,
  p=0.005 it is a real within-cohort association driven by HLA-B, and the manuscript
  currently reports it under the same "weakly correlated / distinct axes" language as the
  catalog claim. That conflation should be fixed in the write-up: the two numbers are two
  projections, and the +0.20 is not "weak" at cohort scale (p=0.005).
- Under honest weighting (freq, ESS=43) the cohort association is +0.077 — weak, but the
  low ESS means the cohort correlation is concentrated: 195 nominal alleles carry the
  information content of ~43.

Canonical value for the orthogonality claim: **catalog-676 Spearman −0.04** (Pearson
−0.02). The +0.20 is retained only as the labeled cohort-projection statistic, not as the
orthogonality number.

## FILES
- Inputs (frozen, read): engageability_scores.csv (v5f19dea6), hed_per_allele.csv
  (vc6390124), hla_characterization.csv (va83c2638), fig_hla_characterization.png lineage
  (v5cff0a9a), MANUSCRIPT.md (v3f7b3f23).
- Outputs (this session): hed_engageability_reconciliation.csv,
  fig_hed_eng_reconciliation.png, this report.

Stop at disposition. No write-up edits this session.
