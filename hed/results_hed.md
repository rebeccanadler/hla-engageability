# Results — HED arm (peptide-repertoire breadth baseline)

**Study:** single HLA class I "immunogenic potency" axis predicting opposite outcomes in
cancer vs. autoimmunity. **This arm:** HED (HLA Evolutionary Divergence), the *baseline*
peptide-repertoire-breadth metric against which the novel engageability metric is compared.
HED and the trade-off concept are prior work (Pierini & Lenz 2018; Chowell et al. 2019);
this note reports our reproduction of HED on a defined common-allele set at IPD-IMGT/HLA
3.64.0. Full methods: `methods_hed.md`.

## 1. Scope of the computed set
- **676 common HLA class I alleles**: HLA-A 218, HLA-B 331, HLA-C 127.
- Common-allele definition: CWD 2.0.0 expressed class I ∩ retained full-length
  (exon-2/3 length gate 90/92), 2-field resolution. (CWD 2.0.0 substituted for CIWD 3.0,
  which is not available in a machine-readable, allowlisted form; set is swappable.)
- HED scope: mature residues **1–182** (α1 1–90, α2 91–182), exon 2 + exon 3 = the
  peptide-binding domain, exactly the published definition. Grantham distance, canonical
  integer matrix.

## 2. Per-locus divergence: B > A > C

| Locus | n | mean HED | median | min | max |
|-------|---|----------|--------|-----|-----|
| HLA-A | 218 | 7.15 | 6.88 | 5.38 | 9.99 |
| HLA-B | 331 | 7.46 | 7.26 | 5.62 | 11.11 |
| HLA-C | 127 | 5.20 | 5.07 | 3.87 | 6.69 |

HLA-B alleles span the widest peptide-repertoire divergence and HLA-C the narrowest — the
expected ordering from known class I polymorphism, and an internal sanity check that the
pipeline is measuring genuine α1/α2 sequence divergence rather than an artifact. HLA-B also
shows the longest upper tail (the B57 family; see §4).

![Per-allele mean HED by locus]({{artifact:art_191ecedf-e7ab-49b7-89a8-00fbdc02e95c}})

*Each point is one common allele; the black bar is the per-locus median. The scalar plotted
is the mean pairwise exon-2/3 Grantham HED from that allele to every other common allele at
its locus — a population-divergence (allele-level breadth) proxy, not a per-individual
genotype HED.*

## 3. Pairwise structure

![Pairwise HED heatmaps per locus]({{artifact:art_37524af0-e5aa-490e-880d-7f9d6f8fba92}})

Hierarchically-clustered pairwise HED matrices show clear block structure within each locus
(allele families with shared α1/α2 sequence cluster into low-HED blocks), and HLA-C is
visibly less divergent (bluer) throughout — consistent with the per-locus summary. The dark
diagonal is self-HED = 0. A small number of distinct 2-field alleles have pairwise HED = 0
because they share an identical exon-2/3 sequence and differ only outside the peptide-binding
domain (e.g. A*02:01/A*02:09, B*44:02/B*44:27) — the correct behavior for an exon-2/3-scoped
metric.

## 4. Most- and least-divergent alleles per locus
Highest mean HED (broadest divergence from locus-mates):
- **HLA-A:** A*24:25 (9.98), A*23:05 (9.91), A*24:14 (9.65), A*24:95 (9.62), A*24:81 (9.55)
- **HLA-B:** B*57:04 (11.11), B*57:05 (10.62), B*57:02 (10.55), B*15:16 (10.47), B*57:01 (10.39)
- **HLA-C:** C*04:08 (6.69), C*01:08 (6.67), C*01:27 (6.56), C*04:05 (6.49), C*04:27 (6.44)

The B57 family occupying the top of the HLA-B distribution is notable for the downstream
hypothesis: B*57:01 (abacavir hypersensitivity anchor) sits at the 98th percentile of HLA-B
divergence.

## 5. Where the trade-off anchor alleles fall
These are the cancer-ICB driver alleles (Chowell et al. 2018) and the autoimmune/drug-reaction
anchors carried through the validation gate. HED here is the *breadth* baseline; the potency
interpretation belongs to the downstream engageability comparison — this table only reports
each anchor's position in the HED distribution.

