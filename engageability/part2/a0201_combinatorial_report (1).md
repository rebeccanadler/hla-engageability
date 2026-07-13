# A*02:01 COMBINATORIAL FOOTPRINT PROBE — NUMBERS ONLY
# SECONDARY EXPLORATORY, EXPLORATORY-AFTER-NULL. Label as such throughout.
# Uses ONLY the existing 127 x 26-crest contact matrix (a0201_contact_footprints.csv). No new data.
# Two pre-specified tests, run exactly as committed; no threshold sweeps, no added tests.

## Rationale
Tier 1a marginal analysis found NO VARIABLE-vs-CONSERVED difference in per-position usage or
group-mean variance. Marginal null != joint null: the metric aggregates ACROSS positions, so
these tests ask whether the VARIABLE/CONSERVED distinction has a COMBINATORIAL signature the
marginal analysis is blind to.

## TEST 1 — FOOTPRINT-PATTERN LOADINGS (PCA on 127 x 26 crest contact matrix)
Size confound control (pre-specified):
  PC1 variance explained: 29.4%
  PC1 vs total crest-contact count: r = 0.969  => PC1 IS a SIZE axis, NOT a pattern axis.
  ACTION: PC1 EXCLUDED; pattern read from PC2 onward (as pre-specified).
  Pattern PCs retained: PC2-PC5 (>5% var each; cumulative 37.7% of total variance).

  Group |loading| comparison (RMS |loading| per position across PC2-PC5):
    mean VARIABLE  = 0.1603
    mean CONSERVED = 0.2035
    Mann-Whitney (two-sided) U = 54, p = 0.129   => NO significant difference
    (direction: CONSERVED marginally higher, not VARIABLE).

  Size-normalized variant (row-normalized presence/absence, PCA):
    PC1 var = 42.8%, PC1 vs size r = -0.302 (size largely removed).
    Pattern PCs PC1-PC4: mean |loading| VARIABLE = 0.1386, CONSERVED = 0.2106,
    Mann-Whitney U = 70, p = 0.487  => NO significant difference.

  ANSWER (Test 1): VARIABLE positions do NOT drive the footprint-PATTERN axes more than
  CONSERVED positions, in either the raw (size-controlled) or size-normalized PCA.

## TEST 2 — WITHIN-GROUP CO-ENGAGEMENT (phi coefficient on binary contact matrix)
  All 26 crest positions had non-zero variance (0 dropped).
  Mean within-VARIABLE  |phi| = 0.3312  (91 pairs)
  Mean within-CONSERVED |phi| = 0.2472  (66 pairs)
  Mean cross-group      |phi| = 0.2831  (168 pairs)
  within-VARIABLE vs within-CONSERVED: Mann-Whitney (two-sided) U = 3761, p = 0.007

  ANSWER (Test 2): VARIABLE positions ARE engaged in more COORDINATED sets than CONSERVED
  positions (higher within-group co-engagement, 0.331 vs 0.247, p=0.007) — a combinatorial
  signature the equal marginal variance (Tier 1a: 0.190 vs 0.200) did not reveal. Cross-group
  co-engagement (0.283) sits between the two.

## (iii) SINGLE-ALLELE CEILING (restated)
Within ONE allele the sequence is FIXED. These footprints vary only by which TCR is bound, not
by allele sequence. This probe therefore describes how TCRs USE the A*02:01 crest surface; it
CANNOT test the BETWEEN-allele metric claim (that sequence differences at VARIABLE crest
positions make alleles differ in TCR permissiveness). No claim-upgrade is licensed.

## SCOPE
Exploratory-after-null, within A*02:01, n=127 TCRs. Numbers only; interpretation is the user's call.
