# Results — Part 1: A per-allele TCR *engageability* metric for HLA class I

**Scope.** This arm builds an allele-level metric — **engageability** — quantifying how permissive an HLA class I α1/α2 TCR-facing surface is to *diverse* TCR docking, and tests it against allele-level Human Evolutionary Divergence (HED). The metric is deliberately **not** clone-specific: footprints vary by TCR and peptide, and that variability is the object of interest. Engageability is conceptually distinct from HED (peptide-repertoire breadth); the head-to-head correlation below is the pre-registered test of that distinction.

All feature directions, standardization, and composite definitions were **pre-registered** in `engageability_spec.md` *before* any feature distribution or HED correlation was examined. The checkpoint reports numbers only — no pass/fail, no post-hoc tuning.

---

## 1. Structure inventory of class I TCR–pMHC complexes

We assembled a non-redundant inventory of human class I TCR–pMHC structures by merging two databases: **TCR3d** (allele annotation) and **STCRDab** (chain assignments, independent docking angles).

- **243 unique human HLA class I complexes** (TCR3d), a strict superset of the 176 downloadable STCRDab entries (176/176 overlap; 0 STCRDab-only).
- Locus split: **A = 168, B = 54, E = 14, C = 7**; 23 allele groups.
- Data-rich allele: **A\*02 (n = 127)**. Secondary: B\*35 = 22, A\*24 = 14, A\*11 = 12, B\*27 = 11; the remainder are singletons or low single digits.
- **Cross-database validation:** TCR3d vs STCRDab docking angle, n = 174, Pearson r = 0.939, mean |Δ| = 1.3°.

![Structure inventory by allele group, coloured by locus]({{artifact:2fc41470-1107-445d-bd06-9abb3022e60c}})

*The inventory establishes the central data-availability fact for the whole project: only A\*02 is structurally data-rich. Tier-1 (below) therefore builds a sequence proxy for all 676 alleles; Tier-2 structural calibration is only powered for A\*02.*

Artifacts: [`tcr_pmhc_structure_inventory.csv`]({{artifact:109fce1f-5a16-4308-968d-9ebdd224e8b0}}), [`stcrdab_summary_all.tsv`]({{artifact:5f125f8f-252b-472e-bad3-41e84bbeaeda}}).

---

## 2. The TCR-facing helix-crest surface

We defined the TCR-facing surface **empirically** from the 176 structures and cross-referenced it against published germline restriction determinants.

- **Empirical footprint:** for each of 176 complexes, MHC α1/α2 residues (mature 1–182) with any heavy atom ≤ 5.0 Å of a TCR atom. The contact-frequency profile recovers the canonical restriction determinants: **R65 (94%), A69 (95%), Q155 (97%)**, plus positions 72, 150, 154, 158, 163, 151, 76, 73 (all ≥ 82%).
- **Landmark assertion (pre-registered):** the A\*02:01 residue extraction was checked against the A\*02:01 crystal structure **1AO7** — **0 mismatches / 182 positions**. An off-by-one would silently corrupt every downstream feature; this gate passed.
- **Footprint threshold:** positions contacted in ≥ 25% of structures → **26 crest positions**.
- **Group split by cross-allele Shannon entropy (676 alleles), threshold 0.30 bits:**
  - **VARIABLE crest (n = 14):** positions 62, 63, 65, 66, 69, 70, 73, 76, 151, 152, 158, 163, 166, 167 — mean entropy **1.11 bits**.
  - **CONSERVED restriction (n = 12):** positions 58, 68, 72, 75, 146, 149, 150, 154, 155, 157, 159, 162 — mean entropy **0.036 bits** (~31× lower).

![TCR footprint contact frequency on α1/α2, coloured by group]({{artifact:8d14c70c-7f89-4b02-a461-5a80b3ae28cf}})

![Per-position cross-allele conservation, VARIABLE vs CONSERVED split]({{artifact:b7070c64-2681-4761-9d12-c7bc4e11b0f3}})

