# Results — CAP-LOH: does somatic HLA loss skew toward high-presentation-capacity alleles?

*Arm status: descriptive escape-mechanism check. Pre-registered (Stage-A freeze before joining).
Not an outcome test, not a trade-off test; reopens no prior arm. Disposition: **NULL / UNDERPOWERED**.*

---

## Question and framing

The presentation-capacity axis (C4) scores each class I allele by the fraction of a fixed antigen
set it can present. A natural escape reading of somatic HLA loss is that tumors preferentially lose
their *most capable* presenting alleles — the ones most likely to display neoantigen. This arm asks
one descriptive question: **do the alleles showing somatic loss (S11-LOH) skew toward high
presentation capacity?**

It is deliberately narrow. It is not an outcome test (no ICB benefit), not the cancer/autoimmunity
trade-off test, and it does not reopen the immunoediting demotion. A positive would be *one piece of
in-hand evidence consistent with* capacity-driven escape; it would not establish it (see Firewall).

## Inputs and definitions

| quantity | source | definition |
|---|---|---|
| presentation capacity | `capacity_axis_master.csv` (C4) | `neo_binder_fraction` — PRIMARY affinity scoring (`-BA`), best window ≤ 500 nM, NetMHCpan 4.1b, N=2,000 neoepitopes |
| loss propensity | `msk50k_within_patient_LOH_bias.csv` (S11-LOH) | `frac_lost` — within-patient informative LOH events |
| independence unit | C4 methods §9 | Sidney/Sette **supertype** (capacity is a pocket-motif quantity; supertypes group alleles by pocket motif) |

Nothing was recomputed from sequence. The two tables were joined 1:1 on allele; all 110 LOH alleles
matched a capacity row with zero misses (A 30, B 53, C 27).

## Pre-registered freeze (before joining)

1. **Direction, pre-stated:** higher capacity → more loss (positive Spearman ρ). That positive is
   the only direction consistent with capacity-driven escape; graded one-sided against it.
2. **Per-locus, A and B separately.** HLA-C excluded — its capacity axis has no clean supertype
   scheme (`supertype_map_status = NULL_C_by_design`, the S6 arithmetic ceiling), so effective-N = 1
   and no correlation is gradable. C values are **listed, not interpreted**.
3. **Report effective-N and MDE first (E1)**, so the result reads against what the data could show.
4. **Mandatory leave-A\*02:01-out** re-run at locus A.

## E1 — effective-N and minimum detectable effect (reported first)

Effective-N is the number of distinct mapped capacity supertypes (the C4 independence unit), not the
number of alleles. MDE is the minimum detectable Spearman ρ at that N (Fisher-z, one-sided α = 0.05,
power = 0.80).

| locus | alleles | mapped supertypes (effective-N) | unclassified | MDE ρ (supertype-N) | MDE ρ (allele-N, reference only) |
|---|--:|--:|--:|--:|--:|
| A | 30 | **6** | 0 | **0.89** | 0.45 |
| B | 53 | **6** | 4 | **0.89** | 0.34 |

**Read before the result.** With ≈6 independent capacity points per locus, the design can only
detect a near-perfect monotone alignment (ρ ≳ 0.89). Few independent points per locus, exactly as
anticipated; anything short of a very strong rank association is below detection here.

## Per-locus association

Graded unit = supertype (median capacity and median `frac_lost` per supertype). One-sided
permutation p (positive tail), B = 20,000, seed = 20260709. Allele-level ρ shown for context only,
not graded against n.

| locus | supertype ρ | 1-sided perm p (positive) | n supertypes | allele-level ρ (context) | allele p (2-sided) |
|---|--:|--:|--:|--:|--:|
| A | **−0.60** | 0.91 | 6 | −0.28 | 0.13 |
| B | **+0.35** | 0.25 | 6 | −0.07 | 0.63 |

