# Data access

**All inputs to this project are public / open-access. No controlled-access, restricted, or patient-identifiable data is used or committed to this repository.** The datasets below are de-identified public releases; each retains its own data-use terms, cited with its source. Large raw files are *not* re-hosted here — use the download scripts in `data/download/`. Only small, aggregated **derived** tables (per-allele summaries) are committed, in `data/derived/`.

## Primary datasets

| Dataset | What it's used for | Access | Version / accession |
|---|---|---|---|
| **TCGA MC3 public MAF** | somatic mutations for capacity peptides, APM dN/dS, trinucleotide null | GDC (open-access publication page) | `mc3.v0.2.8.PUBLIC` |
| **MSK-IMPACT (public)** | HLA-LOH loss/retention, within-patient LOH pressure, somatic selection | cBioPortal (public study) | e.g. `msk_impact_2017` / MSK MetTropism `msk_met_2021` |
| **IPD-IMGT/HLA** | HLA class I allele sequences (α1/α2, α3), Bw4/Bw6, reference haplotype | EBI IPD-IMGT/HLA | release **3.64.0** |
| **Allele Frequency Net Database (AFND)** + NMDP (Gragert 2013) | allele-frequency floors, frequency controls, ancestry strata | allelefrequencies.net | as retrieved (record date in methods) |
| **VDJdb** | CDR3β repertoire diversity for the TCR-diversity arm | vdjdb.cdr3.net / GitHub release | release pinned in `arms/` provenance |
| **UniProt reviewed human proteome** | self-peptide set, WT k-mer index | UniProt | UP000005640, organism 9606, canonical |
| **PDB / TCR3d / STCRDab** | TCR–pMHC crystal complexes for the crest footprint (243 complexes); landmarks 1AO7, 1AKJ | RCSB PDB / TCR3d / STCRDab | accessions in `arms/engageability` provenance |

## External tools (installed separately; not redistributed here)

Some arms call external binaries that carry their own licenses — install them yourself; we do not redistribute them.

- **NetMHCpan-4.1** — peptide–MHC binding (capacity arm). DTU academic license.
- **dNdScv** (R) — somatic selection / dN/dS (APM arm). MIT, GitHub `im3sanger/dndscv`.
- **EvoEF2** — CD8/α3 ΔΔG (alpha-3 arm). Open source.
- **LOHHLA** — HLA-LOH allele-copy calling (LOH arm). McGranahan lab.
- **MSIsensor / MANTIS** — MSI status for hypermutator stratification (APM arm).

## Provenance discipline

Every constant in this project is "fetched-or-flagged": it traces to fetched primary text, recorded in a `verification` column or provenance ledger in the relevant `arms/` folder. Two checks were run before any number left a session — source reconciliation (was this number fetched?) and prose-to-table reconciliation (does the sentence match the table it cites?).

## What is committed vs fetched

- **Committed:** code, methods, results, pre-registration, figures, and small aggregated derived tables (per-allele engageability, HED, capacity, fraction-lost, dN/dS summaries).
- **Fetched by script (not committed):** the large raw inputs above (MAFs, full IMGT sequences, VDJdb dumps, proteome). See `data/download/`.
- **Never committed:** nothing patient-identifiable exists in this project; `.gitignore` additionally blocks common raw-data and patient-file patterns as a safeguard.
