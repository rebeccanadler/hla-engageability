# Autoimmune-risk axis — ordinal rank construction (methods)

## Design decision: ordinal RANK, not raw OR
The autoimmune-risk axis is an **ordinal rank** over anchor alleles. Verified per-allele
odds ratios are used ONLY to determine ORDER; OR magnitude never enters any fit.

Rationale:
1. **Provenance-heterogeneous ORs.** Values come from GWAS-native (GWAS Catalog this
   session), meta-analytic, single-cohort, pooled, and phenotype-defined sources
   (see `source_ref` column). They are not on a common scale.
2. **Leverage capture.** Raw OR is dominated by A*29:02 (157), B*27:05 (58), and
   especially B*57:01 (~1945). The B*57:01 abacavir OR is a patch-test-confirmed-
   phenotype artifact (~100% specificity by construction), reflecting ascertainment,
   not allele biology. A rank is robust to both; raw OR is not.
3. If a continuous axis is ever required for a specific test, use **log(OR)** (symmetric
   for protective OR<1 and risk OR>1), never raw OR. Default remains the rank.

## Tied rank bands
Where OR confidence intervals overlap, alleles share a tied rank band (not collapsed
arbitrarily). The high-OR risk alleles (B*39:06 through B*57:01) form a single connected
CI-overlap chain → **tied band r7** (r5 before the protective tail was added): their magnitude ordering is not statistically
separable, which is exactly why the axis is ranked. Direction-only conditioned-protective
alleles (no per-allele OR published) form tied band **r1**.

## Scope widening: class-I-attributable ALLELE EFFECTS
Guardrail widened FROM "class-I DISEASES" TO "class-I-attributable ALLELE EFFECTS,
including independent class-I effects within class-II-associated diseases, admitted ONLY
where a conditioning analysis demonstrates class-I independence."

- **B*39:06 (T1D) ADMITTED** on a CONDITIONED estimate: OR = 10.31 (95% CI 4.21–25.1),
  P = 4×10⁻¹⁰, after accounting for LD with HLA class II (T1DGC; Noble et al., Diabetes
  2010, doi:10.2337/db10-0699; review PMC3233362). B*39:06 "appears to modulate the risk
  of all DRB1-DQA1-DQB1 haplotypes on which it resides, suggesting a class I effect
  independent of class II" — it passes the conditioning test.
- **B*08:01 (AH8.1) DROPPED** — same bar, opposite outcome: its signal is NOT separable
  from DR3/DQ2, and the DR3-B8-A1 haplotype confers LESS T1D risk than other DR3
  haplotypes (directionally protective; non-separable + sign confound). The bar is
  identical; only the outcome differs.

Mechanistic support (stated, not overclaimed): T1D SUSCEPTIBILITY is class-II-dominated,
but the EFFECTOR arm — CD8 T-cell-mediated destruction of insulin-producing pancreatic
beta cells — is class-I-restricted. Class I alleles shaping which beta-cell epitopes are
presented to CD8 T cells therefore play an independent role in driving susceptibility,
making a class-I allele a mechanistically coherent T1D anchor, not an LD artifact.

## Protective tail (conditioned OR<1), disease-anchored
Protective alleles occupy the LOW end of the same rank — the reason the axis is ranked.
Admitted under all three guardrails:
1. **Same bar as risk alleles** — class-I-attributable AFTER conditioning on class II.
   All protective entries are from the T1DGC LD-adjusted analysis (Noble 2010):
   B*57:01 (OR 0.19, P=4×10⁻¹¹, quantified, rank r2); and eight conditioned-protective
   by DIRECTION (no per-allele OR in source → tied band r1): B*44:03, B*07:02, B*35:02,
   A*11:01, A*32:01, A*66:01 (A/B, join-eligible) and C*16:01, C*04:01 (HLA-C,
   join-INELIGIBLE, retained autoimmune-only per guardrail 3 — same precedent as C*06:02).
   C*16:01's protection is partly attributable to LD with B*4403 (noted in source).
