# PRE-REGISTRATION — Does engageability predict the DIVERSITY of the TCR repertoire an allele recruits?
# VDJdb arm. FROZEN before any engageability↔diversity association is computed.
# Written and committed in frame d8dcd259; amendments A1–A4 / R1–R4 from the user folded in.

## 0. STATUS OF THIS DOCUMENT
This is the frozen analysis plan. No feature, threshold, index, clustering rule, or null is
revised after inspecting any engageability↔diversity association. Per the relaxation (A2/R1):
diversity indices and their sampling error ARE computed in this (blind) stage, because the
minimum detectable effect (MDE) needs the empirical measurement-noise scale — but **diversity
is joined to nothing, and no association is computed**. The stop is before any join of
engageability to diversity.

## 1. QUESTION AND SIGN CONVENTION
Does an allele's ENGAGEABILITY (permissiveness of its α1/α2 helix-crest surface to diverse TCR
docking; metric frozen in `engageability_spec.md`, composite `engageability_A`) predict the
DIVERSITY of the TCR repertoire it actually recruits, measured from observed TCR–pMHC pairs?

- SIGN CONVENTION: higher engageability → HIGHER recruited-TCR-repertoire diversity (positive
  predicted association).
- TWO-SIDED (rule 4): the test is two-sided. A significant NEGATIVE association is a
  FALSIFICATION of the permissiveness claim (a maximally permissive crest could instead select
  a single convergent docking solution), recorded as such — never reframed as a positive.

## 2. DATA
- PRIMARY and ONLY source: VDJdb. McPAS-TCR / IEDB are NOT pooled (they corrupt the reference
  structure the confound design controls).
- Release tag, commit SHA, and access date are RECORDED AT FETCH TIME in this session
  (fetched-or-flagged, rule 1). **No VDJdb version is named in this pre-registration.** Any
  number/tag/accession that cannot be retrieved this session is written FLAGGED-UNVERIFIED.
- Keep TRB rows with: CDR3-beta amino-acid sequence, V and J gene, class I MHC restriction,
  epitope, epitope source, VDJdb confidence score, and REFERENCE (study handle). Carry
  reference, donor (where parseable), antigen class as it appears in the table, and CDR3b length.
- Donor field availability in VDJdb is VERIFIED at fetch (non-blocking note): if donor is
  largely absent/unusable, `reference` is the only handle on study structure, which raises the
  stakes on the permutation-null design (A3).

## 3. FILTERS (frozen)
1. Class I only (HLA-A/B/C). Non-class-I, MHC class II, non-human excluded.
2. Confidence: `vdjdb.score >= 1` (score 0 excluded).
3. HLA resolution: keep only entries resolvable to a 4-digit (2-field) allele, e.g. HLA-A*02:01.
   2-digit / coarse / haplotype / serotype-only entries are EXCLUDED and COUNTED (reported in
   the filter waterfall).
4. Dedup rule: within each (allele, epitope), a clonotype is unique on (CDR3b aa, V gene, J gene);
   exact duplicates on that key collapse to one.
A filter waterfall reports rows retained/dropped at every step.

## 4. DIVERSITY MEASURE (frozen; computed blind, joined to nothing)
- PRIMARY index: mean pairwise NORMALIZED Levenshtein distance among CDR3b amino-acid sequences,
  normalized by the max of the two lengths (range 0–1), computed on RAREFIED sets.
- Scheme: WITHIN-EPITOPE then aggregate. For each (allele, epitope) with ≥ d TCRs, subsample to
  depth d, compute the mean pairwise normalized Levenshtein; average across the allele's epitopes
  (report unweighted AND n-epitope-weighted). Repeat over B_rar rarefaction draws; per-allele
  diversity = mean over draws, and per-allele SE = SD over draws (this SE feeds the MDE, A2).
- SECONDARY read: Shannon entropy of V-gene usage (reported for context; not the primary).
- d = 5 (primary). Note the depth floor: d = 5 gives 10 pairs per (allele,epitope) draw, so the
  per-allele diversity carries non-trivial rarefaction noise — this is precisely why the MDE
  injects that noise (A2).
