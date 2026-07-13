# Drug-Hypersensitivity (Drug-HSR) Response Arm — Methods Note
# Standalone class I drug-HSR arm; quarantined from the autoimmune-risk axis

## 0. Purpose and quarantine rule
This arm tests whether the ENGAGEABILITY metric tracks a drug-hypersensitivity
RESPONSE phenotype. It is a **response** axis, NOT autoimmunity, and is kept
**quarantined** from the autoimmune-risk axis: every entry is disease/drug-anchored
and is never pooled with an allele's autoimmune sign. Class I only.

The arm was built in two stages, both preserved:
- **S8 core set** (3 anchors): `drug_hsr_arm_anchors.csv`, `drug_hsr_arm_summary.json`.
- **Addendum** (independent-contrast expansion): `drug_hsr_arm_anchors_ADDENDUM.csv`,
  `drug_hsr_dropped_anchors.csv`, `drug_hsr_rank_association_expanded.csv`,
  `drug_hsr_arm_addendum_summary.json`, `fig_drug_hsr_expanded.png`.

## 1. Axis definition — ordinal presence/rank, NOT raw OR
The axis is **ordinal**: an allele is a strong-response anchor (present) or not.
Raw odds ratios are used ONLY to establish that each association is real and
strong; **OR magnitude never enters any fit or contrast**. Rationale:
1. **Phenotype-definition artifact.** B*57:01/abacavir OR ≈ 960–1945 is inflated by
   patch-test-confirmed ascertainment (~100% specificity built in), not effect
   biology. A*32:01/vancomycin has an *undefined* OR (zero control-cell). Magnitudes
   are not on a common scale.
2. **Ancestry confounding (§4).** Anchors are population-restricted, so cross-anchor
   OR magnitudes are not like-for-like.
If a continuous form is ever required, use **log-OR** only; the default is the rank.

## 2. Stopping rule for admission (stated and obeyed)
An association is admitted only if it is:
- **(a) class I** — class II / DRB1-DQ associations excluded; where a drug has both,
  only the class I allele is taken;
- **(b) well-established** — replicated in ≥2 cohorts or a meta-analysis, not a
  single case series.
This is a principled expansion toward the known class I drug-HSR set, NOT a search
for whatever moves the trend. The established set is admitted, then reported as-is.

## 3. Anchor set and OR provenance (HARD REQUIREMENT)
Every OR was pulled from **fetched primary/meta-analysis full text or abstract this
session** — not from memory and not from a search snippet. Each row in the anchor
tables carries a `source_ref` AND a `verification` column stating exactly how the
value was obtained. Retrieval used `fetch_article_fulltext` (PMC/PDF) and NCBI
E-utilities `efetch`/`esearch`; values were read verbatim from the RESULTS text.

### 3a. S8 core anchors (`drug_hsr_arm_anchors.csv`)
| Allele | Drug | OR (verified) | Source |
|---|---|---|---|
| B*57:01 | abacavir | 960 (94.4% cases vs 1.7% controls, P<1e-5) | Martin et al., PNAS 2004, doi:10.1073/pnas.0307067101 |
| B*15:02 | carbamazepine (+ aromatic anticonvulsants) | 2504 (95% CI 126–49,522; Pc=3.13e-27) | Chung et al., Nature 2004;428:486, doi:10.1038/428486a — Table 1 |
| B*58:01 | allopurinol | 82.77 (95% CI 41.63–164.58, matched; P<1e-5) | Wu et al., Oncotarget 2016;7(49):81870, doi:10.18632/oncotarget.13250 (PMC5348437) — meta-analysis of 21 studies |

### 3b. Addendum anchors (`drug_hsr_arm_anchors_ADDENDUM.csv`)
| Allele | Drug | Phenotype | OR (verified) | Independent contrast? | Source |
|---|---|---|---|---|---|
| A*31:01 | carbamazepine | HSS/DRESS, MPE, SJS-TEN | 12.41 (1.27–121); MPE 8.33 (3.59–19.4); SJS-TEN 25.93 (4.93–116) | YES | McCormack et al., NEJM 2011, doi:10.1056/NEJMoa1013297 |
| B*13:01 | dapsone | DHS (DRESS-like) | 20.53 (P=6.84e-25; sens 85.5%/spec 85.7%) | YES | Zhang et al., NEJM 2013, doi:10.1056/NEJMoa1213096 |
| A*32:01 | vancomycin | DRESS | OR undefined (19/23=82.6% vs 0/46=0%; P=1e-8) | YES | Konvinse et al., JACI 2019, doi:10.1016/j.jaci.2019.01.045 (PMC6612297) |
| B*57:01 | flucloxacillin | DILI (not SCAR) | 80.6 (P=9.0e-19) | **NO — same allele as abacavir** | Daly et al., Nat Genet 2009, doi:10.1038/ng.379 |

B*57:01/flucloxacillin is retained for the one-allele→two-phenotypes observation but
does NOT add an independent engageability contrast (engageability is allele-intrinsic).

### 3c. Dropped, with reason (`drug_hsr_dropped_anchors.csv`)
- **A*33:03 / allopurinol** and **C*03:02 / allopurinol** — both lie on the A33-Cw3-B58
  ancestral haplotype in LD with B*58:01, entered as a *combined* B*58:01/C*03:02 factor
  in a single Vietnamese cohort (Ha Pham et al., Pharmacogenomics 2022;23:303, PMID
  35187976); not shown class-I-independent of B*58:01. Fail the independence +
  replication bar → dropped.

