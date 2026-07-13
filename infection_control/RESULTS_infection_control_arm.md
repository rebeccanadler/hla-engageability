# Results — Infection / viral-control arm (divergent-allele-advantage / pathogen-defense arm)

This arm tests whether the engageability axis tracks **favorable viral control**, framing the
original evolutionary rationale that the cancer/autoimmunity trade-off extends: HLA class I
polymorphism is maintained by balancing selection for pathogen defense. If a single "immunogenic
potency" (engageability) axis drives effective anti-target immunity, favorable viral control
should carry the **same** sign as cancer-favorability and the **opposite** sign of autoimmune-risk.

**Sign convention (fixed once):** FAVORABLE = better viral control (protective / controller /
delayed progression / clearance), mapped so it is directionally comparable to cancer-favorable
(both = effective anti-target immunity).

**Bottom line (reported, no pass/fail — that call is the PI's):** across the cleanest replicated
class I infection associations, the **composite** engageability axis does **not** track favorable
control. A single VARIABLE-crest sub-feature (`z_het`) appeared to track control within the HIV-B
anchor set, but that signal **did not survive** the addition of independent non-HIV control
anchors — it collapsed to null on pooling. The arm is, on the present evidence, **muddy**, and per
the pre-stated rule the PI may report-and-drop it.

---

## 1. Primary data — HLA-B / HIV-1 control (strongest, most replicated class I infection signal)

14 anchors (12 HLA-B, 2 HLA-A); 9 carry a quantitative effect, 5 are direction-only. Two distinct
replicated primary sources (Pereyra 2010 controller GWAS; Gao 2001 five-cohort progression study)
plus one clade-C review (Goulder & Walker 2012). Every value was read from fetched primary-source
full text or abstract, never from memory. `favorability_rank`: 4 = strong protective → 1 = risk.

| rank | allele | direction | effect | scale | ancestry | source |
|---|---|---|---|---|---|---|
| 4 | B*57:01 | protective | 5.5 | OR_controller | European/mixed | Pereyra 2010 Science |
| 4 | B*57:03 | protective | 5.1 | OR_controller | African/cladeC | Pereyra 2010 Science |
| 3 | B*27:05 | protective | 0.43 | RH_progression | European/mixed | Gao 2001 NEJM |
| 3 | B*58:01 | protective | — | direction_only | African/cladeC | Goulder & Walker 2012 |
| 3 | B*81:01 | protective | — | direction_only | African/cladeC | Goulder & Walker 2012 |
| 2 | A*25:01 | protective | 2.6 | OR_controller | European/mixed | Pereyra 2010 Science |
| 2 | A*32:01 | protective | 1.6 (weak) | OR_controller | European/mixed | Pereyra 2010 Science |
| 2 | B*14:02 | protective | — | direction_only | European/mixed | Pereyra 2010 Science |
| 2 | B*52:01 | protective | — | direction_only | European/mixed | Pereyra 2010 Science |
| 1 | B*07:02 | risk | 0.5 | OR_controller | African/cladeC | Pereyra 2010 Science |
| 1 | B*35:02 | risk | 2.90 | RH_progression | European/mixed | Gao 2001 NEJM |
| 1 | B*35:03 | risk | 2.70 | RH_progression | European/mixed | Gao 2001 NEJM |
| 1 | B*53:01 | risk | 2.02 | RH_progression | African/cladeC | Gao 2001 NEJM |
| 1 | B*58:02 | risk | — | direction_only | African/cladeC | Goulder & Walker 2012 |

(OR_controller: OR>1 = better control. RH_progression: RH>1 = risk. Full provenance, CIs, P-values,
and AFND frequencies in `tradeoff_infection_arm.csv`; methods in `methods_infection_control_arm.md`.)

## 2. Engageability vs favorable control (HIV anchor set)

**Composite does not track control.** Protective anchors mean engageability_A = **+0.182** (n=9);
risk anchors mean = **+0.619** (n=5) — risk alleles sit *higher*, the opposite of the hypothesis
(Mann-Whitney U=9.5, p=0.090). Rank association:

| feature | Spearman ρ (vs favorability_rank) | p | n |
|---|---|---|---|
| engageability_A (composite) | **−0.167** | 0.568 | 14 |
| engageability_B (PC1) | −0.139 | 0.635 | 14 |
| **z_het** (VARIABLE crest heterogeneity) | **+0.502** | 0.067 | 14 |
| z_absnetchg (VARIABLE) | +0.365 | 0.199 | 14 |
| z_hydimb (VARIABLE) | −0.244 | 0.401 | 14 |
| con_heterogeneity (CONSERVED) | 0.000 | 1.000 | 14 |

The composite and its single VARIABLE driver (`z_het`) point in **opposite directions**: the
composite trends negative (risk alleles more engageable) while crest heterogeneity trends positive.

**Frequency / ancestry robustness (before vs after flagging).** HIV/HLA associations are among the
most population-confounded in the literature, so the association is reported before and after
frequency and ancestry flagging:

- `engageability_A` composite: raw ρ=−0.167 → freq-partial −0.215 → European/mixed-only −0.321
  (n=8) → HLA-B-only −0.237 → quantitative-effect-only −0.350. Negative, never significant.
- `z_het`: raw ρ=+0.502 (p=0.067) → freq-partial +0.491 → **HLA-B-only ρ=+0.632 (p=0.028)** — the
  positive sign survives flagging and strengthens within HLA-B.

Ancestry composition is balanced on favorability (African/cladeC n=6 mean rank 2.17; European/mixed
n=8 mean rank 2.13) but not on engageability (0.538 vs 0.188), i.e. engageability is partly
collinear with ancestry within the HIV set — the caveat that motivated the extension in §4.

![Infection-control arm (HIV): composite engageability does not track control (a); VARIABLE-crest heterogeneity trends with control (b).]({{artifact:47ab86c3-a800-4509-b2ab-a238e9ac0572}})

*Figure 1. (a) Engageability composite A by control direction, colored by ancestry flag; group
medians as grey bars (MWU p=0.09). (b) z_het vs favorability rank, HLA-B (circles) vs HLA-A
(triangles); dashed trend line. ρ shown for all anchors and HLA-B-only.*

## 3. Cross-phenotype (allele-wise antagonistic-pleiotropy signature)

Four alleles are HIV-protective **here** and autoimmune-**risk** elsewhere — the trade-off appearing
at the single-allele level (reported explicitly, **not** pooled or averaged):

| allele | HIV control | autoimmune risk (other arm) |
|---|---|---|
| B*57:01 | protective (rank 4) | abacavir HSR, OR≈1945 |
| B*27:05 | protective (rank 3) | ankylosing spondylitis, OR≈57.5 |
| B*58:01 | protective (rank 3) | allopurinol SCAR, OR≈79.3 |
| B*52:01 | protective (rank 2) | Takayasu arteritis, OR≈3.7 |

Both signs also recur (reported, not averaged): B*57:01 and A*32:01 are autoimmune-*protective* for
T1D; B*07:02/B*35:02 are HIV-risk but T1D-protective.

---

## 4. Extension — independent non-HIV virus-control anchors

The HIV-only set is internally collinear: B*57:01/B*57:03/B*58:01 share the B58/Bw4 cluster,
B*27:05 recurs, and engageability tracks clade-C vs European ancestry (§2). To test whether the
`z_het` trend generalizes, independent class I control anchors were added from **other viruses**.
Each cleared the same admission bar **before** its engageability was inspected: (a) class I only;
(b) replicated in ≥2 cohorts or a meta-analysis; (c) a control/clearance/progression phenotype.
Virus-driven-cancer associations were quarantined into a separate track.

**4 new independent control anchors** — new supertypes (A02, A03), a new B-family (B15, non-Bw4),
a new locus (HLA-C), and new ancestries:

| allele | virus | direction | effect | scale | ancestry | note |
|---|---|---|---|---|---|---|
| B*15:01 | SARS-CoV-2 | protective | 2.40 | OR_asymptomatic | European/mixed | independent |
| A*02:01 | HTLV-1 | protective | 0.50 | OR_HAMTSP | Asian/mixed | independent |
| A*03:01 | HCV | protective | 0.36 | OR_chronicity | European | independent |
| C*04:01 | HCV | risk | 1.78 | OR_persistence | mixed (US) | independent (first HLA-C) |
| B*57:01 | HCV | protective | 0.62 | OR_persistence | European/mixed | recurrent (also HIV) |
| B*27:05 | HCV | protective | 0.12 | OR_chronicity | European | recurrent (also HIV) |

Sources (each fetched this session): Augusto 2023 Nature (B*15:01 meta OR=2.40, 95%CI 1.54–3.64,
P=5.7e-5); Jeffery 1999 PNAS (A*02 halves odds of HAM/TSP, P<0.0001); Fitzmaurice 2015 Gut (A*03
OR=0.36; B*27 OR=0.12); Thio 2002 J Virol (Cw*04 OR=1.78; B*57 OR=0.62). A per-anchor
`verification` column in the CSV records exactly how each value was obtained.

**The independence test — the signal does not generalize.**

| feature | HIV-only | non-HIV | pooled (unique alleles) |
|---|---|---|---|
| engageability_A vs control sign | ρ=−0.49 (p=0.08, n=14) | ρ=−0.26 (n=4) | ρ=−0.40 (p=0.10, n=18) |
| **z_het** vs control sign | ρ=+0.15 (n=14) | ρ=−0.77 (n=4) | **ρ=−0.03 (p=0.89, n=18)** |

The composite stays negative and non-significant throughout. The `z_het` trend that carried the
HIV-only signal **flips sign** in the independent anchors and **collapses to null** when pooled —
consistent with the HIV-only `z_het` association having been an artifact of the collinear HIV
B-cluster rather than a generalizable engageability→control relationship.

![Multivirus extension: composite still does not track control (a); adding independent anchors collapses the z_het signal (b).]({{artifact:b9cc7279-c3e5-41ef-af7c-b460dae0a2a4}})

*Figure 2. (a) Pooled engageability composite vs control sign (18 unique alleles), colored by virus,
HIV-arm (circles) vs non-HIV (squares). (b) Spearman ρ of z_het vs control across scopes: HIV-only
→ non-HIV → pooled; the signal collapses from +0.15 to −0.03.*

### Quarantined track (virus-driven cancer — reported, NOT in the control-sign axis)

Kept out of the engageability→control axis because the outcome is malignancy and would confound the
project's own cancer arm. Reported for completeness only:

| allele | phenotype | direction | effect | scale |
|---|---|---|---|---|
| A*11:01 | nasopharyngeal carcinoma resistance | protective (cancer) | — | direction_only |
| B*13:01 | nasopharyngeal carcinoma resistance | protective (cancer) | — | direction_only |
| A*02:07 | nasopharyngeal carcinoma susceptibility | risk (cancer) | — | direction_only |
| B*46:01 | nasopharyngeal carcinoma susceptibility | risk (cancer) | — | direction_only |
| A*01:01 | EBV+ Hodgkin lymphoma risk | risk (cancer) | 2.15 | OR_EBVposHL |
| A*02:01 | EBV+ Hodgkin lymphoma resistance | protective (cancer) | 0.70 | OR_EBVposHL |

(NPC alleles are directional in Tang 2012 — no allele-level ORs in the paper. EBV+HL ORs from
Hjalgrim 2010 PNAS. Note A*02:01 is HTLV-control-protective *and* EBV-cancer-protective — same
allele, but the EBV row is a malignancy phenotype, so it is quarantined.)

---

## 5. Effective N and honest read

- **Effective N** is small: 14 HIV anchors (9 quantitative) + 4 independent non-HIV control anchors
  = **18 unique alleles** in the pooled independence test.
- The **composite** engageability axis does not track favorable viral control at any scope.
- The one positive sub-signal (`z_het`, HLA-B-only ρ=+0.63) was **HIV-B-cluster-specific** and did
  not replicate on independent viruses; pooling collapsed it (ρ=−0.03).
- Per the pre-stated MINI-GATE rule — *if the infection-control signal is muddy, report-and-drop so
  a shaky arm does not dilute the clean core* — the evidence here is **muddy**. This document
  reports the numbers; the report-vs-drop decision is the PI's.

## Artifacts referenced

- `tradeoff_infection_arm.csv` — 14-anchor HIV arm, full provenance + AFND frequencies + engageability
- `tradeoff_infection_arm_multivirus.csv` — 12-row non-HIV extension (control + recurrent + quarantine) with `verification` column
- `methods_infection_control_arm.md`, `methods_infection_arm_multivirus.md` — sign convention, sources, admission bar, tests
- `fig_infection_arm.png` (Figure 1), `fig_infection_arm_multivirus.png` (Figure 2)
- `afnd_freqs_infection.json`, `afnd_freqs_infection2.json` — scraped AFND allele frequencies
