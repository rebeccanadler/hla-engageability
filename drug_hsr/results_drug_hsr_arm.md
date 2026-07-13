# Drug-Hypersensitivity (Drug-HSR) Response Arm — Results

*Standalone class I drug-HSR response arm, quarantined from the autoimmune-risk axis.
Reports numbers only — no pass/fail judgment. Methods: `methods_drug_hsr_arm.md`.*

## Summary
A per-allele engageability contrast was run against a set of well-established class I
drug-HSR anchors. The original 3-anchor set showed the anchors sitting above the
engageability median, but that tendency was carried by a structural degeneracy
(B*57:01 = B*58:01, same B58 supertype). Expanding to independent-contrast alleles on
different loci/supertypes **broke the degeneracy and weakened the trend toward null**:
anchor mean percentile fell from 75.6 → 60.9 and MWU p rose from 0.12 → 0.40. This is a
properly-independent null on a small anchor set, reported as-is.

## 1. Anchors and association evidence
Every OR was retrieved from primary/meta-analysis full text or abstract (provenance in
`drug_hsr_arm_anchors.csv` / `_ADDENDUM.csv`, each with a `verification` column).

**Core set (S8):**
- **B*57:01 / abacavir** — OR 960 (94.4% cases vs 1.7% controls, P<1e-5); patch-test
  confirmed variants reach ~1945. *Martin et al., PNAS 2004.*
- **B*15:02 / carbamazepine** — OR 2504 (95% CI 126–49,522; Pc=3.13e-27). *Chung et al.,
  Nature 2004, Table 1.*
- **B*58:01 / allopurinol** — OR 82.77 (95% CI 41.63–164.58, matched). *Wu et al.,
  Oncotarget 2016, meta-analysis of 21 studies.*

**Addendum (independent-contrast expansion):**
- **A*31:01 / carbamazepine** — OR 12.41 (HSS); 8.33 (MPE); 25.93 (SJS-TEN). *McCormack
  et al., NEJM 2011.* Same drug as B*15:02 → within-drug internal control.
- **B*13:01 / dapsone** — OR 20.53 (P=6.84e-25). *Zhang et al., NEJM 2013.*
- **A*32:01 / vancomycin** — OR undefined (19/23=82.6% vs 0/46=0%; P=1e-8; zero control
  cell). *Konvinse et al., JACI 2019.*
- **B*57:01 / flucloxacillin (DILI)** — OR 80.6 (P=9.0e-19). *Daly et al., Nat Genet 2009.*
  Same allele as abacavir → one-allele→two-phenotypes, **not** a new contrast.

**Dropped (`drug_hsr_dropped_anchors.csv`):** A*33:03 and C*03:02 (allopurinol) — LD
proxies for B*58:01 on the A33-Cw3-B58 haplotype, single Vietnamese cohort, not shown
class-I-independent. Fail the well-established/independence bar.

## 2. Engageability per anchor and effective N
| Allele | Drug | engageability_A | %ile | supertype |
|---|---|---|---|---|
| A*31:01 | carbamazepine | 1.306 | 99.2 | A03 |
| B*57:01 | abacavir / flucloxacillin | 0.833 | 84.2 | B58 |
| B*58:01 | allopurinol | 0.833 | 84.2 | B58 |
| B*15:02 | carbamazepine | 0.024 | 58.6 | B62 |
| B*13:01 | dapsone | −0.183 | 39.1 | Unclassified |
| A*32:01 | vancomycin | −0.319 | 23.5 | A01 |

**Effective N:** 6 independent alleles → **5 distinct engageability profiles** (B*57:01 =
B*58:01 identical, both B58) → **4 distinct assignable Sidney supertypes** (A01, A03, B58,
B62); B*13:01 is Unclassified. The 3-anchor set collapsed to ~2 independent profiles; the
addendum breaks the B58 degeneracy with A01/A03/B62 alleles.

## 3. Rank/direction association — did expansion change it?
| Set | n | anchor mean %ile | MWU p | rank-biserial |
|---|---|---|---|---|
| 3-anchor (S8 original) | 3 | 75.6 | 0.124 | −0.514 |
| 6-anchor expanded | 6 | 64.8 | 0.210 | −0.297 |
| 5 distinct profiles (B57/B58 deduped) | 5 | 60.9 | 0.398 | −0.219 |

Adding independent alleles **weakened the association toward null**. A*31:01 is very high
(99.2 %ile) but B*13:01 (39.1) and A*32:01 (23.5) fall below the median. The above-median
tendency in the 3-anchor set was a degeneracy artifact, not an independent signal.

**Within-carbamazepine internal control:** A*31:01 (engA 1.306, 99.2 %ile) vs B*15:02
(engA 0.024, 58.6 %ile), Δ = +1.28 — same drug, opposite ends of the engageability range.

![Drug-HSR anchors vs the 676-allele engageability background. The expanded 6-allele set
(red) spans the full range rather than clustering high; the B58 pair (B*57:01/B*58:01) is
the only degenerate profile. Dotted line = background mean.]({{artifact:4158942c-53a4-4398-a3b6-aa54e0345bce}})

## 4. Frequency confound
Engageability does not track allele frequency: Spearman engageability_A vs AFND
freq_median = −0.135 (p=0.502, n=27) overall and −0.319 (p=0.538, n=6) across the anchors.
Core-anchor freq_medians are nearly identical (0.0249–0.0265). Anchors are
population-restricted (B*15:02 SE-Asian, B*57:01 European-enriched, B*58:01 Asian-enriched,
B*13:01 E/SE-Asian, A*31:01 N.European/Japanese/Native-American, A*32:01 European/W.Asian),
so OR magnitudes are not compared cross-population as like-for-like; the rank mitigates.

## 5. Mechanism heterogeneity (reported, not averaged)
Pooling assumes response runs through the TCR-facing surface identically across
mechanisms — an assumption made explicit: abacavir/flucloxacillin (repertoire/F-pocket),
allopurinol (direct non-covalent), carbamazepine (p-i/contested), dapsone (non-covalent/
p-i proposed), vancomycin (unknown).

## 6. Cross-phenotype opposite-sign recurrence (disease-anchored, not pooled)
- **B*57:01** — drug-HSR RISK (abacavir; flucloxacillin DILI) vs autoimmune PROTECTIVE
  (T1D OR 0.19; AS reduced-risk).
- **A*32:01** — drug-HSR RISK (vancomycin DRESS) vs autoimmune T1D-PROTECTIVE (Noble 2010,
  conditioned direction).

Both listed as disease-anchored features, never averaged into a single per-allele value.

## 7. Read (numbers only)
With independent contrasts added across 4 supertypes, engageability **does not track
drug-HSR membership** — the trend present in the degenerate 3-anchor set does not survive
breaking the B58 degeneracy. This is a clean null on a properly-independent (though small,
5-profile) set, and is stronger than the degenerate 3-anchor null. The mini-gate judgment
is the project owner's.

## Artifacts
- Data: `drug_hsr_arm_anchors.csv`, `drug_hsr_arm_anchors_ADDENDUM.csv`,
  `drug_hsr_dropped_anchors.csv`, `drug_hsr_rank_association_expanded.csv`
- Summaries: `drug_hsr_arm_summary.json`, `drug_hsr_arm_addendum_summary.json`,
  `afnd_new_anchors.json`
- Figure: `fig_drug_hsr_expanded.png`
- Methods: `methods_drug_hsr_arm.md`
