# Results — HLA Class I Engageability: Cancer Arm + Metric Validation

*Scope: this document covers the **cancer arm** and **metric-validation** results only. The
autoimmune-risk arm (per-allele ORs) is a separate step and is **not** reported here; no
two-arm / joint / antagonistic-pleiotropy result appears in this file, because the second
arm does not yet exist. The cancer-side association below is **preliminary** — the
allele-frequency covariate and the TCGA prognostic control are **not yet run**.*

---

## 1. Metric validation — engageability is orthogonal to HED

Engageability is an allele-level score of how permissive an allele's α1/α2 crest surface is
to diverse TCR docking, built as a composite of three physicochemical features of the
TCR-facing crest:

```
engageability_A = ( z_heterogeneity − z_|net charge| − z_hydrophobic imbalance ) / 3
```

computed across **676 common class I alleles** (HLA-A = 218, HLA-B = 331, HLA-C = 127).

**Core orthogonality result.** Engageability is essentially uncorrelated with HLA Evolutionary
Divergence (HED), the peptide-repertoire-breadth baseline:

> **r = −0.02** (Pearson, engageability_A vs mean HED; −0.03 at full 676-allele scope,
> −0.02 at the 181-allele HED scope — ±0.01 across scopes, immaterial).

This is orthogonality **by construction**: engageability reads the outward crest surface,
HED reads the peptide-binding groove floor — different faces of the molecule. The composite
is HED-clean because two of its raw features carry opposite-sign HED correlations that
cancel (hydrophobic imbalance vs HED −0.26; |net charge| vs HED +0.22; heterogeneity −0.09).

**Per-locus dispersion.** Engageability varies most at HLA-A and least at HLA-C:

| Locus | SD of engageability_A |
|-------|-----------------------|
| A     | 0.80 |
| B     | 0.58 |
| C     | 0.30 |

![F1 — Engageability vs HED scatter, colored by locus, with per-locus SD inset]({{artifact:art_8cf7c35d-9868-49e5-8a72-669d549e74cb}})

**Figure 1.** Engageability is orthogonal to HED (r = −0.02). Points are 676 alleles colored
by locus; the inset shows per-locus SD (A 0.80 > B 0.58 > C 0.30).

---

## 2. Metric provenance — the empirically-derived TCR-facing footprint

The crest positions that define engageability were derived empirically from **176 human
class I TCR–pMHC crystal complexes** (STCRDab; TCR3d superset n = 243), taking residues in
TCR contact (≤5 Å) in ≥25 % of structures. This yields a **26-position** helix-crest
footprint on the α1 (58–76) and α2 (146–167) helices, split by cross-allele sequence
variability into:

- **VARIABLE crest** (sequence entropy ≥ 0.30 bits): **n = 14** positions
- **CONSERVED restriction determinants**: **n = 12** positions

The three highest-frequency conserved contacts recovered — the canonical restriction
determinants — are **R65 (94 %)**, **A69 (95 %)**, and **Q155 (97 %)**. Landmark validation on
A\*02:01 (PDB 1AO7) showed **0/182 residue mismatch**; TCR3d-vs-STCRDab docking-angle
agreement was Pearson r = 0.94 (mean |Δ| = 1.3° over 174 shared complexes).

![F2 — TCR-facing crest surface on the class I fold, split by sequence variability]({{artifact:art_d9604268-dcd6-467f-8799-6fea3e0336ba}})

**Figure 2.** Empirically-derived TCR-facing crest surface, split by sequence variability
(VARIABLE n = 14, CONSERVED restriction determinants n = 12), with R65/A69/Q155 called out.
Marker size ∝ structural contact frequency. *This is a surface description; the VARIABLE
positions are not asserted to be engagement hotspots or pattern-drivers.*

---

## 3. Cancer arm — engageability vs supertype favorability (supertype-primary)

**Design (locked, supertype-primary).** The cancer outcome is the Chowell 2018 ICB hazard
ratio, available at **supertype resolution** (the Sidney/Sette scheme, authoritative for
A/B). The cancer arm is modeled as a continuous vector of the **twelve supertype HR point
estimates** — no thresholding on significance. Allele-level is a labeled secondary analysis,
not co-primary, because the allele-resolution two-arm overlap is structurally N = 0.

