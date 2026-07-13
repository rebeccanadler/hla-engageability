# CIRCULARITY AUDIT
# Cohort provenance of the two quantities the positive control links, and whether they overlap.
# All facts fetched this session from the primary full texts.

## Supertype log-HR axis (the cancer-arm OUTCOME)
Source: **Chowell et al. 2018, Science (aao4572)**. The B44 (favorable) / B62 (unfavorable)
supertype hazard ratios that define `cancer_arm_supertype_axis.csv` come from that paper's
two independent MELANOMA cohorts. Its cohort 1 (n=369; 269 advanced melanoma + 100 NSCLC)
was assembled from previously reported series — cited as Rizvi 2015 (ref 10), Snyder 2014
(ref 11), and **Van Allen et al. 2015 (ref 12)** — plus a second pan-cancer cohort 2
(n=1166). The supertype survival result: B62 HR=2.29 (95% CI 1.40–3.74, P=0.0007), and the
B62 signal was driven by HLA-B*15:01 (HR=2.21, 95% CI 1.33–3.70, P=0.002). [fetched:
Chowell 2018 Science]

## Published HED–ICB effect (the effect the control is meant to be able to recover)
Source: **Chowell et al. 2019, Nat Med (0639-4)**. The headline HED effect (HR=0.47, 95% CI
0.26–0.82, P=0.0072) was estimated in "**cohort 1**", which the paper's Methods state
explicitly is the **Van Allen et al. 2015** metastatic-melanoma anti-CTLA-4 cohort (n=100).
[fetched: Chowell 2019 Nat Med]

## Overlap determination
**The underlying patient cohorts OVERLAP.** Chowell 2019's HED cohort 1 (Van Allen 2015) is
one of the exact melanoma series that Chowell 2018's supertype cohort 1 was built from; both
papers are from the same group (MSKCC, Chan lab) and reuse the same public ICB melanoma
cohorts (Van Allen 2015, Snyder 2014, Rizvi 2015). The supertype-favorability axis used here
and the published HED–ICB effect are therefore NOT derived from disjoint patients.

## Required sentence (written into the output)
**Because the supertype-favorability axis (Chowell 2018) and the published HED–ICB effect
(Chowell 2019) are estimated on overlapping patient cohorts, recovering an association
between HED and the supertype log-HR axis in this session is a DESIGN-CAPABILITY CHECK — a
test of whether the allele-level design can register a divergence signal that is known to
track ICB outcome in these same patients — and NOT an independent replication of the HED–ICB
effect. The recovered negative cancer-arm coefficient is not presented as validation of
HED.**
