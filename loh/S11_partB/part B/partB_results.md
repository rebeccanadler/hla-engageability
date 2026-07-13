# S11 Part B — Results: MC3 HLA-A/HLA-B positional mismapping test

*Companion to the frozen numbers-only audit record (`partB_report.md`), the counting/provenance ledger
(`partB_counting_provenance.md`), and the blindness/mtime record (`partB_blindness_mtime.md`). All numbers in this
document are read back out of the frozen result artifacts; hashes are pinned in `partB_artifacts.sha256`.*

**Class I only. HLA-A and HLA-B are analysed and reported separately and are never pooled.** No pass/fail verdict is
issued; this arm reports numbers and their bounds. B2M and TAP1 are untouched. No dN/dS, no carriage regression.

---

## Question

Do the TCGA MC3 somatic calls annotated in *HLA-A* and *HLA-B* concentrate at the positions that are **polymorphic
across common HLA alleles** — the signature expected if germline sequence divergence causes short-read mismapping and
manufactures spurious "somatic" calls — or do they distribute across the coding sequence as real somatic mutation
would? The exposure axis is a per-residue cross-allele Shannon **entropy** vector (mature positions 1–182), split at a
**fixed, external, pre-committed 0.30-bit threshold** into POLYMORPHIC (≥0.30 bits, 60/182) and INVARIANT (<0.30,
122/182). The 0.30-bit cut was calibrated on 26 structurally preselected helix-crest positions *before Part B existed*
and is blind to the call distribution; it is not re-tuned here and no sweep over the cut is run (h.3).

## Effective sample

| gene | PRIMARY (truncating) | SECONDARY (missense) | THIRD (In_Frame_Del, counted not tested) | excluded |
|---|---|---|---|---|
| HLA-A | 14 | 41 | 1 | 8 |
| HLA-B | 13 | 18 | 2 | 10 |

PRIMARY = nonsense + frameshift, the pre-registered primary class (§3.0.a). The truncating counts (14 / 13) reproduce
the v3 join-set exactly. In_Frame_Del is counted but not entered into any test (g.5); its Part B vs Part A′ count
difference is a range-form-vs-total reconciliation left UNRESOLVED because the deciding column (Protein_position) was
dropped from the source file — details in `partB_report.md` (C2).

---

## Figure 1 — Positional distribution of calls against the entropy exposure

![HLA-A (a) and HLA-B (b) MC3 calls per mature residue, truncating (up, red) and missense (down, blue); (c) cross-allele Shannon entropy over 676 common alleles with the 0.30-bit POLYMORPHIC cut.]({{artifact:art_f3ebf892-2fe5-465e-a459-49687255c87b}})

The outcome (per-position call counts, panels a/b) and the exposure (entropy track, panel c) were emitted **before**
being joined — the mechanical basis of the blindness claim (see §Blindness). By eye, truncating calls (red) do not
track the tall POLYMORPHIC entropy bars of the α1/α2 core (panel c); they fall predominantly on low-entropy INVARIANT
positions. The remaining figures quantify that.

---

## Read (i): rank correlation of call count with entropy

Spearman ρ between per-position truncating/missense count and per-position entropy, with the zero-inflation stated
(the count vector is >90% zeros for the primary class, so ρ is reported alongside frac_zeros rather than in place of
it):

| gene | class | n | non-zero positions | frac_zeros | Spearman ρ | p |
|---|---|---|---|---|---|---|
| HLA-A | PRIMARY | 14 | 10 | 0.945 | −0.090 | 0.224 |
| HLA-A | SECONDARY | 41 | 30 | 0.835 | −0.130 | 0.080 |
| HLA-B | PRIMARY | 13 | 12 | 0.934 | −0.101 | 0.177 |
| HLA-B | SECONDARY | 18 | 15 | 0.918 | −0.257 | 0.0005 |

Every ρ is negative (calls, if anything, fall *away* from high-entropy positions). No positive entropy–count
association is observed in any gene/class.

---

## Read (ii): fraction of calls at POLYMORPHIC positions vs the trinucleotide-matched null

The pre-registered "whole test": the observed fraction of calls landing at POLYMORPHIC positions, compared to a
**trinucleotide-context-matched** null (B=20,000 draws, fixed seed 20260710, Monte-Carlo SE reported) that redraws
each call among positions sharing its ±1bp genomic context, plus an unmatched uniform null.

