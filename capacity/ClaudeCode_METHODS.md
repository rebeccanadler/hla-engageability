# Methods — Per-allele MHC-I presentation capacity across the somatic-mutation neoepitope, self, and trinucleotide-null peptide sets

This document describes the C4-RUN pipeline: a pan-allele NetMHCpan-4.1 binding screen that scores
three matched peptide sets against every allele in a fixed HLA class I catalogue, and emits one
per-allele summary table with the counts and denominators required for downstream binomial
inference. All numerical parameters (sample size *N*, binder threshold, allele list, peptide files)
were fixed before execution in a machine-readable decision file (`GATE_DECISION.json`) and are read,
not recomputed, by the run.

The pipeline performs **no** hypothesis testing, allele ranking, or capacity comparison. Those are
reserved for a separate downstream analysis (referred to here as S6); this repository produces only
counts and provenance.

---

## 1. Software and execution environment

| Component | Value |
|---|---|
| Predictor | NetMHCpan **4.1b** (`data/version` self-report: `NetMHCpan version 4.1b`) |
| Prediction heads | Eluted-ligand (EL) and binding-affinity (BA), via `-BA` |
| Invocation flags | `-p -BA` (peptide-list input, BA predictions on) |
| Container image | `netmhcpan_mcp:patched` (sha256 `b6d029ae…`), `linux/amd64` |
| Host | Apple M4 Pro (`arm64`); the amd64 container runs under Rosetta 2 emulation |
| Throughput (benchmark) | 0.181 s startup; ~3.33 ms / peptide / allele; ~300 peptides/s |

**Version-label caveat.** The container's Dockerfile renames the extracted directory
`netMHCpan-4.1` → `netMHCpan-4.2` and points `NMHOME` there, so output paths print `4.2`. This is a
directory label only; the binary, its `data/version` file, and its runtime banner all report
**4.1b**. The resolved version of record is 4.1b.

---

## 2. Peptide sets

Three sets are scored. The **unit of analysis** differs by set and is the object over which binder
status is aggregated (§4). For each unit, all overlapping 8–11-mer windows spanning the relevant
residue are generated (≤ 38 windows per unit: 4 lengths × up to 10–11 registers), deduplicated to
unique peptides for prediction, and re-associated to their owning unit(s) via a sidecar map.

| Set (CSV prefix) | Unit | Units *N* | Unique peptides scored | Map sidecar |
|---|---|---|---|---|
| Neoepitope (`neo`) | somatic missense variant | 2000 | 74,361 | `neoepitope_map.tsv` |
| Self (`self`) | reference proteome residue | 2000 | 74,579 | `self_map.tsv` |
| Trinucleotide null (`sim`) | simulated variant | 500 (= *N*/4) | 18,611 | `mc3_trinuc_null_map.tsv` |

### 2.1 Neoepitope set
Somatic missense variants from an MC3 PASS call set are mapped to SwissProt protein coordinates.
From a PASS universe of 1,400,558 variants, 1,167,281 mapped to a reference-consistent protein
position; after dropping variants whose every window matched wild-type (§7.1), 1,166,139 were
retained, from which **2000** were sampled. Each variant contributes the windows that contain the
**mutated** residue in its alternate form.

### 2.2 Self set
The universe is every residue of the reference proteome (11,416,105 positions). The reference
residues of the sampled neoepitope variants are excluded so the two sets are disjoint; **2000**
residues are then sampled, each contributing its overlapping wild-type windows.

### 2.3 Trinucleotide-null set
A mutation-spectrum–matched null: simulated single-nucleotide variants drawn to match the
MC3 PASS trinucleotide substitution spectrum over CDS opportunity sites, translated to missense
protein changes, and filtered identically to the neoepitope set. **500** simulated variants
(*N*/4) are retained. This is the single pre-registered null; a gene-matched null was considered
and declined.

### 2.4 Invariants verified at build time
- **Lengths:** 8–11 only, 0 violations.
- **Mutated residue present:** 0 windows missing the alternate residue across all neo (74,361) and
  null (18,611) windows.
- **Disjointness:** neo ∩ self = 0, null ∩ self = 0, null ∩ neo = 0.
- **Determinism:** rebuilding at *N* = 2000 reproduces byte-identical files (identical sha256).
  Sampling uses NumPy `SeedSequence(20260709)` spawned into independent per-arm generators; neo and
  null nest by ordered/permutation prefix, self resamples (its exclusion set differs across *N*).

