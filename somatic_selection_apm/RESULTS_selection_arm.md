# Somatic Selection in Antigen-Presentation Genes — Results

**Analysis arm:** endogenous selection on the antigen-presentation machinery (APM) in tumors, reconstructed from somatic mutation data. This arm is independent of the germline-HLA presentation arm; it asks a single question — *which APM genes carry a somatic signal of positive (driver-like) selection, and does that signal survive the confounds that inflate it?*

**Cohort:** TCGA MC3 public MAF (`mc3.v0.2.8.PUBLIC`), pan-cancer, 10,123 patients with genome-wide coding calls. Selection is quantified with **dNdScv** (Martincorena trinucleotide-aware dN/dS), fitted genome-wide (3.6M coding substitutions) so the neutral background is estimated from the whole exome, not from the gene set under test.

---

## 1. The naive "escape enrichment" test measures target size, not selection

The intuitive test — *do APM-mutated tumors have higher mutational burden than expected?* — is not target-size-neutral, and it fails. Fitting `APM_defect ~ log(TMB)` gives an odds ratio well above 1, but so does the identical model on a control set of ten large non-immune genes:

| Gene set | OR (per SD log-TMB) | 95% CI | n |
|---|---|---|---|
| APM (all 16 genes) | 6.02 | 5.30–6.83 | 10,123 |
| APM (MSK-panel subset) | 5.54 | 4.82–6.36 | 10,123 |
| MHC-I core defect | 6.09 | 5.27–7.02 | 10,123 |
| B2M mutation | 4.47 | 3.48–5.75 | 10,123 |
| **CONTROL (non-immune genes)** | **6.36** | **5.67–7.14** | 10,123 |

The control OR (6.36) **exceeds every APM OR.** APM mutations accumulate with mutational burden exactly as a length-matched non-immune background does — the enrichment is a property of how many bases each set presents to the mutational process, not of selection.

**This is provable in closed form.** For a gene set of total coding target *L* under a zero-selection Poisson process at per-base rate μ, the log-odds slope of "≥1 mutation" on log-burden is

> β_null(u) = u / (1 − e^(−u)),  u = μL,

which is **monotonically increasing in L**. The smallest set predicts the *lowest* OR. A high-precision simulation (1,500 draws per set, Monte-Carlo error < 0.6%) confirms the analytic ordering exactly — B2M (357 bp) → 4.55, MHC-I core → 5.08, MSK-9 → 5.09, APM-16 → 5.25, control (158 kb) → 5.93 — strictly ordered by *L*, with the control the largest. **The OR ordering is a target-size artifact and carries no evidence of immune escape.**

![Pan-cancer APM landscape and the target-size null]({{artifact:art_21e4c48b-5d0e-4baa-80ff-8b40d572a30e}})

*Figure 1. Pan-cancer APM mutation landscape (TCGA MC3). Raw mutation counts across the 16-gene APM set; the OR-vs-burden comparison against the length-matched non-immune control is the benchmark the "escape enrichment" claim rests on.*

---

## 2. dN/dS localizes selection to loss-of-function, and only in a few genes

dNdScv separates the substitution classes. Genome-wide, missense is essentially neutral (global wmis = 1.05) and truncating is weakly elevated (wnon = 1.19) — the exome-wide baseline. Against that baseline, the per-gene APM picture is:

- **Missense selection: absent across the APM set.** No non-quarantined APM gene reaches significant positive missense selection (all qmis > 0.05; the apparent JAK-family signals are truncating, not missense — JAK2 wmis = 0.85, qmis = 0.77).
- **Truncating selection: confined to loss-of-function of a small number of genes.** In the full cohort, B2M, HLA-A, HLA-B all show wnon > 11 (q ≈ 0); TAP1, JAK1, JAK2, IRF1 show weaker truncating signals (wnon 2–5, q < 0.05).

The HLA-A/B truncating values, however, are not usable as evidence — see §3 — and the JAK/IRF signals do not survive confound stratification (§4). The analysis therefore rests on **B2M**.