| Allele | Context | mean HED (182) | 181-scope | within-locus pct | Chowell dir. |
|--------|---------|----------------|-----------|------------------|--------------|
| B*44:02 | ICB driver | 9.25 | 9.30 | 90th | favorable |
| B*44:05 | ICB driver | 8.98 | 9.03 | 87th | favorable |
| B*44:03 | ICB driver | 8.63 | 8.68 | 82nd | favorable |
| B*50:01 | ICB driver | 6.98 | 7.01 | 40th | favorable |
| B*18:01 | ICB driver | 6.78 | 6.82 | 34th | favorable |
| B*15:01 | ICB driver | 6.42 | 6.46 | 22nd | unfavorable |
| B*57:01 | abacavir | 10.39 | 10.45 | 98th | — |
| B*27:05 | ank. spondylitis | 9.59 | 9.65 | 94th | — |
| B*51:01 | Behçet | 7.66 | 7.70 | 62nd | — |
| B*15:02 | carbamazepine | 6.78 | 6.82 | 33rd | — |
| C*06:02 | psoriasis | 4.79 | 4.60 | 26th | — |
| A*29:02 | birdshot | 6.12 | 6.16 | 18th | — |

**Observation (hypothesis-generating, not a test):** within the B44/B62 ICB contrast, the
favorable B44 core (B*44:02/44:03/44:05) sits high in HLA-B divergence (82nd–90th pct) while
the unfavorable B62 driver B*15:01 sits low (22nd pct) — directionally consistent with
"higher breadth → better anti-tumor immunity." But the pattern is not clean: two favorable
B44-set members (B*18:01, B*50:01) sit mid/low, and the autoimmune anchors span the whole
range (C*06:02 low, B*27:05/B*57:01 very high). This is exactly why HED alone is treated as
the baseline and not the potency axis — a single breadth number does not separate the arms.
No statistical test of the trade-off is performed here; that is the downstream head-to-head.

## 6. Validation status
- HED algorithm reproduced the reference HLA-HED tool **exactly** (561/561 pairs,
  max Δ 1.8e-15).
- Grantham matrix = canonical published integer matrix.
- Scope caveat: primary values use 182 residues (task spec); the reference/published pipeline
  uses 181 (drops mature position 1, invariant in A/B but polymorphic G/C in C). Impact is
  negligible and rank-preserving for A/B (r=1.000) and small for C (r=0.950). Both columns are
  shipped in `hed_per_allele.csv`.
- All 6 Chowell ICB drivers + 6 autoimmune anchors retained at full length; 0 blockers.

## 7. Caveats and open items
- **Population-level, not genotype-level.** The per-allele scalar is mean divergence to other
  common alleles, a breadth proxy. Per-individual HED (divergence between an individual's two
  alleles at a locus) requires genotypes and is a separate computation.
- **Common-set dependence.** Values are computed *within* the 676 common alleles; the mean
  shifts if the common set is redefined (e.g. true CIWD 3.0). Rankings are robust; absolute
  means are set-relative.
- **Table S1 not loaded.** The Chowell supertype→allele membership roster (Supplementary
  Table S1) remains behind anti-bot challenges; supertype-level effects and named drivers are
  captured, the exhaustive 27A+50B membership is not.

## 8. Artifacts
- `hed_per_allele.csv` — per-allele mean/median/min/max HED (both scopes + Chowell annotation)
- `hed_pairwise_{A,B,C}.csv` — full pairwise HED matrices
- `common_alleles.parquet` / `common_alleles_list.csv` — the 676-allele set + representatives
- `alpha1_alpha2_alignment.parquet` / `.fasta` — full α1/α2 alignment for the engageability arm
- `grantham_matrix.csv`, `hed_validation.txt`, `methods_hed.md`
- `fig_hed_by_locus.png`, `fig_hed_heatmaps.png`

*Data: IPD-IMGT/HLA 3.64.0 (tag v3.64.0-alpha, 2026-04-16). Common set: CWD 2.0.0.
Method: Pierini & Lenz 2018 / Chowell et al. 2019 exon-2/3 Grantham HED.*
