# Autoimmune-risk arm — Results

*HLA class I "immunogenic potency" project. This arm builds the per-allele autoimmune-risk
axis that is tested, head-to-head, against the cancer-favorability arm. Generated 2026-07-12.*

## Summary

We assembled a per-allele **autoimmune-risk axis** over HLA class I alleles anchored to
canonical class I diseases (ankylosing spondylitis, Behçet's, birdshot chorioretinopathy,
psoriasis, Takayasu arteritis, type 1 diabetes) plus drug-hypersensitivity strong-response
phenotypes (abacavir/B\*57:01, carbamazepine/B\*15:02, allopurinol/B\*58:01). The axis is an
**ordinal rank**, not raw odds ratios: verified per-allele ORs determine ORDER only, never
entering any fit. The final axis spans **22 entries / 19 unique alleles**, from a
class-I-native + class-II-conditioned **protective tail** (13 entries) through a
provenance-heterogeneous **risk arm** (9 entries).

Every odds ratio is traceable to a named retrieval source (`source_ref` column); no value
is taken from memory. Population allele frequencies (Allele Frequency Net Database, AFND)
are attached to all 19 alleles to flag frequency confounders.

![Autoimmune-risk axis: ordinal rank with protective tail de-confounded across diseases]({{artifact:8082ddb5-cd00-4232-a6ec-e8561f512c14}})

**Figure.** Ordinal autoimmune-risk axis. Points are placed at log₁₀(OR) where a verified
OR exists; open circles are conditioned-protective by direction only (no per-allele OR
published). Marker shape encodes the conditioning basis (● class-I-native, ■
class-II-conditioned, ▲ marginal/native). Blue = protective, red = risk. Bars are 95% CIs.
The dashed line is OR = 1. `‡` marks HLA-C alleles excluded from the two-arm join (no
favorability supertype). B\*07:02 and B\*57:01 each appear under more than one disease
anchor — the same allele's effect recorded per disease, never pooled.

## Why an ordinal rank, not raw OR

1. **Provenance-heterogeneous ORs.** Values come from GWAS-native (GWAS Catalog),
   meta-analytic, single-cohort, pooled, and phenotype-defined sources — not on a common
   scale.
2. **Leverage capture.** Raw OR is dominated by A\*29:02 (157), B\*27:05 (58), and
   especially B\*57:01 (~1945). The B\*57:01 abacavir OR is a patch-test-confirmed-phenotype
   artifact (~100% specificity by construction), reflecting ascertainment, not allele
   biology. A rank is robust to both; raw OR is not.
3. If a continuous axis is ever needed, use **log(OR)** (symmetric for protective/risk),
   never raw OR. Default remains the rank.

**Tied rank bands.** Where OR confidence intervals overlap, alleles share a tied band
rather than being force-ordered. The six high-OR risk alleles (B\*39:06 → B\*57:01) form a
single connected CI-overlap chain → tied band **r7**: their magnitude ordering is not
statistically separable, which is exactly why the axis is ranked.

## Protective tail (ranks r1–r4)

