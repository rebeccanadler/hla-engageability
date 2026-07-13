# ENGAGEABILITY METRIC — PRE-REGISTERED SPECIFICATION
# Committed BEFORE inspecting any feature distribution or HED correlation.
# No feature uses HED or any downstream outcome. No revision after seeing results.

## Concept
Engageability = how PERMISSIVE an allele's α1/α2 TCR-facing helix-crest surface is
to DIVERSE TCR docking. It is NOT a clone-specific contact set (footprints vary by
TCR/peptide — that variability is the point). It is computed on the VARIABLE
helix-crest positions (allele-discriminating), with the CONSERVED restriction-
determinant group carried SEPARATELY (expected near-invariant; see below).

## Surface (from Step 2)
- VARIABLE crest positions (n=14): 62,63,65,66,69,70,73,76,151,152,158,163,166,167
- CONSERVED restriction positions (n=12): 58,68,72,75,146,149,150,154,155,157,159,162
- These are HELIX-CREST residues (TCR docks on top), a DIFFERENT structural surface
  from HED's groove-floor/anchor-pocket residues, though in the same exons 2/3.
  => orthogonality to HED is a structural claim, stated explicitly.

## Amino-acid property scales (fixed, standard published values)
- Charge: D,E = -1; K,R = +1; H = +0.1 (partial, physiological); else 0.
- Hydrophobicity: Kyte-Doolittle (1982) hydropathy index.
- Volume: side-chain volume (Zamyatnin 1972), Å^3.

## FEATURES (theory-fixed DIRECTION; one-line mechanism each)
Computed WITHIN-allele across the crest positions (intrinsic to the molecule, NOT
catalog-relative). Direction = sign of hypothesized contribution to engageability.

1. crest_heterogeneity  (+)  A physicochemically VARIED crest surface presents more
   distinct local microenvironments -> accommodates a wider range of TCR docking
   solutions. Operationalized as the mean pairwise physicochemical distance among
   the VARIABLE crest residues within an allele (combining normalized charge,
   hydrophobicity, volume), i.e. within-allele dispersion of residue properties.

2. abs_net_charge  (-)  |net formal charge summed over VARIABLE crest residues|.
   A strongly net-charged crest imposes an electrostatic constraint that RESTRICTS
   which complementarily-charged TCR surfaces can dock; extremity = restriction.
   Direction negative: higher |net charge| => lower engageability.

3. hydrophobic_imbalance  (-)  |sum of Kyte-Doolittle hydropathy over VARIABLE crest
   residues| (deviation from balanced amphipathy). An extreme hydrophobic/hydrophilic
   crest biases docking toward a narrow complementary chemistry; extremity =
   restriction. Direction negative: higher imbalance => lower engageability.

## STANDARDIZATION
- Primary: z-score each feature across ALL 676 alleles pooled.
- Variant: within-locus z-score (mean/SD computed within A, B, C separately).

## COMPOSITES (on VARIABLE group; CONSERVED carried separately)
- COMPOSITE A (primary, equal-weight): mean of the z-scored, theory-SIGNED features:
      A = mean( +z[heterogeneity], -z[abs_net_charge], -z[hydrophobic_imbalance] ).
  No tunable weights.
- COMPOSITE B (robustness, PC1): first principal component of the standardized
  3-feature matrix (features entered in theory-signed orientation). Sign fixed so
  the loading on heterogeneity is POSITIVE. Report loadings and % variance explained.

## AGREEMENT & REPORTING (no judging, no tuning)
- Report Spearman & Pearson A vs B (overall + per locus); top/bottom-decile overlap.
- Report VARIABLE-feature intercorrelation matrix; flag |r|>0.7 pairs.
- Report per-group variance (VARIABLE vs CONSERVED).
- At checkpoint: HED correlation (Pearson+Spearman, mean_HED_181scope PRIMARY and
  mean_HED 182 sensitivity) for A, B, each RAW feature, and each GROUP separately.

## CONSERVED-GROUP FRAMING
The CONSERVED group is expected to be near-invariant across common alleles. Its
low variance is a DESIGN CONSEQUENCE (an allele-discriminating metric cannot draw
signal from a near-constant group), NOT a substantive null about germline
restriction determinants. Reported, carried separately, never tuned in.