### 3.1 The 12-supertype cancer axis

| Supertype | HR | 95 % CI | P | Direction | Member alleles (of 676) |
|-----------|-----|---------|-----|-----------|--------------------------|
| B44 | 0.61 | 0.42–0.89 | 0.009 | favorable **(sig)** | 49 |
| A24 | 0.67 | 0.44–1.03 | 0.070 | favorable | 24 |
| B08 | 0.85 | 0.52–1.39 | 0.51 | favorable | 7 |
| A01 | 0.87 | 0.60–1.27 | 0.47 | favorable | 35 |
| A01A24 ‡ | 0.89 | 0.43–1.83 | 0.76 | favorable | 5 |
| B58 | 0.98 | 0.51–1.88 | 0.96 | favorable | 10 |
| B27 | 1.09 | 0.73–1.63 | 0.67 | unfavorable | 57 |
| A02 | 1.13 | 0.76–1.63 | 0.53 | unfavorable | 39 |
| A01A03 ‡ | 1.20 | 0.49–2.94 | 0.69 | unfavorable | 6 |
| B07 | 1.35 | 0.92–1.97 | 0.12 | unfavorable | 83 |
| A03 | 1.39 | 0.96–2.03 | 0.08 | unfavorable | 47 |
| B62 | 2.29 | 1.40–3.74 | 0.0007 | unfavorable **(sig)** | 38 |

‡ = bridge supertype category. Only **2 of 12** supertypes are individually significant
(B44 favorable, B62 unfavorable); the axis uses all twelve, weighted by uncertainty.

### 3.2 Join model and primary association

**Join** (locked): one row per allele — each allele keeps its own engageability (allele
resolution preserved) and **inherits** its supertype's cancer log-HR and SE. Fit
engageability → cancer log-HR with **supertype as a cluster**, inverse-variance weighted by
supertype SE (wide-CI supertypes down-weight themselves). Not collapsed to a supertype mean.

**Degrees-of-freedom honesty.** Within a supertype the cancer outcome is constant, so the
association is driven **entirely by between-supertype contrasts**. The cancer arm has
**≈ 12 outcome levels regardless of the 400 allele rows** — effective df ≈ number of
supertypes, not row count.

| Specification | β (per +1 SD engageability) | 95 % CI | p | Effective df |
|---------------|------------------------------|---------|-----|--------------|
| Allele-level, cluster-robust (normal) | **+0.108** | +0.007 … +0.208 | **0.037** | ≈ 12 supertypes |
| Allele-level, cluster-robust (t₁₁) | +0.108 | −0.006 … +0.221 | 0.061 | 11 |
| 12-point supertype-level IVW | **+0.272** | −0.235 … +0.778 | 0.260 | 10 |

On the HR scale the allele-level estimate is exp(β) = 1.11 (1.01–1.23).

**Sign.** β > 0 means **↑ engageability → ↑ hazard ratio → worse ICB benefit**. This is the
**opposite** of the cancer-favorable prior for the engageability axis. The effect is weak on
the honest ~12-supertype df (supertype-level p = 0.26; allele-clustered small-sample
t₁₁ p = 0.061). Reported as-found; no positive/negative call is made here.

![F3 — Engageability vs the 12 supertype favorability HRs, fitted 12-point supertype IVW line]({{artifact:art_9a735000-b2ac-40ef-b809-126a53b491cc}})

**Figure 3.** Engageability (supertype mean) vs the 12 supertype ICB hazard ratios
(B44 0.61 → B62 2.29). **The drawn line is the 12-point supertype-level IVW slope
(β = +0.272)** — matching the twelve plotted points — not the allele-clustered +0.108.
On-frame caveats: effective df ≈ 12 supertypes not 400 alleles; sign against-prior;
allele-frequency covariate and TCGA prognostic control NOT YET RUN. Preliminary, cancer-side
only.

### 3.3 Robustness — leave-one-supertype-out

Refitting the allele-level cluster-robust model dropping each supertype in turn, the sign of
the engageability↔favorability coefficient is **stable across all twelve** (β range
+0.062 … +0.128). The two bridge categories are inert — dropping A01A03 (β 0.108) or A01A24
(β 0.108) barely moves the estimate, confirming inverse-variance weighting already
down-weights their wide-CI HRs. The largest attenuation is from dropping A24 (→ 0.062) or
A01 (→ 0.083); dropping A03 (→ 0.128) or B62 (→ 0.121) strengthens it.

