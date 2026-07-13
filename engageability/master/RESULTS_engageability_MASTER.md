# Engageability — Master Results

**HLA class I "immunogenic potency" project.** This document consolidates the
**engageability** arm end-to-end: how the metric is built, how it relates to the prior
peptide-repertoire axis (HED), what its allele-level identifiability limits are, and how it
performs in the two-arm cancer-vs-autoimmunity trade-off test. It is a top-level synthesis
and **index** — the per-step results files it points to remain the primary record for each
step; every headline number here is quoted from those saved files.

**The metric, in one sentence.** Engageability is an allele-level measure of how permissive
an HLA class I alpha1/alpha2 TCR-facing surface is to *diverse* TCR docking - deliberately
**not** clone-specific, because TCR footprints vary by clone and peptide and that variability
is the object of interest. It is conceptually distinct from HED (peptide-repertoire breadth)
and from clone-specific contact-residue analyses.

---

## 0. Reading order

| # | Step | Primary file | One-line result |
|---|---|---|---|
| 1 | Metric construction | [`RESULTS_part1_engageability_metric.md`](RESULTS_part1_engageability_metric.md) | 676-allele sequence proxy; usable spread; robust to blending choice |
| 2 | Axis orthogonality | [`axis_orthogonality_report.md`](axis_orthogonality_report.md) | HED x engageability orthogonal overall (r~-0.03); opposite-sign per-locus structure |
| 3 | Orthogonality reconciliation | [`hed_engageability_reconciliation_report.md`](hed_engageability_reconciliation_report.md) | the -0.02/+0.20 discrepancy is a projection change, not weighting or one-allele leverage |
| 4 | Identifiability theory | [`identifiability_note.md`](identifiability_note.md) | allele-level ICB associations cannot separate escape from elimination without form assumptions |
| 5 | Single-allele mechanism | [`RESULTS_part2_a0201_mechanism.md`](RESULTS_part2_a0201_mechanism.md) | TCRs use the A*02:01 crest variably (exploratory, single-allele ceiling) |
| 6 | Two-arm trade-off test | [`results_tradeoff_two_arm.md`](results_tradeoff_two_arm.md) | bounded null on both arms; antagonistic-pleiotropy signature absent |
| - | Within-arm construction | [`results_cancer_arm.md`](results_cancer_arm.md), [`results_autoimmune_risk_arm.md`](results_autoimmune_risk_arm.md) | the two outcome axes the trade-off test consumes |

---

## 1. Metric construction (Part 1)

The structure record fixes the whole project's design up front: of the **243 non-redundant
human class I TCR-pMHC complexes** inventoried (TCR3d union STCRDab, cross-database
docking-angle r = 0.939), only **A*02 is structurally data-rich (n = 127)**. This forces a
two-tier design - a sequence proxy for all **676 alleles**, with structural calibration
powered only for A*02.

![Structure inventory by allele group, coloured by locus]({{artifact:2fc41470-1107-445d-bd06-9abb3022e60c}})

The TCR-facing surface was defined **empirically** from the 176 structures (alpha1/alpha2
residues <=5.0 A of any TCR atom), recovering the canonical restriction determinants
(R65 94%, A69 95%, Q155 97%) and passing a landmark gate against the A*02:01 crystal 1AO7
(0/182 mismatches). Positions were split by cross-allele Shannon entropy into a **VARIABLE
crest (14 positions, mean 1.11 bits)** and a **CONSERVED restriction set (12 positions,
0.036 bits, ~31x lower)**.

Three pre-registered physicochemical features on the VARIABLE crest - crest heterogeneity
(+), |net charge| (-), hydrophobic imbalance (-) - combine equal-weight (z-scored,
theory-signed) into **Composite A**. The features are near-independent (max |r| = 0.24, no
>0.7 flag), and the score is **robust to the blending choice** (Composite A vs PC1 Composite
B: Spearman 0.925). Spread is usable (SD 0.634) and ordered **HLA-A 0.80 > B 0.58 > C 0.30**,
tracking polymorphism.

![Engageability distribution across 676 alleles]({{artifact:a2fd4100-3483-49af-94ec-346005515a8a}})

*Primary artifact:* [`engageability_scores.csv`](engageability_scores.csv) - per-allele
scores, pre-registered in `engageability_spec.md` before any HED correlation was examined.

---

## 2. Orthogonality to HED

