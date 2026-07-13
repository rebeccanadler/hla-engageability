# S10 — LOH Arm, Stage A Results
### Pre-modeling audit of allele-level HLA class I loss in public MSK-IMPACT 50K

*Dataset: cBioPortal `msk_impact_50k_2026` / Zenodo record 18445440 (CC-BY-NC-ND-4.0).
Source study: Bandlamudi et al., *Cancer Cell* 2026 (PMID 41895280 †). Callers: POLYSOLVER
(2-field genotypes), LOHHLA / McGranahan 2017 (somatic HLA LOH), MHCflurry PHBR engine /
Marty 2017 PMID 29107334.*

> **Scope.** This is a **pre-modeling gate battery**. It establishes executability, data structure,
> and caller bias, and reproduces the published positive control. It does **not** compute any
> engageability × LOH-outcome quantity, fit any model, estimate the primary estimand, or make a
> go/no-go call. The engageability metric is untouched; Δ_ENG appears **only as a covariate** in the
> G4 bias correlations, never regressed on loss. The go/no-go decision is deferred.

---

## Summary of results

| Gate | Question | Result |
|---|---|---|
| **G0** | Is per-homolog LOH available, and homolog-level (not locus-agnostic)? | **PASS** — homolog-level confirmed; 29,799 scored, 7,554 (25.3%) with class I LOH |
| **G1** | Does the pipeline reproduce Bandlamudi Fig 6F–G (Δ_PHBR only)? | **PASS** — both hard-gate specificities reproduce |
| **G2** | What is genuinely novel vs prior work? | Only Δengageability→loss conditional on Δ_PHBR is not-present; not tested here |
| **G3** | How are losses structured; what is the true unit of power? | 41% of LOH patients lose all 3 loci; effective N = 12,696 independent events |
| **G4** | Is the LOH caller biased; how degenerate is the design? | 13/64 common alleles biased; caller keys on divergence; ~134 effective contrasts |

---

## G0 — Fields & executability

The per-homolog LOH field was **discovered on disk rather than assumed**. The digested
`HLA_{A,B,C}{1,2}_LOH` flag (values Loss / Unchanged) is the canonical per-homolog call, but it
is served through **cBioPortal clinical attributes**, not the Zenodo file dump (which ships only the
raw LOHHLA output). Both were fetched and reconciled. The homolog index "1/2" was found empirically
to correspond to the **alphabetical sort of the two allele names** at each locus — this mapping matched
the authoritative raw `LossAllele` direction in **100.0%** of loss loci (vs 61.5% under genotype-file
column order), and digested-vs-raw agreement on *whether* LOH occurred was 96.9%.

**LOH is homolog-level, not locus-agnostic — the arm is executable.**

| Quantity | Value |
|---|---|
| Patients in cohort | 48,179 |
| Tumors (samples) | 54,331 |
| HLA-genotyped patients | 44,229 |
| LOHHLA-scored patients | 29,799 (study reports 29,802; off-by-3) |
| Patients with ≥1 class I LOH | **7,554 (25.3% of scored)** |
| Per-locus patient loss (A / B / C) | 5,706 / 4,842 / 5,156 |

All loss calls fall at heterozygous loci (0 at homozygous loci), confirming the caller correctly
excludes homozygous loci from the loss denominator. *Amendment A1 logged: the digested field is real
and canonical but its location (cBioPortal, not the Zenodo dump) differs from what Amendment A1 asserted.*

---

## G1 — Positive control (hard gate): reproduction of Bandlamudi Fig 6F–G

Using **Δ_PHBR only** (no engageability), we asked whether the restricting HLA allele — the better
PHBR presenter of a mutant driver neopeptide — is preferentially lost under LOH among patients who
carry it and have LOH at that locus. The lost homolog was taken from the raw `LossAllele` field
(direction verified 100% against copy number in G0). Both hard-gate specificities reproduce.

![G1 positive control — preferential loss of the restricting HLA allele (Delta_PHBR only), reproducing Bandlamudi 2026 Fig 6F-G]({{artifact:art_9dd5bc65-c5cb-4364-8601-c673885da3e2}})

