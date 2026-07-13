# Allele loss-preference at HLA-A/B/C

Descriptive characterization of which class I alleles are preferentially lost vs retained in the MSK-IMPACT 50k HLA-LOH events. All p-values from exact within-event label-flip nulls (B = 20,000, seed 20260709) unless noted. Numbers only; no verdict.

## 1. frac_lost distribution (per locus)

| locus | n alleles | min | median | max | SD | IQR |
|---|---|---|---|---|---|---|
| A | 30 | 0.4189 | 0.5030 | 0.7097 | 0.0569 | 0.0521 |
| B | 53 | 0.3947 | 0.5000 | 0.6875 | 0.0636 | 0.0770 |
| C | 27 | 0.4467 | 0.5205 | 0.7083 | 0.0585 | 0.0563 |

## 2. Overdispersion (between-allele variance vs binomial expectation)

Observed statistic = mean squared deviation of frac_lost from 0.5; expected binomial = `sum(0.25/n_i)/k`. Parametric bootstrap under H₀: pᵢ = 0.5 ∀i.

| locus | k | obs var (MSD) | exp binom var | ratio | quasi-binom φ (H₀ p=0.5) | bootstrap p (MC-SE) |
|---|---|---|---|---|---|---|
| A | 30 | 0.00330 | 0.00259 | 1.275 | 1.683 | 0.1998 (0.0028) |
| B | 53 | 0.00406 | 0.00380 | 1.068 | 2.097 | 0.3652 (0.0034) |
| C | 27 | 0.00398 | 0.00240 | 1.657 | 1.224 | 0.0794 (0.0019) |

The variance-ratio and φ diverge for B because they weight alleles differently (ratio = unweighted mean of squared deviations; φ = event-count-weighted Pearson dispersion). Both reported as computed. **Note:** these MSD/φ statistics are **superseded** by the Bradley–Terry LRT below (§4), which is the primary estimand for allele heterogeneity; they are retained for reconciliation.

## 3. Empirical-Bayes shrinkage (per-locus beta-binomial prior)

Ten alleles with the largest raw |deviation from 0.5|, raw → shrunken frac_lost:

| locus | allele | n_events | frac_lost raw | frac_lost EB |
|---|---|---|---|---|
| A | A\*36:01 | 31 | 0.7097 | 0.5172 |
| C | C\*04:03 | 24 | 0.7083 | 0.5013 |
| B | B\*46:01 | 48 | 0.6875 | 0.5477 |
| C | C\*16:04 | 28 | 0.6786 | 0.5013 |
| B | B\*67:01 | 21 | 0.6667 | 0.5248 |
| B | B\*58:01 | 164 | 0.6646 | 0.5858 |
| B | B\*81:01 | 21 | 0.6190 | 0.5194 |
| A | A\*66:01 | 78 | 0.6154 | 0.5200 |
| B | B\*15:10 | 38 | 0.3947 | 0.4855 |
| B | B\*15:18 | 37 | 0.5946 | 0.5229 |

Small-n outliers collapse toward the locus mean; B\*58:01 (n=164) retains the largest shrunken deviation.

## 4. Bradley–Terry loss-preference (primary estimand)

Allele "strengths" fit by minorization–maximization (validated against `statsmodels` logistic BT to 1e-11); a lost allele "wins" the within-patient contest. LRT vs the null of all-equal strengths, p from the within-event flip null.

| locus | n alleles | n events | LRT | df | flip-null p (MC-SE) | distinct crest profiles |
|---|---|---|---|---|---|---|
| A | 30 | 5,578 | 48.97 | 29 | 0.0130 (0.0008) | 22 |
| B | 53 | 4,629 | 100.52 | 52 | **0.0002 (0.0001)** | 19 |
| C | 27 | 5,106 | 33.10 | 26 | 0.1644 (0.0026) | 10 |

**Reconciliation on the flip null** (both statistics on the same B=20,000 null): event-weighted Pearson φ (H₀ p=0.5) flip-p = A 0.0112, B 0.00005, C 0.2198 — same ordering as the BT LRT (primary).

**Highest-influence allele (largest |ΔLRT| on removal), refit without it:**

| locus | dropped | ΔLRT | LRT without | df | flip-p without | profiles remaining |
|---|---|---|---|---|---|---|
| A | A\*01:01 | +7.47 | 41.50 | 28 | 0.0501 | 21 |
| B | B\*07:02 | +16.78 | 83.74 | 51 | 0.0030 | 19 |
| C | C\*02:02 | +5.85 | 27.25 | 25 | 0.3474 | 10 |

HLA-B remains significant after dropping its most influential allele; the locus-level signal is not carried by any single allele.

### Per-allele strengths and distinguishability (ref = highest-event allele)

