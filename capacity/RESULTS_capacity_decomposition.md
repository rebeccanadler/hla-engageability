# Capacity decomposition — self / sim / neo on both arms

**Scope.** Self/sim/neo decomposition of HLA class I presentation capacity across the two
capacity arms — **breadth** (C4 binder-fraction summary) and **depth** (CAP-DEPTH per-allele
table). Allele-level, 676 alleles, per locus. **No outcomes loaded; nothing recomputed or tuned.**
This document reports values and nulls only.

## Inputs & audit anchors

| role | artifact | audit |
|---|---|---|
| depth (CAP-DEPTH) | `depth_table.tsv` | sha256 `619debdc652f0d0bb3534fdcc52fba7d4e43d5a0f75fb522e45b2fbfd8eac2e7` — **recorded** as the anchor. No external reference hash for this file exists in the store (the C4 checksums file predates it), so this is recorded, not matched. |
| breadth (C4) | `capacity_axis_master.csv` | sha256 `82ca46bd…` — **matches** `capacity_C4_checksums.sha256`. |
| engageability | `engageability_A` (per-allele, reconciled axis of record) | from the same C4 master. |

- Merge: 676 alleles, clean (inner = outer = 676). **HLA-A 218 · HLA-B 331 · HLA-C 127.**
- All depth flags `OK` — no NA / no sparse rows to handle.
- Breadth zeros kept as rows (never dropped): neo 7 · self 6 · sim 12.
- **B\*57:01** present (locus B); watched on every contrast.

## Conventions (read before the numbers)

- **Orientation.** Depth is native affinity (nM, smaller = deeper). It is oriented as
  **−log10(nM)** *before* any contrast or correlation, so **higher = more presentation on
  both arms**. A positive `sim − self` means sim presents more; a positive breadth–depth
  correlation means the two co-vary.
- **sim is rank-level only** (N_sim = 500). Every sim-bearing contrast is a **catalog-wide rank
  relationship**, never a per-allele nM point.
- **self is an anchor** (germline baseline), **never** read as an autoimmune-risk axis.
- **Per locus, never pooled.**
- **Statistics.** Per locus: median shift of (x − y), Wilcoxon signed-rank p, fraction
  present-more (>0), and cross-arm Spearman ρ. Distribution-free throughout.
- The **q=0.05** column is a depth-only robustness check (breadth carries a single binder
  fraction — no q025/q05).

---

## 1. The three contrasts (median shift; Wilcoxon p in parentheses)

![Per-locus median shift for the three contrasts, both arms]({{artifact:art_eccdde28-f5bf-4097-b83b-1f2c9cffdd48}})

*Solid marker = Wilcoxon p<0.05; open marker = null (p≥0.05). Stems drop to zero. Positive =
first term presents more. sim-bearing contrasts are rank-level; neo−sim is the Gate-4-demoted
residual.*

### 1a. sim − self  — PRIMARY (mutational-process match, pre-tolerance)

| arm | HLA-A | HLA-B | HLA-C |
|---|---|---|---|
| breadth | +0.007  (3.3e-14) | -0.002  (0.01603) | +0  (0.354 (null)) |
| depth q025 | -0.04094  (2.3e-07) | -0.02207  (0.0001306) | +0.05795  (1.1e-10) |
| depth q05 | -0.04046  (9.1e-11) | -0.03115  (2.6e-09) | +0.03054  (1.0e-05) |

- **Locus-heterogeneous**, and the sign is **identical across q025 and q05** in every locus
  (A −, B −, C +). On depth, sim presents **less** than self at HLA-A and HLA-B, and **more**
  at HLA-C.
- **q=0.05 robustness check: holds. No sign divergence to flag.**
- Breadth: HLA-A slightly +, HLA-B slightly −, **HLA-C null** (p=0.35).
- B\*57:01 (locus B): breadth +0.0140; depth q025 -0.0535; depth q05 -0.1426.

### 1b. neo − sim  — residual (editing + survivorship)

> **Gate-4 note (permanent).** The immunoediting interpretation of this residual is demoted.
> Reported here, not promoted. **This is not an immunoediting finding.**

| arm | HLA-A | HLA-B | HLA-C |
|---|---|---|---|
| breadth | +0.0145  (4.9e-21) | +0.0055  (1.0e-13) | +0.0005  (0.0325) |
| depth q025 | +0.122  (7.0e-23) | +0.04878  (2.7e-19) | -0.04909  (6.9e-07) |
| depth q05 | +0.1293  (3.5e-29) | +0.05189  (1.4e-21) | -0.02155  (0.003679) |

- B\*57:01 (locus B): breadth +0.0060; depth q025 +0.1599; depth q05 +0.1984.

### 1c. neo − self  — raw (confounded by construction)

> Reported once. **Never primary.**

| arm | HLA-A | HLA-B | HLA-C |
|---|---|---|---|
| breadth | +0.024  (3.1e-35) | +0.002  (0.001324) | +0  (0.01174) |
| depth q025 | +0.08087  (2.2e-25) | +0.02441  (2.8e-08) | +0.002218  (0.602 (null)) |
| depth q05 | +0.09797  (1.8e-30) | +0.0164  (0.0001893) | -0.00623  (0.773 (null)) |

- B\*57:01 (locus B): breadth +0.0200; depth q025 +0.1064; depth q05 +0.0558.
- Nulls: depth neo−self **HLA-C** at both quantiles (q025 p=0.60; q05 p=0.77).

---

## 2. Within-capacity correlations (no outcomes)

![Breadth vs depth, and engageability vs each capacity axis]({{artifact:art_d1f8be5f-7f65-434f-9067-1e8bf804945e}})

### 2a. Breadth vs depth — one axis or two?

Spearman ρ, same unit-arm, per locus (depth as −log10 nM, q025):

| unit-arm | HLA-A | HLA-B | HLA-C |
|---|---|---|---|
| neo | 0.936 | 0.967 | 0.972 |
| self | 0.940 | 0.976 | 0.973 |
| sim | 0.929 | 0.968 | 0.951 |

- All ρ ≈ **0.93–0.98** (every p < 1e-60). Breadth and depth co-rank tightly within each locus
  and each unit-arm.

### 2b. Engageability vs each capacity axis

Spearman ρ (engageability_A vs neo arm), per locus:

| locus | eng vs breadth ρ (p) | eng vs depth ρ (p) |
|---|---|---|
| HLA-A | 0.539 (7.4e-18) | 0.509 (8.8e-16) |
| HLA-B | -0.117 (0.03358) | -0.021 (0.708 (null)) |
| HLA-C | 0.016 (0.855 (null)) | 0.080 (0.373 (null)) |

- Engageability tracks both capacity axes at **HLA-A** (ρ≈0.51–0.54); weak-negative at HLA-B
  (breadth ρ=−0.12, p=0.034; depth null); **null at HLA-C** (both).

---

## Null ledger

- Breadth `sim − self` HLA-C — p=0.35.
- Depth `neo − self` HLA-C — q025 p=0.60, q05 p=0.77.
- Engageability vs depth, HLA-B — p=0.71.
- Engageability vs breadth HLA-C (p=0.86) and vs depth HLA-C (p=0.37).

## Files

- Figures: `fig_decomp_contrasts.png`, `fig_within_capacity.png`
- Tables: `decomp_contrasts_by_locus.csv`, `within_breadth_vs_depth.csv`,
  `within_engageability_correlations.csv`
- Methods/provenance: `decomp_methods_note.md`
