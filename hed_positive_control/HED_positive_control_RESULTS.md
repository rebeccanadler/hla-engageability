# HED Positive Control — Results

**Arm:** Divergence axis (HLA class I Heterozygosity / Evolutionary Divergence, HED) run
through the cancer-favorability and autoimmune-risk specifications **unchanged**, as a design
positive control for the engageability trade-off analysis.

**Discipline.** HED, both outcome axes, and the engageability scores were reused verbatim
from prior project artifacts — nothing was recomputed. The only new computation is the
allele-frequency re-weighting of the existing pairwise-HED matrix plus the
association / permutation / sensitivity statistics reported below. Numbers are reported
without a pass/fail verdict; the interpretation is the reader's call.

Full machine-readable report: [hed_positive_control_REPORT.md]({{artifact:art_f2256782-672c-4b53-ba19-bca9d741eaa0}}) ·
fixes addendum: [hed_fixes_addendum_REPORT.md]({{artifact:art_80fb577e-055d-43e7-8f0a-0132377cabe4}}).

---

## 1. Pre-commitment and provenance

Before any fit, the favorable direction was pre-registered: **higher HED → favorable ICB →
NEGATIVE supertype-log-HR coefficient** (records: [pre_commitment.md]({{artifact:art_220f7a5b-f36f-4e2b-bfbc-192e3a9ed5a7}}),
[hed_provenance_confirmation.md]({{artifact:art_f0a0b191-7735-4658-8fb3-f67ba12d15aa}})).

- Scope: exon 2–3 (α1/α2, mature residues 1–182), **IMGT/HLA release 3.64.0**.
- **n retained = 676** common class I alleles (A = 218, B = 331, C = 127), reused verbatim
  from `hed_per_allele.csv`.
- **n quarantined = 7,860** (partial 5′ coverage = 7,859; one genuine in-frame deletion,
  C*03:46). Zero full-length alleles quarantined.
- Verification: the row-mean of the saved pairwise-HED matrices reproduces the saved
  `mean_HED` to **max abs diff 0.0** per locus — confirming the projections are built on the
  unmodified saved matrix.

## 2. Two HED projections and their agreement

Two projections were **pre-registered**: (a) unweighted mean HED and (b) frequency-weighted
mean HED. Because the across-population central-tendency statistic was **not** pre-specified,
four were run: `unweighted_182`, `unweighted_181`, `freqweighted_median` (**primary**),
`freqweighted_mean` (labeled sensitivity — see §7 projection lock).

- **(a) unweighted (182):** mean 6.934, SD 1.356, range [3.872, 11.113].
- **(b) freq-weighted (median AFND freq):** mean 7.045, SD 1.385, range [3.996, 11.143].
  Estimand = expected divergence to the other allele a random individual carrying allele *i*
  would carry, Σ_j (f_j / Σ_{k≠i} f_k)·d(i,j), same-locus normalized probability weights.
  Frequency source: **AFND page-1 (100-population) median allele frequency**, scraped for all
  676 alleles.
- **Missing-handling (quarantine-not-drop):** 0 alleles truly missing from AFND; 335 alleles
  have a measured-zero page-1 median (rare) and carry weight 0 as a partner but still receive
  a projection. Every allele retains ≥92 positive-weight partners (min 92, median 114, max 134).
- **Mutual correlation (a vs b): Pearson r = 0.957, Spearman ρ = 0.951** (n = 676).
  The two projections do not disagree materially.

![Distributions of both HED projections and their mutual correlation]({{artifact:art_79bd38da-411f-457b-ab91-8329571cbe0c}})

## 3. Cancer arm — HED vs supertype log-HR (t leads)

Sign convention: log-HR > 0 = unfavorable ICB; **negative β = pre-committed favorable
direction**. Cluster-robust OLS grouped by supertype (small-sample t on G−k df), plus a
12-point inverse-variance-weighted fit; predictors z-scored across 676.