## 4. Engageability values and effective N
Engageability is read from `engageability_scores.csv` (composite A = primary VARIABLE-group
equal-weight z-composite; composite B = PC1; within-locus variant; CONSERVED group carried
separately as `con_*`, invariant across common alleles by design). No engageability feature
was recomputed for this arm.

**Effective N of independent contrasts** — stated plainly:
- 6 independent alleles (B*57:01, B*15:02, B*58:01, A*31:01, B*13:01, A*32:01).
- **5 distinct engageability profiles**: B*57:01 and B*58:01 are **identical** (0.833,
  both B58 supertype) — structurally non-independent; all other profiles distinct.
- **4 distinct assignable Sidney supertypes** (A01, A03, B58, B62). **B*13:01 is
  Unclassified** in the project supertype layer (`favorability_supertype_layer.csv`) —
  it is NOT counted as a 5th supertype. (An earlier draft mislabeled it "B62?"; corrected.)
- The 3-anchor S8 set collapses to ~2 independent profiles (B*57:01=B*58:01); the
  addendum breaks that B58 degeneracy by adding A01/A03/B62 alleles.

## 5. Rank/direction association (`drug_hsr_rank_association_expanded.csv`)
Mann-Whitney U of anchor engageability_A against the 670-allele non-anchor background
(pooled z); rank-biserial effect size reported. Percentiles are pooled across all 676 alleles.

| Set | n | anchor mean %ile | MWU p | rank-biserial |
|---|---|---|---|---|
| 3-anchor (S8 original) | 3 | 75.6 | 0.124 | −0.514 |
| 6-anchor expanded | 6 | 64.8 | 0.210 | −0.297 |
| 5 distinct profiles (B57/B58 deduped) | 5 | 60.9 | 0.398 | −0.219 |

Adding independent alleles **weakened the trend toward null**: the 3-anchor above-median
tendency was carried by the degenerate B*57:01/B*58:01 pair. A*31:01 is high (99.2 %ile);
B*13:01 (39.1) and A*32:01 (23.5) fall below the median.

Within-carbamazepine internal control (same drug, two alleles): A*31:01 engA = 1.306
(99.2 %ile) vs B*15:02 engA = 0.024 (58.6 %ile), Δ = +1.28.

## 6. Frequency confound control (AFND)
Allele frequencies pulled from allelefrequencies.net (AFND), page-1 population summaries
(median/max/p90 across ~79–100 populations), same source and method as the autoimmune arm.
New-anchor frequencies stored in `afnd_new_anchors.json`; core anchors from
`afnd_freqs_full.json`.
- Core-set freq_medians are nearly identical (0.0249–0.0265) → within the anchor set,
  engageability does NOT track frequency.
- Global Spearman engageability_A vs freq_median: rho = −0.135 (p=0.502, n=27) overall;
  −0.319 (p=0.538, n=6) across the six anchors.
- Anchors are population-restricted (per-row ancestry flags: B*15:02 SE-Asian, B*57:01
  European-enriched, B*58:01 Asian-enriched, B*13:01 E/SE-Asian, A*31:01
  N.European/Japanese/Native-American, A*32:01 European/W.Asian). Magnitudes are NOT
  compared cross-population as like-for-like; the rank mitigates.

## 7. Mechanism heterogeneity (reported, not averaged)
Each anchor is tagged with its HLA-engagement mechanism, because pooling assumes response
runs through the TCR-facing surface identically across mechanisms — an assumption made
visible rather than silent:
- abacavir / flucloxacillin (B*57:01): altered self-peptide repertoire / F-pocket;
- allopurinol (B*58:01): direct non-covalent;
- carbamazepine (A*31:01, B*15:02): p-i vs direct (contested);
- dapsone (B*13:01): non-covalent / p-i (proposed);
- vancomycin (A*32:01): unknown.

## 8. Cross-phenotype opposite-sign recurrence (disease-anchored, not pooled)
Two anchors recur elsewhere in the project with the OPPOSITE sign; listed as
disease-anchored features, never averaged into a single per-allele value:
- **B*57:01** — drug-HSR RISK (abacavir; flucloxacillin DILI) vs autoimmune PROTECTIVE
  (T1D OR 0.19, Noble 2010; AS reduced-risk, Immunochip).
- **A*32:01** — drug-HSR RISK (vancomycin DRESS) vs autoimmune T1D-PROTECTIVE
  (Noble 2010, conditioned direction).

## 9. Reporting discipline
The arm reports numbers only: no pass/fail judgment, no anchor tuned to a target, no
narrative decision. A clean null on the properly-independent set is reportable and is
stronger than the degenerate 3-anchor null.

## 10. Artifact inventory
| File | Contents |
|---|---|
| `drug_hsr_arm_anchors.csv` | S8 3-anchor set (OR + source_ref + verification + engageability + AFND) |
| `drug_hsr_arm_summary.json` | S8 contrast stats, frequency confound, effective N |
| `drug_hsr_arm_anchors_ADDENDUM.csv` | Expanded anchors (append to S8), full provenance + supertype |
| `drug_hsr_dropped_anchors.csv` | A*33:03, C*03:02 with drop reasons |
| `drug_hsr_rank_association_expanded.csv` | 3 vs 6 vs 5-distinct contrast statistics |
| `drug_hsr_arm_addendum_summary.json` | Full numeric summary of the expanded arm |
| `afnd_new_anchors.json` | Retrieved AFND frequencies for new anchors |
| `fig_drug_hsr_expanded.png` | Anchor engageability vs background, expanded set |

Inputs consumed (not modified): `engageability_scores.csv`, `afnd_freqs_full.json`,
`favorability_supertype_layer.csv`, `autoimmune_risk_axis_ranked.csv`.