| gene | class | n | obs. frac at POLYMORPHIC | matched-null mean | matched p(enrich) | MC-SE | unmatched-null mean | unmatched p(enrich) |
|---|---|---|---|---|---|---|---|---|
| HLA-A | PRIMARY | 14 | 0.143 | 0.356 | 0.982 | 0.00095 | 0.329 | 0.969 |
| HLA-A | SECONDARY | 41 | 0.146 | 0.300 | 0.997 | 0.00040 | 0.329 | 0.998 |
| HLA-B | PRIMARY | 13 | 0.077 | 0.417 | 1.000 | 0.00000 | 0.329 | 0.994 |
| HLA-B | SECONDARY | 18 | 0.000 | 0.301 | 1.000 | 0.00000 | 0.329 | 1.000 |

**p(enrich) = P(null ≥ observed)** — the pre-registered direction. In all four cells the observed fraction lies
**below** the null mean, so every enrichment p is ≥0.97: the pre-registered enrichment is not present in any cell.

The two null types are distinguished for the truncating (PRIMARY) class — the matched null shifts *above* the
unmatched (0.356/0.417 vs ~0.329), because trinucleotide context concentrates the expected fraction upward — but for
the missense (SECONDARY) class the matched and unmatched nulls are essentially indistinguishable (0.300–0.301 vs
0.329).

![HLA-A (a) and HLA-B (b) truncating-class observed fraction (red line) against the trinucleotide-matched null distribution (grey); POLYMORPHIC marginal 0.33 dashed.]({{artifact:art_1f4486de-ad0b-4c70-92b3-8eb3ff7c2cd9}})

**Figure 2.** For both genes the observed truncating fraction (red) sits in the left tail of the matched null, at or
below the POLYMORPHIC marginal — the opposite side from where a mismapping artifact would place it.

### Depletion is post-hoc

Because the observed fraction lies below the null mean in every cell, a depletion-direction p is reported — but
§0.2 pre-committed the **enrichment** direction only, so **these values are POST-HOC** and descriptive, not a test of
the pre-registered hypothesis. Computed from the *same* existing matched null (same B, same seed, same draws — not
regenerated):

| gene | class | obs. frac | null mean | p(deplete), POST-HOC | MC-SE |
|---|---|---|---|---|---|
| HLA-A | PRIMARY | 0.143 | 0.356 | 0.076 | 0.00188 |
| HLA-A | SECONDARY | 0.146 | 0.300 | 0.011 | 0.00075 |
| HLA-B | PRIMARY | 0.077 | 0.417 | 0.004 | 0.00044 |
| HLA-B | SECONDARY | 0.000 | 0.301 | 0.002 | 0.00028 |

---

## Sensitivity: within-gene positional recurrence, and the entropy it carries

Raw per-position counts are primary **unconditionally** — positional recurrence across patients *is* the mismapping
artifact's signature, so it is not collapsed in the primary analysis (g.2). Reported here as a sensitivity line only:

- **HLA-A:** raw n=14; positions carrying >1 truncating call: IMGT 19 (×3), 53 (×2), 133 (×2); collapsed n = 10.
- **HLA-B:** raw n=13; positions carrying >1 truncating call: IMGT 57 (×2); collapsed n = 12.

The recurrent positions and their entropy/context:

| gene | IMGT | mult | variant (all patients) | entropy (bits) | partition | codon | CpG in ±1 |
|---|---|---|---|---|---|---|---|
| HLA-A | 19 | ×3 | p.E43* (nonsense) | 0.016 | INVARIANT | GAG | no |
| HLA-A | 53 | ×2 | p.E77Dfs*23 (FS ins) | 0.000 | INVARIANT | GAG | no |
| HLA-A | 133 | ×2 | p.W157* (nonsense/FS) | 0.000 | INVARIANT | TGG | no |
| HLA-B | 57 | ×2 | p.P81Rfs*70 (FS del) | 0.016 | INVARIANT | CCG | yes |

All four recurrent positions carry entropy ≤0.016 bits and are INVARIANT — none is POLYMORPHIC. The trinucleotide-
matched null of Read (ii) conditions on exactly this ±1bp context, so these recurrences enter the null on the INVARIANT
side rather than inflating the POLYMORPHIC contrast.

---

## Internal control: exon 2–3 vs exon 4+ call density

§0/§3.0.b carried a standing (non-blind) prediction that a mismapping artifact would enrich the polymorphic exon-2–3
core. The control of record is the **CDS-length-normalized** call density ratio (exons 2–3 ÷ 4+):

| gene | exon 2–3 density (calls/kb) | exon 4+ density (calls/kb) | ratio |
|---|---|---|---|
| HLA-A | 111.7 | 85.6 | **1.30** |
| HLA-B | 69.6 | 221.3 | **0.32** |

![Call density (calls per kb CDS) in exons 2–3 (teal) vs exon 4+ (orange), HLA-A and HLA-B; ratio annotated.]({{artifact:art_8488eba1-7a2f-41d3-bf04-cb3f4f5cdaea}})