**KRAS G12V-not-G12D asymmetry (Fig 6F).** Among A\*11:01 carriers, the restricting allele is
preferentially lost for **G12V** (80.8% vs 45.4% in mutation-WT, OR = 5.06, p = 3×10⁻⁴) but **not for
G12D** (35.6% vs 47.1%, OR = 0.62, n.s.). The asymmetry matches the paper's mechanism: A\*11:01
presents G12V (PHBR best-rank 0.036) more strongly than G12D (0.107), so only G12V exerts the immune
pressure that selects for loss.

**R175H / A\*02:01 colorectal specificity (Fig 6G).** Preferential loss of A\*02:01 in TP53 R175H
carriers is significant in **colorectal** (82.6% vs 56.6%, OR = 3.64, p = 0.012) but absent in NSCLC
(OR = 1.17, n.s.) and pancreatic (OR = 1.40, n.s.) — the reported colorectal-specific pattern.

*Caveat on the wider panel: across all five trial neopeptides, the significant/non-significant split
tracks **carrier sample size** (R175H n = 72, G12V n = 26 vs R248W n = 16, Y220C n = 19), not
presentation strength — R175H is in fact the worst-presented peptide of the panel yet is significant.
The two hard-gate tests each turn on a within-mutation or within-cancer-type contrast and are robust
to this.*

**The pipeline is correct; the battery proceeds.**

---

## G2 — Novelty

A claim-by-claim provenance table was frozen **before** any modeling, tagging each claim
published-by-source, published-in-field, or not-present. The result: the PHBR engine and the
depletion result (carriage ~ log-PHBR) are **implementations/reproductions of Marty 2017**; the
Δ_PHBR→loss direction is a **generalization of Bandlamudi + Marty + McGranahan** (reproduced here as
the G1 control, not claimed as novel); HED and the antagonistic-pleiotropy trade-off are **credited
prior work**. The **only not-present (potentially novel) claim is Δengageability→loss conditional on
Δ_PHBR — the helix crest — and it is not tested in this Stage-A battery.** Full table: `g2_novelty.md`.

---

## G3 — Structure & effective N

![G3 — LOH breadth (loci lost per patient) and haplotype-level coordination of multi-locus loss]({{artifact:art_6143b2a6-a2b0-4c49-874a-d5af7d9780ca}})

**Breadth.** Among the 7,554 patients with class I LOH, loss is broad: 33% lose one locus, 26% lose
two, and **41% lose all three A/B/C loci** — a signature of coordinated, chromosome-6p-wide loss rather
than three independent selective events.

**Haplotype coordination.** For the 5,043 patients losing ≥2 loci, we tested whether the lost alleles
form a single A~B~C haplotype, using two-locus haplotype frequencies estimated by EM from the cohort
itself (n = 44,226 fully-genotyped patients). The EM recovered the canonical NMDP common haplotypes as
validation (A\*01:01~B\*08:01, the 8.1 ancestral haplotype; A\*03:01~B\*07:02; B\*07:02~C\*07:02).
**41% (2,052 / 5,043) of ≥2-loci losses are consistent with a single shared haplotype** (all pairwise
lost alleles in positive linkage, D′ > 0.1), i.e. plausibly one segmental deletion.

**Frozen event sets and effective N.** This structure forces a clean separation of the analysis units:

- **PRIMARY = focal LOH** (exactly one locus lost, both other loci heterozygous **and** retained; no
  phasing): **N = 1,866 events** (A = 1,011, C = 489, B = 366). 645 single-locus-lost patients were
  excluded because they were homozygous at another locus, where LOH is unscoreable.
- **SECONDARY = haplotype-level, unit = patient**: **N = 7,554**.
- **Effective N = 12,696 independent selective events** — not the 15,704 patient×locus loss rows,
  which overcount segment-wide loss (one 6p deletion is one event but three rows). The unit of
  statistical power is the independent selective event, and any downstream test must use PRIMARY
  (N = 1,866) or SECONDARY (N = 7,554), never patient×locus rows as if independent.

---

## G4 — Caller bias & degeneracy

![G4 — per-allele marginal loss frequency; 13/64 common alleles deviate significantly from 0.5]({{artifact:art_a6134869-98a5-4271-855a-a3d69c8dbf0e}})

