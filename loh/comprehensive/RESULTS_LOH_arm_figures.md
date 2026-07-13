# HLA Class I LOH Arm — Figures Index

## Main Results Figures

### Figure 1: Bradley–Terry Allele Loss-Preference Ranking

![Bradley–Terry per-locus strength estimates]({{artifact:art_84d15ca1-5c4f-4d57-bba6-649ebfd772ad}})

**Caption:** Centered log-strength estimates (± 1.96 SE) for each allele per locus, sorted by strength. Positive values = loss-biased; negative = retention-biased. Red points indicate alleles surviving global BH-FDR < 0.05. HLA-B shows the strongest heterogeneity with 8 individually significant alleles. Highest-event reference alleles: A\*02:01 (n=2,103), B\*07:02 (n=829), C\*04:01 (n=1,488).

**Key findings:**
- **HLA-A:** A\*36:01 (loss-biased), A\*02:01 (retention-biased, high n), A\*01:01 (retention-biased, FDR<0.05)
- **HLA-B:** B\*58:01 (loss-biased, FDR<0.05), B\*08:01 (retention-biased, FDR<0.05), B\*07:02 (retention-biased, FDR<0.05)
- **HLA-C:** No individual alleles survive correction; locus shows no global heterogeneity (LRT p=0.164)

**Statistical test:** Logistic regression (minorization–maximization optimization); LRT vs. null of all equal strengths. P-values from within-event flip null (B=20,000, seed 20260709). Centered SE from covariance matrix.

---

### Figure 2: S11 Negative Control — Reference-Divergence Artifact Test

![S11 reference-divergence negative control]({{artifact:art_3fc5fdf2-110e-488d-a1af-91650a78216b}})

**Caption:** Testing the hypothesis that apparent allele-specific LOH directionality is a read-mapping artifact (divergent alleles miscalled as lost). Top row: Hamming divergence distributions (GRCh38 reference: A\*03:01, B\*07:02, C\*07:02) over mature residues 1–182; overlay shows the ≥20-event informative panel. Reference self-distance = 0 marked. Bottom row: Per-locus Spearman ρ(divergence, frac_lost) scatter; reference allele = diamond with retention rank annotated; B\*57:01 circled as an example.

**Result:** Read-mapping artifact predicts positive ρ (divergence → apparent loss). Only HLA-B shows weak positive (ρ=+0.231, not significant); HLA-A shows significant **negative** ρ (−0.508, p=0.005), the **opposite** of artifact prediction. This rules out a systematic caller bias as the source of observed loss-preference heterogeneity.

**Statistical test:** Permutation within-locus null on |ρ| (B=20,000, seed 20240709; two-sided). Leave-one-out influence max |Δρ| ≈ 0.06–0.09 per locus.

---

## Supplementary/Exploratory Figures

Additional figures are available in the project artifact store; key supplementary analyses include:

- **`fig_g1_positive_control.png`** — Positive control validation (R175H TP53 mutation example from Bandlamudi et al.)
- **`fig_g3_breadth.png`** — Engageability/HED diversity metrics
- **`fig_g4_divergence.png`** — Extended divergence analysis by structural domain
- **`fig_g4_per_allele_loss.png`** — Per-allele loss-frequency heatmap
- **`fig_loh_directionality.png`** — Allele-level directionality (loss vs. retention bias)
- **`fig_cap_loh.png`** — CAP LOH meta-analysis integration

All figures are publication-ready PNG format with 300 dpi resolution and use consistent color palettes (FDR-significant = red; reference alleles = outlined; allele n ≥ 100 = solid; n < 100 = translucent).

---

## Data Availability and Reproducibility

All numerical results, intermediate tables, and R/Python code are available in the project artifact store under the prefix `LOH_arm_` or with matching result table filenames (e.g., `BT_A_refhighest.csv`, `perprofile_nested_LRT.csv`).

Full provenance (code, environment, checksums, lineage) is documented in:
- `s10_provenance_ledger.md` — Complete S10 section
- `s10_checksums.sha256` — SHA256 hashes for all tables and figures

All p-values are from exact permutation tests with fixed random seeds, enabling complete reproduction.