**Figure 3.** HLA-A is roughly flat (1.30); HLA-B is *depleted* in the polymorphic core and piles up ~3× in exon 4+
(0.32) — the opposite of the predicted exon-2–3 enrichment. Only the length-normalized ratios (1.30 / 0.32) are the
control; class-pooled unnormalized figures are barred from the record (R7). A MAPQ-dropout reading of the HLA-B
direction (divergent positions producing *missing* rather than spurious calls) is POST-HOC — it occurred after the
table was seen (§3.0.b).

---

## Power bound (MDE)

Minimum detectable effect, computed before the join from n and the POLYMORPHIC marginal only (reads no call position,
g.6):

| gene | n (truncating) | POLYMORPHIC marginal | MDE fraction-in-POLYMORPHIC (80% power) |
|---|---|---|---|
| HLA-A | 14 | 0.33 | 0.71 |
| HLA-B | 13 | 0.33 | 0.69 |

![Minimum detectable fraction-in-POLYMORPHIC at 80% power, HLA-A (0.71) and HLA-B (0.69), against the 0.33 POLYMORPHIC marginal (dashed).]({{artifact:art_52925928-c62a-4f41-a8d7-4acdce840b10}})

**Figure 4 / bound.** At n=14/13 the arm can detect a fraction-in-POLYMORPHIC of ~0.71 (HLA-A) / ~0.69 (HLA-B) or
greater — roughly 2.1× the 0.330 baseline — and nothing weaker (`near_total_only=False`, which is *not* the same as
"well-powered"). **This arm cannot exclude a moderate mismapping contribution:** a null result is consistent both
with no artifact and with an artifact contributing a substantial minority of the truncating calls.

---

## What the numbers show, stated as numbers

Across both genes and both classes, and by all three readings (rank correlation, POLYMORPHIC-fraction contrast, and
the exon control), the MC3 HLA-A/HLA-B calls do **not** show the positive concentration at polymorphic positions that
the pre-registered enrichment hypothesis predicts; the observed POLYMORPHIC fractions sit at or below both nulls, and
the within-gene recurrences fall on INVARIANT, context-explained codons. The power bound is the load-bearing caveat:
this arm rules out a *large* mismapping contribution, not a moderate one. No pass/fail verdict is issued (that is the
evaluator's call), and HLA-A and HLA-B are reported separately throughout.

---

## Provenance and reproducibility

- **Frozen inputs** (hashes in `partB_artifacts.sha256`): coordinate map v3 (canonical, sha256 `92435172…60c124`,
  now loadable under the unambiguous name `hla_mc3_imgt_coordinate_map_v3.json`; the `_v2.json`-named object is
  retained as historical and its name is ambiguous — pin by hash); MC3 calls `mc3_apm_ctrl_consequence.csv`; entropy
  vector `partB_entropy_vector_1_182.csv` (h.1 26-crest checksum: 0 mismatches); trinucleotide context from
  `hla_cds_genomic_frozen.json`.
- **Blindness:** the record rests on the on-disk mtimes of §3.0, g, h and the reproduced prompt section, all
  preceding `partB_positional_calls.csv` by >35 min. §3's base text has neither session-mtime nor version-history
  evidence here; its substance is reproduced verbatim in the on-disk prompt section, which quotes and supersedes it.
  The mechanical ordering claim is sound and is narrower than an earlier draft (see `partB_blindness_mtime.md`,
  `partB_counting_provenance.md`).
- **B2M receipt (g.2, counting provenance only):** raw truncating (nonsense) global = 18; n_ind 27 → 16 = whole-
  sample hypermutator/MSI-POLE exclusion (every dNdScv category co-drops), NOT a homopolymer/tract dedup. B2M is on
  chr15, unrelated to HLA on chr6, and is absent from any Part B conclusion.

## Artifact index

**This document:** `partB_results.md`.
**Audit / numbers-only record:** `partB_report.md`. **Provenance ledger:** `partB_counting_provenance.md`.
**Blindness/mtime:** `partB_blindness_mtime.md`. **Hash sidecar:** `partB_artifacts.sha256`.
**Data tables:** `partB_effective_N.csv`, `partB_spearman.csv`, `partB_polymorphic_invariant_contrast.csv`,
`partB_depletion_posthoc.csv`, `partB_exon_control.csv`, `partB_mde.csv`, `partB_entropy_vector_1_182.csv`,
`partB_positional_calls.csv`.
**Figures:** `fig_partB_positional_distribution.png` (Fig 1), `fig_partB_association.png` (Fig 2),
`fig_partB_exon_control.png` (Fig 3), `fig_partB_mde.png` (Fig 4).