![Per-gene dN/dS across the APM set]({{artifact:art_e7fce685-7b6a-414b-9b9c-371b26509c76}})

*Figure 2. dNdScv per-gene selection (cv=NULL, genome-wide background). Truncating dN/dS by gene; the exome-wide neutral baseline (wnon ≈ 1.19) marked. B2M, HLA-A, HLA-B stand out on truncating loss; missense is neutral throughout.*

---

## 3. HLA-A/B truncating dN/dS is a reference-mismapping artifact; HLA-C is the negative control

The classical HLA loci are the most polymorphic in the genome, and short-read alignment to a single reference haplotype miscalls germline variation as somatic. Under `cv=NULL`, dNdScv models the background with a 192-trinucleotide substitution model only — **no term operates at the read-mapping level**, so mismapped calls surface as somatic truncating events invisibly. HLA-A and HLA-B are therefore **quarantined**.

A clean diagnostic separates artifact from signal. Mismapped calls are TMB-independent, whereas a genuine neutral background scales with TMB — so **excluding hypermutators inflates an artifact ratio but holds or deflates a real one.** Under real MSI-H / POLE exclusion (§4):

| Gene | Full-cohort wnon | MSI/POLE-excluded wnon | Direction | 95% CI (excluded) |
|---|---|---|---|---|
| HLA-A | 11.13 | **18.11** | RISES → artifact | [8.76, 41.53] |
| HLA-B | 15.45 | 13.97 | ~flat | [7.57, 27.24] |
| **HLA-C** | 4.13 | **1.87** | collapses → neutral | **[0.61, 4.78] — includes 1** |
| B2M | 14.46 | 9.74 | falls, stays high | [4.06, 25.10] — excludes 1 |

HLA-A rising and the least-polymorphic classical locus **HLA-C collapsing to a neutral 1.87 (CI includes 1)** is exactly what the mismapping hypothesis predicts, and is inconsistent with genuine selection at the classical loci. HLA-C is the built-in negative control. **B2M is the opposite case:** it falls under exclusion (real signal, partially TMB-correlated) but stays ~10× with a CI that excludes 1.

---

## 4. B2M loss-of-function is the sole selection signal that survives every confound

Two confounds inflate truncating dN/dS: **hypermutators** (MSI-H, POLE/POLD1) generate excess indels/nonsense across all genes, and **reference mismapping** (§3). The pre-committed test was: exclude real hypermutators and ask whether B2M survives.

Using real MSI status (MSIsensor ≥ 10 or MANTIS ≥ 0.4 from cBioPortal; 417 MSI-H of 8,409 typed) plus POLE/POLD1 exonuclease-domain mutants (129; P286R, V411L), **487 samples were excluded** — and critically, **45 of the 99 B2M-truncating carriers fell in this set.** After exclusion, on the surviving MSS/non-POLE tumors:

- **B2M truncating SNVs: dN/dS = 9.74, q = 3×10⁻⁴** (10 nonsense + 3 splice = 13 events; package CI [4.06, 25.10]).
- **B2M frameshift indels: dN/dS = 30.65, q = 1.3×10⁻¹⁰** — B2M's canonical escape lesion, ~3× stronger than the SNV signal and even more significant. (The 30.65 is computed on the 16 distinct/deduped indels dNdScv treats as independent, from 27 raw frameshift events in 24 patients; dNdScv collapses the recurrent chr15:45,003,781 CT-dinucleotide homopolymer deletion, which recurs in 12 patients, as likely non-independent — a conservative deduplication that can only lower the count.)
- **TAP1 does not survive:** MSS/non-POLE wnon = 1.99, q = 0.79 (8 events). "Does not survive" is not "is neutral" — its CI [0.83, 4.28] still admits selection; its full-cohort signal was hypermutator-driven.

**After quarantine and hypermutator exclusion, exactly one non-quarantined APM gene shows significant truncating selection: B2M.** The result is robust to the covariate choice — refitting with `cv="hg19"` genome covariates *raises* B2M truncating dN/dS to 12.86 (CI [5.71, 29.65]), so `cv=NULL` was the conservative setting.