- [SETTLED BLIND — m_d rule, item #1] An allele receives a diversity value ONLY if ≥ 2 of its
  epitopes reach depth d (m_d ≥ 2). Rationale: the estimand is within-epitope diversity AVERAGED
  ACROSS an allele's epitopes; an allele with a single epitope at depth d has no cross-epitope
  average and its value would confound allele-level engageability with one epitope's identity.
  This is structural (independent of any association; passes the tuning test). It drops A*68:01
  and B*15:01 from the primary set (15 → 13 alleles, 13 → 11 exact profiles). Applied at every
  threshold; what moves is reported.

## 5. MIN-COUNT THRESHOLDS (frozen)
Qualify alleles with ≥ K distinct TCRs across ≥ M epitopes. Report counts at THREE settings:
- permissive (K=10, M=2, d=5)
- PRIMARY (K=20, M=3, d=5)
- strict (K=50, M=5, d=10)
(M·d is a floor on K, so the primary triplet hangs together.) Thresholds are ADOPTED AND FROZEN;
they are never tuned to a target.

## 6. EFFECTIVE N — qualifying ALLELES vs INDEPENDENT ENGAGEABILITY PROFILES (rule 2; amendment A1)
Effective N is the number of independent engageability contrasts, NOT the qualifying-allele count.
The phrase "qualifying-allele count = effective N" is never written. Reported at every threshold:
  (i)   EXACT-IDENTITY profile count — distinct sequences over the 14 crest positions that
        DETERMINE engageability_A (positions 62,63,65,66,69,70,73,76,151,152,158,163,166,167,
        the frozen VARIABLE set in engageability_spec.md). This is the CEILING on independent
        profiles — it counts distinct sequences, which is an OVER-count of independent contrasts.
        PROVENANCE NOTE: empirically 19 of 26 crest columns vary across the 676-allele catalog
        (the extra 5 — p68,p149,p150,p159,p162 — are near-invariant singletons the metric spec
        assigns to the CONSERVED group and are NOT inputs to engageability_A). Clustering uses the
        14 engageability-determining positions, because "independent engageability profile" is
        defined by what moves the metric, not by every position that ever varies.
  (ii)  EPSILON-LADDER clustering so collapse is VISIBLE, not assumed: agglomerative (complete-
        linkage) clustering of qualifiers on the 14 crest positions under BOTH a Hamming distance
        and a Grantham-weighted physicochemical distance, across an epsilon ladder; report the
        profile (cluster) count at each rung. Rationale (from S8): distinct crest sequences can
        still be one effective contrast (e.g. B*57:01 + B*58:01 differ in sequence yet collapsed
        S8 to ~1 contrast), so exact identity alone would under-report collapse.
  (iii) The DISTRIBUTION of engageability_A among the qualifiers vs the full 676-allele catalog
        (spread, range, quantiles, and a plot). This is the arm-deciding quantity: information for
        a rank association depends on the SPREAD of the predictor among entering units, not on
        their count. Reported blind.
WITHIN-PROFILE AGGREGATION RULE (frozen, applies whenever an epsilon rung yields a non-singleton
cluster): the entering unit is the profile; its engageability_A = mean engageability_A over member
alleles (near-identical by construction of the cluster); its diversity = n_TCR-weighted mean of
member alleles' per-allele diversity; its measurement SE = n_TCR-weighted pooled SE. Singleton
clusters pass through unchanged.

## 7. LEVERAGE / DOMINANCE REPORTING (rule 3; amendment A4)
- Report A*02:01's share of all retained TCR entries, and the A2-SUPERTYPE (supertype == A02)
  share, from the per-allele supertype mapping in favorability_supertype_layer.csv (structural
  Sidney-scheme membership column only; cancer-arm HR columns unused). Coverage caveat recorded:
  of 49 A*02:xx catalog alleles, 35 map to A02, 7 Unclassified, 7 no_scheme_match; A*02:01 is
  cleanly A02-mapped.
- STUDY-EFFORT is the named live risk (rule 3): rarefaction equalizes DEPTH, not study
  heterogeneity. `reference` is retained on every entry as the handle on study structure.

## 8. REFERENCE STRUCTURE & PERMUTATION-NULL DESIGN (amendment A3; measure-before-pricing)
Diagnostic reported BEFORE any null is priced: the allele × reference bipartite structure — how
many references span > 1 qualifying allele, and what share of retained entries those cross-allele
references carry.
- If NEGLIGIBLE: cross-allele dependence in the diversity outcome is immaterial; a unit
  (profile-grain) permutation of engageability is exchangeable and valid. Issue closed.
- If MATERIAL: the null is built at ENTRY grain — block-resample references within alleles and
  propagate through the diversity index — because one study spanning several alleles induces
  cross-allele dependence in y that breaks exchangeability.
- FALLBACK (R4, named now, not chosen post-diagnostic): if entry-grain resampling is infeasible
  in budget, use a reference-CLUSTERED bootstrap. Gate-1 criterion 6(b) is satisfied by EITHER
  the entry-grain permutation or the reference-clustered bootstrap.
No clustered null is ASSERTED that has not been built.

## 9. MINIMUM DETECTABLE EFFECT (amendment A2 / R1)
Computed BLIND (no engageability↔diversity join), reported ALONGSIDE the association ALWAYS —
blindness is preserved by computation ORDER, not by a decision round-trip. There is NO
powered/not-powered gate; the powered call is not withheld for the user.
- MDE = smallest true Spearman rho detectable at 80% power against the reference-appropriate null
  (§8), two-sided alpha = 0.05, NO multiplicity correction (there is ONE primary estimand).
- Effective sample size for the MDE = the INDEPENDENT-PROFILE count (§6), NOT the allele count.
- The predictor marginal in the simulation uses the OBSERVED engageability_A spread among
  qualifiers (§6-iii).
- Measurement noise (A2): the simulated observed diversity y carries the empirical per-allele
  rarefaction SE (§4) as additive measurement noise, which attenuates rho toward null. Report the
  MDE BOTH ways (noise-free and noise-injected) and LEAD with the noise-injected value.
- Report the permutation/simulation count and the Monte-Carlo SE of the power estimate.

## 10. PRIMARY ESTIMAND (one; amendment / rule "one primary estimand")
ONE result: the Spearman rho between composite `engageability_A` and the PRIMARY within-epitope
rarefied CDR3b diversity, at PROFILE grain, on the PRIMARY threshold (K=20, M=3, d=5). Everything
else is a confound LAYER that can only DAMAGE this estimand, never produce a finding of its own.
Reporting rule enforcing this: a subset/layer result is NEVER featured against the full-set sign;
layers are reported only as "does the primary survive / by how much does it move."
(The association itself is NOT computed in this session — this defines the target for the next.)

## 11. z_het IS PRE-COMMITTED NON-CONFIRMATORY IN ISOLATION (rule 5)
If the composite `engageability_A` association is null and `z_het` alone is positive, that is
REPORTED and NOT FEATURED. Prior: z_het produced an HIV lead in S9 and reversed across independent
viruses in S9-ADD.

## 12. GATE 1 LIFT CONDITION — written blind, verbatim (rule 6, with R2/R3 amendments)
The retired "not-validated-against-measured-diversity" bound lifts ONLY if ALL hold. The final
report answers each as a mechanical yes/no, one line per criterion; the argument is NOT
constructed after seeing the result; no docking-calibration language is reintroduced.
  6(a) the COMPOSITE engageability_A association is POSITIVE and significant against the
       reference-appropriate permutation null (§8);
  6(b) it survives that reference-clustered / entry-grain resampling null (either construction);
  6(c) [AMENDED per R3] under leave-A2-SUPERTYPE-out: SIGN RETAINED and |Δrho| ≤ one-half the
       primary's magnitude. (The former "sign and CI intact" was a hidden significance test — n
       falls and the CI crosses zero regardless of truth.) [SETTLED BLIND, item #5] In the m_d≥2
       qualifying set A*02:01 is the ONLY A02-supertype member (A*02:06 does not survive m_d≥2), so
       leave-A2-supertype-out is OPERATIONALLY IDENTICAL to leave-A*02:01-out — reported as ONE
       control, not two.
  6(d) survives BOTH HED-partial AND AFND-frequency control (a signal that vanishes under AFND
       control IS the finding, per project convention);
  6(e) [AMENDED per R2] per-locus reported DESCRIPTIVELY; the criterion is that leave-one-locus-out
       neither REVERSES the sign nor REMOVES MOST of the effect magnitude. (The former "holds in
       ≥2 loci" was infeasible: HLA-C contributes near-zero qualifiers, so a true effect could
       fail for reasons unrelated to the metric.)
  6(f) [ADDED — power floor; correctable only while blind, now frozen] The lift is UNAVAILABLE
       from an analysis whose blind MDE exceeds the detectable range. If the blind power to detect
       the observed |rho| is ≤ 0.16 at any rho ≤ 0.95, THE GATE 1 BOUND CANNOT LIFT REGARDLESS OF
       P-VALUE. Rationale: significance without power is a fluke risk, not validation — a nominal
       p<0.05 at power 0.16 carries likelihood ratio ≈ 0.16/0.05 ≈ 3.2 (weak evidence), and the
       attenuation implied by the measurement noise (1/√(1+2.69²) = 0.35) means any observed effect
       understates truth ~3-fold. If a Part-2 result is nominally significant it is reported WITH its
       likelihood ratio and attenuation-implied magnitude inflation, and is NOT called support. This
       criterion makes the gate HARDER, not easier. (Accepted blind; the earlier rule 6 required
       significance (6b) but never power — 6(f) closes that gap.)
Anything short: the metric stays bounded exactly as Gate 1 left it.

## 13. AFND FREQUENCY CONTROL
AFND per-allele frequency (afnd_freqs_676.json, page-1 100-pop median) is a mandated confound
layer per project convention: a signal that vanishes under AFND control IS the finding.

## 14. WHAT THIS SESSION DELIVERS AND WHERE IT STOPS
Delivered (all association-blind): this prereg; VDJdb tag/SHA/access-date; filter waterfall;
qualifying ALLELES and distinct engageability PROFILES at all three thresholds; A*02:01 and
A2-supertype shares; reference & donor counts and their distribution across alleles; the
allele×reference bipartite diagnostic; HED–engageability correlation WITHIN the qualifying subset
alongside the 676-allele catalog value (the known −0.02 unweighted vs +0.20 cohort-weighted
discrepancy is LOGGED, not resolved); the blind MDE (noise-free and noise-injected, with sim count
and MC-SE); and the proposed confound design with per-layer inclusion/decline justifications.
STOP: no engageability↔diversity join, no association, no pass/fail judgment, no tuning.
