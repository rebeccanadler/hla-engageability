# Results — Part 2: Within-A\*02:01 residue-level mechanism probes

**Status: exploratory, post-checkpoint, not pre-registered.** These analyses were run *after* the Part-1 checkpoint to interrogate the metric's mechanism on the one data-rich allele. They are labelled exploratory throughout and do **not** feed back into the pre-registered metric.

**Single-allele ceiling (applies to everything in Part 2).** Within one allele the sequence is fixed, so these footprints vary only by which TCR is bound — not by allele sequence. They describe how TCRs *use* the A\*02:01 crest surface. They **cannot** test the between-allele metric claim (that sequence differences at VARIABLE crest positions make alleles differ in TCR permissiveness), and they do **not** license "docking-diversity-calibrated" language for the metric.

The question motivating Part 2: do TCRs actually engage the crest positions the metric treats as permissive, and do they engage them *variably* — the premise of engageability? All work uses only the 127 inventoried A\*02:01 complexes (no subsampling).

---

## 1. Per-structure contact footprints (n = 127)

For each of the 127 A\*02:01 complexes we computed the TCR contact footprint on the MHC α1/α2 surface (heavy-atom distance ≤ 5.0 Å), yielding a **127 × 182 binary contact matrix**.

**Method note (a real correction).** β2-microglobulin sits under the peptide-binding platform and contacts the α1/α2 *underside* (floor positions 92–97, 115–122) in essentially every structure. An initial run mis-identified β2m as a TCR chain and those floor positions showed ~98% "contact" frequency. Excluding β2m by sequence removed the artifact (floor positions → 0.00). MHC chains with non-standard author numbering were mapped to mature 1–182 by sequence alignment, so all 127 structures were retained under a uniform method.

- Mean footprint: **19.6 α1/α2 residues per TCR**.
- **7 complexes contact zero crest positions** — genuine non-canonical binders: 6p64, 6uk2, 6uk4, 6uz1, 6vm7, 6vm8, 6vmc (including the reversed-polarity 6vm7/6vm8/6vmc and the β2m-side 6uk2/6uk4 TCRs). Retained, not dropped.

Artifact: [`a0201_contact_footprints.csv`]({{artifact:0fd86be7-fa1a-4392-9694-b17545fb0433}}) — the 127 × 182 matrix that all of Part 2 is built on.

---

## 2. Marginal analysis — do TCRs concentrate on the crest, and do they use it variably?

**Contact frequency by position group** (fraction of 127 TCRs):

| Group | n | mean | median | range |
|---|---|---|---|---|
| VARIABLE crest | 14 | **0.651** | 0.732 | 0.26–0.89 |
| CONSERVED crest | 12 | **0.615** | 0.618 | 0.31–0.90 |
| other α1/α2 | 156 | **0.020** | 0.008 | 0.00–0.27 |

TCRs concentrate on **both** crest groups ~32× more than the rest of the α1/α2 surface. VARIABLE vs CONSERVED preference is essentially equal (0.65 vs 0.62).

**Across-structure contact variance by group** [p(1−p), max 0.25 at p = 0.5]:

| Group | mean | median |
|---|---|---|
| VARIABLE crest | **0.190** | 0.194 |
| CONSERVED crest | **0.200** | 0.223 |
| other α1/α2 | **0.018** | 0.008 |

- crest (both) vs other surface: Mann-Whitney p = 9.4×10⁻¹⁷; crest variance ~11× the background.
- **VARIABLE vs CONSERVED: Mann-Whitney U = 70, p = 0.764 → no difference.**

**Marginal reading.** TCRs use the crest surface variably (variability is the point), but that variability is **not** preferentially located at the VARIABLE-*sequence* positions. The metric's VARIABLE/CONSERVED split — built from cross-allele sequence entropy — does not map onto differential *structural-usage* variability within A\*02:01. The sequence-conserved restriction positions are contacted just as variably as the sequence-variable crest positions.

**Within-allele crest usage vs docking geometry** (n = 127): TCRs at more extreme/unusual docking geometries use *fewer* VARIABLE crest positions — VARIABLE-crest count vs |docking-angle deviation from median| Pearson **−0.257** (p = 0.003), vs docking angle −0.202 (p = 0.023), vs incident angle −0.232 (p = 0.009). Geometric diversity does not co-locate with heavier variable-crest engagement; if anything the opposite. Descriptive.

![A*02:01 per-position contact frequency (top) and across-structure variance (bottom), by group]({{artifact:8a95bf20-b3d1-46f7-84d7-d0f9185a39e2}})

Artifact: [`a0201_mechanism_report.md`]({{artifact:01cad09a-ea3d-4863-9044-6f6a1b6cb346}}).

---

## 3. Combinatorial analysis — a joint signature the marginal test is blind to

A marginal null (per-position) does not rule out a **joint** signature, because the metric aggregates *across* positions. Two pre-specified tests (committed before computing; exactly these two, no threshold sweeps):

