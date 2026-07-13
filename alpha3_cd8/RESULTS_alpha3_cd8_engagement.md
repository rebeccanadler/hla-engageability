# Results — α3 (exon-4) CD8 co-receptor engagement axis

*Class-I HLA "immunogenic potency" project. This arm builds a third pre-registered
sequence-derived feature group — CD8 co-receptor engagement on the α3/exon-4 domain — by the
same discipline as the α1/α2 engageability crest. Primary score = structure-based CD8-binding
ΔΔG (EvoEF2). Frozen spec: `methods_alpha3_cd8_engagement.md`. All numbers below are computed;
figures are embedded. The disposition call (mini-gate) is the user's.*

---

## 1. Human-only CD8-contact footprint + exon-4 coverage gate

**Structure set (human-only, Fix 3).** The 5.0 Å contact map is derived from **two human
classical HLA class-I CD8 complexes**: **1AKJ** (HLA-A\*02:01, 2.65 Å, CD8αα chains D/E) and
**3QZW** (HLA-A\*24:02, 2.80 Å, CD8α chains G–J). Both resolve CD8 packing against the
α3/exon-4 domain, so the ≥2-template requirement is met. Non-human complexes (murine H-2Kb
1BQH, H-2Dd 3DMM, TL 1NEZ; chicken BF2 6LHF/6LHG) and non-classical/non-CD8/non-MHC entries
were excluded from derivation — full candidate list and per-structure source_refs, resolution,
chains, organism, and exclusion reason in `alpha3_cd8_structures.csv`. β2m and peptide/TCR
chains are excluded from the "CD8 chain" set.

**Footprint (≥25% contact over the 2 structures) = 20 exon-4 positions:** 198, 212, 214, 219,
222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 243, 248, 250, 262 (mature
numbering). **16 positions are supported by both structures**; 212/219/223 are 3QZW-only, 250
is 1AKJ-only. Scoping to exon 4 deliberately **excludes the known α2 CD8 contacts (~E128,
Q115)** — this is the α3-only sub-footprint, not the full CD8 interface.

**Empirically-recovered acidic loop.** The footprint ∩ the 223–229 CD-loop region =
{223,224,225,226,227,228,229}; the loop reads **DQTQDTE** (identical in both templates). This
is the α3 analog of the crest's R65/A69/Q155 landmark recovery.

**Landmark / indexing integrity.** IMGT-extracted A\*02:01 α3 vs the 1AKJ crystal heavy chain:
**0 mismatches** across all 20 footprint positions AND the full α3 (mature 183–274). Footprint
reads `EETREDQTQDTELVETKVPQ`.

**Exon-4 coverage gate (Fix 4).** Requiring all 92 α3 positions be standard residues:
**RETAINED-N = 674** — **A = 217, B = 331, C = 126**. **Quarantined 2**: A\*24:26
(exon 4 not typed, 92-gap), C\*12:04 (partial, 71-gap). 674/676 — not a material limitation,
stated up front as the true effective allele count for this axis.

![Human-only α3 CD8-contact frequency profile over the 20 exon-4 footprint positions; CD-loop 223–229 highlighted, ≥25% threshold marked.]({{artifact:afe45fe4-7422-496d-8742-26d948703883}})

---

## 2. α3 polymorphism in absolute units + known-variant anchoring

The degeneracy rule (**ε = 0.05 minimum pooled SD**, frozen) governs which features enter
z-scoring/PCA; the axis is reported first in interpretable absolute units.

**(a) Distinct-footprint collapse — the honest denominator: 5 distinct α3 footprints / 674
alleles.**

| footprint (20 aa) | n | freq | loci | change vs modal | Grantham |
|-------------------|---|------|------|-----------------|----------|
| EETREDQTQDTELVETKVPQ (modal) | 628 | 93.2% | A,B,C | — | 0 |
| EETWEDQTQDTELVETKVPQ | 36 | 5.3% | C | R219W | 101 |
| EETWEDQTQDTELVETKMPQ | 8 | 1.2% | C | R219W+V248M | 122 |
| EETREDQTQDMELVETKVPQ | 1 | 0.1% | A | T228M | 81 |
| EETREDQTQDTQLVETKVPQ | 1 | 0.1% | C | E229Q | 29 |

