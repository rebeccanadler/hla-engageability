# LOH Arm — Summary Tables

## Table 1: Allele-Level Results (Established Findings)

Alleles reaching global BH-FDR < 0.05 on the Bradley–Terry primary estimand or marginal-binomial test.

| Locus | Allele | n Events | frac_lost | BT Log-Strength | SE | Direction | Multiplicity Status |
|-------|--------|----------|-----------|-----------------|-----|-----------|---|
| HLA-A | A\*01:01 | 632 | 0.4304 | −0.203 | 0.085 | Retention | BT-FDR<0.05, Marginal-p=4.4e-4 |
| HLA-B | B\*07:02 | 829 | 0.4391 | −0.166 | 0.083 | Retention | Marginal binomial p=4.4e-4 |
| HLA-B | B\*08:01 | 226 | 0.4301 | −0.299 | 0.114 | Retention | Marginal binomial p=1.6e-4 |
| HLA-B | B\*58:01 | 164 | 0.6646 | +0.513 | 0.131 | Loss | Marginal binomial p=3e-5 |

## Table 2: Locus-Level Tests of Heterogeneity

| Locus | n Alleles | n Events | Bradley–Terry LRT | p-value | Divergence Effect (β) | Frequency Effect (β) |
|-------|-----------|----------|-------------------|---------|----------------------|----------------------|
| **HLA-A** | 30 | 5,578 | 48.97 | **0.013** | −0.0057 (p=0.043) | −0.082 (p=0.002) |
| **HLA-B** | 53 | 4,629 | 100.52 | **< 0.001** | +0.0130 (p<0.001) | −0.015 (p=0.589) |
| **HLA-C** | 27 | 5,106 | 33.10 | 0.164 | +0.0024 (p=0.477) | −0.042 (p=0.027) |

## Table 3: Negative Control — Reference-Divergence Artifact Test

| Locus | Reference Allele | Spearman ρ | p-value (2-sided) | Reference Retention Rank | Interpretation |
|-------|------------------|-----------|-------------------|------------------------|---|
| HLA-A | A\*03:01 | −0.508 | **0.005** | 21/30 (not retained) | **Opposite** to artifact prediction |
| HLA-B | B\*07:02 | +0.231 | 0.094 | 7/53 (retained end) | Weak positive, not significant |
| HLA-C | C\*07:02 | −0.073 | 0.716 | 5/27 (retained end) | Null |

## Table 4: Crest-Profile Nested Tests

Alleles with identical engageability crest surfaces may show different loss-preference. Tested via nested LRT (strengths free vs. constrained within profile).

| Locus | Global Nested LRT | p-value | Profiles Detected ≥2 alleles | Profiles with p<0.05 (FDR-corrected) |
|-------|-------------------|---------|------|---|
| HLA-A | 3.32 | 0.914 | 4 | 0 |
| HLA-B | 47.58 | 0.072 | 14 | 1: RNQITNTERVATEW (p=0.0035) |
| HLA-C | 20.63 | 0.253 | 9 | 0 |

**HLA-B profile RNQITNTERVATEW:** B\*08:01 (retention-biased; frac_lost=0.430) vs. B\*18:01 (near-mean; frac_lost=0.497). Identical crest but 7 pocket-residue and 18 mature-residue groove differences.

## Table 5: Haplotype Concordance (Descriptive)

| Haplotype | Members | Observed Concordance | Expected (Flip Null) | Excess |
|-----------|---------|---------------------|---------------------|--------|
| 8.1 | A\*01:01 / B\*08:01 / C\*07:01 | 113/5043 = 2.24% | 1.68% | +0.56% |
| 7.1 | A\*03:01 / B\*07:02 / C\*07:02 | 88/5043 = 1.75% | 1.91% | −0.16% |
| **Total** | — | 201/5043 = **3.99%** | **3.59%** | **+0.40%** (p=0.056, not significant) |

Conclusion: Loss-preference is not primarily haplotype-driven.

## Table 6: Distribution Summary (frac_lost per locus)

| Locus | n Alleles | Min | Q1 | Median | Q3 | Max | SD | Range Span |
|-------|-----------|-----|-----|--------|-----|-----|-----|-----------|
| HLA-A | 30 | 0.4189 | 0.4766 | 0.5030 | 0.5287 | 0.7097 | 0.0569 | 0.290 |
| HLA-B | 53 | 0.3947 | 0.4584 | 0.5000 | 0.5354 | 0.6875 | 0.0636 | 0.293 |
| HLA-C | 27 | 0.4467 | 0.4907 | 0.5205 | 0.5470 | 0.7083 | 0.0585 | 0.262 |