SEs re-parameterized against the highest-event allele per locus (A\*02:01 n=2103, B\*07:02 n=829, C\*04:01 n=1488); centered log-strength tested vs the locus mean via the covariance matrix. Alleles distinguishable from the locus mean at uncorrected p<0.05: **A = 3** (A\*36:01, A\*02:01, A\*01:01), **B = 8** (B\*46:01, B\*58:01, B\*49:01, B\*51:01, B\*14:02, B\*07:02, B\*08:01, B\*35:02), **C = 5** (all retained-side: C\*07:02, C\*07:01, C\*12:03, C\*05:01, C\*15:02).

![Bradley–Terry allele loss-preference per locus; red = survives global BH-FDR<0.05]({{artifact:be09f301-a039-4093-ab2c-65e7f66fbfdc}})

*Caterpillar of centered BT log-strength (± 1.96·SE) per allele, sorted; positive = loss-biased. Red points survive global BH-FDR<0.05 on the primary BT estimand.*

## 5. Crest-profile structure (does loss-preference respect the engageability crest surface?)

Pre-committed branches (frozen): *free ≯ constrained* → loss preference is crest-consistent; *free > constrained* → loss preference varies within identical crest surfaces (a crest-derived predictor cannot account for it). Both reportable, neither preferred.

**Global nested BT** (strengths free vs constrained equal within crest profile; df = n_alleles − n_profiles; flip null):

| locus | LL free | LL constrained | LRT | df | flip-null p |
|---|---|---|---|---|---|
| A | −3841.889 | −3843.550 | 3.32 | 8 | 0.9139 |
| B | −3158.317 | −3182.104 | 47.58 | 34 | 0.0721 |
| C | −3522.659 | −3532.972 | 20.63 | 17 | 0.2527 |

**Per-profile nested LRT** (each multi-allele profile constrained equal in the full-locus fit; BH-FDR within locus across all 27 multi-allele profiles: A=4, B=14, C=9). Only one profile survives FDR<0.05:

| locus | profile | members | LRT | df | flip-p | BH-FDR (within locus) |
|---|---|---|---|---|---|---|
| B | **RNQITNTERVATEW** | B\*08:01, B\*18:01 | 12.32 | 1 | 0.00025 | **0.0035** |
| B | GERNASTERVALEW | B\*57:01, B\*57:03, B\*58:01, B\*58:02 | 8.60 | 3 | 0.0398 | 0.279 |
| C | REQKRQAVREATEW | 6 members | 8.65 | 5 | 0.128 | 0.480 |

