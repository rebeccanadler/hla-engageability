# Manifest — mapping your `Claude Science Hackathon` folder into this repo

Your working folder is organized by experimental arm. This repo keeps that structure under `arms/`. Run `assemble_local.sh` (below) to copy each arm folder in, or copy them by hand using this map. **Before pushing, review each arm folder and remove any large raw data — only results, methods, figures, provenance, and small derived tables belong in git.**

## Arm-folder map (`<your folder>` → `arms/<slug>`)

| Your folder | → repo slug |
|---|---|
| `engageability arm` + `engageability master` | `arms/engageability` |
| `engageability-tcr diversity arm` | `arms/engageability_tcr_diversity` |
| `HED arm` | `arms/hed` |
| `HED pos control arm` | `arms/hed_positive_control` |
| `capacity arm` | `arms/capacity` |
| `peptide selection` | `arms/peptide_selection` |
| `HLA allele freq` | `arms/allele_frequency` |
| `a3 domain arm` | `arms/alpha3_cd8` |
| `cancer arm` | `arms/cancer` |
| `autoimmune risk arm` | `arms/autoimmune_risk` |
| `tradeoff arm` | `arms/tradeoff` |
| `drug hsr arm` | `arms/drug_hsr` |
| `infection control arm` | `arms/infection_control` |
| `LOH arm` + `LOH arm comprehensive` | `arms/loh` |
| `S11` | `arms/loh` (S11 Part B, mismapping negative control) |
| `msk50k internal arm` | `arms/msk50k_internal` |
| `somatic selection of apm arm` | `arms/somatic_selection_apm` |
| identifiability note (in `engageability master`) | `arms/identifiability` |

> **Excluded from the submission:** the `cancer mimic demo arm` (viral/molecular-mimicry structural demo) is intentionally left out — it did not make the final project or presentation. Do not copy it into `arms/`.

## What still needs to be added by you

1. **Code.** The per-figure analysis code lives in your Claude Science / Claude Code sessions, not in the results folder. Export the scripts (Python for the metric/stats/NetMHCpan wrapper; R for dNdScv) into `code/` (or into each arm folder), so every figure has a runnable source. This is the single most important thing for the research track.
2. **Derived tables.** Copy the small aggregated CSVs (per-allele engageability, HED, capacity, fraction-lost, dN/dS summaries) into `data/derived/` and point the notebook at them.
3. **Pre-registration.** Copy the frozen prereg documents into `prereg/`.
4. **Pin environments.** `pip freeze > environment/requirements.lock.txt` and `sessionInfo()` → `environment/r_session_info.txt`.
5. **Fill the download script.** Add the exact URLs/accessions in `data/download/fetch_public_data.sh`.
