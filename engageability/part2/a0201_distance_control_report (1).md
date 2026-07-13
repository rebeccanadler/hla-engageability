# A*02:01 CO-ENGAGEMENT — SPATIAL-CLUSTERING CONFOUND CONTROL — NUMBERS ONLY
# EXPLORATORY-AFTER-NULL. Uses ONLY the existing 127x26 contact matrix + 1AO7 structure. No new data.
# Tests whether the Tier-1b positive co-engagement result (within-VAR |phi| 0.331 > within-CON 0.247,
# p=0.007) is explained by VARIABLE crest positions being more spatially clustered on the helices.

## Q1 — ARE VARIABLE POSITIONS MORE SPATIALLY CLUSTERED? (Ca-Ca distance in 1AO7)
  All 26 crest positions have Ca in 1AO7 (author numbering == mature 1-182, verified 0-mismatch).
  Pairwise Ca-Ca distance (A), mean / median:
    within-VARIABLE  : mean 15.26  median 16.30  (91 pairs)
    within-CONSERVED : mean 17.19  median 18.80  (66 pairs)
    cross-group      : mean 16.50  median 17.53  (168 pairs)
  within-VAR vs within-CON: Mann-Whitney U=2433, p=0.043
  => YES, modestly: VARIABLE positions are ~1.9 A closer on average (a real but small clustering
     difference). The confound is present.

## Q2 — DOES THE CO-ENGAGEMENT DIFFERENCE SURVIVE DISTANCE CONTROL?
  Co-engagement depends strongly on distance: overall |phi| vs Ca-Ca distance Pearson r = -0.514
  (p=2.4e-23) — closer positions co-engage more, as expected. So distance MUST be controlled.

  OLS: |phi| ~ intercept + is_VARIABLE + distance   (within-group pairs, n=157)
    intercept    beta=+0.4870  SE=0.0374  t=+13.03  p<1e-4
    is_VARIABLE  beta=+0.0571  SE=0.0261  t=+2.19   p=0.030
    distance     beta=-0.0140  SE=0.0018  t=-7.54   p<1e-4
  Partial correlation (|phi| vs is_VARIABLE | distance): r=0.174, p=0.029

  Nonparametric distance-matched check (pairs in overlapping band 8-20 A):
    |phi| within-VAR = 0.330 (n=50) vs within-CON = 0.298 (n=26), Mann-Whitney p=0.244

  => MIXED / WEAKENED. Controlling for distance, the VARIABLE co-engagement effect:
     - SURVIVES the linear model (is_VARIABLE beta=+0.057, p=0.030; partial r=0.174, p=0.029),
       shrunk from the raw comparison (raw p=0.007 -> distance-adjusted p=0.030).
     - DOES NOT reach significance in the nonparametric distance-matched band (p=0.244).
  The positive co-engagement result is PARTLY, not wholly, attributable to spatial clustering:
  a residual group effect remains in the regression but is small and not robust to the
  distribution-free matched test. Numbers only; no adjudication.

## SINGLE-ALLELE CEILING (restated)
Within one allele the sequence is fixed; these footprints vary only by which TCR is bound. This
describes A*02:01 crest USAGE and cannot test the between-allele metric claim. No claim-upgrade.

## SCOPE
Exploratory-after-null, within A*02:01, n=127 TCRs; structure 1AO7. Interpretation is the user's call.