---

## 4. Feature-level HED control (cancer arm)

Controlling for HED **at the feature level** (not just on the composite average): each raw
feature → cancer log-HR, then re-fit with HED as a covariate.

| Feature | Raw β (p) | HED-adjusted β (p) |
|---------|-----------|--------------------|
| Heterogeneity | +0.062 (0.33) | **+0.086 (0.086)** |
| \|net charge\| | −0.063 (0.31) | −0.030 (0.583) |
| Hydrophobic imbalance | −0.025 (0.43) | **+0.003 (0.922)** |

**Heterogeneity carries the signal** and strengthens after HED adjustment; the
**hydrophobic-imbalance component collapses to ≈ 0**. So "engageability adds beyond HED"
holds for the heterogeneity component but would **overstate** the hydrophobic-imbalance
component. (This is a covariate adjustment; excluding HED as a *favorability axis* — for
circularity — stands separately.)

![F4 — Feature-level HED-control panel, cancer arm]({{artifact:art_faaf6c23-bc38-499a-920a-cca46ddb303a}})

**Figure 4.** Feature-level HED control (cancer arm): raw vs HED-adjusted β per feature.
Heterogeneity strengthens after HED (+0.086, p = 0.086); hydrophobic imbalance collapses to
~0 (+0.003). On-frame df and NOT-YET-RUN caveats.

---

## 5. Allele-frequency control (RUN — resolved)

The allele-frequency covariate is now run. Population frequencies for **all 400** cancer-subset
alleles come from AFND (NMDP populations); the covariate is z-scored log₁₀(mean frequency),
added to the locked cluster-robust join. No allele was missing a frequency (0/400).

| Specification | β (engageability) | 95 % CI (t₁₁) | p (normal) | p (t₁₁) |
|---------------|-------------------|----------------|------------|---------|
| raw | +0.108 | −0.006 … +0.221 | 0.037 | 0.061 |
| **+ frequency** | **+0.112** | −0.003 … +0.226 | 0.031 | 0.054 |
| + HED | +0.083 | −0.006 … +0.171 | 0.041 | 0.066 |
| + frequency + HED | +0.088 | +0.002 … +0.174 | 0.025 | 0.046 |

**The engageability coefficient is stable under frequency adjustment** — sign unchanged,
magnitude essentially unchanged (+0.108 → +0.112), so the against-prior association is not an
artifact of common vs rare alleles. Adding HED attenuates the coefficient modestly (as
expected, since HED shares the heterogeneity feature) but does not flip it. Effective df stays
≈ 12 supertypes throughout. (`cancer_arm_freq_control.csv`.)

## 6. Honest framing and remaining control

- **Allele-frequency covariate: RUN** — engageability coefficient stable (+0.108 → +0.112),
  against-prior sign preserved (§5).
- **TCGA prognostic control: NOT RUNNABLE with in-project data.** A prognostic control needs
  per-patient TCGA **HLA genotype + overall survival** to test whether supertype favorability
  tracks a generic (ICB-independent) survival effect. The project's TCGA artifacts are
  immune-escape / APM-mutation tables (TMB, APM defects, B2M/NLRC5) with **no per-patient HLA
  calls and no survival endpoint**, so the control cannot be run here without importing an
  external TCGA HLA-typing + clinical-outcome dataset. Flagged, not fabricated.
- **Sign is against the engageability prior** on the cancer side (higher engageability →
  *worse*, not better, ICB HR), and the effect is **weak** on the honest ~12-supertype
  effective df. Reported without massaging.
- **Effective df ≈ 12 supertypes**, not 400 alleles — the cluster-robust N is not the power.
- The autoimmune arm (real per-allele ORs) is deferred to a separate step; the two-arm
  trade-off test is held until that arm lands.

**Net status:** one of the two open controls (allele frequency) is now resolved and does not
overturn the cancer-arm result; the TCGA prognostic control remains open pending an external
HLA-typed survival dataset. The cancer-arm association is therefore **frequency-robust but
still preliminary** until the prognostic control is run.

See `methods_cancer_arm.md` for data sources, provenance, and per-figure methods.
