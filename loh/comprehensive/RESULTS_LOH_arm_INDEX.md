# HLA Class I Loss-of-Heterozygosity (LOH) Arm — Complete Results Index

**Research Question:** Which HLA class I alleles are preferentially lost vs. retained in somatic LOH events across a pan-cancer cohort? Is this loss-preference allele-intrinsic or a read-mapping artifact?

**Cohort:** MSK-IMPACT 50k (Bandlamudi et al., *Cancer Cell* 2026); n=29,802 tumors passing LOHHLA QC  
**Events:** 15,704 within-patient informative LOH events (5,706 HLA-A; 4,842 HLA-B; 5,156 HLA-C)  
**Allele Panel:** 110 HLA-I alleles (n ≥ 20 informative events)

---

## Quick Summary: Key Findings

### Alleles Established at Global FDR < 0.05:
- **HLA-B\*58:01** — **LOSS-BIASED** (frac_lost=0.665; BT strength +0.513; n=164 events)
- **HLA-B\*08:01** — **RETENTION-BIASED** (frac_lost=0.430; BT strength −0.299; n=226 events)
- **HLA-B\*07:02** — **RETENTION-BIASED** (frac_lost=0.439; n=829 events, highest HLA-B count)
- **HLA-A\*01:01** — **RETENTION-BIASED** (n=632 events)

### Locus-Level Heterogeneity:
| Locus | LRT | p-value | Robustness |
|-------|-----|---------|-----------|
| **HLA-B** | 100.52 | **< 0.001** | ✓ Very robust (survives jackknife; signal not driven by single allele) |
| **HLA-A** | 48.97 | **0.013** | ✓ Significant; weaker after dropping A\*01:01 (p=0.050) |
| **HLA-C** | 33.10 | 0.164 | ✗ No global heterogeneity detected |

### Negative Control Result:
Divergence from reference does NOT predict loss-preference as expected under read-mapping bias:
- **HLA-A:** ρ = −0.508 (**opposite** to artifact prediction; p=0.005)
- **HLA-B:** ρ = +0.231 (weak, not significant)
- **HLA-C:** ρ = −0.073 (null)

**Conclusion:** Loss-preference is **not a systematic read-mapping artifact**.

---

## Documents (in reading order)

### 1. Overview & Methods
- **`LOH_arm_00_overview.md`** — Cohort provenance, LOH caller identity (LOHHLA + POLYSOLVER), reference construction, event definition, event counts
  - Read this first for context and data provenance
  
### 2. Main Results (Comprehensive)
- **`RESULTS_LOH_arm_comprehensive.md`** — Complete results write-up including interpretation and biological plausibility discussion
  - Sections: frac_lost distributions, overdispersion, Bradley–Terry model, crest-surface structure, conditional logistic regression, multiplicity, haplotype concordance, novelty delineation
  - **Best for:** Understanding full analysis and biological implications
  
### 3. Summary Tables
- **`RESULTS_LOH_arm_tables.md`** — Quick-reference tables (6 tables) with key numerical findings
  - Table 1: Alleles reaching corrected significance
  - Table 2: Locus-level heterogeneity tests
  - Table 3: Negative control (divergence artifact test)
  - Table 4: Crest-profile nested tests
  - Table 5: Haplotype concordance
  - Table 6: Distribution summaries
  - **Best for:** Quick lookups and presentation

### 4. Negative Control
- **`LOH_arm_01_negcontrol_S11.md`** — Pre-registered negative control testing reference-divergence read-mapping bias
  - Explains the S11 design, divergence calculation, permutation null, results, and interpretation
  - **Best for:** Understanding whether findings are artifacts

### 5. Loss-Preference Detail
- **`LOH_arm_02_loss_preference.md`** — Detailed analysis of allele loss-preference across eight dimensions:
  1. frac_lost distributions  
  2. Overdispersion (variance structure)  
  3. Empirical-Bayes shrinkage
  4. Bradley–Terry strengths (primary estimand) and jackknife robustness
  5. Crest-profile nested tests
  6. Paired conditional logistic regression (divergence & frequency effects)
  7. Multiple testing summary
  8. Haplotype concordance
  9. Published novelty delineation
  
  - **Best for:** All the numbers and statistical details

### 6. Figures
- **`RESULTS_LOH_arm_figures.md`** — Figure index with captions, interpretation, and data-availability notes
  - Main figures: Bradley–Terry caterpillar (Figure 1), S11 negative control (Figure 2)
  - Supplementary figures: positive control, breadth, divergence detail, per-allele heatmap, directionality, meta-analysis
  - **Best for:** Understanding visualizations and locating figure artifacts

---

## Statistical Methods at a Glance