No HLA-A or HLA-C profile reaches raw flip-p < 0.05. The single significant profile (RNQITNTERVATEW) contains **B\*08:01 (strongly retention-biased) and B\*18:01 (near-mean)** — two alleles with an identical 14-position crest surface but a divergent groove (7 pocket-residue, 18 mature-residue differences), which was pre-registered as an identical-crest/divergent-groove pair in an earlier engageability artifact (`crest_merge_verification.csv`, `report_engageability_tcr_diversity.md`, both predating this arm's event table and BT fits).

**Minimum detectable effect (global nested test).** Simulating a within-profile log-strength split injected into every multi-allele profile: δ at 80% power = **A ≈ 0.425, B ≈ 0.278, C ≈ 0.265**. The single observed B\*58:01 − B\*57:01 difference = 0.513 exceeds each locus MDE, but that MDE is for a split present in *all* profiles simultaneously; a single-profile split of that size sits below the global test's detectable regime — which is why the global nested-B test (LRT 47.6, flip-p 0.072) does not reach significance while the focused single-profile GERNASTERVALEW test (flip-p 0.040) does.

**Focused GERNASTERVALEW test** (4 members constrained equal, full-locus fit): LRT 8.60, df 3, flip-p 0.0398; contrast **B\*58:01 − B\*57:01 = 0.513, SE 0.205** (covariance matrix), Wald p 0.012. This supersedes the earlier 5-event within-profile test (which used only contests internal to the profile and was unpowered).

## 6. Paired conditional logistic (supersedes S11 marginal Spearman)

1:1 matched pairs (lost − retained homolog): P(homolog lost) ~ ΔHamming-to-reference + Δlog10 AFND frequency. Coefficients with within-event flip-null p (both-covariate model):

| locus | ΔDivergence β (SE) | flip-p | ΔLog10Freq β (SE) | flip-p |
|---|---|---|---|---|
| A | −0.0057 (0.0028) | 0.0428 | −0.0821 (0.0265) | 0.0021 |
| B | +0.0130 (0.0023) | **0.00005** | −0.0153 (0.0284) | 0.589 |
| C | +0.0024 (0.0034) | 0.477 | −0.0423 (0.0193) | 0.0274 |

Divergence sign differs by locus (A negative, B positive, C null); frequency is negative throughout (rarer homolog lost) but significant only at A and C. Within-pair collinearity is negligible (corr(ΔDiv, ΔLogFreq): A −0.028, B −0.159, C −0.043; VIF ≤ 1.03) — the A/B sign difference is not a collinearity artifact.

**Leave-out on the HLA-B divergence coefficient:** full +0.0130 (flip-p 5e-5); drop pairs w/ B\*07:02 +0.0132 (2e-4); drop pairs w/ B\*58:01 +0.0118 (5e-5); drop both +0.0103 (0.0040). The positive HLA-B divergence effect survives removal of either or both alleles.

**Adding within-pair Bw4/Bw6 (HLA-B, residue 83: Arg83 = Bw4, Gly83 = Bw6):** ΔDivergence +0.0102 (flip-p 0.0014) retains significance; ΔLog10Freq −0.0182 (0.528); ΔBw4 +0.0691 (0.226) not distinguishable from zero. ΔDiv–ΔBw4 correlate at +0.698 (VIF 2.0), so divergence attenuates modestly (+0.0130 → +0.0102) but remains the dominant term.

## 7. Multiplicity — which alleles are individually established

Two estimands, both corrected:

- **Marginal exact binomial** (n_lost vs n_total, p=0.5) across 110 alleles: global BH-FDR<0.05 and within-locus Bonferroni<0.05 both give the **same 3 alleles** — B\*58:01 (loss-biased; frac_lost 0.665, p 2.99e-5), B\*08:01 (retention; 0.430, p 1.56e-4), B\*07:02 (retention; 0.439, p 4.43e-4). All HLA-B.
- **Primary BT estimand** (centered log-strength vs locus mean, covariance-matrix SE, n=110 panel alleles): global BH-FDR<0.05 gives **4 alleles** — adds **A\*01:01** (retention; −0.203, FDR 0.043) to the three above. Within-locus Bonferroni<0.05 gives 3 — B\*58:01, B\*08:01, A\*01:01 (B\*07:02 drops).

No HLA-C allele survives either correction under either estimand.

## 8. Haplotype concordance (descriptive)

Patients with informative events at ≥2 loci: **5,043** (≥3 loci: 3,107). Lost-allele concordance with a common haplotype (all informative loci matching one haplotype's alleles; 8.1 = A\*01:01/B\*08:01/C\*07:01, 7.1 = A\*03:01/B\*07:02/C\*07:02): **observed 201/5,043 = 0.0399** (8.1: 113; 7.1: 88).

- Expected under **independent per-locus loss** (product of marginals): 0.0081.
- Expected under the **within-patient flip null** (genotype-preserving): **0.0359** (181.2 patients, SD 12.0); **flip-null p = 0.0558**. The genotype-preserving null is far higher than the product-of-marginals because it conditions on each patient's actual two germline alleles; against it the observed concordance is only marginally elevated.

## 9. Published-novelty delineation (fetched)

- **Bandlamudi et al. 2026** (full text, PMC): reports allele-preferential loss **only conditioned on neoantigen/driver context**, not as a germline-allele-intrinsic property. E.g. loss of the A\*02:01 restricting allele "enriched in tumors with TP53 R175H mutation but not in tumors that were TP53 wild-type," and "cancer type-specific." Baseline (their Fig 6E): "the rates of LOH at the loci of the restricting alleles were indistinguishable from those in tumors wild-type for the evaluated mutations."
- **Montesion et al. 2021** (abstract, the retrievable primary source): pan-cancer HLA-I LOH landscape at **locus level** — 17% prevalence, nonlinear "Goldilocks" relationship with TMB, negative OS predictor under ICI in NSCLC. No allele-specific or germline-allele-preferential loss claim.

**Left unclaimed by both:** a germline-**allele-intrinsic, context-free** ranking of which class I alleles are preferentially lost vs retained across a pan-cancer cohort (independent of a specified restricting neoantigen/driver). Bandlamudi conditions on driver context; Montesion is locus-level. On the evidence fetched, this arm's allele-level loss-preference ordering is **not pre-empted** by a published identical finding.

---

### Artifacts (tables)

- `frac_lost_distribution_perlocus.csv` · `overdispersion_perlocus.csv` · `frac_lost_EB_shrinkage.csv`
- `BT_A_refhighest.csv` · `BT_B_refhighest.csv` · `BT_C_refhighest.csv` — per-allele BT strengths/SE/rank/n_events
- `BT_HLAB_with_B5801.csv` · `BT_HLAB_without_B5801.csv` — HLA-B fits with/without B\*58:01
- `BT_strength_multiplicity.csv` — BT-estimand FDR/Bonferroni
- `multipletesting_110alleles.csv` — marginal-binomial FDR/Bonferroni
- `perprofile_nested_LRT.csv` — all 27 multi-allele profile nested LRTs
- `conditional_logistic.csv` · `HLAB_ddiv_leaveout.csv` · `HLAB_condlogistic_bw4.csv`
- `haplotype_concordance.csv` — per-patient concordance and flip-null expectation

### Figures

- `fig_loh_BT_strengths.png` — per-locus BT strength caterpillar (§4)
- `fig_s11_negcontrol.png` — negative-control figure (see `LOH_arm_01_negcontrol_S11.md`)
