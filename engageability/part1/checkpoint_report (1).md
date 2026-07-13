# ENGAGEABILITY CHECKPOINT — NUMBERS ONLY
# Per instruction: report numbers, no pass/fail, no tuning, no decision to proceed.
# n = 676 common class I alleles (A=218, B=331, C=127); merged with HED n=676.

## (i) SPREAD / VARIANCE OF ENGAGEABILITY
Composite A (equal-weight, primary):  mean 0.000, SD 0.634, var 0.402, range [-2.420, 1.658], IQR 0.728
Composite B (PC1, robustness):        mean 0.000, SD 1.118, var 1.251, range [-3.489, 2.627], IQR 1.721
Per-locus SD (Composite A):           A 0.796, B 0.579, C 0.298
  (HLA-A most dispersed; HLA-C least — consistent with lower C polymorphism.)

Per-GROUP variance:
  VARIABLE composite variance:                 0.402
  CONSERVED composite variance (z-scored):     0.513
  VARIABLE raw features (var):  heterogeneity 0.0010, |net charge| 0.700, hydrophobic_imbalance 33.59
  CONSERVED raw features (var): heterogeneity 0.0000, |net charge| 0.0015, hydrophobic_imbalance 0.358
  CONSERVED-group cross-allele residue entropy: mean 0.036 bits (vs VARIABLE 1.108 bits), 31x lower.
  NOTE: the CONSERVED group's flatness is a DESIGN CONSEQUENCE (an allele-discriminating metric
  cannot draw signal from a near-constant feature group), NOT a substantive null about germline
  restriction determinants. (Raw CONSERVED features are near-constant; the z-scored composite
  variance ~0.5 reflects amplification of the handful of alleles that vary at all.)

## (ii) CORRELATION WITH HED  (format: Pearson / Spearman  |  181-scope  vs  182-scope)
Primary column = mean_HED_181scope; sensitivity column = mean_HED (182).

  Composite A (primary):            -0.021 / -0.038  |  -0.029 / -0.038
  Composite B (PC1):                +0.025 / +0.002  |  +0.002 / -0.009
  RAW var_heterogeneity:            -0.117 / -0.160  |  -0.087 / -0.140
  RAW var_abs_net_charge:           +0.214 / +0.172  |  +0.224 / +0.176
  RAW var_hydrophobic_imbalance:    -0.291 / -0.278  |  -0.256 / -0.257
  GROUP VARIABLE composite:         -0.021 / -0.038  |  -0.029 / -0.038
  GROUP CONSERVED composite:        +0.009 / -0.010  |  +0.012 / -0.010

  Scope sensitivity: 181 vs 182 changes every correlation by <=0.035 in |r|; orthogonality of the
  composites to HED does not depend on the scope choice.

## COMPOSITE A vs B AGREEMENT (no judgement)
  Overall: Spearman 0.925, Pearson 0.924
  Per locus: A (Spearman 0.979), B (0.954), C (0.829)
  Top-decile overlap: 56 alleles; Bottom-decile overlap: 59 alleles.
  Reading rule (pre-registered): Spearman >= ~0.8 => metric robust to blending choice; carry A
  primary, B confirms robustness. (Observed 0.925 >= 0.8.)

## VARIABLE-FEATURE INTERCORRELATION (|r|>0.7 flagged)
                           var_heterogeneity  var_abs_net_charge  var_hydrophobic_imbalance
var_heterogeneity                      1.000              -0.054                      -0.01
var_abs_net_charge                    -0.054               1.000                       0.24
var_hydrophobic_imbalance             -0.010               0.240                       1.00
  |r|>0.7 flagged pairs: NONE (max |r| = 0.24, abs_net_charge vs hydrophobic_imbalance).
  Reading: the three VARIABLE features are near-orthogonal, so Composite A's equal weighting
  genuinely combines three independent dimensions (not a covert single dimension).

## (iii) PROXY vs DOCKING-GEOMETRY DIVERSITY (data-rich alleles)
  Tier-2 N: 8 alleles cleared >=5 structures; 5 cleared >=10; only A*02 is truly data-rich (n=127).
  Cross-allele proxy (Composite A) vs docking-angle SD:  Pearson r = +0.050 (p=0.91), Spearman = -0.167 (p=0.69), n=8
  Cross-allele proxy vs incident-angle SD:               Pearson r = -0.024 (p=0.96), Spearman = -0.095 (p=0.82), n=8
  Cross-allele proxy vs docking-angle IQR:               Pearson r = -0.156 (p=0.71), Spearman = -0.429 (p=0.29), n=8
  CONFOUND: n_structures vs docking_SD  Pearson r = +0.608 (more structures -> larger observed spread).
  => cross-allele calibration is UNPOWERED at n=8 and confounded by sample size.

  Within-allele (the "variability is the point" observation), A*02:01, n=127 TCRs:
    docking angle:  mean 48.0 deg, SD 19.4 deg, range [27, 169] deg
    incident angle: mean 10.7 deg, SD  8.6 deg, range [0, 72] deg
    => a single allele accommodates a wide docking-geometry range.

## INPUTS / PROVENANCE
  Structures: TCR3d class I (n=243 human) + STCRDab chain assignments (n=176 downloadable);
  docking angles cross-checked TCR3d vs STCRDab Pearson r=0.939, mean|delta|=1.3 deg.
  Sequences: IMGT/HLA 3.64.0, 676 CWD2 common alleles; A*02:01 extraction == PDB 1AO7 (0/182 mismatch).
  HED: prior project artifact hed_per_allele.csv (mean_HED_181scope primary, mean_HED 182 sensitivity).