Engageability is **orthogonal to HED overall** - the pre-registered test of the claim that it
measures something the peptide-repertoire-breadth axis does not.

| scope | Pearson | Spearman | n | flag |
|---|---|---|---|---|
| **OVERALL** | **-0.029** | -0.038 | 676 | ORTHOGONAL (\|r\|<0.2) |
| HLA-A | -0.456 | -0.416 | 218 | intermediate, negative |
| HLA-B | +0.013 | -0.062 | 331 | orthogonal |
| HLA-C | +0.373 | +0.393 | 127 | intermediate, positive |

No pair reaches |r|>0.7 anywhere - the axes never collapse into redundancy. The overall ~0 is
**partly a cancellation of opposite-sign per-locus structure** (moderate negative in A, flat
in B, moderate positive in C), which is why the per-locus breakdown is reported mandatorily
rather than the headline alone.

![Axis orthogonality: HED x engageability, overall and per-locus]({{artifact:1784bd84-fb8a-41fe-8ba7-1e92791cabb6}})

*Primary artifact:* [`axis_orthogonality_report.md`](axis_orthogonality_report.md).

---

## 3. Reconciliation of the orthogonality number

A standing discrepancy - an **unweighted catalog r ~ -0.02** versus a **+0.20** appearing in
the manuscript's cohort figure - was traced to source. Findings, each resolving to a named
cell in a named artifact:

1. **The projection the orthogonality claim is about is the unweighted 676-allele catalog**
   (Spearman -0.04 / Pearson -0.02), z-scored over that catalog - a property of the two
   sequence axes, not of any cohort's allele mix.
2. **+0.20 is not a cohort-weighted correlation.** It is the **unweighted Pearson over the
   195-allele cohort subset** (r = +0.2020, p = 0.005), reproduced exactly from the Figure 2
   lineage code, where frequency is used only as scatter *colour*, never as a weight. The
   genuinely frequency-weighted cohort correlation is **+0.077 at effective N = 43**.
3. So the -0.02 -> +0.20 shift is a **projection/sample change** (catalog-676 -> cohort-195),
   not a weighting change; the flip lives inside **HLA-B** (+0.01 -> +0.20; HLA-A is stable at
   -0.46). HLA-C is the one column-sensitive locus (catalog +0.37 on full HED -> cohort +0.21).
4. **A*02:01 leverage rejected:** dropping A*02:01 moves the +0.20 to +0.204 (it ranks 147th
   of 195 in jackknife influence). The +0.20 is a composition property, not one allele's
   leverage.

![Where the HED-engageability sign flip lives: projection, not weighting]({{artifact:78f909c6-3f31-466a-affd-e032d885edd6}})

**Disposition:** the catalog-676 orthogonality claim stands (|r| <= 0.04, p > 0.3, every
statistic/scope). The manuscript's cohort +0.20 is a *different projection* (cohort-present
alleles, unweighted), real within-cohort (p = 0.005, HLA-B-driven), and should be labelled as
such rather than under the same "weakly correlated" language as the catalog number.

*Primary artifacts:* [`hed_engageability_reconciliation_report.md`](hed_engageability_reconciliation_report.md),
[`hed_engageability_reconciliation.csv`](hed_engageability_reconciliation.csv).

---

## 4. Identifiability limits (theory)

Whatever the metric's construction, there is a **structural ceiling on what allele-level ICB
outcome data can identify**. Modelling an allele's expected anti-tumor contribution as
Delta(e) = (1-h(e))*s(e) - elimination pressure s and escape probability h, both increasing
in latent potency e - the note establishes:

- **Shape is conditional, not universal:** Delta is non-monotone only when the escape hazard
  eta = h'/(1-h) overtakes elimination's log-growth; a bounded increasing h leaves Delta
  monotone.
- **Identification depends on functional-form assumptions:** with both s and h parametric,
  (a,b) are point-identified from the curve; with h parametric and s nonparametric, escape
  sensitivity has an unbounded identified set. It is the joint flexibility that destroys
  identification, not cohort count.
- **Firewall:** the h term stands for *any* escape-like process (immunoediting, HLA-LOH, ...);
  the result is orthogonal to which mechanism is real, so no allele-level sign can be
  attributed to a named mechanism.

![Identifiability of the escape/elimination decomposition]({{artifact:50311883-692a-478d-9227-ccb712f2781a}})

