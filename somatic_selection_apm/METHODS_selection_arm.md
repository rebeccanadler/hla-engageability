# Somatic Selection in Antigen-Presentation Genes — Methods

## Data

- **Somatic mutations:** TCGA MC3 public controlled-consensus MAF `mc3.v0.2.8.PUBLIC.maf.gz` (GDC file `1c8cfe5f-e52d-41ba-94da-f15ea1337efc`), pan-cancer, 10,123 patients with genome-wide coding calls. Used genome-wide (all coding genes) as the dNdScv input so the neutral background is exome-derived.
- **MSI status:** per-sample MSIsensor (`MSI_SENSOR_SCORE`) and MANTIS (`MSI_SCORE_MANTIS`) scores pulled from cBioPortal TCGA PanCancer Atlas studies (20 cohorts), 8,409 samples with a score. MSI-H defined as MSIsensor ≥ 10 **or** MANTIS ≥ 0.4 (417 samples).
- **POLE/POLD1 hypermutators:** exonuclease-domain missense mutants extracted from the MC3 MAF — POLE aa 268–471, POLD1 aa 304–517 (129 patients; recurrent P286R n=29, V411L n=20).
- **MSK-IMPACT arm (for panel-presence and the participatory/regulatory variant split):** somatic APM/HLA variant catalogue from cBioPortal `msk_impact_50k_2026` (5,604 variants, 3,348 patients, 10 panel genes).
- **Cross-cohort landscape:** cBioPortal mutation frequencies (11 TCGA WES cohorts + MSK-IMPACT) for the APM panel.

## Gene sets

**APM 16-gene set (dNdScv):** B2M, TAP1, TAP2, TAPBP, CALR, HLA-A, HLA-B, HLA-C, PSMB8, PSMB9, NLRC5, CIITA, STAT1, IRF1, JAK1, JAK2. (IFNGR1 is in the MSK catalogue but not the MC3-16 dNdScv set; ERAP1/2 are in neither.)

**Participation vs regulation split (§5 of Results):**
- *APM-proper (participation, peptide-touching):* PSMB8, PSMB9, TAP1, TAP2, TAPBP, calreticulin (CALR), B2M, HLA-A, HLA-B, HLA-C (ERAP1/2 conceptually here but absent from the data).
- *Regulatory (IFN-γ signalling / transactivation):* IFNGR1, JAK1, JAK2, STAT1, IRF1, NLRC5, CIITA.
This split is stated in Methods because it is a design decision, not a result: JAK1/2, IFNGR1, STAT1, IRF1, NLRC5, CIITA are signalling/transactivator genes, none of which touches a peptide, and are therefore reported separately from the antigen-presentation machinery proper.

**Non-immune control set (target-size benchmark):** ten large genes with no antigen-presentation role — PCLO, FAT1, FAT3, CSMD1, PKHD1, DNAH11, USH2A, DST, MACF1, HMCN1 — run through the identical escape-enrichment model as a length-matched null benchmark.

## dNdScv configuration

- Package: `dndscv` (im3sanger), RefCDS hg19 (`refcds_hg19.rda`).
- Exact call (primary): `dndscv(m, refdb="refcds_hg19.rda", cv=NULL, max_muts_per_gene_per_sample=Inf, max_coding_muts_per_sample=Inf)`, `m` = full genome-wide MC3 MAF (3,600,963 substitution rows). Because the background is fitted exome-wide, per-gene wmis/wnon/wspl/wind are relative to the genome-wide neutral rate, not to the gene set under test.
- `cv=NULL` (no genomic covariates) is the **primary, conservative** setting. Under `cv=NULL` the background is the 192-trinucleotide substitution model only; **no term controls replication timing, expression, or read-mapping** — a claim of any such control would be void, and reference-mismapping at the classical HLA loci is not absorbed (motivating the HLA-A/B quarantine).
- **Covariate sensitivity:** the analysis was repeated with `cv="hg19"` (default genome covariates). For sparse-synonymous genes like B2M the covariates shrink the background, *raising* B2M truncating dN/dS (9.74 → 12.86), confirming `cv=NULL` is conservative.
- **Per-consequence significance:** always read from the per-consequence columns — `qmis_cv` (missense), `qtrunc_cv` (nonsense+splice), `qind_cv` (indels) — never `qglobal_cv` for a class-specific claim. (An earlier misreading of qglobal as a missense q-value for JAK1/2 was corrected.)
- **Per-gene confidence intervals:** the package's own `geneci(dndsout, gene_list, level=0.95)` function, which requires the model to be fitted with `outmats=TRUE`. Reported CIs are geneci's, not hand-rolled Poisson scaling.

