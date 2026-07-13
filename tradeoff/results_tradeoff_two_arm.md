# Results — Two-arm trade-off test: engageability vs cancer-favorability and autoimmune-risk

*Scope: this document covers the **head-to-head two-arm step** — does a single engageability
axis trend cancer-favorable in the ICB arm AND autoimmune-risky in the disease-anchor arm
(antagonistic pleiotropy)? — with **allele-frequency control as the gating requirement** and
feature-level HED control. It supersedes the "NOT YET RUN" frequency caveat and the
"allele-resolution overlap N = 0 / arms disjoint" framing carried in the earlier
`results_cancer_arm.md`. Companion within-arm construction is in `results_cancer_arm.md`
(cancer axis + metric validation) and `results_autoimmune_risk_arm.md` (ranked risk axis).*

*Framing note: this is a **descriptive proof-of-concept on well-characterized anchors**. The
effective N is the number of supertype points where the arms meet (≈8–12), not the allele
row count. All associations are reported as-found, before and after frequency control;
no positive/negative narrative call is made here.*

---

## 1. What actually overlaps between the arms (correcting the record)

The two arms were previously described as "disjoint at allele resolution, N = 0." That
wording was **retracted** — see the correction note in the methods artifact. The precise
statement:

- **N = 0** applies only to the overlap of **independent allele-specific measurements** —
  alleles that carry their *own* allele-level ICB hazard ratio *and* are class I autoimmune
  anchors. No allele holds both an independent cancer HR and an autoimmune OR.
- But cancer favorability is defined at **supertype** resolution and is inherited by member
  alleles. **15 of the 16** A/B autoimmune anchor alleles fall in a favorability-bearing
  supertype and therefore carry a (supertype-constant) cancer log-HR. A paired allele-level
  joint table **is** constructable, and the joint test **was** run (§4).
- Those 15 alleles span **8 distinct supertypes**. Because favorability is constant within a
  supertype, the joint test's effective N is **~8 supertype points**, not 15 independent
  alleles.
- The 3 HLA-C anchors (C\*06:02, C\*04:01, C\*16:01) carry no favorability (Sidney/Sette + ICB
  data are A/B only) → autoimmune-only, excluded from the joint test.

---

## 2. The key figure

![Engageability vs cancer log-HR (supertype-level, N=12) and vs autoimmune risk rank (allele-level, N=16), pre- and post-frequency control]({{artifact:art_bd4b7b64-2172-4508-9d00-05bb534b3a40}})

**Figure 1.** *Left (a)* — cancer arm: engageability (supertype mean) vs all 12 supertype ICB
hazard ratios (most-favorable B44 HR 0.61, log-HR −0.49, bottom-centre with leader; least-favorable
B62 HR 2.29, top), marker size ∝ member alleles, blue = favorable / red = unfavorable. Solid = IVW fit (raw); dashed = IVW fit with log-frequency control. *Right (b)* —
autoimmune arm: per-allele engageability vs the signed protective→risk rank (1 protective → 7
risk), 16 A/B anchors. On-frame caveat: effective N = supertype points (cancer ≈12); arms meet
only at supertype resolution; values shown pre- and post-frequency control; C anchors are
autoimmune-only.

---

## 3. Single-axis associations, before and after frequency + HED control

### 3.1 Cancer arm — engageability vs supertype log-HR

Sign convention: **β > 0 ⇒ higher engageability → higher HR → *less* ICB-favorable** (opposite
to the engageability prior). One row per allele, clustered by supertype; the honest small-sample
reading is the t on cluster df, led over the cluster-robust normal. The transparent 12-point
supertype-level IVW fit (weight 1/SE_logHR²) is the effective-N-honest anchor.