2. **Risk is DISEASE-ANCHORED, not allele-intrinsic.** Every entry keeps its specific
   disease anchor; no allele gets a single pooled "autoimmune value." Engageability is
   allele-intrinsic, so the axis mapping runs THROUGH a chosen disease — stated explicitly.
   **B*57:01 appears with OPPOSITE SIGN across two diseases**: drug-HSR RISK (abacavir,
   OR~1945, rank r5) vs T1D PROTECTIVE (OR 0.19, rank r2). This is a reportable feature
   of disease-specificity, not a contradiction to be averaged away.
3. **Join constraint unchanged.** An allele enters the two-arm cancer×autoimmune test
   only if it also lands in a favorability-bearing supertype (A/B only; HLA-C carries no
   favorability). Three HLA-C alleles stay autoimmune-only (`enters_two_arm_test=False`):
   C*06:02 (psoriasis, risk) and the two protective C*16:01, C*04:01 (T1D) — the guardrail
   applies identically to both signs.

## Allele-frequency control (AFND)
All 19 unique alleles (22 axis rows; B*57:01 appears three times — drug-HSR risk, T1D
protective, AS protective; B*07:02 twice — T1D and AS protective) have AFND median/max
frequencies across ~79–98 populations, enabling the frequency-confounder control on the
full set (freq_p90 present for all except the two late-added HLA-C protectives C*16:01,
C*04:01). B*15:02 flagged SE-Asian-restricted
(max 36%); C*06:02 common (max 24%).


## Protective-tail de-confounding across diseases (non-T1D)
The initial protective tail was entirely T1D/Noble-2010 (class-II-conditioned). To
de-confound the protective end, verified protective/reduced-risk class I alleles were
added from non-T1D diseases, with a DISTINCT conditioning basis — class-I-NATIVE
fine-mapping (conditioned on the disease's primary class I risk allele, not class II).
Every entry disease-anchored, source_ref per row, no memory values.

Non-T1D protective entries admitted (all verified by retrieval this session):
- **B*07:02 (Ankylosing spondylitis)** OR 0.15 after conditioning on B*27 (Chinese
  cohort); also reduced-risk in European Immunochip (9,069 cases). source_ref: PMC5750450.
  class-I-native.
- **B*57:01 (Ankylosing spondylitis)** reduced-risk, European Immunochip (direction).
  source_ref: PMC5750450. class-I-native.
- **A*03:01 (Behçet's disease)** OR 0.6 (95% CI 0.4–0.7), P=2.4×10⁻⁶, after conditioning
  on B*51:01. source_ref: PNAS Ombrello 2014 (10.1073/pnas.1406575111). class-I-native.
- **B*49:01 (Behçet's disease)** OR 0.6, P=1.2×10⁻⁵, protective in the B*51-negative
  stratum. source_ref: PNAS Ombrello 2014. class-I-native.
(An A*33:01/Behçet protective entry was initially drafted but REMOVED: the retrieved
Sci Rep 2019 source s41598-019-40824-y is about HLA-A*26, not A*33, so the A*33 claim
was unsupported by any retrieval and dropped rather than kept as a memory value.)

**Psoriasis** was searched but yielded no clean protective class I allele — fine-mapping
(Okada 2014, PMC4129407) reports only additional C*06:02-INDEPENDENT *risk* alleles
(C*12:03 etc.); none admitted rather than fabricate a protective one.

**Same-allele, multiple-disease anchoring (deliberate).** B*07:02 and B*57:01 each now
appear under two disease anchors — protective in both T1D (Noble 2010) and AS (Immunochip).
This is the disease-anchoring principle in action: an allele is not assigned one pooled
value; its effect is recorded per disease. (B*57:01 also appears as drug-HSR RISK — the
opposite-sign feature already noted.) A `conditioning_basis` column now distinguishes
class-II-conditioned (T1D) from class-I-native (AS/Behçet) protective evidence.
