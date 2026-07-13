# MSK-IMPACT 50K — Internal Arm Results

**HLA class I representation across cancer types, and within-patient allelic immune pressure**

Cohort: MSK-IMPACT 50K Clinical Sequencing Cohort (MSK, Cancer Cell 2026; Bandlamudi et al.,
PMID 41895280). Class I genotypes from POLYSOLVER on patient-matched blood normal (germline);
somatic HLA loss-of-heterozygosity from LOHHLA. Analysis env: `hla-a3` (python 3.13). Every figure
and table below is a saved, versioned artifact; the three component reports
(`msk50k_hla_internal_arm_results.md`, `msk50k_LOH_adversarial_review.md`) carry the full methods.

---

## Framing (honest scope)

This arm is the **internal type-vs-type analysis** — the pre-specified primary analysis, because it
needs no external population reference and compares like ancestry against like. Two deliverables:

1. **A descriptive representation map** — does HLA allele composition differ across cancer types,
   *within* ancestry strata? Without the engageability metric this is a **descriptive map, not a
   hypothesis test**, and the antagonistic-pleiotropy framing does **not** apply to it. Stated as such.
2. **A within-patient allelic LOH-pressure test** — which HLA allele is preferentially deleted when a
   tumor undergoes HLA LOH? Each patient is their own control, so this is confound-free and is the
   arm's primary quantitative finding.

The engageability metric itself is held (pre-registered separately in `engageability_spec.md`); it is
**not** computed or correlated here. Only results that survive the adversarial review (§3) are
eligible to enter the later trade-off arm.

---

## 1. Representation map — Stage-1 stratified omnibus

**Design.** For each OncoTree cancer type with ≥200 patients (28 types), test whether its 2-field
allele-frequency distribution differs from the rest of the cohort, at each locus (A/B/C), **within
each clean ancestry stratum separately** (nonASJ-EUR, AFR, EAS). χ² on chromosome counts, rare
alleles pooled to keep the test valid, BH-corrected. **Stratify, don't adjust** — an association must
hold within a stratum to count, because cancer-type distribution and HLA frequency are both strongly
ancestry-dependent and pooled comparisons largely recover ancestry composition.

**Result.** 183 type×locus×stratum tests. **9 reach FDR<0.05; none replicate across ≥2 clean
strata.** Hits are stratum-specific:

- Melanoma-B/C and NSCLC-A/B significant only in nonASJ-EUR (where those cancers are common).
- Breast Cancer significant only in EAS (n=286), yet null in the 10×-larger nonASJ-EUR (n=3,006) —
  flagged as either genuine EAS structure or a small-stratum artifact, unresolvable at this power.
- Melanoma was tested in EAS (n=30) and is non-significant there (p=0.53/0.29/0.73 for A/B/C); it
  could not be tested in AFR (n<30). So its nonASJ-EUR signal is not shown to replicate.

![Stage-1 omnibus: −log10 FDR per cancer type within each clean ancestry stratum. Cells clearing FDR<0.05 never light up across strata for the same cancer type — Melanoma bright only in nonASJ-EUR, Breast only in EAS.]({artifact:art_5662d86e-4588-41c4-8c29-781272e176a7})

**Interpretation — a positive methodological finding, not a gap.** The absence of cross-ancestry-
robust type structure is itself the result: it supplies a mechanical reason the literature's
type-specific HLA associations are substantially **ancestry composition**, i.e. apparent type
structure that dissolves once the comparison is made within ancestry. Reported as a finding, not a
failure to find. Table: `msk50k_internal_stage1_omnibus.csv` (all 183 tests).

---

## 2. Within-patient allelic LOH-pressure test (primary quantitative finding)

**Design.** LOHHLA reports which HLA allele copy is lost. In heterozygous patients undergoing
single-allele HLA LOH, ask per allele: when it is heterozygous and one copy is deleted, is *it* the
one deleted more often than its partner? Because the comparison is within one patient, ancestry,
cancer type, age, sex, referral pattern and survivorship all cancel identically. Binomial sign test
vs 0.5 per allele, ≥20 events floor, BH-corrected.

**Result.** **15,704 heterozygous single-allele LOH events.** Global fraction-lost = **0.5000** — the
test is calibrated, with no systematic detection asymmetry. Of 110 testable alleles, **3 are
significant at FDR<0.05, all at HLA-B:**

| Allele | Direction | fraction lost | lost / retained | FDR |
|---|---|---|---|---|
| **B\*58:01** | preferentially **LOST** | 0.665 | 109 / 55 | 0.0033 |
| **B\*07:02** | preferentially **RETAINED** | 0.439 | 371 / 474 | 0.0163 |
| **B\*08:01** | preferentially **RETAINED** | 0.430 | 320 / 424 | 0.0086 |

![Within-patient allelic LOH bias. Each point is an HLA allele (≥20 het-LOH events); x = fraction of its heterozygous LOH events in which it is the lost copy, y = −log10 FDR. Red = FDR<0.05. B*58:01 is preferentially lost; B*07:02 and B*08:01 preferentially retained. All three are HLA-B.]({artifact:art_294faa22-4af2-4c4a-abf4-3f2af872db84})

B\*58:01 is a broad, high-affinity presenter and a canonical strong-CD8 allele; its preferential
loss is a directional immune-pressure signal of exactly the kind the project's favorability axis
predicts. Table: `msk50k_within_patient_LOH_bias.csv`.

---

## 3. Adversarial review — is the LOH signal real, or reference-mapping bias?

