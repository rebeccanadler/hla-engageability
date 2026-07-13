# Infection arm — extension to non-HIV class I virus-control associations

Adds INDEPENDENT engageability contrasts from viruses other than HIV, because the HIV-only
anchor set is internally collinear: B*57:01/B*57:03/B*58:01 share the B58/Bw4 cluster,
B*27:05 recurs, and engageability is confounded with clade-C vs European ancestry. Sign
convention UNCHANGED: FAVORABLE = better viral control (protective). Harmonized `fav_sign`:
+1 protective, −1 risk — directionally comparable to cancer-favorable.

## Admission bar (stated, obeyed)
Every anchor cleared, BEFORE its engageability was inspected:
(a) CLASS I only — where a virus has both class I and class II signals, take only the class I
    allele; class-II-dominated associations excluded;
(b) WELL-ESTABLISHED — replicated in ≥2 cohorts or a meta-analysis, not a single case series;
(c) a VIRAL-CONTROL / CLEARANCE / PROGRESSION / INFECTION-OUTCOME phenotype.
Virus-driven-CANCER associations are QUARANTINED into a separate track (their outcome axis is
malignancy and would confound the project's own cancer arm). This was an independence-adding
move, decided on the bar and independence value, NOT on whether an anchor moved the trend.

## Candidate ledger (every candidate the search surfaced + decision)
ADMITTED to control axis (independent, non-HIV):
- **B*15:01 — SARS-CoV-2**, asymptomatic infection (rapid control), protective. Meta OR=2.40
  (95%CI 1.54–3.64, P=5.7e-5) across discovery + 2 independent cohorts. European/mixed.
  Augusto 2023 Nature 10.1038/s41586-023-06331-x. NEW LOCUS-INDEPENDENT anchor (B15, non-Bw4).
- **A*02:01 — HTLV-1**, HAM/TSP myelopathy risk / proviral load, protective (halves odds of
  HAM/TSP, P<0.0001). Kagoshima + replicated. Asian/mixed. Jeffery 1999 PNAS 10.1073/pnas.96.7.3848.
  NEW SUPERTYPE (A02) + new ancestry. NB Cw*08:01/B*54:01 (also cited protective/risk in HTLV)
  were NOT admitted as standalone anchors — the replicated, cross-cohort HTLV signal is A*02.
- **A*03:01 — HCV**, spontaneous clearance, protective (OR=0.36 chronicity, 0.15–0.89, p=0.027).
  Irish single-source + Swiss (Fitzmaurice 2015 Gut 10.1136/gutjnl-2013-306287); McKiernan 2004.
  NEW SUPERTYPE (A03).
- **C*04:01 — HCV**, viral persistence, RISK (OR=1.78, 1.21–2.59, codominant). Thio 2002 J Virol
  10.1128/jvi.76.10.4792. NEW LOCUS (HLA-C) — first C-locus control anchor in the arm.

FLAGGED RECURRENT (admitted but NOT counted as new independence — same allele already in HIV arm):
- **B*57:01 — HCV** clearance, protective (Thio 2002 OR=0.62 persistence). Recurs with HIV.
- **B*27:05 — HCV** clearance, protective (Fitzmaurice 2015 OR=0.12 chronicity, genotype-1).
  Recurs with HIV.

QUARANTINED — virus-driven CANCER outcome, reported but NOT in the control-sign axis:
- A*11:01 + B*13:01 (EBV/NPC resistance, directional), A*02:07 + B*46:01 (NPC susceptibility,
  directional) — all Asian/S.China GWAS, Tang 2012 PLoS Genet 10.1371/journal.pgen.1003103.
  Tang 2012 reports these at allele level as DIRECTIONAL (resistance/susceptibility); the paper's
  numeric ORs are SNP-level, so no allele-level OR is entered (direction_only). [An earlier draft
  carried a fabricated A*11:01 "OR=0.59, P=1.7e-19" not present in the fetched paper — removed.]
- A*01:01 (EBV+ Hodgkin lymphoma risk, OR=2.15) and A*02:01 (EBV+ HL resistance, OR=0.70),
  Hjalgrim 2010 PNAS 10.1073/pnas.0915054107. NB A*02:01 is HTLV-control-protective AND
  EBV-cancer-protective — same allele, but the EBV row is a malignancy phenotype (quarantined).

EXCLUDED (could not resolve to a replicated class I control effect): Cw*08:01/B*54:01 HTLV
(single-population / not present in several validation cohorts); HBV, HPV, dengue class-I signals
(class-II-dominated or not replicated at class I) — excluded and not padded into N.

## Result (report only — no pass/fail judgment)
- 4 new independent non-HIV control anchors (SARS-CoV-2, HTLV-1, HCV×2), spanning 2 new
  supertypes (A02, A03), a new B-locus family (B15, non-Bw4), and a new locus (HLA-C), across
  3 new ancestries.
- Composite engageability_A vs control sign: HIV-only ρ=−0.49 (p=0.08); non-HIV ρ=−0.26 (p=0.74);
  pooled 18 unique alleles ρ=−0.40 (p=0.10). Composite stays negative (risk alleles more engageable),
  still non-significant.
- z_het (VARIABLE crest heterogeneity), the feature that carried the HIV-only positive trend:
  HIV-only ρ=+0.15; non-HIV ρ=−0.77; **pooled ρ=−0.03 (p=0.89)** — the independent anchors do
  NOT reproduce the z_het trend; pooling collapses it to null.

## Reproducibility
Environment: python (pandas, numpy, scipy, pypdfium2, matplotlib). AFND freqs via the same
urllib scraper (page-1 ~100-population sample; afnd_freqs_infection2.json). Sources fetched via
Unpaywall / Semantic Scholar / PMC. Artifacts: tradeoff_infection_arm_multivirus.csv,
afnd_freqs_infection2.json, fig_infection_arm_multivirus.png.
