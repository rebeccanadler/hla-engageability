# Methods & Provenance — Cancer Arm + Metric Validation

Companion to `results_cancer_arm.md`. Class I only, allele-level metric, public summary
statistics. Every figure is reproducible from the artifacts named below.

---

## Data sources

| Source | Role | Identifier |
|--------|------|-----------|
| Chowell et al. 2018, *Science* | ICB HR by HLA class I supertype (cancer outcome) | DOI 10.1126/science.aao4572 |
| Sidney et al. 2008, *BMC Immunol.* | Allele → supertype membership map (Sidney/Sette scheme, authoritative A/B) | Additional File 1 |
| STCRDab / TCR3d | 176 human class I TCR–pMHC crystal complexes → TCR-facing footprint | n = 176 (superset 243) |
| Engageability score set | 676 common class I alleles, crest-surface composite | artifact `5f19dea6-…` |
| HED per allele | Peptide-repertoire-breadth baseline (comparator) | artifact `c6390124-…` |

**Framing note.** HED and the cancer/autoimmunity trade-off concept are prior work. The
contribution here is (1) the **engageability** metric — permissiveness of the α1/α2 crest to
diverse TCR docking, distinct from HED's peptide-repertoire breadth — and (2) the head-to-head
cancer-arm test. HED is used only as an orthogonality comparator and as a feature-level
covariate; it is **never** used as the favorability axis (that would be circular).

---

## Metric construction (engageability)

- Composite over three z-scored crest features: `engageability_A = (z_heterogeneity −
  z_|net charge| − z_hydrophobic imbalance) / 3` (recovered by least squares, R² = 1.000).
- Features are computed on the 26-position **TCR-facing footprint**: residues in TCR contact
  (≤5 Å) in ≥25 % of 176 class I TCR–pMHC complexes, on α1 (58–76) and α2 (146–167).
- Footprint validation: A\*02:01 landmark check 0/182 mismatch (PDB 1AO7); TCR3d-vs-STCRDab
  docking-angle Pearson r = 0.94, mean |Δ| = 1.3° over 174 shared complexes.
- HED-cleanliness: corr(engageability_A, mean HED) = −0.03 (676-allele scope), −0.02 at the
  181-allele HED scope; the composite is clean because raw-feature HED correlations cancel
  (hydrophobic imbalance −0.26, |net charge| +0.22, heterogeneity −0.09).

---

## Cancer-arm model (locked design)

- **Supertype-primary.** Cancer outcome = Chowell 2018 ICB HR at supertype resolution
  (12 supertypes incl. two bridge categories A01A03, A01A24). Allele-level = labeled
  secondary; allele-resolution two-arm overlap is structurally N = 0.
- **Continuous axis:** all 12 supertype HR point estimates, no significance thresholding.
- **Join:** one row per allele; each allele keeps its own engageability and inherits its
  supertype's log-HR + SE. WLS(log-HR ~ engageability), inverse-variance weighted by supertype
  SE, **supertype as cluster** (cluster-robust SEs). Not collapsed to supertype mean.
- **Effective df ≈ 12 supertypes** (outcome constant within supertype → association is a
  between-supertype contrast); the cluster-robust N = 400 is not the power.
- **Robustness:** leave-one-supertype-out (12 refits); bridge categories flagged and confirmed
  inert under IVW.
- **Feature-level HED control:** each raw feature → log-HR, raw then +HED covariate.
- **Allele-frequency control (RUN):** AFND/NMDP per-allele frequency
  (`afnd_freqs_676.json`, version `c5658ebb-…`), z-scored log₁₀(mean freq), added to the
  cluster-robust join. All 400 cancer-subset alleles covered (0 missing). Engageability β
  stable: raw +0.108 → +freq +0.112 → +freq+HED +0.088; against-prior sign preserved.
  (`cancer_arm_freq_control.csv`, version `b78a6774-…`.)
- **TCGA prognostic control (NOT RUNNABLE in-project):** requires per-patient TCGA HLA
  genotype + overall survival. Project TCGA artifacts are immune-escape/APM-mutation tables
  (TMB, APM defects, B2M/NLRC5) with no per-patient HLA calls and no survival endpoint →
  control deferred pending an external HLA-typed clinical-outcome dataset. Flagged, not
  fabricated.

---

## Per-figure provenance

| Figure | Content | Source artifact(s) |
|--------|---------|--------------------|
| F1 | Engageability vs HED (r = −0.02), per-locus SD inset | `5f19dea6-…` (engageability), `c6390124-…` (HED) |
| F2 | 26-position TCR-facing crest footprint | `ca220ee8-…` (tcr_facing_positions), `89859e67-…` (methods) |
| F3 | Engageability vs 12 supertype HRs; drawn line = 12-point supertype IVW slope (+0.272) | `4c87f084-…` (cancer axis), `b5e0907d-…` (primary specs) |
| F4 | Feature-level HED control, cancer arm | `a88e3da6-…` (feature-HED cancer) |

Underlying result tables: cancer axis `4c87f084-…`; primary specs `b5e0907d-…`;
leave-one-out `cb00f069-…`; feature-HED `a88e3da6-…`; per-allele join checkpoint
`6519bce7-…`.

---

## Scope boundaries (this session)

- **Cancer arm + metric validation only.** The autoimmune arm (real per-allele ORs) is a
  separate step; the binary anchor-membership probe is out of scope and is not reported.
- **No two-arm / joint / antagonistic-pleiotropy figure** — the second arm does not yet exist;
  the trade-off test is held until the autoimmune-risk step lands.
- The cancer-side sign is **against the engageability prior** and weak on honest df; reported
  as-found, no tuning.
