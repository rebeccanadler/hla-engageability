# A*02:01 RESIDUE-LEVEL MECHANISM PROBE — NUMBERS ONLY
# EXPLORATORY, POST-CHECKPOINT, NOT PRE-REGISTERED. Label as such throughout.
# Within-A*02:01 mechanism probe on n=127 TCR-pMHC complexes. NOT a cross-allele
# validation. Does NOT license "docking-diversity-calibrated" language for the metric.

## Method
- All 127 inventoried A*02:01 complexes used; none reduced, rarefied, or subsampled.
- Per structure: MHC heavy chain identified by sequence alignment to A*02:01 alpha1/alpha2
  (author numbering -> mature 1-182). TCR chains = the two non-MHC, non-beta2m protein
  chains (90-260 aa) with the most heavy-atom contacts to the MHC. beta2-microglobulin
  explicitly excluded by sequence (else it contaminates the alpha1/alpha2 UNDERSIDE
  floor positions 92-97/115-122, which are b2m contacts, not TCR).
- Contact = any MHC alpha1/alpha2 residue with a heavy atom <=5.0 A from any TCR atom.
- Output: 127 x 182 binary contact matrix (a0201_contact_footprints.csv).
- Mean footprint size: 19.6 alpha1/alpha2 residues per TCR.
- 7 complexes contact ZERO crest positions (atypical / non-canonical docking, incl. the
  reversed-polarity 6vm7/6vm8/6vmc and b2m-side 6uk2/6uk4 TCRs); RETAINED, not dropped.

## (i) CONTACT FREQUENCY BY POSITION GROUP (fraction of 127 TCRs)
                 n     mean   median    min    max
  VARIABLE crest 14   0.651   0.732   0.260  0.890
  CONSERVED crest 12  0.615   0.618   0.307  0.898
  other alpha1/alpha2 156  0.020   0.008   0.000  0.268
  => TCRs concentrate on BOTH crest groups (~32x the rest of the alpha1/alpha2 surface).
     Whether they favour VARIABLE vs CONSERVED positions: essentially equal (0.651 vs 0.615).

## (ii) ACROSS-STRUCTURE CONTACT VARIANCE BY GROUP  [p(1-p), max 0.25 at p=0.5]
                 mean   median    min    max
  VARIABLE crest 0.1899 0.1942  0.098  0.250
  CONSERVED crest 0.2004 0.2226  0.092  0.249
  other alpha1/alpha2 0.0179 0.008  0.000  0.196
  VARIABLE vs CONSERVED: Mann-Whitney U (V>C, one-sided) U=70, p=0.764 -> NO difference.
  crest (both) vs other:  Mann-Whitney p=9.4e-17; crest variance ~10.9x the background.
  => TCRs use the crest surface VARIABLY (variability is the point), but that variability
     is NOT preferentially located at the VARIABLE-SEQUENCE positions. The metric's
     VARIABLE/CONSERVED split (built from cross-allele sequence entropy) does NOT map onto
     differential structural-usage variability WITHIN A*02:01. Both crest groups are used
     variably; the sequence-conserved restriction positions are contacted just as variably
     as the sequence-variable crest positions.

## (iii) WITHIN-ALLELE CREST USAGE vs DOCKING GEOMETRY  (n=127, 127 with docking angle)
  var_crest_used vs |docking-angle deviation from median|: Pearson r=-0.257 (p=0.003), Spearman=-0.269 (p=0.002)
  var_crest_used vs docking angle:  Pearson r=-0.202 (p=0.023), Spearman=-0.223 (p=0.012)
  var_crest_used vs incident angle: Pearson r=-0.232 (p=0.009), Spearman=-0.195 (p=0.028)
  => TCRs at MORE extreme/unusual docking geometries use FEWER VARIABLE crest positions
     (negative correlation), i.e. geometric diversity does NOT co-locate with heavier
     variable-crest engagement within this allele; if anything the opposite. Descriptive.

## SCOPE STATEMENT (explicit, per instruction)
This is a WITHIN-A*02:01 mechanism probe on n=127 TCRs. It is NOT a cross-allele validation
of the engageability ranking, and it does NOT license "docking-diversity-calibrated" language
for the metric. Interpretation is the user's call.