**Per-allele marginal loss frequency (the single most informative diagnostic).** For each common
allele (≥100 het+LOH appearances), the fraction of appearances called *lost* should be 0.5 under an
unbiased caller. **13 of 64 common alleles deviate significantly (BH-FDR q < 0.05)**, in both
directions: some are preferentially kept / reference-like (A\*30:02 = 0.386, B\*08:01 = 0.413,
B\*07:02 = 0.434) and some preferentially lost (B\*58:01 = 0.707, B\*57:01 = 0.641).
**A\*02:01 is flagged — 0.542 (n = 2,123, q = 2×10⁻³), preferentially lost.** The caller is measurably
non-neutral, and A\*02:01 in particular is non-neutral, so any allele-level loss analysis must condition
on this marginal bias.

![G4 — LOH call rate rises with homolog divergence (left); Delta_ENG co-varies with divergence (right)]({{artifact:art_8f24878c-51f6-4550-a02c-e302b9a9320e}})

**The caller keys on divergence.** LOH-called loci have higher homolog α1/α2 (exon 2–3) divergence than
retained loci (Mann–Whitney p = 3×10⁻²³), and the LOH call rate in the lowest-divergence decile is 0.136
versus ~0.20 elsewhere — a mechanical detection floor when the two homologs are nearly identical (weak
B-allele-frequency signal).

**Δ_ENG co-varies with the very quantity the caller keys on.** Unconditionally (n = 82,515 het loci),
|Δ_ENG| correlates with homolog divergence at Spearman ρ = **0.367** (p < 10⁻³⁰⁰) and with
reference-likeness gap at ρ = 0.163. Because |Δ_ENG| is selected on divergence, and the caller detects
loss as a function of divergence, **Δ_ENG must enter any downstream bias model as an unconditional
covariate** — this is a bias diagnostic, not a test of Δ_ENG→loss (no such quantity is computed here).

**Degeneracy — event count is not power.** The 1,866 focal events reduce to 590 distinct allele-pair
contrasts, 311 supertype-level pairs, and a **Simpson effective ≈ 134 independent allele-pair
contrasts** — the raw event count overstates independent contrasts by ~14×. Supertype-identical alleles
share one engageability value, collapsing distinct contrasts further; the top-5 allele pairs (all at the
A locus) carry 13.6% of all events. **Power is bounded by ~130 effective contrasts, not 1,866 events.**

---

## What this arm establishes (and what it does not)

The data are executable at homolog resolution; the pipeline reproduces the published positive control
on both hard-gate specificities using Δ_PHBR alone; the loss structure is often segment-wide, so the
honest unit of power is the independent selective event (12,696), the focal set (1,866), or the patient
(7,554), never patient×locus rows; and the LOHHLA caller is measurably biased in a way that co-varies
with Δ_ENG. **These are the constraints any downstream engageability modeling must respect. No modeling,
primary estimand, or go/no-go decision is made here — that call is deferred.**

---

### Provenance
All inputs fetched-and-verified against Zenodo (the full CCF MAF cross-checked against Zenodo's
published md5 `1249ca252de6938148679edf230177cc`); PMID 41895280 verified live and bidirectionally via
NCBI E-utilities. Per-artifact checksums in `s10_checksums.sha256`; full ledger in
`s10_provenance_ledger.md`.

† *The source task document names "Bandlamudi 2026" without a PMID. PMID 41895280 was resolved
independently and verified live via NCBI E-utilities (esummary PMID→DOI and esearch DOI[AID]→PMID both
return 10.1016/j.ccell.2026.03.003, *Cancer Cell*); it is not transcribed from the source document.*

### Companion artifacts
- Battery (terse, per-value stamped): `s10_battery_report.md`
- Per-gate detail: `g0_fields_report.md`, `g1_positive_control_report.md`, `g2_novelty.md`, `g3_effective_n.md`, `g4_caller_bias_report.md`
- Frozen event sets: `g3_primary_focal_events.csv` (N=1,866), `g3_secondary_haplotype_events.csv` (N=7,554)
- Diagnostic tables: `g1_reproduction.csv`, `g1_r175h_by_cancer.csv`, `g2_novelty_table.csv`, `g4_caller_bias.csv`, `g4_covariate_correlations.csv`, `g4_degeneracy.csv`
- Provenance: `download_manifest.csv`, `s10_provenance_ledger.md`, `s10_checksums.sha256`