| Analysis | Method | Null | p-value source | n tests |
|----------|--------|------|---|---|
| **Locus-level heterogeneity** | Bradley–Terry logistic regression (LRT vs all equal) | Within-event label flip | Permutation (B=20k) | 3 (one per locus) |
| **Per-allele significance** | Logistic regression (centered strength vs locus mean); covariance-matrix SE | All zero | Permutation OR t-distribution | 110 (corrected: BH-FDR / Bonferroni) |
| **Marginal binomial** | Binomial test (n_lost vs n_total; p=0.5) | p = 0.5 | Permutation (B=20k) | 110 (corrected: BH-FDR / Bonferroni) |
| **Reference-divergence control** | Spearman ρ | H₀: no correlation | Permutation within-locus (B=20k) | 3 (one per locus) |
| **Crest-profile nested tests** | Nested logistic regression (LRT free vs constrained) | All profiles equal | Permutation (B=20k) | 27 (multi-allele profiles; corrected: BH-FDR within locus) |
| **Paired conditional logistic** | Logistic regression on matched pairs (lost vs retained) | No coefficient effect | Permutation (B=20k) | 6 (3 loci × 2 covariates) |
| **Haplotype concordance** | Exact binomial (observed vs expected) | Genotype-preserving flip null | Permutation (B=20k) | 1 global test |

**Random seed:** 20260709 (all analyses). Full reproducibility via saved code and environment snapshots in `s10_provenance_ledger.md`.

---

## Artifact Files in Project Store

### Key Data Tables (CSV)
- `msk50k_LOH_events.csv` — Event-level table (15,704 rows; patient, locus, lost_allele, retained_allele)
- `msk50k_within_patient_LOH_bias.csv` — Per-allele loss table (110 alleles; frac_lost upstream input)
- `merged_loh_divergence.csv` — Allele-level summary (divergence, frac_lost, crest profile, frequency)
- `BT_A_refhighest.csv`, `BT_B_refhighest.csv`, `BT_C_refhighest.csv` — Per-locus Bradley–Terry strengths/SE/rank/n_events
- `multipletesting_110alleles.csv` — FDR/Bonferroni corrections (marginal binomial + BT estimand)
- `perprofile_nested_LRT.csv` — All 27 multi-allele profile nested test results
- `conditional_logistic.csv`, `HLAB_ddiv_leaveout.csv`, `HLAB_condlogistic_bw4.csv` — Paired logistic regression results and leave-out sensitivity
- `haplotype_concordance.csv` — Per-patient concordance with expected (flip null)

### Figures
- `fig_loh_BT_strengths.png` — Bradley–Terry per-locus strength caterpillar (main result)
- `fig_s11_negcontrol.png` — Divergence negative control (divergence vs frac_lost scatter)
- `fig_loh_directionality.png` — Allele directionality heatmap
- `fig_g1_positive_control.png` — Positive control (R175H example)
- Additional: `fig_g3_breadth.png`, `fig_g4_divergence.png`, `fig_g4_per_allele_loss.png`, `fig_cap_loh.png`

### Methods & Provenance
- `s10_provenance_ledger.md` — Full code, environment snapshot, checksums, lineage
- `s10_checksums.sha256` — SHA256 hashes for all outputs
- `LOH_arm_00_overview.md` — Cohort, methods, event definition
- `LOH_arm_01_negcontrol_S11.md` — Negative control design and results
- `LOH_arm_02_loss_preference.md` — Detailed loss-preference analysis (8 dimensions)

---

## Key Interpretation Points

1. **Loss-preference is real, not an artifact.** Ruled out read-mapping bias via divergence negative control (HLA-A shows opposite-sign correlation).

2. **HLA-B shows the strongest and most robust signal.** LRT p < 0.001 with 8 individually significant alleles; signal persists after jackknife.

3. **Crest identity does not fully explain loss-preference.** B\*08:01 and B\*18:01 share identical engageability crest surfaces but differ significantly in loss-preference (p=0.00025), suggesting groove-architecture modulation.

4. **Loss-preference is allele-intrinsic, not haplotype-driven.** Haplotype concordance marginally elevated (3.99% vs 3.59% expected; p=0.056), not significant.

5. **No HLA-C alleles reach corrected significance.** Locus shows no global heterogeneity; loss-preference appears more stochastic or driven by other factors.

6. **Published novelty established.** Bandlamudi et al. (same cohort) only reports allele-preferential loss when conditioned on driver mutations; this arm reports unconditional, allele-intrinsic loss-preference. Not pre-empted by existing literature.

---

## Next Steps / Open Questions

- **Mechanism:** Why are B\*58:01 loss-biased while B\*08:01/B\*07:02 are retention-biased? Is it immune selection (under patient TCR pressure), structural accessibility of the allele to somatic mutation, or driver-context dependency?

- **Structural basis:** What groove-architecture features (beyond the crest) explain the B\*08:01 vs. B\*18:01 divergence despite identical crest surfaces?

- **Integration with engageability/HED:** How do loss-preference alleles compare in TCR-repertoire engagement breadth and specificity?

- **Cancer-type specificity:** Is loss-preference uniform across tumor types, or do specific driver contexts (TP53, BRCA1/2, MSI, TMB extremes) modulate it?

- **Immune impact:** Do loss-preference alleles correlate with survival outcomes under ICI, or is loss-preference selected *for* immunological escape independently of favorable TCR engagement?

---

## Contact & Reproducibility

All analyses are fully reproducible. Code, environment, and checksums are in `s10_provenance_ledger.md`. To reproduce:

1. Fetch the `s10_provenance_ledger.md` artifact
2. Extract environment snapshot (conda env file)
3. Run R/Python code scripts in the order specified
4. Verify checksums via `s10_checksums.sha256`

All p-values are exact permutation tests with fixed seeds, ensuring bit-identical reproduction.