Artifacts: [`tcr_facing_positions.csv`]({{artifact:ca220ee8-4b0e-450f-9cc8-0d7f4fed4201}}), [`allele_crest_residues.csv`]({{artifact:ff1e9c1f-1a71-4601-b81a-81c012b12a87}}), [`methods_tcr_facing_surface.md`]({{artifact:89859e67-37f2-4a18-a0fa-9a0fc297b39a}}), [`structural_contact_profile.csv`]({{artifact:2e5a131e-8084-4189-887f-862b1d5dd533}}).

---

## 3. Physicochemical surface features (pre-registered)

Three VARIABLE-group features were computed **within-allele** (intrinsic to the molecule, not catalog-relative), each with its direction fixed from theory *before* computation:

| Feature | Direction | Mechanism |
|---|---|---|
| crest heterogeneity | **+** | a varied surface admits diverse TCR docking |
| \|net crest charge\| | **−** | charge extremity imposes electrostatic restriction |
| hydrophobic imbalance | **−** | hydrophobic extremity imposes restriction |

Heterogeneity = mean pairwise Euclidean distance among crest residues in normalized charge/Kyte-Doolittle-hydropathy/volume space. The same three features were computed for the CONSERVED group and carried separately.

**Internal non-redundancy (pre-registered check).** VARIABLE-feature intercorrelation across 676 alleles: heterogeneity vs \|net charge\| = −0.054; heterogeneity vs hydrophobic imbalance = −0.010; \|net charge\| vs hydrophobic imbalance = +0.240. **No \|r\| > 0.7 flags** (max 0.24) — the equal-weight composite genuinely combines three near-independent dimensions rather than covertly upweighting a shared axis.

**CONSERVED-group flatness is a design consequence, not a biological null.** The CONSERVED features are near-invariant across common alleles (variances: heterogeneity 0.007, \|net charge\| 0.039, hydrophobic imbalance 0.598). An allele-discriminating metric cannot draw signal from a near-constant feature group; this is a property of the metric's construction, not a statement about germline restriction determinants.

![Feature correlation heatmap (VARIABLE and CONSERVED features)]({{artifact:c71b3a95-92a0-43c9-b981-f0ca30dc7b6a}})

Artifacts: [`engageability_spec.md`]({{artifact:9bf5ab63-7d15-4fa2-9356-d05ec47e91b2}}) (pre-registration), [`allele_physicochem_features.csv`]({{artifact:ce080efb-318e-4a64-90fa-f2732bac7a19}}).

---

## 4. The engageability score

Two composites were run on the VARIABLE-group features (both pre-registered):

- **Composite A (primary, equal-weight):** mean of the z-scored, theory-signed features. No tunable weights.
- **Composite B (robustness, PC1):** first principal component of the same standardized matrix, sign fixed positive-loading-on-heterogeneity. **PC1 loadings** [het, \|net charge\|, hydrophobic imbalance] = [0.18, 0.70, 0.69]; **PC1 explains 41.6%** of variance (PC2 33.2%, PC3 25.2%).

**Spread.** Composite A: mean 0, SD 0.634, range [−2.42, 1.66], IQR 0.728. Composite B: SD 1.118, range [−3.49, 2.63]. Per-locus SD (A): **HLA-A 0.796, HLA-B 0.579, HLA-C 0.298** — HLA-C shows the tightest distribution, consistent with its lower polymorphism.

**A-vs-B agreement (blend-robustness).** Overall Spearman **0.925**, Pearson 0.924; per-locus Spearman A 0.979, B 0.954, C 0.829. Top-decile overlap 56 alleles, bottom-decile 59. Above the pre-registered 0.8 threshold → the score is robust to the blending choice; **Composite A carried as primary, Composite B confirms robustness.**

![Composite A vs B agreement, coloured by locus]({{artifact:7a5e6c25-7745-4917-9f60-b0b003e3a364}})

![Engageability distribution across 676 alleles]({{artifact:a2fd4100-3483-49af-94ec-346005515a8a}})

Artifact: [`engageability_scores.csv`]({{artifact:5f19dea6-f51d-4aa4-bd9e-0c4fe3d4e62c}}) — per-allele scores with VARIABLE and CONSERVED components.

---