| projection          | spec                      |    beta |    ci_lo |    ci_hi |    p_t |   df_t |   p_norm |
|:--------------------|:--------------------------|--------:|---------:|---------:|-------:|-------:|---------:|
| unweighted_182      | clustered raw (overall)   | -0.1501 |  -0.2807 |  -0.0195 | 0.0283 |     10 |   0.0104 |
| unweighted_182      | clustered +freq (overall) | -0.164  |  -0.2996 |  -0.0283 | 0.0231 |      9 |   0.0063 |
| unweighted_182      | clustered raw (locus A)   | -0.2772 |  -0.3599 |  -0.1946 | 0.0007 |      4 |   0      |
| unweighted_182      | clustered raw (locus B)   | -0.1134 |  -0.3    |   0.0732 | 0.1669 |      4 |   0.0917 |
| unweighted_182      | IVW raw                   | -0.2775 | nan      | nan      | 0.069  |     10 |   0.069  |
| unweighted_182      | IVW +freq                 | -0.3071 | nan      | nan      | 0.0521 |      9 |   0.0521 |
| unweighted_181      | IVW raw                   | -0.2933 | nan      | nan      | 0.069  |     10 |   0.069  |
| unweighted_181      | clustered raw (locus B)   | -0.1198 |  -0.317  |   0.0774 | 0.1669 |      4 |   0.0917 |
| unweighted_181      | IVW +freq                 | -0.3245 | nan      | nan      | 0.0521 |      9 |   0.0521 |
| unweighted_181      | clustered +freq (overall) | -0.1732 |  -0.3166 |  -0.0299 | 0.0231 |      9 |   0.0063 |
| unweighted_181      | clustered raw (overall)   | -0.1586 |  -0.2966 |  -0.0206 | 0.0283 |     10 |   0.0104 |
| unweighted_181      | clustered raw (locus A)   | -0.293  |  -0.3803 |  -0.2057 | 0.0007 |      4 |   0      |
| freqweighted_median | clustered raw (overall)   | -0.144  |  -0.2817 |  -0.0063 | 0.042  |     10 |   0.0198 |
| freqweighted_median | clustered +freq (overall) | -0.1831 |  -0.3386 |  -0.0275 | 0.026  |      9 |   0.0078 |
| freqweighted_median | clustered raw (locus A)   | -0.2532 |  -0.3436 |  -0.1628 | 0.0015 |      4 |   0      |
| freqweighted_median | clustered raw (locus B)   | -0.1278 |  -0.3697 |   0.1141 | 0.2163 |      4 |   0.1424 |
| freqweighted_median | IVW raw                   | -0.2609 | nan      | nan      | 0.0807 |     10 |   0.0807 |
| freqweighted_median | IVW +freq                 | -0.3381 | nan      | nan      | 0.0329 |      9 |   0.0329 |
| freqweighted_mean   | IVW raw                   | -0.3125 | nan      | nan      | 0.042  |     10 |   0.042  |
| freqweighted_mean   | clustered raw (overall)   | -0.1627 |  -0.3104 |  -0.0151 | 0.0339 |     10 |   0.0141 |
| freqweighted_mean   | clustered +freq (overall) | -0.1822 |  -0.3371 |  -0.0274 | 0.026  |      9 |   0.0078 |
| freqweighted_mean   | clustered raw (locus A)   | -0.2777 |  -0.36   |  -0.1954 | 0.0007 |      4 |   0      |
| freqweighted_mean   | clustered raw (locus B)   | -0.1336 |  -0.369  |   0.1018 | 0.1902 |      4 |   0.1151 |
| freqweighted_mean   | IVW +freq                 | -0.3558 | nan      | nan      | 0.025  |      9 |   0.025  |

