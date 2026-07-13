# PRE-COMMITMENT — DIVERGENCE AXIS (HED) AS DESIGN POSITIVE CONTROL
# Written BEFORE fitting anything. Frozen. Nothing below is revised after seeing results.

## What this session is
Running the HED (HLA evolutionary divergence) axis through the cancer-favorability and
autoimmune-risk specifications UNCHANGED, as a DESIGN POSITIVE CONTROL — a calibration of
the design's ability to recover a known effect, NOT a new hypothesis test and NOT a
re-litigation of the engageability arm. Saved tables are reused exactly as they stand.
HED is NOT recomputed; the outcome axes are NOT re-derived; no specification is altered to
make the control pass.

## PRE-COMMITTED DIRECTION (the thing the control must recover)
The published direction is: **higher HED tracks FAVORABLE ICB outcome**, i.e. a
**NEGATIVE coefficient on supertype log-HR** (log-HR > 0 = unfavorable/worse ICB, per the
standing sign convention). A recovered NEGATIVE cancer-arm beta is the direction the
published literature predicts. This is committed here before any fit is run.

## TWO ALLELE-LEVEL PROJECTIONS OF HED — both pre-registered, both ALWAYS reported,
## neither selected on results
(a) **mean_HED_unweighted** — the projection already used in this project: mean Grantham
    divergence of allele i to all other catalogued common alleles at the same locus,
    exon 2–3 scope per the standing HED methods. Both 181 and 182 residue scopes reported
    (`mean_HED_181scope` primary-for-reference, `mean_HED` 182 companion), reused verbatim
    from `hed_per_allele.csv`.
(b) **mean_HED_freqweighted** — sum over j of f_j · d(i,j) using AFND per-allele
    frequencies. This is the EXPECTED divergence to the other allele carried by a random
    individual who carries allele i, and is therefore the correct allele-level projection
    of a quantity defined on a genotype PAIR. Frequency source, population set, and
    missing-f_j handling (quarantine-not-drop, with counts) are stated where it is built.

The unweighted projection is what the project has been using; the frequency-weighted one is
what the published estimand (genotype-pair HED) implies. **If they disagree, that
disagreement IS the finding** — it is reported, not reconciled.

## SPECIFICATIONS (identical to the engageability fit, row-for-row)
CANCER ARM: HED vs supertype log-HR, one row per fav-bearing member allele,
  supertype-clustered robust SE; 12-point supertype-level inverse-variance-weighted
  (w = 1/SE_logHR²) fit; raw and +log10(frequency); report beta, 95% CI, cluster-robust
  NORMAL p AND small-sample t p on stated df, **LEAD WITH THE t**; per-locus (A/B/C) and
  overall; both HED projections.
AUTOIMMUNE ARM: HED vs signed autoimmune risk RANK, Spearman, raw and +frequency.
  **LABELED DESCRIPTIVE, NOT A CONTROL** — there is no established allele-level
  HED-to-autoimmunity effect to recover, so a null here calibrates nothing.

## PERMUTATION / MINIMUM DETECTABLE EFFECT (the reason this session exists)
Holding outcome vectors fixed, permute the HED predictor ≥10,000× under each of:
  (a) 15 paired A/B anchors (Spearman); (b) 8 distinct supertype points (Spearman);
  (c) cancer-arm clustered/IVW specification (beta). Report two-sided 95th percentile of
  |statistic| under the null and the smallest TRUE effect detectable at 80% power,
  α = 0.05. Compare the smallest detectable effect to the fetched published HED effect
  WITHOUT softening.

## REPORTING DISCIPLINE
Report numbers only. Do NOT judge pass/fail. Do NOT decide the narrative. Do NOT tune the
scope, projection, or specification. No effect size / HR / p-value / cohort size is typed
from memory; any value not fetched this session is reported as UNVERIFIED.