## 5. Checkpoint — engageability vs HED (numbers only)

Merged engageability with HED for all **676 alleles**. Primary HED column `mean_HED_181scope` (181 residues); sensitivity column `mean_HED` (182 residues).

**Correlation with HED** (Pearson / Spearman | 181-scope vs 182-scope):

| Component | 181 P/S | 182 P/S |
|---|---|---|
| **Composite A (primary)** | **−0.021 / −0.038** | **−0.029 / −0.038** |
| Composite B (PC1) | +0.025 / +0.002 | +0.002 / −0.009 |
| raw heterogeneity | −0.117 / −0.160 | −0.087 / −0.140 |
| raw \|net charge\| | +0.214 / +0.172 | +0.224 / +0.176 |
| raw hydrophobic imbalance | −0.291 / −0.278 | −0.256 / −0.257 |
| GROUP VARIABLE composite | −0.021 / −0.038 | −0.029 / −0.038 |
| GROUP CONSERVED composite | +0.009 / −0.010 | +0.012 / −0.010 |

**Readings (numbers only):**
- Composite A is **orthogonal to HED** (|r| ≈ 0.02–0.04). The metric is not a repackaging of peptide-repertoire divergence.
- The **181- vs 182-scope choice moves every correlation by ≤ 0.035** in |r|; orthogonality does not depend on it.
- **Per-feature reporting exposes cancellation:** individual raw features carry more HED signal (hydrophobic imbalance −0.29, \|net charge\| +0.21) than the composite, and these partially cancel in the equal-weight average. This is surfaced, not adjudicated — it is the reviewer's call whether the composite's orthogonality is a feature or an artifact of averaging opposing signals.

![Checkpoint summary: spread, HED orthogonality, per-feature cancellation]({{artifact:0cc5b88f-1f5c-4efd-bd73-2bceaea22854}})

Artifact: [`checkpoint_report.md`]({{artifact:03a7c4d5-2f8d-412b-82f1-9b8d4cba2b3b}}) — full numbers with provenance.

---

## 6. Tier-2 — docking-geometry diversity in data-rich alleles

We tested whether the tier-1 sequence proxy predicts **observed** docking-geometry diversity, using TCR3d docking/incident angles.

- **Tier-2 N (foregrounded):** 8 alleles cleared ≥ 5 structures; 5 cleared ≥ 10; **only A\*02 is truly data-rich (n = 127)**. Any cross-allele calibration is descriptive, not powered.
- **Cross-allele proxy vs docking-angle SD:** Pearson r = **+0.05** (p = 0.91), Spearman −0.17 (p = 0.69), n = 8 — null.
- **Confound:** n_structures vs docking-angle SD, Pearson r = **+0.61** — observed spread grows with sample size, so the cross-allele test is both unpowered and confounded.
- **Within A\*02:01 (n = 127 TCRs):** docking angle spans **27–169°** (SD 19.4°), incident angle **0–72°** — a single allele accommodates a wide range of TCR docking geometries, operationalizing "variability is the point" at the level of one molecule.

![Tier-2 docking geometry: within-A*02 spread and unpowered cross-allele proxy test]({{artifact:073339fb-ffe0-4993-927d-d8890aec4425}})

Artifact: [`docking_geometry_diversity.csv`]({{artifact:7505caf8-a335-4a76-8938-dd83f8da9163}}).

---

## Summary of Part 1

1. The structure record supports a **sequence proxy for all 676 alleles + structural calibration only for A\*02** — established up front, not discovered late.
2. Engageability (Composite A) has a **usable spread** (SD 0.63, HLA-A > B > C) and is **robust to the blending choice** (A-vs-B Spearman 0.93).
3. Engageability is **orthogonal to HED** (|r| ≈ 0.02–0.04), scope-insensitive — it measures something HED does not.
4. The cross-allele docking-diversity calibration is a **confounded null at n = 8**; the honest structural result lives *within* A\*02:01, where docking geometry is demonstrably diverse. The residue-level follow-up on that single allele is **Part 2**.

*Continued in `RESULTS_part2_a0201_mechanism.md`.*