*Primary artifacts:* [`identifiability_note.md`](identifiability_note.md),
[`section9_standalone.md`](section9_standalone.md),
[`identifiability_check.py`](identifiability_check.py).

---

## 5. Single-allele mechanism (Part 2, exploratory)

On the one data-rich allele (A*02:01, 127 complexes, exploratory and post-checkpoint), TCRs
**concentrate on the crest** (VARIABLE 0.65 / CONSERVED 0.62 contact frequency vs 0.02 for
the rest of alpha1/alpha2, ~32x) and **use it variably** (contact variance ~11x background).
But the variability is **not preferentially at the VARIABLE-sequence positions** (VARIABLE vs
CONSERVED Mann-Whitney p = 0.76). This is a single-allele ceiling: it shows how TCRs *use* the
A*02:01 surface, and cannot test the between-allele sequence claim.

*Primary artifact:* [`RESULTS_part2_a0201_mechanism.md`](RESULTS_part2_a0201_mechanism.md).

---

## 6. Two-arm trade-off test

The project's central hypothesis is antagonistic pleiotropy: a single potency axis trending
**cancer-favorable** under ICB *and* **autoimmune-risky**. Tested head-to-head with
allele-frequency control as the gating requirement.

![Engageability vs cancer log-HR (supertype-level) and vs autoimmune risk rank (allele-level), pre/post frequency control]({{artifact:5565a790-7a74-4375-ace1-dc4c92ebafe5}})

**Cancer arm** (engageability -> supertype ICB log-HR; beta>0 = *less* favorable, against prior):

| Specification | beta (per +1 SD) | p (t) | df |
|---|---|---|---|
| allele-clustered, raw | +0.101 | 0.132 | 10 |
| allele-clustered, +freq | +0.097 | 0.081 | 9 |
| supertype-IVW, raw | +0.272 | 0.260 | 10 |

**Autoimmune arm** (engageability -> signed risk rank): composite rho = +0.212 (p = 0.38)
raw, halving to +0.126 under frequency control.

**Paired joint test** (antagonistic-pleiotropy signature, 15 alleles / 8 supertypes): cancer
log-HR vs autoimmune risk-rank **rho = +0.037, p = 0.90** - the signature is **not present**,
and the observed sign is, if anything, the *wrong* direction for the trade-off.

**Honest reading:** every arm is a **non-significant bounded null** under the conservative
effective-N (~8-12 supertype points, not the 400-row allele count); no signal was significant
before frequency control, so none "vanishes under" it; both arms attenuate toward the null
with frequency added. The cancer-side sign runs against the engageability->favorable prior.
This is a **descriptive proof-of-concept on well-characterized anchors**, not a powered
population test.

*Primary artifacts:* [`results_tradeoff_two_arm.md`](results_tradeoff_two_arm.md),
[`results_two_arm_INDEX.md`](results_two_arm_INDEX.md),
[`tradeoff_cancer_summary_freqcontrol.csv`](tradeoff_cancer_summary_freqcontrol.csv),
[`tradeoff_paired_joint_summary.csv`](tradeoff_paired_joint_summary.csv).

---

## 7. What is settled, and what is not

**Settled.**
- A reproducible, pre-registered 676-allele engageability metric with usable spread and
  blend-robustness (Sec 1).
- Orthogonality to HED overall, with the per-locus structure and the -0.02/+0.20 provenance
  fully reconciled to source (Sec 2-3).
- A theory result bounding what allele-level ICB data can identify, independent of the metric
  (Sec 4).

**Not settled (honest limits).**
- The two-arm trade-off is a **bounded null** at effective N ~ 8-12; it neither confirms nor
  refutes antagonistic pleiotropy, and the cancer-side sign is against prior (Sec 6).
- The composite's overall HED-orthogonality partly reflects **cancellation of opposing raw
  features** (hydrophobic imbalance -0.29, |net charge| +0.21) - surfaced, not adjudicated (Sec 1).
- Structural calibration of docking diversity is a **confounded null at n = 8**; the only
  powered structural evidence is within A*02:01 (Sec 5).

**Novelty delineation.** HED and the antagonistic-pleiotropy trade-off concept are prior
work. The contribution of this arm is the **engageability metric** (a TCR-docking-permissiveness
axis distinct from repertoire breadth), its **orthogonality decomposition**, the
**identifiability analysis**, and the **head-to-head two-arm test** on both cancer and
autoimmune arms.