**(b) Per-position entropy — only 4 of 20 footprint positions vary:** 219 (R:630/W:44, 0.348
bits), 248 (V:666/M:8, 0.093), 228 (T:673/M:1, 0.016), 229 (E:673/Q:1, 0.016). The acidic-loop
core 223–227 is fully invariant.

**(c) Grantham magnitude** of each variant vs the modal footprint: as in the table above (29 to
122), meaningful as an absolute distance even though most alleles score exactly 0.

**Known-functional-variant anchoring (verified, not asserted).** The residue-245 dimorphism
(Salter et al. 1989, *Nature* 338:345–348; PubMed 2784196; source_ref in
`alpha3_known_variants.csv`) is carried by **22 alleles** (all 21 A\*68 + A\*02:122). **Residue
245 is NOT in the 5.0 Å footprint** — its minimum distance to CD8 is **7.14 Å (1AKJ) / 7.28 Å
(3QZW)**, vs 3.01 Å for footprint residue 227. Honest finding: the contact-based footprint is
**blunt to this known-functional variant** (245 is a second-shell/conformational determinant).
The 223–229 acidic loop is fully recovered but invariant across alleles, so it does not
discriminate.

![α3 polymorphism in absolute units: distinct-footprint collapse (lollipop), per-position Shannon entropy, and Grantham magnitude of each variant vs modal.]({{artifact:c442bb84-0971-4c29-a4d1-6f8b88cb6e0e}})

---

## 3. Structure-based CD8-engagement ΔΔG (EvoEF2)