## Confound-control protocol

1. **Target-size estimand (escape enrichment).** The naive `APM_defect ~ log(TMB)` OR is benchmarked against the identical model on the non-immune control set. The null log-odds slope is derived in closed form, β_null(u) = u/(1−e^(−u)), u = μL, monotonically increasing in target size L; a 1,500-draw Poisson simulation per set (Monte-Carlo error < 0.6%) confirms the analytic ordering. Because the null OR increases with L and the control is the largest set, an APM OR is evidence of selection only if it exceeds the length-matched control — it does not.
2. **Reference mismapping (HLA-A/B quarantine).** HLA-A and HLA-B truncating dN/dS are excluded from all conclusions. HLA-C serves as the least-polymorphic-classical-locus negative control. Diagnostic: hypermutator exclusion inflates a TMB-independent mismapping artifact but holds/deflates a TMB-scaling real signal (§3, Results).
3. **Hypermutators (pre-committed test).** Real MSI-H (MSIsensor ≥ 10 or MANTIS ≥ 0.4) and POLE/POLD1 exonuclease-domain mutants excluded (487 samples). The `>1000-mutation` proxy used in an earlier pass was replaced with real MSI calls because MSI-H colorectal/endometrial tumors commonly carry 300–800 coding mutations and slip under a 1,000-mutation cut. Pre-commitment: B2M survives → escape truncation is not an MSI phenomenon; B2M collapses → escape truncation is an MSI phenomenon. Outcome: **survives** (SNV dN/dS 9.74, q = 3×10⁻⁴).

## Indel accounting (B2M)

`dndscv` models indels separately from substitutions (`wind_cv`/`qind_cv`), so the truncating-SNV statistic (wnon/wspl) does not include frameshifts. B2M frameshift events in the MSS/non-POLE set: 27 raw frameshift calls (26 Frame_Shift_Del + 1 Frame_Shift_Ins) in 24 patients; dNdScv collapses recurrent-identical calls (its "same mutations in different sampleIDs" deduplication) to 16 distinct independent indels — dominated by the recurrent chr15:45,003,781 CT-dinucleotide homopolymer-tract deletion (12 patients). The reported wind = 30.65 (qind = 1.3×10⁻¹⁰) is computed on those 16 distinct indels. This deduplication is conservative (it lowers the count and the dN/dS).

## Undercount computation

Patient-level undercounts compare distinct patients carrying ≥1 nonsilent (or truncating) mutation in a gene set, full 16-gene set vs the MSK-IMPACT panel subset. Reported per arm (APM-proper, regulatory, all-16) because the mixed all-16 ratio (1.61×) conflates a nearly-panel-complete participation arm (1.20×) with a panel-sparse regulatory arm (2.34×).

## Software / environment

- dNdScv in R 4.5.3 (conda env `r`; package installed to a workspace `rlib` via `install_github("im3sanger/dndscv")` + Bioconductor deps Rsamtools/GenomeInfoDb; RefCDS hg19 from the package data repo).
- Downstream statistics, the derived null, and figures in Python 3.13 (env `hla-a3`: statsmodels, scipy, pandas, matplotlib).

## Scope and non-claims

- This arm is deliberately isolated from the germline-HLA presentation arm; no immunoediting or antagonistic-pleiotropy interpretation is attached to it.
- HLA-A/B truncating dN/dS are reported only as a quarantined diagnostic, never as a finding.
- The hotspot/residue-level selection section is out of scope here (blocked pending separate structural annotation).