![B2M survives real MSI/POLE exclusion; frameshift is the stronger signal]({{artifact:art_6d6cb04f-18a5-47d7-afe2-8d9db41bbaa7}})

*Figure 3. (A) Mismapping diagnostic: truncating dN/dS full-cohort vs real MSI-H/POLE exclusion. HLA-A rises (artifact), HLA-C collapses to a neutral 1.87 (negative control), B2M stays ~10× (CI excludes 1). (B) B2M truncating-SNV dN/dS (9.7, CI [4.1, 25.1], 13 events) vs frameshift-indel dN/dS (30.7, q≈10⁻¹⁰) — the frameshift signal is stronger and sits outside the SNV statistic.*

![B2M selection across stratifications]({{artifact:art_032ffd84-07ed-4b0a-9cf0-1b1644347235}})

*Figure 4. B2M truncating dN/dS across successive confound controls — full cohort, mutation-cap, hypermutator-proxy, and real MSI-H/POLE exclusion. The signal declines as confounds are removed but remains ~10× neutral and significant throughout.*

---

## 5. The panel blind spot is regulatory, not participatory — and is non-mutational

Splitting the APM set by function — **participation** (peptide-touching: PSMB8/9, TAP1/2, TAPBP, calreticulin, B2M, HLA-A/B/C) vs **regulation** (IFN-γ signalling / transactivation: IFNGR1, JAK1/2, STAT1, IRF1, NLRC5, CIITA) — resolves what targeted panels miss:

| Arm | Off-panel genes | Patient undercount (nonsilent) | Undercount (truncating) |
|---|---|---|---|
| APM-proper (participation) | PSMB8/9, TAPBP | **1.20×** | **1.07×** |
| Regulatory | STAT1, IRF1, NLRC5, CIITA | **2.34×** | 1.78× |
| All-16 (mixed) | (both) | 1.61× | 1.26× |

The large "panel undercount" is almost entirely a **regulatory-arm** effect; the participation arm is nearly panel-complete. Per-kilobase, B2M is the most densely mutated APM gene by a wide margin (457 muts/kb vs the next, HLA-B at 142/kb); **NLRC5's apparent top rank by raw count (378 mutations) is target size** — at 5,598 bp it falls to mid-pack (68/kb), and it shows no selection (wnon 1.27, q = 0.90).

**Corollary.** The one gene with truncating selection (B2M) is *on* the targeted panel. The panel blind spot therefore costs **zero detectable escape selection**, and the truncating undercount is an undercount of *passengers*. The panel argument survives only as: the panel cannot observe the transactivator arm (NLRC5/CIITA) at all — but that arm is plausibly inactivated by **promoter methylation or copy-number loss**, which mutation data cannot test *on or off* the panel. The panel gap is a non-mutational-mechanism gap, not a missed-somatic-variant gap.

![APM per-kb landscape by panel presence]({{artifact:art_aaa6277e-316d-4aaf-becc-f169fc06f02f}})

*Figure 5. (A) Raw mutation count vs per-kb density across the APM set, colored by targeted-panel presence; B2M leads on density, NLRC5's raw rank is target size. (B) B2M truncating dN/dS survives real MSI/POLE exclusion.*

---

## Summary of the finding

After removing (i) the target-size estimand artifact in the naive escape test, (ii) the HLA-A/B reference-mismapping confound (with HLA-C as the confirming negative control), and (iii) the MSI-H/POLE hypermutator confound, the **sole non-confoundable somatic selection signal in the antigen-presentation machinery is loss-of-function of B2M** — a monomorphic, on-panel, mapping-clean gene, driven by both truncating SNVs (dN/dS ≈ 9.7–12.9, CI excludes 1) and, more strongly, frameshift indels (dN/dS ≈ 30, q ≈ 10⁻¹⁰). No other APM gene — participatory or regulatory — carries a selection signal that survives these controls.

See `METHODS_selection_arm.md` for gene-set definitions, dNdScv configuration, the MSI/POLE exclusion protocol, and the derivation of the target-size null.
