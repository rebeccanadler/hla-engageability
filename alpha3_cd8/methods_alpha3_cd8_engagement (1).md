# α3 (EXON 4) CD8-CO-RECEPTOR-ENGAGEMENT GROUP — PRE-REGISTERED SPECIFICATION v2
# Committed BEFORE inspecting any α3 feature distribution, ΔΔG value, or cross-axis
# correlation. No feature or score uses HED, engageability, or any downstream outcome.
# No revision of footprint / features / directions / ε / template / weights after seeing results.

## 0. CONCEPT AND SCOPE
This is the THIRD labeled feature group of the surface-permissiveness programme, added by the
SAME pre-registration discipline as the α1/α2 helix-crest groups (see engageability_spec.md,
methods_tcr_facing_surface.md). It asks a DIFFERENT question from engageability: not how
permissive the α1/α2 TCR-docking crest is, but how the α3 (exon-4) domain engages the CD8
co-receptor.

The α3 CD8 interface in class I is LOW-AFFINITY and largely CONSERVED. We therefore expect a
priori that most alleles will be near-identical over the α3 CD8-contact footprint. Per the
mini-gate framing, a near-invariant α3 is a CLEAN reportable finding ("CD8 co-receptor
engagement is conserved / not allele-discriminating in class I"), carried separately — NOT a
failure. Nothing below is tuned to avoid that outcome.

Scope note (stated once, explicitly): this group is scoped to EXON 4 (the α3 Ig-like domain).
That EXCLUDES the known α2-domain CD8 contacts (≈ E128, Q115 in the α2 loop). This is the
α3-ONLY sub-footprint of the CD8 interface, not the full CD8 footprint. Stated as a deliberate
scoping choice, not an omission.

## 1. PRIMARY SCORE — structure-based CD8-engagement ΔΔG (EvoEF2)

### 1.1 Engine
EvoEF2 — an OPEN-SOURCE, FoldX-lineage empirical protein energy function
(https://github.com/tommyhuangthu/EvoEF2), built from source.
- GitHub commit hash (frozen): 38df01d305ed728ef067c3e0d22072058f33e255 (2023-05-06)
- Build: g++ -O3 -o EvoEF2 src/*.cpp (compiler version recorded in the build log artifact)
- Path used: BuildMutant (thread allele residues onto the template heavy chain) →
  ComputeBinding (change in the CD8–MHC interface binding energy).

EXPLICIT STATEMENT: EvoEF2 is NOT FoldX and NOT Rosetta. It is an open-source empirical function
in the same class (FoldX-lineage energy terms). It was chosen because FoldX (site/registration-
gated) and Rosetta/PyRosetta (license/conda-channel-gated) are both unreachable in this execution
environment, whereas EvoEF2 builds with no license or network gate and a reviewer can rebuild the
exact binary from the frozen commit. This is a reproducibility choice, stated up front.

OPTIONAL confirmatory cross-run (non-blocking): if a FoldX or PyRosetta (flex-ddG /
InterfaceAnalyzer) license is later provided, re-run ONLY the nonzero-ΔΔG threads through it and
report agreement in SIGN and RANK. The build does not wait for this.

### 1.2 Template(s)
Highest-resolution HUMAN CD8–MHC-I complex(es) from the human-only footprint set, with the α3
CD8-contact loop RESOLVED at the footprint positions. Seed: CD8αα–HLA-A2, PDB 1AKJ; a higher-
resolution human complex is used as primary if one is in the retained set. Record PDB ID,
resolution, chains, and the template heavy-chain α3 sequence.
- Report ΔΔG on ≥2 templates where available and state template-sensitivity (range across templates).
- ≥2-TEMPLATE FALLBACK: very few human CD8–MHC-I complexes exist with the α3 CD8-contact loop
  resolved. If fewer than 2 usable human templates are available, PROCEED with the single usable
  template and report template-sensitivity as UNAVAILABLE (a stated limitation), rather than
  blocking. NEVER substitute a non-human template to reach 2 (human-only; see §4).

### 1.3 Per-allele threading
After the distinct-footprint collapse (§3a), ΔΔG is computed ONCE per UNIQUE α3-footprint thread
(a handful, not 676×) and mapped back to member alleles. For each distinct thread, only the
footprint positions DIFFERING from the template are mutated onto the template heavy chain.
Run ≥3 replicates with FIXED seeds where the protocol is stochastic; report mean ± SD across
replicates.

### 1.4 Sign convention (stated once, explicitly)
engagement_ddG = ΔG_bind(allele) − ΔG_bind(template),
oriented so that MORE-NEGATIVE ΔΔG = STRONGER CD8 engagement.
Identical footprint sequence ⇒ ΔΔG = 0 by construction (a feature, not a gap).

### 1.5 Caveats (stated in methods; do not overclaim)
- EvoEF2 is an empirical, design-oriented energy function; its binding-ΔΔG has its OWN
  calibration/error. Cite EvoEF2's OWN benchmarks — do NOT borrow FoldX/Rosetta error bars.
- Noisier for MULTI-substitution threads than for single point mutations.
- Computed on ONE fixed crystallographic backbone per template (no backbone sampling).
- The CD8 interface is low-affinity and largely conserved ⇒ MOST alleles are expected to score
  ≈ 0. That near-zero spread is the expected, honest result and must NOT be inflated into signal.
- With only a handful of unique threads, this score is a MECHANISTIC ANNOTATION on the
  Grantham-magnitude grading (§3c), NOT an independent large-N axis. Reported as such.

## 2. DESCRIPTIVE SEQUENCE FEATURES (RETAINED but DEMOTED)
The three original α3 sequence features are RETAINED but DEMOTED to descriptive characterizations.
They are NOT combined into any directional composite (the withdrawn equal-weight signed composite
was undefined: only acidic charge carries a sign; the other two are undirected).

### 2.1 Acidic charge — TWO pre-registered position sets, both ALWAYS reported
Both position sets are frozen BEFORE inspection and both are always reported. Pre-registration-safe
because neither is selected on results. NB: classical α3 has NO indels, so EACH is a FIXED position
set across all alleles — only the RESIDUES occupying the positions vary (that variation is the
signal). A fixed position set is REQUIRED for cross-allele comparability.
  • footprint_acidic_charge (PRIMARY / default) — over the FULL derived α3 footprint;
    comparability-clean, no hand-picking.
  • CDloop_acidic_charge (mechanism-matched companion) — over the acidic-loop subset the footprint
    RECOVERS (the 223–229 region), defined EMPIRICALLY as footprint ∩ recovered acidic loop,
    NOT hand-typed from memory.
SAME EXPLICIT FORMULA for both (not prose):
    acidic_charge = (#Asp + #Glu) − (#Lys + #Arg)   over the position set,
oriented "more acidic ⇒ higher value ⇒ stronger CD8 engagement."
Role: MECHANISTIC cross-check on the ΔΔG — do the acidic-loop substitutions that move ΔΔG make
electrostatic sense? (§iii-b concordance check.)

### 2.2 footprint_heterogeneity (report, direction NEUTRAL/undirected)
Mean pairwise physicochemical distance among the footprint residues WITHIN an allele
(combining normalized charge, Kyte-Doolittle hydropathy, Zamyatnin side-chain volume — the SAME
scales and normalization as the crest crest_heterogeneity). Carried UNDIRECTED because
permissiveness-vs-restriction has no established sign at the co-receptor interface — report-don't-
assume.

### 2.3 footprint_conservation_deviation (report, undirected)
Per-allele deviation from the MODAL footprint sequence (count of footprint positions differing
from the modal residue), a direct read on whether α3 varies at all across alleles.

## 3. POLYMORPHISM IN ABSOLUTE UNITS (no divide-by-near-zero)
Because α3 is expected near-conserved, the axis is reported in ABSOLUTE units via three instruments:
(a) DISTINCT-SEQUENCE COLLAPSE — collapse retained alleles to unique amino-acid strings over the
    footprint. Report the number of distinct α3-footprint variants, each variant's allele
    membership, and its frequency. This distinct-variant count is the HONEST DENOMINATOR for the
    whole axis — stated BEFORE any per-allele number. It also bounds the ΔΔG compute.
(b) PER-POSITION VARIABILITY MAP — for each footprint position, the amino-acid distribution and
    its Shannon entropy across alleles (reuse the crest entropy tooling). Flag the specific
    positions carrying variation; these are where the axis has resolution.
(c) CHEMICAL-MAGNITUDE GRADING — for each allele whose footprint differs from the MODAL footprint,
    grade the difference by Grantham distance (the SAME published matrix as methods_hed.md,
    grantham_matrix.csv). Stays meaningful when most alleles score exactly 0 because it is an
    ABSOLUTE distance.

## 4. HUMAN-ONLY FOOTPRINT (Fix 3)
Footprint derivation (the 5.0 Å contact map and the ≥25% aggregation) uses ONLY human HLA class I
heavy chains. Non-human CD8–MHC-I structures (murine H-2, etc.) are EXCLUDED from the derivation —
different α3 numbering / loop composition would corrupt the pooled contact map — and may be
reported ONLY as a labeled, separate sensitivity. Chain assignment must EXCLUDE β2m and
peptide/TCR chains from the "CD8 chain" set (α3 packs against β2m; do not mislabel it).

## 5. EXON-4 COVERAGE GATE (Fix 4)
Do NOT assume all 676 alleles carry full-length exon 4 — IMGT covers exon 4 worse than exons 2–3.
Apply an explicit exon-4 length gate; QUARANTINE (do not silently drop) alleles lacking full-length
exon 4 to a flagged list with observed length + reason (mirror the HED 90/92 gate). Report the
RETAINED-N (true effective allele count for this axis) UP FRONT — per locus A/B/C — before any
downstream number. If materially below 676, that is a stated finding.

## 6. STANDARDIZATION, DEGENERACY RULE ε, AND PCA
### 6.1 Degeneracy rule (frozen, with the number)
ε = 0.05 (minimum pooled SD, in each feature's native units). Any feature with pooled SD < ε is
reported as its RAW distribution + a count of deviating alleles, and is EXCLUDED from z-scoring /
composite / PCA. Near-zero-variance correlations are reported but labeled UNINTERPRETABLE up front
(same move as the crest CONSERVED-group framing).
Rationale for ε = 0.05: on the native scales here — acidic charge in integer units of elementary
charge, Grantham-scaled distances, and count-based deviation — a pooled SD below 0.05 means fewer
than a handful of alleles deviate at all; z-scoring such a feature divides by ≈0 and manufactures
spurious extreme scores. 0.05 is set BEFORE seeing any distribution and is not tuned.

### 6.2 z-scoring (only for features clearing ε)
- Primary: z-score across all retained alleles pooled.
- Variant: within-locus z-score (mean/SD within A, B, C separately).

### 6.3 PC1 robustness variant
Run ONLY over features whose pooled SD exceeds ε; sign fixed on the HIGHEST-VARIANCE surviving
feature. If FEWER THAN 2 features clear ε, OMIT PC1 and say so explicitly.

### 6.4 No directional composite
There is NO equal-weight theory-signed α3 composite (withdrawn as undefined). The primary readout
is the ΔΔG (§1); the sequence features (§2) are descriptive; PC1 (§6.3) is the only multivariate
summary and only if ≥2 features clear ε.

## 7. AA PROPERTY SCALES (fixed, identical to the crest)
- Charge: D,E = −1; K,R = +1; H = +0.1 (partial, physiological); else 0.
- Hydrophobicity: Kyte-Doolittle (1982) hydropathy index.
- Volume: side-chain volume (Zamyatnin 1972), Å³.

## 8. CHECKPOINT — REPORT then STOP (actual values only)
(i)   FOOTPRINT: human-only structure set (PDB IDs, resolution, chains, organism, source_refs;
      excluded candidates + reason), footprint positions + contact-frequency support, ≥2-structure
      support per position, 0-mismatch landmark recovery, indexing-integrity check, exon-4 length
      gate result + RETAINED-N per locus (+ quarantine list).
(ii)  α3 POLYMORPHISM in absolute units: distinct-footprint count + membership + frequency;
      per-position entropy map; Grantham-magnitude of each variant vs modal; recovery (or not) of
      the VERIFIED known-functional α3 variants, with source_refs.
(iii) ENGAGEMENT ΔΔG: engine EvoEF2 + commit hash; template(s) + resolution + seeds + replicate
      mean±SD; number of UNIQUE threads scored; per-allele ΔΔG distribution, variance, per-locus
      SD; how many alleles score nonzero; template-sensitivity range or UNAVAILABLE; (optional
      FoldX/PyRosetta cross-run agreement, if run). PC1 only if ≥2 features clear ε.
(iii-b) MECHANISTIC CONCORDANCE: engagement_ΔΔG vs acidic charge across distinct threads (and the
      nonzero alleles) — Pearson + Spearman, using CDloop_acidic_charge PRIMARY and
      footprint_acidic_charge ALONGSIDE. Do MORE-acidic loops (higher acidic_charge) yield MORE-
      negative (stronger-engagement) ΔΔG? Report sign, flag agreement/disagreement. If the α3 set
      is near-invariant (≤2 distinct nonzero threads) label UNINTERPRETABLE. Report-only.
(iv)  CROSS-AXIS REDUNDANCY: correlation of engagement_ΔΔG and (separately) footprint_acidic_charge
      with HED and with the engageability composite (Pearson + Spearman, overall + per locus) —
      each flagged UNINTERPRETABLE if the α3 variance is ≈0 per the degeneracy rule.
Report the numbers only. Do NOT judge pass/fail, do NOT tune footprint / ε / template / weights to
a target, do NOT decide the narrative. The mini-gate is the user's call.

Descriptive-scale note: the engageability spread (A 0.796 > B 0.579 > C 0.298) is stated ONLY as a
descriptive scale reference, NEVER as a target. That is an allele-DISCRIMINATING metric's SD; a
conserved co-receptor axis is lower by construction.
