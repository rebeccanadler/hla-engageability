# SEQUENCE-DERIVED POTENCY AXES — ORTHOGONALITY / DECOMPOSITION TEST

**Descriptive decomposition of the axes themselves. No NetMHCpan, no outcome data, no
outcome association.** The claim under test is that class I immunogenic potency is not one
quantity but factors into distinct, largely-independent sequence-derived components. This
does NOT depend on any outcome and is not framed as one. Report-then-stop; numbers only; the
mini-gate call is the user's.

## Axes
- **HED** = peptide-repertoire BREADTH (groove-floor/anchor positions, exons 2–3). Column
  `mean_HED` from `hed_per_allele.csv`.
- **Engageability** = α1/α2 TCR-facing-surface ENGAGEMENT permissiveness (crest). Column
  `engageability_A` from `engageability_scores.csv` (per-locus SD A 0.796 / B 0.579 / C 0.298,
  confirmed).
- **α3 CD8-engagement** = EXCLUDED as an axis (mini-gate: near-invariant — 5 distinct
  footprints/674, HLA-B fully invariant, 46/674 nonzero ΔΔG; 5–8 Å sweep confirmed contact-
  surface conservation). Recorded as a carried-separately CONSERVED axis. Its ΔΔG
  correlations with HED and engageability are reported DESCRIPTIVELY for completeness only —
  near-zero variance makes them unstable/uninterpretable, and **|r|<0.7 is NOT orthogonality
  here.** The withdrawn composite and acidic_loop_charge are NOT entered as axes.

n = 676 alleles (A 218, B 331, C 127); α3 defined for 674 (2 exon-4-quarantined).
Flags: **|r| > 0.7 = REDUNDANCY (axes collapse); |r| < 0.2 = ORTHOGONAL (independent).**

## PRIMARY RESULT — HED × engageability (the two axes that vary)

| scope | Pearson | Spearman | n | flag |
|-------|---------|----------|---|------|
| **OVERALL** | **−0.029** | −0.038 | 676 | **ORTHOGONAL (\|r\|<0.2)** |
| HLA-A | −0.456 | −0.416 | 218 | intermediate (0.2≤\|r\|≤0.7) |
| HLA-B | +0.013 | −0.062 | 331 | ORTHOGONAL (\|r\|<0.2) |
| HLA-C | +0.373 | +0.393 | 127 | intermediate (0.2≤\|r\|≤0.7) |

**No pair reaches \|r\|>0.7 anywhere — the two axes never collapse into redundancy.** The
overall correlation is ≈0 (orthogonal), but the per-locus breakdown — mandatory precisely to
catch this — shows the overall zero is partly a cancellation of **opposite-sign** per-locus
structure: moderate **negative** in HLA-A (−0.46), flat in HLA-B (+0.01), moderate **positive**
in HLA-C (+0.37). Neither A nor C is in the orthogonal band; neither is redundant.

## Extreme-decile overlap — HED × engageability (are the extremes independent?)

| scope | top-decile overlap | bottom-decile overlap | expected by chance | k/decile |
|-------|-------------------|----------------------|--------------------|---------|
| overall | 9 | 4 | 6.8 | 68 |
| HLA-A | 0 | 0 | 2.2 | 22 |
| HLA-B | 1 | 0 | 3.3 | 33 |
| HLA-C | 2 | 4 | 1.3 | 13 |

Corroborates the correlations: HLA-A extremes are anti-associated (0/0 overlap vs ~2.2
expected — high-breadth alleles are not high-engageability and vice versa); HLA-C bottom
decile over-overlaps (4 vs 1.3) consistent with the positive C correlation; overall ≈ chance.

## DESCRIPTIVE ONLY — α3 engagement_ΔΔG (conserved axis; NOT orthogonal-tested)

Reported for completeness; near-zero variance ⇒ unstable/uninterpretable; HLA-B is
zero-variance (all modal) ⇒ UNINTERPRETABLE.

| pair | overall | HLA-A | HLA-B | HLA-C |
|------|---------|-------|-------|-------|
| α3ΔΔG × HED | P +0.137 / S +0.283 | −0.013 / +0.007 | UNINTERPRETABLE (SD 0) | −0.496 / −0.488 |
| α3ΔΔG × engageability | P +0.063 / S +0.020 | +0.076 / +0.064 | UNINTERPRETABLE (SD 0) | −0.052 / −0.234 |

These are NOT evidence of orthogonality (the |r|<0.2 cells here reflect α3's near-zero
variance, not axis independence). Recorded, not interpreted.

## ⏸ STOP

Full matrix (Pearson + Spearman, overall + per-locus), decile overlaps, and redundant/
orthogonal flags reported above. No axis dropped to improve a story; nothing tuned; no metric
selected. The mini-gate — whether the sequence-derived axes are mutually independent (a
genuine multi-axis decomposition) or whether any pair collapses — is the user's call. For the
record: no pair collapses (\|r\|>0.7 nowhere), HED×engageability is orthogonal overall and in
HLA-B, and intermediate with opposite signs in HLA-A and HLA-C.