| Specification | β (per +1 SD) | SE | p (normal / WLS) | p (t) | df_t |
|---|---|---|---|---|---|
| allele-clustered, raw | +0.101 | 0.062 | 0.101 | 0.132 | 10 |
| allele-clustered, **+freq** | +0.097 | 0.049 | 0.050 | **0.081** | 9 |
| allele-clustered, +HED | +0.083 | 0.049 | 0.092 | 0.126 | 9 |
| allele-clustered, +freq+HED | +0.075 | 0.041 | 0.069 | 0.107 | 8 |
| **supertype-IVW, raw** | +0.272 | 0.227 | 0.260 | 0.260 | 10 |
| **supertype-IVW, +freq** | +0.256 | 0.240 | 0.315 | 0.315 | 9 |

Nothing reaches p < 0.05 under the conservative (t on cluster df; 12-point IVW) reading. Adding
the log-frequency covariate **shrinks** β modestly (+0.101→+0.097 clustered; +0.272→+0.256 IVW)
— directionally consistent with population structure contributing, but there is no significant
effect to attribute either way. Full table: [`tradeoff_cancer_summary_freqcontrol.csv`](tradeoff_cancer_summary_freqcontrol.csv).

### 3.2 Autoimmune arm — engageability vs signed risk rank

Rank-based (Spearman / rank-partial) across the full protective→risk gradient; raw OR never
enters. 16 A/B anchors (19 disease-anchored entries).

| Feature | ρ raw (p) | +freq (p) | +HED (p) | +freq+HED (p) |
|---|---|---|---|---|
| engageability_A (composite) | +0.212 (0.384) | +0.126 (0.618) | +0.208 (0.409) | +0.123 (0.639) |
| z_het (VARIABLE) | +0.168 (0.491) | +0.111 (0.661) | +0.204 (0.416) | +0.138 (0.598) |
| z_absnetchg (VARIABLE) | −0.022 (0.928) | +0.044 (0.863) | −0.032 (0.899) | +0.038 (0.886) |
| z_hydimb (VARIABLE) | −0.356 (0.135) | −0.303 (0.222) | −0.360 (0.142) | −0.310 (0.226) |
| con_heterogeneity (CONSERVED) | +0.269 (0.265) | +0.388 (0.111) | +0.265 (0.288) | +0.388 (0.123) |

The composite trends weakly in the predicted (risk) direction (ρ=+0.212) but is not significant
and roughly halves under frequency control (ρ=+0.126). Full table:
[`tradeoff_autoimmune_rank_assoc.csv`](tradeoff_autoimmune_rank_assoc.csv).

### 3.3 Which feature group carries any signal

Any nonzero trend sits in the **VARIABLE** group — specifically crest heterogeneity `z_het`
(cancer clustered β +0.079 raw → +0.089 with freq+HED; autoimmune ρ +0.168). The **CONSERVED**
group is near-invariant across alleles (variance 6.2×10⁻⁵), so its regression coefficients are
numerically meaningless. **That the discriminating group carries the signal is a mathematical
necessity of an allele-discriminating metric, not a mechanistic claim.** Cancer feature
decomposition: [`tradeoff_cancer_feature_decomp.csv`](tradeoff_cancer_feature_decomp.csv).

---

## 4. Paired allele-level joint test (antagonistic-pleiotropy signature)

The antagonistic-pleiotropy prediction is that cancer-favorable alleles (low log-HR) are
autoimmune-risky (high rank) — i.e. a **negative** log-HR ↔ risk-rank correlation. Tested on the
15 paired alleles (8 supertypes):

| Test | Method | ρ | p | N |
|---|---|---|---|---|
| cancer log-HR vs autoimmune risk-rank | Spearman | +0.037 | 0.896 | 15 alleles |
| cancer log-HR vs autoimmune risk-rank | Spearman | +0.374 | 0.362 | 8 supertype pts |
| engageability vs cancer log-HR | Spearman | −0.400 | 0.139 | 15 |
| engageability vs cancer log-HR (+freq) | partial-Spearman | −0.380 | 0.180 | 15 |
| engageability vs autoimmune rank | Spearman | +0.169 | 0.546 | 15 |
| engageability vs autoimmune rank (+freq) | partial-Spearman | +0.077 | 0.792 | 15 |