**Engine.** EvoEF2 (open-source empirical interface-ΔΔG in the FoldX class — NOT FoldX or
Rosetta, both unreachable in the environment), built from source, GitHub commit
**38df01d305ed728ef067c3e0d22072058f33e255**. Chosen for reproducibility: a reviewer can
rebuild it (no license/network gate). EvoEF2 carries its OWN calibration/error (not FoldX's).

**Templates + protocol.** ΔΔG computed on both human templates (1AKJ split A,DE; 3QZW split
A,GH). RepairStructure → BuildMutant → ComputeBinding. Sign convention: **engagement_ΔΔG =
ΔG_bind(thread) − ΔG_bind(modal template), more-negative = stronger engagement**; identical
footprint ⇒ ΔΔG = 0 by construction. EvoEF2 BuildMutant is deterministic (SD = 0 across 3
fixed replicates). ΔΔG is computed **once per unique footprint thread** (a handful, not 676×)
and mapped back to member alleles.

**Per-thread ΔΔG** (1AKJ / 3QZW / mean / template-sensitivity range):

| thread (alleles) | 1AKJ | 3QZW | mean | template range |
|------------------|------|------|------|----------------|
| R219W (36) | −0.20 | −0.12 | **−0.160** | 0.08 |
| R219W+V248M (8) | −0.10 | −1.63 | **−0.865** | 1.53 |
| T228M (1) | +3.10 | −0.39 | **+1.355** | 3.49 |
| E229Q (1) | −0.19 | +0.05 | **−0.070** | 0.24 |
| modal (628) | 0 | 0 | **0** | 0 |

**46 of 674 alleles carry nonzero ΔΔG** (all others = modal = 0). Per-locus SD of
engagement_ΔΔG: A 0.092 (2 distinct values), B 0.000 (invariant — all modal), C 0.212 (4
distinct values). This is a **mechanistic annotation on the Grantham grading**, not an
independent large-N axis (only a handful of unique threads) — reported as such.

**Degeneracy rule outcome.** Of the descriptive features, exactly **2 clear ε**:
footprint_acidic_charge (SD 0.251) and footprint_conservation_deviation (SD 0.312).
CDloop_acidic_charge (SD 0.038) and footprint_heterogeneity (SD 0.004) are **degenerate** →
excluded from z/PCA and reported as raw distributions. With ≥2 features clearing ε, PC1 is
computable (loadings 0.707/0.707, 95.1% variance) — reported for completeness.

---

## 4. Mechanistic concordance + cross-axis redundancy

**(iii-b) Mechanistic concordance (physics vs chemistry).** Hypothesis: more-acidic loops
(higher acidic charge) → more-negative (stronger) ΔΔG. **CDloop_acidic_charge (PRIMARY) is
near-invariant (degenerate) → UNINTERPRETABLE.** footprint_acidic_charge (reported alongside):
across all 674, Pearson **−0.625**, Spearman **−0.948** (negative = concordant, driven by the
R219W acidic-loss thread); across only the nonzero alleles, r = −0.367 / ρ = −0.492.

**(iv) Cross-axis redundancy** (all |r| < 0.7; flagged UNINTERPRETABLE where α3 variance ≈ 0 —
HLA-B is invariant everywhere):
- engagement_ΔΔG × **HED**: overall P +0.168 / S +0.339; A −0.013 / +0.007; **B UNINTERPRETABLE
  (SD 0)**; C −0.508 / −0.291.
- engagement_ΔΔG × **engageability**: overall +0.063 / +0.020; A +0.076 / +0.064; **B
  UNINTERPRETABLE**; C −0.052 / −0.234.
- footprint_acidic_charge × HED: overall −0.312 / −0.326; footprint_acidic_charge ×
  engageability: overall −0.024 / −0.004.

![α3 engagement ΔΔG: per-thread distribution, mechanistic concordance vs acidic charge, and cross-axis correlations with HED and engageability (UNINTERPRETABLE cells flagged).]({{artifact:216c0480-6e09-4e56-855b-9c61cccb1b90}})

---

## 5. Cutoff sensitivity (exploratory-after-the-fact; does NOT revise the frozen 5.0 Å axis)

Pre-specified sweep of the contact cutoff (≥25% rule + human-only unchanged):

| cutoff | footprint size | distinct footprints | modal fraction | non-modal N | 245 in? |
|--------|---------------|--------------------|----------------|-------------|---------|
| **5.0** (frozen) | 20 | 5 | 93.2% | 46 | no |
| 6.0 | 27 | 7 | 50.9% | 331 | no |
| 7.0 | 35 | 11 | 48.2% | 349 | no |
| 8.0 | 44 | 14 | 47.0% | 357 | **yes** |

Residue 245 first enters at **8.0 Å**, as 1 of 24 second-shell positions added — not
selectively. Its A245V EvoEF2 ΔΔG on the frozen templates = −0.99 (1AKJ) / 0.00 (3QZW),
mean −0.50 — small and 0 on one template, consistent with a conformational/second-shell effect
a fixed-backbone contact predictor does not reproduce. Relaxing the cutoff trades
contact-specificity for coverage (modal fraction falls to ~47% as broadly-polymorphic
second-shell positions enter); the contact-specific 5.0 Å footprint stays near-invariant.

![Contact-cutoff sensitivity: footprint growth, modal-fraction decline, and the 8.0 Å entry of residue 245.]({{artifact:7ecad58d-4d97-46d9-a67a-72eaa86e15b4}})

---

## Disposition (pre-registered framing; the mini-gate call is the user's)

Across all three instruments, α3 CD8 co-receptor engagement is **near-invariant** in class I:
**5 distinct footprints over 674 alleles (93.2% modal), only 4 of 20 footprint positions vary,
HLA-B is entirely invariant, and 46/674 alleles carry any nonzero ΔΔG.** Per the
pre-registration this is a **clean reportable finding** — "CD8 co-receptor engagement is
conserved / not allele-discriminating in class I" — carried separately as a CONSERVED axis, NOT
a failure. Whether that disposition stands is the user's call.

## Artifacts (this section)
- `methods_alpha3_cd8_engagement.md` — frozen pre-registration spec v2
- `alpha3_checkpoint_report.md` — the 4+1 checkpoint items, numbers only
- `alpha3_cutoff_sensitivity_report.md` — the pre-specified cutoff sweep
- `alpha3_cd8_structures.csv`, `alpha3_distinct_footprints.csv`, `alpha3_entropy_map.csv`,
  `alpha3_polymorphism.csv`, `alpha3_known_variants.csv`, `alpha3_ddg_distinct.csv`,
  `alpha3_scores.csv` — the underlying tables