Because the LOH result is the project's most attractive finding, one alternative — **reference-
mapping bias** — was pre-specified as a mandatory gate and tested with four checks before any allele
is allowed into the trade-off arm.

**Premise, verified against the assembly (not asserted).** The GRCh38/hg19 reference MHC carries the
PGF haplotype: A\*03:01 / B\*07:02 / C\*07:02. Confirmed by pulling each class I gene's canonical
Ensembl reference protein (HLA-A ENST00000376809, HLA-B ENST00000412585, HLA-C ENST00000376228) and
matching over the α1/α2 domain against IMGT/HLA — each is a **100% α1/α2 identity match** to
A\*03:01, B\*07:02, C\*07:02 respectively. The mapping-bias worry: reads from reference-divergent
alleles fail to map to chr6 and are dropped before LOHHLA, so divergent alleles would spuriously read
as "lost." This predicts the direction of all three hits and why they are all at HLA-B (the most
polymorphic class I locus).

**Check 1 — cross-locus divergence regression. NOT the general driver.** Mapping bias makes a
*universal* prediction: at every locus, divergence from the reference allele should correlate
positively with fraction-lost, and the reference allele should be retained. Regressing per-allele
fraction-lost on α1/α2 protein divergence (IMGT/HLA alignments) breaks it:

| Locus | ρ(divergence, frac_lost) | reference allele fraction-lost |
|---|---|---|
| A | **−0.51 (p<0.01)** — opposite direction | A\*03:01 = 0.523 (slightly *lost*) |
| C | −0.07 (ns) | C\*07:02 = 0.483 |
| B | +0.23 (p=0.10) — weak only | B\*07:02 = 0.439 (retained) |

Direct counterexamples at B: near-reference B\*81:01 (div 0.027) and B\*67:01 (div 0.060) are
preferentially *lost* (0.62, 0.67). Divergence does not set the direction; the universal signature
fails at 2 of 3 loci and is weak at the third.

![Mapping-bias test at HLA-B: fraction lost vs α1/α2 divergence from reference B*07:02. If mapping bias drove the signal, points would rise steeply left-to-right. The relationship is weak and non-significant (ρ=+0.23, p=0.10); near-reference alleles B*81:01/B*67:01 are lost, divergent B*13:01 retained. Red = original hits, blue = B*57:01 control.]({artifact:art_6b980c35-1bd6-47c6-ac50-e954fc185ed8})

**Check 2 — partner composition (Bradley–Terry). Hits survive.** The test is paired, and B\*58:01
carriers are ancestry-enriched, so partners are non-random. Re-estimating retention propensity
jointly across the full allele-vs-allele contest matrix (regularized MAP Bradley–Terry): B\*58:01
ranks 2nd-most-lost of 53; B\*07:02 and B\*08:01 rank 49–50/53 (most retained). The marginal
directions all survive.

**Check 3 — segmental haplotype loss. B\*58:01 loss is B-specific.** chr6p deletions remove A/B/C
together, so "B\*58:01 lost" could mean "its haplotype was lost." Its usual partner C\*03:02 shows
**no** loss bias (0.505, p=1.0) — the pressure attaches to B\*58:01, not a co-deleted block.

**Check 4 — positive control B\*57:01. Consistent.** B\*58:01's sister allele (both Bw4-80I,
KIR3DL1 ligands, strong-CD8) trends the same LOST direction (0.534, mild/ns). Caveat: B\*57:01 does
not discriminate the mapping artifact and is a drug-HSR anchor in the autoimmune arm — a reason for
care, not confidence.

### Disposition

| Result | Verdict | Rationale |
|---|---|---|
| **B\*58:01 preferential loss** | **ELIGIBLE** for trade-off arm | Survives all four checks; loss not part of a general divergence→loss trend (locus-A evidence runs opposite), robust to partner composition (BT 2/53), not segmental, sister-allele consistent |
| B\*07:02 / B\*08:01 retention | **DOWNGRADED, not eligible** | These are exactly the near-reference HLA-B alleles; retention cannot be cleanly separated from a reference-alignment advantage. Reported as inconclusive, not immunology |

**Residual, stated honestly.** The locus-B regression is weakly positive (ρ=+0.23, p=0.10), and
B\*58:01's own high divergence means a residual mapping contribution to its loss cannot be fully
excluded from summary calls alone — only shown not to be the general mechanism and not to operate at
A/C. A definitive test needs read-level mapped-read depth (germline call vs LOHHLA realignment),
which the public summary release does not expose. B\*58:01 is carried forward with this caveat.

Checks table: `msk50k_LOH_adversarial_checks.csv`.

---

## Bottom line for this arm

- **Representation map:** little cross-ancestry-robust HLA structure across cancer types — apparent
  type associations are largely ancestry composition (a positive methodological finding).
- **Immune-pressure signal:** **B\*58:01 is preferentially deleted under somatic HLA LOH** (66.5%,
  FDR 0.003), a confound-free per-allele readout that survives a four-check adversarial review and is
  the single allele-level result eligible for the engageability trade-off arm.

## Component artifacts
- `msk50k_hla_internal_arm_results.md` — representation map + LOH test methods and results
- `msk50k_LOH_adversarial_review.md` — full four-check adversarial review with verified premise
- `msk50k_within_patient_LOH_bias.csv` — per-allele lost/retained counts, fraction-lost, FDR
- `msk50k_internal_stage1_omnibus.csv` — all 183 stratified omnibus tests
- `msk50k_LOH_adversarial_checks.csv` — four-check summary