Both primary projections recover a **negative clustered β, significant on the small-sample
t** (unweighted-182 β = -0.150, p_t(10) = 0.028; freq-weighted-median
β = -0.144, p_t(10) = 0.042). The effect is strongest at locus A
(β ≈ −0.25 to −0.28, p_t(4) ≤ 0.002); locus B is negative but not significant; locus C
carries no favorability (A/B-only ICB data) and does not enter. The 12-point IVW β ≈ −0.26
to −0.31 (p_t 0.042–0.081; the freqweighted_mean IVW p = 0.042 is discussed in §7).

![Cancer arm — HED vs supertype log-HR, both projections]({{artifact:art_0b793686-884b-4856-84f7-b84b5f493b6b}})

## 4. Autoimmune arm — descriptive, not a control

Explicitly **descriptive**. There is no established allele-level HED-to-autoimmunity effect to
recover, so this null calibrates nothing — it is reported, not interpreted as a failed control.
Spearman of HED vs the signed autoimmune risk rank (16 paired A/B anchors):

| projection          | spec                   |     rho |      p |   n |
|:--------------------|:-----------------------|--------:|-------:|----:|
| unweighted_182      | Spearman raw           | -0.0172 | 0.9497 |  16 |
| unweighted_182      | partial-Spearman +freq | -0.0291 | 0.9181 |  16 |
| unweighted_181      | Spearman raw           | -0.0172 | 0.9497 |  16 |
| unweighted_181      | partial-Spearman +freq | -0.0291 | 0.9181 |  16 |
| freqweighted_median | Spearman raw           | -0.0734 | 0.7871 |  16 |
| freqweighted_median | partial-Spearman +freq | -0.0926 | 0.7429 |  16 |
| freqweighted_mean   | Spearman raw           | -0.0078 | 0.9771 |  16 |
| freqweighted_mean   | partial-Spearman +freq | -0.0096 | 0.973  |  16 |

## 5. Published HED effect (fetched from primary sources; verification column)

Verified against the primary full texts fetched this session (Chowell 2019 *Nat Med*,
PMC7938381; Chowell 2018 *Science*). Full verification strings in
[hed_published_effect_verified.csv]({{artifact:art_ee7697c5-46ef-4bba-a4a2-07386fadd8be}}).

| estimand                                               | value                      | ci        |        p | unit                                                     | cohort                                                            | n                              |
|:-------------------------------------------------------|:---------------------------|:----------|---------:|:---------------------------------------------------------|:------------------------------------------------------------------|:-------------------------------|
| HED–ICB survival (primary headline)                    | 0.47                       | 0.26–0.82 |   0.0072 | hazard ratio (Cox / log-rank), dichotomized top-quartile | Cohort 1 = Van Allen et al. 2015 metastatic melanoma, anti-CTLA-4 | 100 patients                   |
| HED–ICB survival, fully heterozygous subset (cohort 1) | 0.43                       | 0.22–0.83 |   0.0094 | hazard ratio, top-quartile dichotomized                  | 78 fully heterozygous patients from cohort 1 (Van Allen 2015)     | 78 patients                    |
| HED–ICB survival, heterozygous NSCLC                   | 0.32                       | 0.10–1.06 |   0.049  | hazard ratio, top-quartile dichotomized                  | Second cohort: NSCLC, anti-PD-1                                   | 76 fully heterozygous patients |
| HED–ICB survival, heterozygous melanoma                | UNVERIFIED (no HR in text) | nan       |   0.025  | two-sided log-rank test                                  | Third cohort: metastatic melanoma, anti-PD-1/PD-L1                | 95 fully heterozygous patients |
| Overall design direction (cutpoint analysis)           | NEGATIVE                   | nan       | nan      | qualitative (Extended Data Fig 3)                        | combined analysis of all three cohorts                            | nan                            |

Pre-committed direction confirmed by source: higher HED → HR < 1 → favorable ICB.

## 6. Resolution — permutation nulls and minimum detectable effect

Permutation nulls (10,000×) with the predictor permuted and the outcome fixed, and the
minimum detectable effect (MDE) at 80% power, α = 0.05, for three specifications:

