# TCR-Facing Helix-Crest Surface — Position Definition

## Purpose
Defines the two labeled position sets on the class I α1/α2 domain used for the
ENGAGEABILITY metric. These are the TCR-facing HELIX-CREST residues (tops of the
α1 and α2 helices that the TCR docks on), a DIFFERENT structural surface from
HED's groove-floor / anchor-pocket residues even though both live in exons 2/3.
That "same domain, different surface" is the basis of the orthogonality claim
between engageability and HED and is stated explicitly here.

## Derivation (structure AND consensus)
1. STRUCTURE-DERIVED footprint: 176 human class I TCR-pMHC crystal complexes
   (STCRDab-assigned MHC/TCR chains; superset inventory from TCR3d, n=243).
   For each complex, MHC α1/α2 residues (mature 1-182, author numbering) with any
   atom within 5.0 Å of any TCR Vα/Vβ atom were flagged as contacts. Positions
   contacted in >=25% of structures define the TCR-facing footprint (26 positions).
2. CONSENSUS cross-check: the footprint recovers the canonical diagonal-docking
   germline-restriction determinants (R65 94%, A69 95%, Q155 97%, plus 66/68/72/
   150/151/154/158/159/167) reported in Rudolph/Stanfield/Wilson 2006, Feng 2007,
   Marrack 2008, and the eLife 2023 biophysical-compatibility analysis.
   `in_published_consensus` marks positions independently named in that literature.

## Group split (cross-allele entropy over 676 common alleles)
- VARIABLE helix-crest (n=14): Shannon entropy >= 0.30 bits across the 676
  common alleles — polymorphic crest positions that DISCRIMINATE alleles.
  {62,63,65,66,69,70,73,76,151,152,158,163,166,167}
- CONSERVED restriction-determinant (n=12): entropy < 0.30 bits — near-invariant
  germline TCR-contact positions.
  {58,68,72,75,146,149,150,154,155,157,159,162}

## Numbering & validation
- Mature-residue numbering (position 1 = first mature residue). Sequences from
  IMGT/HLA 3.64.0, length-gated to exactly 90 (α1) + 92 (α2) residues.
- LANDMARK ASSERTION PASSED: extracted A*02:01 α1/α2 residues match the
  crystallized A*02:01 sequence in PDB 1AO7 exactly at all 182 positions
  (0 mismatches), confirming no off-by-one in the residue map.
- Independent docking-angle cross-check: TCR3d vs STCRDab docking angles agree
  Pearson r=0.939, mean|Δ|=1.3° over 174 shared complexes.

## Note on the CONSERVED group
Expected to be near-invariant across common alleles (see entropies). Its flatness
is a DESIGN CONSEQUENCE — an allele-discriminating metric cannot draw signal from
a near-constant feature group — NOT a substantive null about germline restriction
determinants. Carried separately and reported, per pre-registration.
