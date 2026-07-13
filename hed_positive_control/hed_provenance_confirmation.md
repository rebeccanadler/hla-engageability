# HED TABLE PROVENANCE CONFIRMATION
# All facts below read directly from saved artifacts this session. NOTHING RECOMPUTED.

## Source and scope (from methods_hed.md, unchanged)
- Database: IPD-IMGT/HLA protein alignments (ANHIG/IMGTHLA GitHub).
- Release: **IPD-IMGT/HLA 3.64.0**, tag `v3.64.0-alpha`, dated 2026-04-16
  (confirmed verbatim from `imgt_release_version.txt`).
- PBD scope: **exon 2 + exon 3 = α1/α2, mature residues 1–182** (α1 = 1–90, α2 = 91–182).
  Not expanded. Column-based slicing from the locus reference frame.
- HED(a,b) = Σ Grantham(a_i,b_i)/L; per-allele scalar = mean pairwise HED to all OTHER
  common alleles at the same locus.

## Retained set (from hed_per_allele.csv, version c6390124)
- **n retained = 676** common class I alleles: **A = 218, B = 331, C = 127**
  (confirmed by row count and per-locus value_counts this session).
- Columns present include both scope variants: `mean_HED` (182-residue, primary) AND
  `mean_HED_181scope` (181-residue, position-2–182 reference companion). Both reused
  verbatim.
- n_partners per allele = (locus n − 1) exactly: A = 217, B = 330, C = 126 — i.e. each
  allele's unweighted mean divergence is computed against every other retained common
  allele at its locus. Confirmed (min = max = expected for every locus).
- File sha256 (first 16 hex): 1c18249edaa33c8a. mean_HED range 3.872–11.113.

## Quarantined set (from flagged_alleles.csv, version 9a8363dd)
- **n quarantined = 7,860**, held out (not silently kept), with observed α1/α2 lengths and
  reason. Reason breakdown confirmed this session:
    - `partial_coverage(*)` = **7,859** (5′ missing-data run; fails the 90/92 length gate)
    - `genuine_deletion(in-frame)` = **1** (C*03:46, α1 = 89, a real single-residue α1
      deletion, correctly caught)
- Zero full-length (90/92) alleles sit in quarantine (rules out a numbering/registration
  bug), per the standing methods note.

## Confirmation of no recomputation
- `hed_per_allele.csv`, `hed_pairwise_{A,B,C}.csv`, `flagged_alleles.csv`,
  `cancer_arm_supertype_axis.csv`, `autoimmune_risk_axis_ranked.csv`, and
  `engageability_scores.csv` are consumed AS SAVED. No HED value, no outcome axis, and no
  engageability score is regenerated in this session. The only new computation is the
  frequency-weighted HED projection (a re-weighting of the existing saved pairwise HED
  matrix, not a re-derivation of HED) and the association/permutation statistics.