---

## 3. Binder definitions

Two definitions are computed and reported **separately**; they are never composited.

**Primary — predicted affinity.** A window binds iff `Aff(nM) ≤ 500`. A single global 500 nM
threshold is used for all alleles. (Basis: Sette et al. 1994, *J Immunol*, PMID 7527444; IEDB
threshold guidance.)

**Secondary (descriptive) — eluted-ligand percentile rank.** Strong binder `%Rank_EL ≤ 0.5`; weak
binder `%Rank_EL ≤ 2.0` (NetMHCpan-4.1 defaults; Reynisson et al. 2020, *NAR*). These are reported
as counts for description only. Because `%Rank_EL` is graded against each allele's own
random-peptide background, the EL binder fraction is approximately fixed by construction across
alleles and cannot express cross-allele capacity — which is why affinity is primary.

---

## 4. Unit of analysis and aggregation

Binder status is assigned per **unit**, not per window: *a unit is a binder iff its best window
binds.* Concretely, for each unit the minimum `Aff(nM)` (and minimum `%Rank_EL`) over all of its
8–11-mer windows is taken, and the threshold is applied to that best value.

Aggregation is performed post-prediction from the sidecar map, which is **many-to-many**: a peptide
occurring in more than one unit's window list is credited to every owning unit. (In the self set,
114 peptides are each shared by exactly two residues; both are credited, so no unit loses a window
from its best-window maximum.)

Counts follow a Binomial(*N*, p_allele) model; per-allele confidence intervals are computed
downstream from the explicit unit denominators (§6). Per the frozen zeros policy, alleles with zero
binders are **retained** as rows (`binder_count = 0`, `units_N` unchanged) — never dropped,
imputed, or floored — so the downstream step can compute a rule-of-three bound from the row.

---

## 5. Allele catalogue and coverage

The catalogue of record is `allele_catalog.tsv`: **676** class I alleles (218 A, 331 B, 127 C), a
two-column table (`catalog_allele`, `locus`) carrying no engageability, HED, frequency, or
supertype fields by design. Catalogue names (`A*02:01`) are mapped to NetMHCpan names
(`HLA-A02:01`) by stripping any `HLA-` prefix and removing `*`, then membership-tested against the
predictor's supported-allele list. All 676 resolve to supported names (0 holes).

**Coverage ≠ training density.** NetMHCpan is pan-specific and predicts for alleles it never trained
on by interpolating from the MHC pseudosequence. Zero holes confirms only that every name resolves,
not that every allele is well-calibrated; the per-allele training-support columns (§7.2) carry that
information separately. The pipeline also records each allele's `Distance to training data` and
nearest-neighbour, as printed by NetMHCpan, in the per-task JSON.

---

## 6. Grid execution and reproducibility

The grid scores every (allele × set) pair: 676 × 3 = **2028 tasks**. Each task is a **single**
NetMHCpan invocation over the whole peptide file (no chunking, so the model loads once per task).
Tasks run in a thread pool of 10 concurrent containers.

### 6.1 Caching and resumption
Each task writes an atomic JSON count file stamped with a cache key:

```
sha256( peptide_file_sha256 | allele_nmpan | version=4.1b | flags='-p -BA'
        | aff_threshold_nM=500 | el_rank_sb=0.5 | el_rank_wb=2.0 | N )
```

where *N* is the set's unit count (2000 neo, 2000 self, 500 null). On (re)launch, a task whose count
file carries a matching key and whose raw output exists is skipped. The run is therefore
idempotent and survives interruption: relaunching resumes from disk and re-runs only unfinished
tasks. Raw stdout is stored gzipped and hashed; counts are parsed from disk, never held only in
memory. Writes are atomic (temp file + rename), so an interrupted task cannot leave a partial count
or output file.

### 6.2 Parsing safeguards
The parser resolves columns **by header name**, never by fixed position, and raises on any
structural or numeric anomaly: a missing required column, a non-numeric value in `%Rank_EL`,
`%Rank_BA`, or `Aff(nM)`, a non-alphabetic peptide field, a row-count mismatch against the expected
peptide count, or zero parsed rows. Silent zero-binder output from column misalignment is therefore
impossible — any misalignment aborts the task.

