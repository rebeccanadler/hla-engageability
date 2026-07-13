# Results — Neo-side length-preference descriptor (C4 arm)

**Question.** Does a per-allele peptide-length-preference descriptor, built from the
C4 capacity summary, carry information independent of the existing predictor axes
(engageability, HED, supertype) — or is it a locus-level nuisance dimension?

**Framing / scope note.** The four length columns used here
(`neo_binder_fraction_{8,9,10,11}mer`) were labeled *descriptive* in the C4 output.
Constructing a per-allele feature from them promotes descriptive columns to a
candidate predictor; that promotion is a deliberate scope change flagged here, not a
decision to treat length as an axis. This analysis **reports** whether length tracks
the other axes and **stops** — length is not called an axis and is not folded into
E-ORTH.

**Provenance / reproducibility.**
- Source: `capacity_axis_master.csv`, SHA256 `82ca46bd3a4ca2c5a6e6d0dee5519828711a148f9ccd00b5aab23848c7f7fa6b` — verified against the C4 checksum manifest (`capacity_C4_checksums.sha256`). Match confirmed.
- Nothing recomputed upstream, nothing tuned, no outcome/label data loaded.
- C4 provenance: seed=20260709, NetMHCpan 4.1b, N=2000/arm, N_sim=500.

---

## 1. Which length columns exist

The per-allele length breakdown in the C4 master is **neo-side only**:
`neo_binder_fraction_8mer`, `_9mer`, `_10mer`, `_11mer`. Every column with "mer"
in its name was checked — **there is no self-side length breakdown** in the master.
The descriptor is therefore **neo-side by construction**, and is reported as such.

(The project's other length file, `per_length_breakdown.csv`, is locus-pooled
[A/B/C/all × 8/9/10/11], not per-allele, so it is not usable for an allele-level
descriptor.)

The four columns are **independent binding rates**, not a simplex — they do not sum
to 1 within an allele.

---

## 2. Descriptor definition

**`L_pref`** = binding-rate-weighted mean neo-peptide length:

```
L_pref = Σ_L (L · f_L) / Σ_L f_L ,   L ∈ {8, 9, 10, 11}
```

where `f_L` is the neo-binder fraction at length `L`. This is scale-free (the
denominator normalizes out overall binding level), so `L_pref` is the centroid of
where an allele's neo-binding sits along the length spectrum. A secondary shape
descriptor, `long_frac` = (f₁₀ + f₁₁)/Σf, is included in the per-allele table.

**Nulls.** 7 alleles have zero neo-binding at all four lengths → `L_pref` undefined
(0/0): **B\*08:02, B\*51:07, B\*51:22, C\*07:04, C\*07:12, C\*18:01, C\*18:02**.
These are reported as nulls and excluded from statistics. Valid n = 669 of 676
supported alleles.

---

## 3. Per-locus spread (never pooled)

| locus | n | mean L_pref | sd | min | max | range | CV % |
|---|---|---|---|---|---|---|---|
| A | 218 | 9.675 | 0.167 | 9.138 | 9.960 | 0.82 | 1.7 |
| B | 328 | 9.440 | 0.205 | 8.875 | 9.884 | 1.01 | 2.2 |
| C | 123 | 9.141 | 0.099 | 8.983 | 9.666 | 0.68 | 1.1 |

**Near-invariant within a locus.** Locus sets the level (A ≈ 9.68 > B ≈ 9.44 >
C ≈ 9.14); within-locus coefficient of variation is only 1–2 %. Most of the total
variance in `L_pref` is the locus offset, not allele-to-allele variation.

---

## 4. Correlation with the other predictor axes (per locus)

Spearman rank correlation (`*` = p < 0.05); full Pearson + Spearman r and p in
`length_pref_correlations.csv`.

| axis | A (n=218) | B (n=328) | C (n=123) |
|---|---|---|---|
| engageability_A | **+0.21\*** | −0.00 | +0.13 |
| engageability_A (within-locus) | **+0.22\*** | +0.05 | +0.11 |
| engageability_B | **+0.23\*** | −0.09 | +0.04 |
| mean_HED | **−0.27\*** | **+0.16\*** | **+0.22\*** |
| median_HED | −0.12 | **+0.23\*** | **+0.21\*** |

**Supertype structure** (Kruskal–Wallis on mapped supertypes with ≥3 alleles;
η² = one-way ANOVA effect size):

| locus | n | # supertypes | η² | KW H | KW p |
|---|---|---|---|---|---|
| A | 156 | 6 | 0.283 | 46.9 | 6×10⁻⁹ |
| B | 243 | 6 | 0.096 | 28.6 | 3×10⁻⁵ |
| C | — | — | — | — | NULL_C_by_design |

C carries no supertype scheme (`NULL_C_by_design`), so the supertype association is
undefined for C, not computed.

**Reading.**
- Correlations with **engageability** are weak and **locus-inconsistent** —
  significant at A, absent or sign-flipped at B, non-significant at C.
- The **HED** relationship **flips sign between loci** (negative at A, positive at
  B and C), so there is no coherent pooled relationship.
- The one solid structural signal is that `L_pref` tracks **supertype** within A
  (η² = 0.28) — expected, since supertype and length preference both derive from
  B/F-pocket chemistry.

---

## 5. B\*57:01 watch

`L_pref` = **9.883**, supertype **B58**. That is the **99.7th percentile of the B
locus** (z = +2.17) — B\*57:01 is a strong long-peptide binder relative to its
locus, driven by its 10mer rate (0.121) exceeding its 9mer rate (0.078), which is
atypical.

---

## 6. Figure

![Per-locus L_pref spread (a) and per-locus Spearman correlations of L_pref against the predictor axes (b). Panel a: strip plot of L_pref by locus with median ticks; B*57:01 marked. Panel b: heatmap of Spearman r, asterisks p<0.05.]({{artifact:24910572-ecde-4ca1-bdce-606cde58351e}})

**Figure 1.** (a) `L_pref` is near-invariant within each locus (CV 1–2 %); locus
sets the level (A > B > C). B\*57:01 (diamond) sits at the top of the B
distribution. (b) Per-locus Spearman correlation of `L_pref` with each predictor
axis. Associations with engageability are weak and locus-inconsistent; the HED
relationship flips sign between loci.

---

## 7. Interpretation (reported, not decided)

On this evidence, within-locus spread in `L_pref` is small and its cross-axis
correlations are weak and sign-inconsistent across loci. The one reproducible
structural signal is aliasing with supertype (strong at A). Read together, neo-side
length preference looks like a **locus-level nuisance dimension partly aliased with
supertype** rather than an independent immunogenic-potency axis.

This is a reported read, not a project decision: **length is not promoted to an
axis and is not folded into E-ORTH here.** That call is deferred.

---

## Artifacts

- `length_pref_descriptor_perallele.csv` — 676 alleles: neo length fractions,
  `L_pref`, `long_frac`, and the predictor-axis columns.
- `length_pref_perlocus_spread.csv` — per-locus spread table (Section 3).
- `length_pref_correlations.csv` — per-locus Pearson + Spearman, r and p (Section 4).
- `fig_length_pref.png` — Figure 1.

**Methods one-liner.** `L_pref` = rate-weighted mean of neo-binder length fractions
(8/9/10/11 aa) from `capacity_axis_master.csv` (hash-verified); per-locus
descriptive statistics and per-locus Pearson/Spearman correlations against
engageability (A, A-within-locus, B), mean/median HED, and a Kruskal–Wallis/η²
supertype association (mapped supertypes, ≥3 alleles per group). 7 non-binding
alleles excluded as undefined. No pooling across loci; no outcome data used.
