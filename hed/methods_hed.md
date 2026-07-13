# HED Pipeline — Methods Note
# Exon-2/3 Grantham HLA Evolutionary Divergence for common HLA class I alleles

## 1. Data source and version
- Database: IPD-IMGT/HLA protein alignments (ANHIG/IMGTHLA GitHub).
- Release: **3.64.0**, tag `v3.64.0-alpha`, dated 2026-04-16.
- Files: `A_prot.txt`, `B_prot.txt`, `C_prot.txt` (reference-anchored protein
  alignments), fetched from
  `raw.githubusercontent.com/ANHIG/IMGTHLA/v3.64.0-alpha/alignments/`.

## 2. Peptide-binding domain (PBD) scope
- HED is scoped **exactly** to the α1/α2 domains = exon 2 + exon 3, mature-protein
  residues **1–182** (α1 = 1–90, α2 = 91–182; IMGT mature numbering, position 1 =
  first mature residue). This is the published Pierini & Lenz (2018) / Chowell
  et al. (2019) HED definition and was NOT expanded.
- Slicing is done on **alignment columns from the reference frame**, not by
  counting residues in each allele's de-gapped sequence. The residue→column map
  is built from the locus reference by counting non-gap reference positions;
  columns for residues 1–90 and 91–182 are selected. An upstream indel therefore
  appears as a gap in a fixed column and cannot shift downstream indices.
- Gaps (`.`) are retained in the stored alignment. The FULL α1/α2 alignment
  (all columns) is preserved for the downstream engageability metric
  (`alpha1_alpha2_alignment.parquet` / `.fasta`), which draws on TCR-facing
  helix-crest residues — a distinct subset within the same exons.

## 3. Allele filtering and length-validation gate
- **Expression-suffix filter:** alleles whose name carries an N/L/S/Q/C/A
  expression suffix (null / aberrant / low / secreted / cytoplasmic /
  questionable) are dropped up front. 1,660 records dropped.
- **Length gate:** after column-based slicing, each allele must have exactly
  **90 non-gap residues in α1 AND 92 in α2**. Deviating alleles are QUARANTINED
  to `flagged_alleles.csv` with observed lengths and reason (not silently kept).
- **Retained:** A = 6,037; B = 7,485; C = 6,524 records (20,046 total).
- **Quarantined:** 7,860 (A 2,537; B 3,138; C 2,185). Cause breakdown:
  partial-coverage (5' `*` missing-data run) = 7,859; genuine in-frame deletion
  = 1 (**C*03:46**, α1 = 89 with no missing-data markers — a real single-residue
  α1 deletion, correctly caught). Zero full-length (90/92) alleles sit in
  quarantine (rules out a registration/numbering bug).

## 4. Cross-locus registration
- A/B/C are aligned against their own locus references in separate files and
  sliced independently. Before comparison the α1/α2 column ranges were verified
  to correspond to the same structural positions across loci: the conserved α2
  disulfide **Cys101/Cys164** sits at identical residue numbers in all three, and
  position 1 residue is G (A/B) or C (C). Column ranges differ per locus
  (different insertion-column counts) but structural positions agree
  (`crosslocus_registration.csv`).

## 5. Common-allele set
- Catalogue: **CWD 2.0.0** (Common and Well-Documented alleles v2.0.0), as
  bundled in nmdp-bioinformatics/py-ard (`pyard/loader/CWD2.csv`).
  [CIWD 3.0 was the original plan but is not available in a machine-readable,
  allowlisted-source form; CWD 2.0.0 is the reproducible community standard and
  the set is swappable by re-running the intersection with any 2-field list.]
- Steps: class I only → drop expression-suffix alleles → intersect with the
  RETAINED full-length set at 2-field resolution.
- **Result: 676 common alleles (A = 218, B = 331, C = 127).** 30 CWD2 common
  alleles were dropped because they exist in IMGT only as partial-coverage
  records (no full-length exon-2/3 at 2-field); 0 were absent from IMGT 3.64.
- Representative sequence per 2-field allele: all 4-field records of a given
  2-field common allele share an IDENTICAL exon-2/3 sequence (verified 0/676 with
  >1 distinct sequence); the canonical `:01:01` record (or lowest field) is used.

## 6. Grantham distance
- **Canonical published integer Grantham (1974) matrix** adopted (identical to
  the matrix bundled in the reference HLA-HED tool). A physicochemical-formula
  reconstruction (composition/polarity/volume; α=1.833, β=0.1018, γ=0.000399,
  ρ=50.723) matched it to ±1 for most cells but deviated up to ~10 for a few
  (e.g. D-W) due to ρ-constant rounding; the integer matrix is used for all final
  outputs for exact Chowell/Lenz comparability. Saved: `grantham_matrix.csv`.

## 7. HED computation
- HED(a,b) = Σ_i Grantham(a_i, b_i) / L over the L aligned PBD positions;
  identical positions contribute 0. L = 182 (task-specified 1–182 scope).
- Pairwise HED computed within each locus among common alleles →
  `hed_pairwise_{A,B,C}.csv`.
- Per-allele scalar = mean/median/min/max pairwise HED to all OTHER common
  alleles at the same locus → `hed_per_allele.csv`. This is a
  population-divergence proxy (allele-level breadth), not a per-individual
  (genotype) HED.
- Locus means: A = 7.15, B = 7.46, C = 5.20 (B > A > C ordering, consistent with
  known class I diversity).

## 8. Validation (see hed_validation.txt)
- **Algorithm reproduced the reference HLA-HED tool EXACTLY**: 561/561 shared
  allele pairs, max abs difference 1.8e-15.
- **Scope note:** the reference tool uses 181 residues (positions 2–182, dropping
  position 1); the task spec is 1–182 (182). Position 1 is invariant (G) in A/B
  but polymorphic (G/C) in C. Impact on per-allele mean HED: A/B negligible
  (mean|Δ|≈0.04, rank r=1.000); C small (mean|Δ|=0.30, rank r=0.950).
  `hed_per_allele.csv` carries both `mean_HED` (182, primary) and
  `mean_HED_181scope` (companion for direct reference comparison).
- **Internal checks:** HED=0 for alleles with identical exon-2/3 differing only
  outside the PBD (e.g. A*02:01/A*02:09, B*44:02/B*44:27); Grantham matrix
  reproduces published cell values.
- **Chowell 2018 anchor survival:** all 6 Chowell driver alleles + 6 autoimmune
  anchors (B*27:05, C*06:02, B*51:01, A*29:02, B*57:01, B*15:02) are RETAINED at
  full length (see allele_status_validation.csv).

## 9. Environment
- Python 3.11; pandas, numpy, scipy, matplotlib; pyarrow; py-ard 0.9.1 (CWD2
  catalogue only). IMGT/HLA 3.64.0.