The protective end is deliberately de-confounded across **three diseases** so it is not a
single-study artifact. It combines **class-II-conditioned** T1D evidence (T1DGC / Noble
2010) with **class-I-native** fine-mapping from ankylosing spondylitis and Behçet's
(conditioned on each disease's primary class I risk allele, not on class II).

| Rank | Allele | Locus | Disease anchor | OR (95% CI) | Conditioning basis | AFND med / max | Join-elig. |
|---|---|---|---|---|---|---|---|
| 1 | B*44:03 | B | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.041 / 0.125 | ✓ |
| 1 | B*07:02 | B | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.042 / 0.176 | ✓ |
| 1 | B*35:02 | B | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.013 / 0.089 | ✓ |
| 1 | A*11:01 | A | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.080 / 0.613 | ✓ |
| 1 | A*32:01 | A | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.032 / 0.102 | ✓ |
| 1 | A*66:01 | A | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.006 / 0.077 | ✓ |
| 1 | C*16:01 | C | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.022 / 0.283 | ✗ (C) |
| 1 | C*04:01 | C | Type 1 diabetes | — (direction) | class-II-conditioned (T1D; Noble 2010) | 0.116 / 0.286 | ✗ (C) |
| 1 | B*57:01 | B | Ankylosing spondylitis | — (direction) | class-I-native (European Immunochip fine-map) | 0.025 / 0.083 | ✓ |
| 2 | B*07:02 | B | Ankylosing spondylitis | 0.15 | class-I-native (conditioned on B*27 risk allele) | 0.042 / 0.176 | ✓ |
| 3 | B*57:01 | B | Type 1 diabetes | 0.19 | class-II-conditioned (T1D; Noble 2010) | 0.025 / 0.083 | ✓ |
| 4 | A*03:01 | A | Behçet's disease | 0.6 (0.4–0.7) | class-I-native (conditioned on B*51:01 risk allele) | 0.081 / 0.250 | ✓ |
| 4 | B*49:01 | B | Behçet's disease | 0.6 (≥0.4) | class-I-native (B*51-negative stratified) | 0.019 / 0.095 | ✓ |

## Risk arm (ranks r5–r7)

| Rank | Allele | Locus | Disease anchor | OR (95% CI) | Conditioning basis | AFND med / max | Join-elig. |
|---|---|---|---|---|---|---|---|
| 5 | C*06:02 | C | Psoriasis vulgaris | 3.58 (2.82–4.54) | marginal / native | 0.089 / 0.240 | ✗ (C) |
| 5 | B*52:01 | B | Takayasu arteritis | 3.7 (2.02–6.77) | marginal / native | 0.027 / 0.180 | ✓ |
| 6 | B*51:01 | B | Behçet's disease | 3.82 | marginal / native | 0.055 / 0.184 | ✓ |
| 7 | B*39:06 | B | Type 1 diabetes | 10.31 (4.21–25.1) | class-II-conditioned | 0.006 / 0.088 | ✓ |
| 7 | B*15:02 | B | Carbamazepine SJS/TEN (drug-HSR) | 42.06 (9.587–184.514) | marginal / native | 0.025 / 0.358 | ✓ |
| 7 | B*27:05 | B | Ankylosing spondylitis | 57.54 (38.17–86.74) | marginal / native | 0.015 / 0.071 | ✓ |
| 7 | B*58:01 | B | Allopurinol SCAR (drug-HSR) | 79.3 (41.5–151.4) | marginal / native | 0.026 / 0.170 | ✓ |
| 7 | A*29:02 | A | Birdshot chorioretinopathy | 157.5 (91.6–272.6) | marginal / native | 0.019 / 0.104 | ✓ |
| 7 | B*57:01 | B | Abacavir hypersensitivity (drug-HSR) | 1945 (110–34352) | marginal / native | 0.025 / 0.083 | ✓ |

## Scope decision: class-I-attributable ALLELE effects

The guardrail was widened from "class I *diseases*" to "class-I-*attributable* allele
effects," admitting an independent class I effect inside a class-II-associated disease
**only where a conditioning analysis demonstrates class I independence**. Applied
symmetrically:

- **B\*39:06 (T1D) admitted** — OR 10.31 (4.21–25.1), P = 4×10⁻¹⁰ after accounting for LD
  with HLA class II (T1DGC, Noble 2010). It modulates risk across all DR-DQ haplotypes on
  which it resides — a class I effect independent of class II.
- **B\*08:01 (AH8.1) dropped** — same bar, opposite outcome: its signal is not separable
  from DR3/DQ2, and the DR3-B8-A1 haplotype confers *less* T1D risk than other DR3
  haplotypes (non-separable + sign confound).

Mechanistic rationale (stated, not overclaimed): T1D *susceptibility* is class-II-dominated,
but the *effector* arm — CD8 T-cell killing of insulin-producing β-cells — is
class-I-restricted, so a class I allele shaping β-cell epitope presentation is a
mechanistically coherent T1D anchor.

## Disease-specificity: same allele, opposite sign

Because engageability is allele-intrinsic but disease risk is not, the axis is anchored
per disease and never pooled into one "autoimmune value." The reportable consequence:

- **B\*57:01** — drug-HSR **risk** (abacavir, OR ~1945, r7) vs T1D **protective**
  (OR 0.19, r3) vs AS **protective** (direction, r1). Three anchors, opposite signs.
- **B\*07:02** — **protective** in both T1D (r1) and AS (r2, OR 0.15 after B\*27 control).

## Overlap with the cancer-favorability arm

The join constraint: an allele enters the two-arm cancer×autoimmune test only if it also
lands in a favorability-bearing supertype (A/B only; **HLA-C carries no favorability**).
Three HLA-C alleles (C\*06:02 risk; C\*16:01, C\*04:01 protective) stay autoimmune-only.

Against the current cancer-favorability allele-level set (B\*15:01, B\*18:01, B\*44:02/03/05,
B\*50:01 + the A\*03 group):

| Level | Overlap N | Members |
|---|---|---|
| Exact 4-digit allele | **1** | **B\*44:03** — cancer-**favorable** (HR 0.49) *and* autoimmune-**protective** (T1D). Same-direction (both "less immune-pathology") at the same allele. |
| 2-digit group | 3 | A\*03, B\*15, B\*44 |
| Sidney supertype (prior work) | 10 | anchors inheriting a supertype-level favorability HR |

The single exact-allele overlap, **B\*44:03**, is notable: it is cancer-favorable (better
ICB-associated outcome) *and* T1D-protective — i.e. lower on both the anti-tumor-potency
and the autoimmune-risk axes, consistent with a shared low-engageability direction rather
than the antagonistic-pleiotropy (opposite-sign) case. This is a single allele and is
reported as an observation, not a test result.

## Frequency confounders (AFND control)

Alleles whose association OR is most exposed to population-stratification confounding
(common and/or highly population-skewed):

| Allele | Disease anchor | AFND median | AFND max | Flag |
|---|---|---|---|---|
| A*11:01 | Type 1 diabetes | 0.080 | 0.613 | common (max≥20%) |
| A*66:01 | Type 1 diabetes | 0.006 | 0.077 | strat (max/med≥8×) |
| C*16:01 | Type 1 diabetes | 0.022 | 0.283 | common (max≥20%); strat (max/med≥8×) |
| C*04:01 | Type 1 diabetes | 0.116 | 0.286 | common (max≥20%) |
| A*03:01 | Behçet's disease | 0.081 | 0.250 | common (max≥20%) |
| C*06:02 | Psoriasis vulgaris | 0.089 | 0.240 | common (max≥20%) |
| B*39:06 | Type 1 diabetes | 0.006 | 0.088 | strat (max/med≥8×) |
| B*15:02 | Carbamazepine SJS/TEN (drug-HSR) | 0.025 | 0.358 | common (max≥20%); strat (max/med≥8×) |

**B\*15:02** (carbamazepine SJS/TEN) is SE-Asian-restricted (max 36%), so its OR is not
transferable to European cohorts. **A\*11:01** reaches 61% in some populations. HLA-C
protective alleles C\*16:01/C\*04:01 are common; C\*16:01's protection is partly
attributable to LD with B\*44:03 (noted in source).

## Provenance & auditability

- **Association ORs**: GWAS Catalog (live, this project) for AS/B\*27:05, birdshot/A\*29:02,
  Behçet/B\*51:01; retrieved literature (with DOI/PMC in `source_ref`) for the conditioned
  T1D panel, drug-HSR, Takayasu, psoriasis, and the non-T1D protective tail.
- **Frequencies**: AFND per-allele across ~79–98 populations.
- **Corrections applied during build** (audited): initial from-memory ORs replaced with
  retrieved values (e.g. B\*57:01 abacavir 117→1945; B\*52:01 Takayasu 2.9→3.7); B\*08:01
  dropped; A\*33:01/Behçet dropped (its cited source is an A\*26 paper); psoriasis yielded
  no clean protective class I allele (none fabricated).

## Files

- `autoimmune_risk_axis_ranked.csv` — the 22-row ranked axis (rank, tied_band, arm,
  disease_anchor, OR + CI, conditioning_basis, source_ref, AFND freqs, join-eligibility).
- `autoimmune_risk_per_allele.csv` — earlier verified-OR risk table (10 anchors).
- `cancer_autoimmune_overlap_summary.csv` — overlap N at all three resolution levels.
- `afnd_freqs_full.json` — raw AFND frequency pulls.
- `methods_autoimmune_risk_axis.md` — full methods (rank construction, scope widening,
  protective-tail guardrails, de-confounding).
- `fig_autoimmune_risk_axis.png` — the axis figure above.