**Leave-A\*02:01-out (mandatory).** A\*02:01 is one allele within the A02 supertype (8 A02 alleles in
the LOH set), so removing it does not materially move the A02 collapsed median: locus-A supertype
ρ = **−0.60, unchanged**, p = 0.91; allele-level ρ moves −0.28 → −0.24. No single high-training-support
allele masks a positive.

**Neither locus supports the pre-stated positive.** HLA-A runs *opposite* to the escape direction
(ρ = −0.60, wrong sign); HLA-B is in-direction but weak (ρ = +0.35), non-significant (p = 0.25), and
far below the MDE the 6-point design would require (ρ ≈ 0.89).

![CAP-LOH — per-locus presentation capacity vs LOH loss propensity]({{artifact:art_c09e94f6-e08b-427a-abb1-167d2b9d1db6}})

*Per-locus capacity (neo binder %) vs LOH loss propensity (`frac_lost`). Grey points are alleles;
blue diamonds are the freq-of-6 supertype-collapsed points that carry the graded test. (a) HLA-A,
with A\*02:01 ringed (leave-one-out probe) — supertype ρ = −0.60, opposite the escape direction.
(b) HLA-B — supertype ρ = +0.35, n.s. (p = 0.25), below the MDE. (c) HLA-C — single bucket
(`NULL_C_by_design`), effective-N = 1, listed but not interpreted.*

## HLA-C — listed, not interpreted

HLA-C collapses to a single bucket (`NULL_C_by_design`, 27 alleles), so effective-N = 1 and no
supertype contrast — hence no gradable capacity–loss correlation — exists. For completeness only
(ungradable): allele-level Spearman ρ = −0.15 (p = 0.45). Full per-allele values are in
`cap_loh_HLAC_listing.csv`. No HLA-C correlation is interpreted: at the arithmetic ceiling, a null or
any value at C carries no information about capacity-driven escape.

## Disposition

**Branch obtained: NULL / UNDERPOWERED** (pre-committed and fully reportable). The loss data do not
visibly favor high-capacity alleles — HLA-A runs opposite the escape direction, HLA-B is in-direction
but weak and nowhere near the MDE, and the leave-A\*02:01-out A result is identical. The positive
branch — an in-direction association surviving leave-A\*02:01-out — **did not obtain.**

Per the pre-commitment, this null **neither supports nor refutes** the escape reading. With ≈6
independent points per locus and MDE ρ ≈ 0.89, the marginal loss data cannot identify a
capacity-escape mechanism (consistent with E-COEVO: the mechanism is not identified from marginal
data). **The null is not read as "no escape."**

### Firewall (restated, non-selectable)

- **Does not reopen the immunoediting demotion.** Capacity → presentation → selection → loss *is*
  immunoediting — but germline **non-selective** HLA-LOH (bait capture, haplotype linkage — the
  S11-LOH confounders) would produce the *same* capacity–loss correlation with no immune selection.
  Had a positive obtained, it would be *consistent with* immunoediting; it would **not assert** it.
- **S11-LOH's confounders are unresolved and inherited unadjusted:** capture-bait bias, 8.1/7.1
  haplotype linkage, Bw4/Bw6. Any association here would carry them, so it could not be attributed to
  capacity alone. (Moot on the observed null; stated for completeness.)

---

## Artifacts

| file | contents |
|---|---|
| `fig_cap_loh.png` | per-locus capacity vs loss, A / B / C (figure above) |
| `cap_loh_E1_effectiveN_MDE.csv` | effective-N and MDE per locus |
| `cap_loh_association_perlocus.csv` | per-locus supertype ρ, permutation p, allele-level ρ, leave-A\*02:01-out |
| `cap_loh_supertype_points.csv` | the 6+6 supertype-collapsed points that carry the graded test |
| `cap_loh_HLAC_listing.csv` | HLA-C per-allele capacity and loss (listed, not interpreted) |
| `cap_loh_disposition.md` | full frozen pre-registration record + disposition |

*Method (statistic, join, presentation) was chosen after the freeze; freeze covered direction,
per-locus scope, HLA-C exclusion, E1-first, and leave-A\*02:01-out. Seed 20260709 throughout.*