| projection          | spec                                                       | stat   |     obs |   null_p95_abs |   mde_80pwr |   n |
|:--------------------|:-----------------------------------------------------------|:-------|--------:|---------------:|------------:|----:|
| unweighted_182      | (a) 15 paired A/B anchors — Spearman(HED,risk_rank)        | rho    | -0.0269 |         0.5225 |      0.6689 |  15 |
| unweighted_182      | (b) 8 supertype points — Spearman(HED,logHR)               | rho    | -0.4286 |         0.7143 |      0.8491 |   8 |
| unweighted_182      | (c) cancer clustered/IVW — beta (cluster-level IVW perm)   | beta   | -0.2775 |         0.2636 |      0.5036 |  12 |
| unweighted_182      | (c') cancer row-level perm [contrast, artificially narrow] | beta   | -0.1501 |         0.0411 |    nan      | 400 |
| freqweighted_median | (a) 15 paired A/B anchors — Spearman(HED,risk_rank)        | rho    | -0.0538 |         0.5186 |      0.6689 |  15 |
| freqweighted_median | (b) 8 supertype points — Spearman(HED,logHR)               | rho    | -0.3333 |         0.7143 |      0.8491 |   8 |
| freqweighted_median | (c) cancer clustered/IVW — beta (cluster-level IVW perm)   | beta   | -0.2609 |         0.2851 |      0.4897 |  12 |
| freqweighted_median | (c') cancer row-level perm [contrast, artificially narrow] | beta   | -0.144  |         0.0418 |    nan      | 400 |

Plain-language resolution:

- **Paired anchors (a):** the 15-anchor Spearman arm can only detect |ρ| ≥ 0.67; observed ρ ≈ 0.
- **Supertype points (b):** the 8-point Spearman arm can only detect |ρ| ≥ 0.85; observed ρ ≈ −0.33 to −0.43.
- **Cancer IVW (c):** the 12-point design can only detect |β| ≥ ~0.49–0.50 log-HR per SD; the
  observed IVW β (≈ −0.26 to −0.28) sits near the null's 95th percentile.
- **Against the published effect:** the published HED–ICB effect (HR = 0.47, P = 0.0072) was
  estimated with 100–1500 patients; this allele-level design has 8–12 effective points and
  could have detected only a large allele-level effect.

![Permutation nulls (10,000×) for the three specifications]({{artifact:art_02cde95a-e337-4d35-8322-f98b4a1f8083}})

## 7. Projection lock (deviation disclosure)

`freqweighted_median` is the primary frequency projection; `freqweighted_mean` is the
**unregistered** central-tendency variant, reported in full and never featured. It is the
**only** one of the four projections with a 12-point IVW p < 0.05 (**IVW raw p = 0.042**; the
other three: 0.069, 0.069, 0.081). On the clustered specification (the significant one) all
four projections agree in sign and small-sample-t significance; the mean-vs-median divergence
is confined to the IVW p. This deviation is disclosed, not repaired into looking
pre-registered and not deleted.

## 8. Clustered-specification permutation null and MDE

The significant result is in the **clustered** fit, whose 400 rows collapse to 12 distinct
supertype points with the outcome constant within supertype. The correct null permutes the
**supertype→outcome assignment** (not rows — row permutation manufactures independence the
design lacks); 10,000×, with the same permuted assignment driving both predictors so they
share one common reference.

| predictor                            |   obs_beta |   perm_p |   null_abs95 |   null_sd |   mde_80pwr |   df |   parametric_t_p |
|:-------------------------------------|-----------:|---------:|-------------:|----------:|------------:|-----:|-----------------:|
| HED freqweighted_median (PRIMARY, z) |    -0.144  |   0.0875 |       0.1628 |    0.0836 |       0.26  |   10 |           0.042  |
| engageability_A (z)                  |     0.0643 |   0.2861 |       0.1122 |    0.0584 |       0.181 |   10 |           0.1325 |

**Plain sentence.** On the clustered specification the smallest true effect this design could
detect at 80% power (α = 0.05) is **|β| ≈ 0.26 log-HR per SD of HED**. HED's observed clustered
β of −0.144 has a design-respecting **permutation p = 0.088**, and engageability's observed β
of +0.064 has **permutation p = 0.286**, against one common supertype-permutation null. The
permutation p (0.088) is larger than the parametric cluster-robust small-sample t p (0.042),
because the permutation respects that the outcome is constant within supertype.

## 9. Leave-one-supertype-out for HED (primary projection)

Refit dropping each supertype in turn, clustered and IVW:

| dropped          |   cl_beta |   cl_ci_lo |   cl_ci_hi |   cl_p_t |   ivw_beta |   ivw_p |
|:-----------------|----------:|-----------:|-----------:|---------:|-----------:|--------:|
| A01              |   -0.1444 |    -0.2919 |     0.0031 |   0.054  |    -0.2585 |  0.0958 |
| A01A03           |   -0.1449 |    -0.2863 |    -0.0036 |   0.0455 |    -0.261  |  0.1006 |
| A01A24           |   -0.1475 |    -0.2887 |    -0.0063 |   0.0424 |    -0.2756 |  0.0821 |
| A02              |   -0.1609 |    -0.3087 |    -0.0131 |   0.036  |    -0.3041 |  0.0842 |
| A03              |   -0.1296 |    -0.2817 |     0.0224 |   0.0859 |    -0.2457 |  0.1724 |
| A24              |   -0.1071 |    -0.2394 |     0.0252 |   0.1002 |    -0.2168 |  0.2065 |
| B07              |   -0.1825 |    -0.3342 |    -0.0307 |   0.0236 |    -0.2611 |  0.0825 |
| B08              |   -0.1413 |    -0.2857 |     0.0031 |   0.0542 |    -0.2617 |  0.1113 |
| B27              |   -0.1746 |    -0.3451 |    -0.0042 |   0.0457 |    -0.2703 |  0.0881 |
| B44              |   -0.1173 |    -0.2573 |     0.0228 |   0.0907 |    -0.2321 |  0.0769 |
| B58              |   -0.151  |    -0.3126 |     0.0106 |   0.0637 |    -0.3154 |  0.0679 |
| B62              |   -0.1259 |    -0.2608 |     0.0089 |   0.0638 |    -0.2305 |  0.0566 |
| (none: full fit) |   -0.144  |    -0.2817 |    -0.0063 |   0.042  |    -0.2609 |  0.0807 |

- **Clustered β range [−0.182, −0.107]** (full fit −0.144); **0/12 sign flips**.
- **IVW β range [−0.315, −0.217]** (full fit −0.261); **0/12 sign flips**.
- Engageability's comparable clustered LOSO range on record: **[0.062, 0.128]**, also 0/12
  sign flips (opposite, positive sign).

Per-supertype IVW weight share and clustered leverage (no supertype exceeds ~12% of IVW weight):

| supertype   |   n_member_alleles |   logHR |   SE_logHR |      zX |   ivw_weight_share |   cl_leverage_abs_dbeta |
|:------------|-------------------:|--------:|-----------:|--------:|-------------------:|------------------------:|
| A03         |                 47 |  0.3293 |     0.191  | -0.6321 |             0.1177 |                  0.0144 |
| A01         |                 35 | -0.1393 |     0.1913 |  0.4182 |             0.1174 |                  0.0004 |
| B44         |                 49 | -0.4943 |     0.1916 |  0.5846 |             0.117  |                  0.0267 |
| B07         |                 83 |  0.3001 |     0.1942 |  0.3654 |             0.1138 |                  0.0385 |
| A02         |                 39 |  0.1222 |     0.1946 | -0.5374 |             0.1133 |                  0.0169 |
| B27         |                 57 |  0.0862 |     0.2049 |  0.6558 |             0.1023 |                  0.0306 |
| A24         |                 24 | -0.4005 |     0.217  |  1.431  |             0.0912 |                  0.0369 |
| B08         |                  7 | -0.1625 |     0.2508 |  1.1229 |             0.0683 |                  0.0027 |
| B62         |                 38 |  0.8286 |     0.2507 |  0.091  |             0.0683 |                  0.0181 |
| B58         |                 10 | -0.0202 |     0.3328 |  1.8826 |             0.0388 |                  0.007  |
| A01A24      |                  5 | -0.1165 |     0.3695 | -0.302  |             0.0315 |                  0.0035 |
| A01A03      |                  6 |  0.1823 |     0.4571 | -0.2436 |             0.0206 |                  0.0009 |

**Locus-A-excluded fit** (B + C fav-bearing; 244 alleles, 6 supertypes):

| fit       |    beta |    ci_lo |    ci_hi |    p_t |   n_alleles |   n_supertypes |
|:----------|--------:|---------:|---------:|-------:|------------:|---------------:|
| clustered | -0.1278 |  -0.3697 |   0.1141 | 0.2163 |         244 |              6 |
| IVW       | -0.4171 | nan      | nan      | 0.3588 |         244 |              6 |

Sign stays negative in both; the clustered result loses significance when locus A — which
carries the strongest per-locus signal — is removed.

![Clustered permutation null and HED leave-one-supertype-out]({{artifact:art_bf8ce349-fba7-47dd-abd2-d32a5022fb18}})

## 10. Side-by-side — HED vs engageability

Both metrics through the **identical** cancer and autoimmune specifications, z-scored
predictors (common β scale; p invariant to scaling — engageability_A cancer p_t = 0.132
reproduces the standing reference exactly).

| axis                |   cancer_clustered_beta | cancer_clustered_ci   |   cancer_p_t |   cancer_p_norm |   cancer_clustered_beta_freq |   cancer_p_t_freq |   cancer_IVW_beta |   cancer_IVW_p |   autoimmune_rho |   autoimmune_p |   autoimmune_rho_freq |   autoimmune_p_freq |
|:--------------------|------------------------:|:----------------------|-------------:|----------------:|-----------------------------:|------------------:|------------------:|---------------:|-----------------:|---------------:|----------------------:|--------------------:|
| unweighted_182      |                  -0.15  | [-0.28,-0.02]         |        0.028 |           0.01  |                       -0.164 |             0.023 |            -0.278 |          0.069 |           -0.017 |          0.95  |                -0.029 |               0.918 |
| unweighted_181      |                  -0.159 | [-0.30,-0.02]         |        0.028 |           0.01  |                       -0.173 |             0.023 |            -0.293 |          0.069 |           -0.017 |          0.95  |                -0.029 |               0.918 |
| freqweighted_median |                  -0.144 | [-0.28,-0.01]         |        0.042 |           0.02  |                       -0.183 |             0.026 |            -0.261 |          0.081 |           -0.073 |          0.787 |                -0.093 |               0.743 |
| freqweighted_mean   |                  -0.163 | [-0.31,-0.02]         |        0.034 |           0.014 |                       -0.182 |             0.026 |            -0.312 |          0.042 |           -0.008 |          0.977 |                -0.01  |               0.973 |
| engageability_A     |                   0.064 | [-0.02,0.15]          |        0.132 |           0.101 |                        0.061 |             0.081 |             0.172 |          0.26  |            0.187 |          0.488 |                 0.121 |               0.668 |
| engageability_z_het |                   0.079 | [-0.07,0.23]          |        0.262 |           0.235 |                        0.063 |             0.203 |             0.189 |          0.239 |            0.073 |          0.789 |                 0.016 |               0.954 |

The four HED projections give **negative, CI-excludes-0** cancer betas (clustered p_t
0.028–0.042); the two engageability axes give **positive, non-significant** betas (p_t 0.13,
0.26). Calibrated against one common clustered permutation null (§8), HED sits at p = 0.088
and engageability at p = 0.286.

![Side-by-side cancer-arm signal, HED vs engageability]({{artifact:art_19148441-3322-4321-9e09-aa23e95b99f1}})

## 11. Circularity audit

The supertype-favorability axis (Chowell 2018 *Science*; B44/B62 supertype HRs from two
melanoma cohorts built on Van Allen 2015 / Snyder 2014 / Rizvi 2015) and the published
HED–ICB effect (Chowell 2019 *Nat Med*; cohort 1 = Van Allen 2015, n = 100) are estimated on
**overlapping patient cohorts** from the same group. Because the cohorts overlap, recovering a
HED–supertype-log-HR association here is a **design-capability check, not an independent
replication** of the HED–ICB effect; the recovered negative cancer-arm coefficient is not
presented as validation of HED. Full detail: [circularity_audit.md]({{artifact:art_68bf3612-5392-4054-8d36-4683cbfe56db}}).

---

### Source artifacts

| Result | File |
|---|---|
| Consolidated numeric report | [hed_positive_control_REPORT.md]({{artifact:art_f2256782-672c-4b53-ba19-bca9d741eaa0}}) |
| Fixes addendum (projection lock, clustered perm, LOSO) | [hed_fixes_addendum_REPORT.md]({{artifact:art_80fb577e-055d-43e7-8f0a-0132377cabe4}}) |
| Pre-commitment / provenance | [pre_commitment.md]({{artifact:art_220f7a5b-f36f-4e2b-bfbc-192e3a9ed5a7}}) · [hed_provenance_confirmation.md]({{artifact:art_f0a0b191-7735-4658-8fb3-f67ba12d15aa}}) |
| HED projections (676 alleles) | [hed_projections.csv]({{artifact:art_0f3c4058-fa13-467a-9d51-71d607723981}}) |
| Cancer arm | [hed_cancer_arm_summary.csv]({{artifact:art_05cef5b0-6a00-4910-a15d-21903860c8e0}}) |
| Autoimmune arm | [hed_autoimmune_arm_summary.csv]({{artifact:art_138e3e67-a04e-47bc-a24f-7e0535c50af8}}) |
| Verified published effect | [hed_published_effect_verified.csv]({{artifact:art_ee7697c5-46ef-4bba-a4a2-07386fadd8be}}) |
| Permutation / MDE (3 specs) | [hed_mde_summary.csv]({{artifact:art_fb6afd99-405e-4444-bafd-84e4cc8baf76}}) |
| Clustered permutation + MDE | [hed_clustered_permutation_summary.csv]({{artifact:art_9edb92af-42b7-4130-b8ad-097ee3111c2b}}) |
| Leave-one-supertype-out | [hed_leave_one_supertype_out.csv]({{artifact:art_38c53875-4dbc-4bf4-b533-b62eaa5891fc}}) |
| Per-supertype leverage | [hed_supertype_leverage.csv]({{artifact:art_7cfce445-0000-4f43-9dcb-caba2b78a72d}}) |
| Locus-A-excluded fit | [hed_locusA_excluded_fit.csv]({{artifact:art_2e2cebdc-8306-41a7-a24d-a245b9890159}}) |
| Side-by-side HED vs engageability | [hed_vs_engageability_sidebyside.csv]({{artifact:art_97c8d1d5-d46a-4400-a16b-04218dc6bdef}}) |
| Circularity audit | [circularity_audit.md]({{artifact:art_68bf3612-5392-4054-8d36-4683cbfe56db}}) |

*Reproducibility: IMGT/HLA 3.64.0; CWD 2.0.0 common set; Grantham 1974 matrix; AFND page-1
100-population median frequencies. Environment: python (pandas, numpy, scipy, statsmodels,
matplotlib). Inputs reused verbatim from prior project artifacts.*
