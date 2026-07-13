# HLA class I allele-specific LOH — results overview

**Cohort.** MSK-IMPACT 50k public release (Bandlamudi et al., *Cancer Cell* 2026; Zenodo 18445440). Analysis is **allele-level** on public summary/deposited calls. Class I only.

**Scope of this arm.** A frozen, pre-registered negative control (S11 §0) plus a descriptive characterization of allele loss-preference at HLA-A/B/C. No outcome axis, no engageability or HED joined as a variable, no S10 modeling. All p-values from exact permutation/flip nulls with fixed seeds; numbers reported without a verdict.

This write-up is split into three files:

- **`LOH_arm_00_overview.md`** (this file) — provenance, LOH-caller identity, event definition, event counts.
- **`LOH_arm_01_negcontrol_S11.md`** — the reference-divergence negative control (is apparent directionality a read-mapping artifact?).
- **`LOH_arm_02_loss_preference.md`** — frac_lost distribution, overdispersion, empirical-Bayes shrinkage, Bradley–Terry, nested/per-profile crest tests, paired conditional logistic, multiplicity, haplotype concordance, and the published-novelty delineation.

---

## 1. LOH caller identity and reference construction

Fetched from the named paper's STAR Methods and Key Resources (Bandlamudi et al. 2026, full text via PMC), not inferred:

- **Caller:** "Somatic HLA loss of heterozygosity was inferred using the LOHHLA algorithm" (ref 64; repo `github.com/mskcc/lohhla`).
- **Germline HLA typing:** MHC class I genotypes inferred using **POLYSOLVER** (default parameters).
- **Reference construction:** LOHHLA aligns reads to a **(b) personalized reference built from the patient's own germline HLA alleles** (this is the defining behavior of the LOHHLA algorithm as specified in its method source, McGranahan et al., *Cell* 2017, which the named paper cites) — **not** the GRCh38/PGF primary reference. The caller identity and POLYSOLVER germline-typing input are stated in the named paper; the personalized-reference build is from the cited algorithm source.

## 2. Event definition (traced through the artifact's own production code)

The per-allele loss table (`msk50k_within_patient_LOH_bias.csv`) never touches LOHHLA's numeric columns. It reads **categorical per-allele calls** (`HLA_A1_LOH … HLA_C2_LOH`, values `Loss` / `Unchanged` / missing) from `msk50k_samples.csv`, a straight pivot of the cBioPortal clinical export `clin_SAMPLE.json` — i.e. the calls as deposited.

An informative event at a locus requires:
1. the two germline alleles differ (**heterozygous**);
2. exactly one allele is called `Loss` and the partner `Unchanged` (discordant);
3. a per-allele floor of **n_total ≥ 20** informative events to enter the panel.

**No numeric QC** (`PVal`, `PVal_unique`, `UnPairedPval`, `propSupportiveSites`, `numMisMatchSitesCov`, coverage) is applied by this code — those fields are not in its input. The numeric→categorical threshold lives **upstream in the deposit**, per Bandlamudi STAR Methods (quoted verbatim): an LOH event is established when there is a significant copy-number-ratio difference between the two alleles at **PVal_unique < 0.001** and the absolute copy-number estimate for one allele is **< 0.5**. Tumors additionally passed FACETS QC and had LOHHLA run successfully (**n = 29,802 of 37,080** tumors).

## 3. Event-level table and counts

`msk50k_LOH_events.csv` — one row per informative within-patient event (`patient, locus, lost_allele, retained_allele`), rebuilt from the same source and logic as `frac_lost`.

| locus | informative events (all) | events used in BT (both contestants in panel, n≥20) |
|---|---|---|
| A | 5,706 | 5,578 |
| B | 4,842 | 4,629 |
| C | 5,156 | 5,106 |
| **total** | **15,704** | 15,313 |

---

### Artifacts (data & tables)

- `msk50k_LOH_events.csv` — event-level table (15,704 rows)
- `msk50k_within_patient_LOH_bias.csv` — per-allele loss-propensity table (110 alleles; upstream input)
- `frac_lost_distribution_perlocus.csv` — per-locus frac_lost summary
- `merged_loh_divergence.csv` — 110-allele merged table (divergence, frac_lost, crest profile, AFND freq)