### 6.3 Input verification
Before any prediction, the runner re-computes the sha256 of all six inputs (three `.pep` files and
three `*_map.tsv` sidecars) and halts on any mismatch with `GATE_DECISION.json`. The summariser
repeats this check before it can write the artifact, so a summary can never be produced over inputs
that differ from the manifest.

---

## 7. Derived annotations

### 7.1 The wild-type–drop filter (neo-specificity)
When neoepitope windows are generated, any window whose exact sequence occurs anywhere in the
wild-type 8/9/10/11-mer proteome index is dropped (`pep not in WT`). Such a peptide is presented as
self elsewhere and is not a neoepitope. Short *k*-mers collide with the ~11 M-residue proteome far
more often than long ones, so 8- and 9-mers are dropped preferentially. This is a specificity
filter, **not** a terminus effect: a unit long enough to own a 10/11-mer necessarily could form an
8/9-mer, so a missing length reflects the drop, not protein geometry. Four neoepitope units
(in *ZNF724*, *PABPC5*, *LILRA3*, *AHNAK2* — all paralogous or repeat-structured loci) lose all of
their 8- and 9-mer windows this way and are scored on their 3 surviving 10/11-mer windows; they are
carried as-is. The self set, which is not neo-specificity-filtered, retains all four lengths for all
2000 units and loses only 114 windows to terminus truncation.

### 7.2 Training-support covariate
Two per-allele training-support counts are attached from the published NetMHCpan-4.1 training set
(`NetMHCpan_train.tar.gz`, sha256 `06f2c9f2…`), retrieved from the DTU Health Tech supplementary
site. **The two columns are on different scales and must never be summed.**

| Column | Definition | Head it supports |
|---|---|---|
| `train_support_n` | single-allele **positive eluted-ligand** instances (binary label, positives only), partitions `c000_el`…`c004_el` | EL (secondary) |
| `train_support_ba_n` | single-allele **binding-affinity measured** instances (continuous label, all rows, no threshold), partitions `c000_ba`…`c004_ba` | BA (primary) |

"Single-allele" means the training `allelelist` key maps to exactly one allele. `train_support_ba_n`
is head-matched to the primary (affinity) endpoint and is **not** filtered by any affinity
threshold, so it is not co-defined with the 500 nM binder cut.

**Multi-allele support is excluded and not recoverable.** The eluted-ligand training data is
predominantly multi-allele (≈ 8.75 M multi-allele vs ≈ 4.11 M single-allele rows), and the training
files carry only a per-dataset allele list, not a per-peptide allele assignment; attribution would
require re-running NNAlign_MA deconvolution, which is not done here. Because NetMHCpan-4.1's non-A
allele coverage derives disproportionately from multi-allele data, excluding it inflates the
A-locus share of apparent training support and understates B and C; partial correlations
conditioned on these columns therefore under-adjust B and C. A fuller decomposition
(`el_sa_pos`, `el_sa_total`, `ba_sa_n`, `ma_rows`, `ma_celllines`) is provided in
`prov/train_support.tsv`.

---

## 8. Outputs

All paths are under `C4_RUN/`.

### 8.1 `summary/per_allele_summary.csv` — the deliverable
One row per allele (676 rows), 24 columns. It is written to this canonical path only when the run is
**complete** (676 alleles) **and** the table passes a well-formedness validator (exact schema, 676
rows, frozen unit denominators on every row, no null/non-integer counts, non-empty provenance).
A run that is incomplete or malformed is diverted to a loudly-named side file and quarantined, never
deleted.

| Column | Meaning |
|---|---|
| `allele` | catalogue name (`A*02:01`) |
| `netmhcpan_name` | predictor name (`HLA-A02:01`) |
| `locus` | A / B / C |
| `supported` | resolves to a supported predictor allele (TRUE for all 676) |
| `neo_units_N`, `self_units_N`, `sim_units_N` | unit denominators (2000 / 2000 / 500) — **required** for binomial CIs |
| `neo_binder_count`, `self_binder_count`, `sim_binder_count` | units that bind (primary, best window ≤ 500 nM) |
| `neo_binder_fraction`, `self_binder_fraction`, `sim_binder_fraction` | count / units_N |
| `neo_rank_SB_count`, `neo_rank_WB_count` | neo units binding under the secondary EL rank (≤ 0.5 / ≤ 2.0) |
| `self_rank_SB_count`, `self_rank_WB_count` | same, self set |
| `neo_binder_fraction_{8,9,10,11}mer` | descriptive per-length breakdown (see note) |
| `train_support_n` | EL single-allele positives (§7.2) |
| `train_support_ba_n` | BA single-allele measured instances (§7.2) |
| `verification` | per-row provenance for the support columns (source, tarball hash, both definitions inline, `NOT_SUMMABLE_DIFFERENT_SCALES`, presence status) |