### Test 1 — footprint-pattern loadings (PCA, size-controlled)
- **Size confound controlled:** PC1 explains 29.4% variance and correlates with total crest-contact count at **r = 0.969** → PC1 is a size axis, excluded. Pattern read from PC2 onward (PC2–PC5, cumulative 37.7%).
- Group |loading| comparison (RMS across PC2–PC5): VARIABLE **0.160** vs CONSERVED **0.204**, Mann-Whitney p = 0.129 → **no difference** (direction favours CONSERVED). Size-normalized variant agrees (0.139 vs 0.211, p = 0.487).
- **VARIABLE positions do not drive the footprint-pattern axes more than CONSERVED.**

![Test 1: per-position pattern loadings after excluding the size axis]({{artifact:5cd140bb-e8aa-420c-9863-5f0e06fe1665}})

### Test 2 — within-group co-engagement (phi coefficients)

| Comparison | mean \|phi\| | n pairs |
|---|---|---|
| within-VARIABLE | **0.331** | 91 |
| cross-group | 0.283 | 168 |
| within-CONSERVED | **0.247** | 66 |

within-VARIABLE vs within-CONSERVED: Mann-Whitney U = 3761, **p = 0.007**. VARIABLE positions are engaged in more **coordinated sets** than CONSERVED — a combinatorial signature the equal marginal variance (0.190 vs 0.200) did not reveal.

![Test 2: position–position co-engagement (phi) heatmap and group means]({{artifact:38dd1280-596d-495c-9ac7-441d88aa4065}})

Artifact: [`a0201_combinatorial_report.md`]({{artifact:e984292d-e280-4b5f-b8b9-0bea47e38f23}}).

---

## 4. Confound control — is the co-engagement result just spatial clustering?

Higher within-VARIABLE co-engagement could be geometry: if VARIABLE positions form a contiguous patch on the helices, they would co-engage simply because a TCR contacting one contacts its neighbour. We tested this against the A\*02:01 structure (1AO7).

**Q1 — are VARIABLE positions more spatially clustered?** (Cα–Cα distance):

| Group | mean (Å) | median | pairs |
|---|---|---|---|
| within-VARIABLE | **15.26** | 16.30 | 91 |
| cross-group | 16.50 | 17.53 | 168 |
| within-CONSERVED | **17.19** | 18.80 | 66 |

within-VAR vs within-CON: Mann-Whitney p = 0.043. **Yes, modestly** — VARIABLE positions sit ~1.9 Å closer on average. The confound is real.

**Q2 — does the co-engagement difference survive distance control?** Co-engagement is strongly distance-dependent (|phi| vs Cα–Cα distance Pearson **r = −0.514**, p = 2.4×10⁻²³), so distance must be held constant.
- **OLS** `|phi| ~ is_VARIABLE + distance` (within-group pairs, n = 157): is_VARIABLE **β = +0.057, p = 0.030**; distance β = −0.014, p < 10⁻⁴. Partial r(|phi|, is_VARIABLE | distance) = **0.174, p = 0.029**.
- **Distance-matched band (8–20 Å):** |phi| VARIABLE 0.330 vs CONSERVED 0.298, Mann-Whitney **p = 0.244**.

**Reading (numbers only).** The VARIABLE co-engagement effect is **partly, not wholly, attributable to spatial clustering**. It survives the linear model (shrunk from raw p = 0.007 to distance-adjusted p = 0.030) but does not reach significance in the distribution-free distance-matched comparison. A small residual group effect remains in the regression; it is not robust to the matched test.

![Distance-control: clustering by group (left) and phi vs distance with group fits (right)]({{artifact:79326093-ff6c-465a-a694-df6fac65a6ad}})

Artifact: [`a0201_distance_control_report.md`]({{artifact:19d6efc7-2992-4122-9d34-a0a36749e1fd}}).

---

## Summary of Part 2

1. **Where TCRs bind:** TCRs concentrate strongly on the crest surface (~32× background), engaging both VARIABLE and CONSERVED crest positions roughly equally.
2. **How variably:** the crest is used ~11× more variably than the background surface — but VARIABLE-*sequence* and CONSERVED-*sequence* positions are used equally variably at the margin (p = 0.76). The sequence-entropy split does not predict structural-usage variability.
3. **Joint structure:** VARIABLE positions do co-engage in more coordinated sets (raw p = 0.007) — a combinatorial signal invisible to the marginal test — but this is **partly a spatial-clustering artifact** (VARIABLE positions are ~1.9 Å closer) and only partially survives distance control (OLS p = 0.030; matched-band p = 0.24).
4. **The ceiling holds:** all of this is within a single fixed sequence and cannot validate the between-allele metric. It characterizes A\*02:01 crest usage; it does not upgrade any metric claim.

*Interpretation and any claim-level decisions are the investigator's call.*
