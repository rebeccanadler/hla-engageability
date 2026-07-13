# S11 §0 — reference-divergence negative control

**Pre-registered question (frozen before seeing correlations).** Does apparent allele-specific HLA-LOH directionality track an allele's **divergence from the GRCh38 reference haplotype** — a read-mapping artifact that would predict **POSITIVE** (more divergence → more apparent loss, with the reference allele at the retention extreme) — rather than somatic selection? Reported as numbers only; the verdict is the PI's call.

## Design

- **Divergence metric:** Hamming distance to the locus reference allele over mature residues 1–182 (α1+α2). A single definition — no Grantham variant, no exon-4 variant.
- **Reference alleles** (exact IMGT sequence identity vs the Ensembl GRCh38 canonical-transcript protein, mature 1–182): **A → A\*03:01, B → B\*07:02, C → C\*07:02.** Self-distance assertion passed (each reference = 0; sequence-identical twins A\*03:26, C\*07:66 also 0).
- **Effective N** = distinct crest profiles among tested alleles (counting only; profiles never joined as a variable).
- **Null:** within-locus permutation, B = 20,000, seed 20240709, two-sided on |ρ|.

## Results

**Full-catalog divergence** (mature 1–182): median A = 14 (range 0–25), B = 19 (0–32), C = 12 (0–17).

**Per-locus Spearman ρ (divergence vs frac_lost) with within-locus permutation null:**

| locus | n alleles | n crest profiles | Spearman ρ | perm p (2-sided) | MC-SE |
|---|---|---|---|---|---|
| A | 30 | 22 | **−0.508** | 0.0053 | 0.0005 |
| B | 53 | 19 | **+0.231** | 0.0942 | 0.0021 |
| C | 27 | 10 | −0.073 | 0.7163 | 0.0032 |

The artifact predicts a **positive** ρ (divergence → apparent loss). Only HLA-B has a positive sign, and it does not reach the 0.05 level; HLA-A is significantly **negative** (opposite to the artifact prediction); HLA-C is null.

**Reference-allele loss rank** (rank 1 = most retained = lowest frac_lost): A\*03:01 = **21/30** (frac_lost 0.523); B\*07:02 = **7/53** (0.439); C\*07:02 = **5/27** (0.483). The artifact predicts the reference allele at the retention extreme (rank 1); only B and C references sit near the retained end, HLA-A does not.

**Confounds (partial on log10 AFND frequency, pop 3210 USA NMDP European Caucasian; and event-count weighting).** ρ raw / partial / weighted per locus: A −0.508 / −0.508 / −0.435; B +0.231 / +0.243 / +0.621; C −0.073 / −0.054 / +0.188. Leave-one-out max |Δρ| ≈ 0.06 / 0.06 / 0.09 (A/B/C) — no single allele drives any correlation.

## Figure

![S11 negative control — divergence distributions (top) and per-locus divergence vs frac_lost (bottom), reference allele marked, self-distance = 0 line, B*57:01 circled]({{artifact:37f9a749-4d57-42cf-8558-c7ac0d0e6bf4}})

*Top row: full-catalog divergence histograms per locus with the informative-panel overlay and the reference self-distance (=0) line. Bottom row: per-locus scatter of divergence vs frac_lost, reference allele as a diamond with its retention rank annotated; B\*57:01 circled as a single labelled point (not a test).*

### Artifacts

- `step1_reference_verification.csv` — reference-allele identity by exact sequence match
- `divergence_1_182.csv` — per-allele Hamming divergence to locus reference
- `step3_perlocus_spearman.csv` — ρ, permutation p, MC-SE, profile counts
- `step4_reference_rank.csv` — reference-allele retention rank per locus
- `step5_confounds.csv` — raw/partial/weighted ρ and leave-one-out influence
- `fig_s11_negcontrol.png` — the figure above
- `s11_negcontrol_report.md` — the original frozen step-by-step report