*Per-length note:* a unit is an L-mer binder iff its best window **of length L** binds; the
denominator is the number of units owning ≥ 1 window of length L (given per set in the coverage
table), which is ≤ `units_N`. These four fractions therefore do not average to
`neo_binder_fraction`.

### 8.2 `summary/coverage_table.tsv`
Per-locus catalogue coverage (rows, supported, holes, scored, listMHC per-locus totals) plus the
per-length unit denominators for each set, with `total_windows` (window slots, with multiplicity)
and `unique_peptides` (distinct sequences scored) reported separately.

### 8.3 `prov/VERSION.txt`
Predictor version, container digest, flags, thresholds, *N* / *N*_sim, catalogue of record, and the
training-support source, tarball hash, and definition.

### 8.4 `prov/SHA256_MANIFEST.txt`
sha256 of the six peptide inputs (verified against `GATE_DECISION.json`), the allele catalogue, all
2028 raw NetMHCpan outputs (hashes of the uncompressed stdout, stored gzipped), and the emitted
output files.

Raw per-allele NetMHCpan output (2028 gzipped files) is retained on disk and hashed, but is not part
of the portable artifact set — only the summary CSV is intended to be shared.

---

## 9. Provenance and limitations

- **Threshold provenance.** The 500 nM affinity cut is A\*02:01-derived (Sette 1994: A\*0201
  transgenic mice, A\*0201-motif peptides). NetMHCpan is pan-specific and interpolates from
  pseudosequence for untrained alleles, so this fixed global threshold is applied uniformly while
  the training-support columns (§7.2) carry the per-allele calibration signal separately.
- **Training-tarball provenance.** The training archive is corroborated but not authenticated: the
  server `ETag` first field (`571c971` = 91,343,217) equals both the `Content-Length` and the bytes
  on disk (a complete, untruncated transfer), and `Last-Modified` (2020-07-28) is contemporaneous
  with the NetMHCpan-4.1 release. DTU publishes no upstream checksum to verify against, so the
  self-computed sha256 establishes custody from retrieval onward only.
- **Emulation.** Predictions run on an amd64 binary under Rosetta on Apple silicon. This is a CPU
  translation layer for an integer/float numerical program; results are deterministic and match the
  version banner, but the environment is noted for completeness.
- **Interruption during the run.** The run tolerates host suspend/resume: a mid-run sleep pauses the
  process and its worker containers, and on wake the grid resumes and completes from cache. The
  final run completed all 2028 tasks with 0 errors.

---

## 10. What this pipeline does not do

It does not test hypotheses, rank alleles, compute per-locus contrasts, relate presentation to
training support, or comment on the spread of capacity across alleles. It emits counts, denominators,
and provenance. All inference is downstream and out of scope for this repository.

---

## Repository layout (run outputs)

```
C4_RUN/
├── scripts/
│   ├── run_grid.py        # grid driver: hash-verify, predict, parse, cache, resume
│   ├── summarize.py       # assemble + validate the artifact; emit coverage/version/manifest
│   └── launch.sh          # detached, resumable launcher (nohup)
├── summary/
│   ├── per_allele_summary.csv     # THE artifact (676 rows)
│   └── coverage_table.tsv
├── prov/
│   ├── VERSION.txt
│   ├── SHA256_MANIFEST.txt
│   └── train_support.tsv          # full training-support decomposition
├── raw/<ALLELE>/{neo,self,sim}.out.gz   # raw NetMHCpan stdout, gzipped + hashed
├── counts/<ALLELE>__<set>.json          # per-task parsed counts + cache key
└── run.log                              # append-only progress + terminal markers
```

## Reproducing the run

```bash
# From the repository root. Resumes from cache; safe to re-run.
P=10 ./C4_RUN/scripts/launch.sh          # detached; writes C4_RUN/run.log
python3 C4_RUN/scripts/summarize.py      # emits + validates the artifact when 676/676 complete
```

Inputs, thresholds, *N*, and the allele list are read from `GATE_DECISION.json`; peptide-file
hashes are verified against it before any prediction and again before the summary is written.