The direct antagonistic-pleiotropy signature is **not present** (log-HR ↔ rank ρ = +0.037,
p = 0.90; +0.374, p = 0.36 supertype-collapsed) — the observed sign is, if anything, the
*wrong* direction for the trade-off (cancer-favorable trending toward autoimmune-*protective*).
On the same 15 alleles, engageability trends toward cancer-*favorable* (ρ = −0.400 on log-HR;
per the §3.1 convention a negative correlation means higher engageability → **lower** HR → more
favorable — the pro-prior direction on this subset) and weakly toward autoimmune-risk
(ρ = +0.169), both non-significant and both attenuated by frequency control. Note this 15-allele
subset sign is opposite to the full 400-row cancer arm (§3.1, β > 0, against-prior); the subset
is small (8 supertype points), so the discrepancy is within sampling noise and not
over-interpreted. Table:
[`tradeoff_paired_joint_summary.csv`](tradeoff_paired_joint_summary.csv); the 15-allele
paired matrix: [`tradeoff_paired_allele_joint.csv`](tradeoff_paired_allele_joint.csv).

**Opposite-sign allele on record.** B\*57:01 appears with opposite autoimmune sign across
diseases — protective in T1D (OR 0.19) and ankylosing spondylitis, but risk in abacavir drug-HSR
(OR ~1945). Within the B58 supertype it pairs with B\*58:01 (allopurinol SCAR, rank 7), the two
sharing an identical inherited cancer log-HR of −0.020.

---

## 5. Allele-frequency control — the gating requirement

A between-supertype association over ~12 points is exactly what population structure can
manufacture, so each arm was refit with an AFND frequency covariate:

- **Autoimmune arm:** per-allele AFND `freq_median` (already on the ranked axis).
- **Cancer arm:** log₁₀ of each supertype's prototype-allele AFND median frequency
  (A01→A\*01:01 … B62→B\*15:01), from AFND page-1 (100-population) medians. The scrape
  reproduced known anchor medians (A\*03:01 0.0797 vs 0.0806; B\*44:03 0.0392 vs 0.041;
  B\*27:05 0.013 vs 0.015). Inputs: [`supertype_prototype_frequencies_afnd.csv`](supertype_prototype_frequencies_afnd.csv).

**Outcome:** no engageability–outcome association was significant *before* frequency control, so
none "vanishes under" it. Both arms attenuate toward the null with frequency added (cancer β
+0.101→+0.097 clustered, +0.272→+0.256 IVW; autoimmune ρ +0.212→+0.126). There is no surviving
signal to declare either genuine or a frequency artifact — the honest reading is a bounded null
on both arms.

---

## 6. Effective-N accounting and honest framing

- **Cancer arm:** 400 member-allele rows collapse to **12 supertype points** (favorability
  constant within supertype); honest df = 10 (raw) / 9 (+freq).
- **Autoimmune arm:** **16 unique A/B anchor alleles** (19 disease-anchored entries).
- **Joint test:** 15 paired alleles across **8 supertypes** → effective N ≈ 8.
- **Independent-measurement two-arm overlap:** N = 0 (no allele carries both its own ICB HR and
  an autoimmune OR) — this is *why* the joint test runs through supertype-inherited favorability
  rather than independent per-allele HRs.
- All three arms (cancer single-axis, autoimmune single-axis, paired joint) are **non-significant
  bounded nulls** under the conservative effective-N reading, and the cancer-side sign runs
  against the engageability→favorable prior. Reported as-found; no result was massaged to reach a
  target, and the narrative call is deferred.

Methods, data sources, and per-figure provenance:
[`methods_tradeoff_two_arm_freqcontrol.md`](methods_tradeoff_two_arm_freqcontrol.md).
