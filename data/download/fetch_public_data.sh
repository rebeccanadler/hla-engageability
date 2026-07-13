#!/usr/bin/env bash
# Fetch the public / open-access inputs for this project into data/raw/ (gitignored).
# All sources are public and were fetched by the analysis sessions; exact accessions,
# versions, and (where recorded) checksums are baked in below. See ../../DATA_ACCESS.md.
#
# A few sources are served behind a query/portal rather than a single static file
# (cBioPortal, AFND) — those steps document the exact study/dataset ID and the endpoint;
# confirm the study is still listed if a download 404s.
set -euo pipefail
RAW="$(cd "$(dirname "$0")/.." && pwd)/raw"
mkdir -p "$RAW"
cd "$RAW"
echo "Downloading into: $RAW"

# ------------------------------------------------------------------ 1. TCGA MC3 public MAF
# mc3.v0.2.8.PUBLIC — GDC file UUID 1c8cfe5f-e52d-41ba-94da-f15ea1337efc
# Publication page: https://gdc.cancer.gov/about-data/publications/mc3-2017  (Ellrott 2018, PMC6075717)
# GRCh37/GENCODE; 3,600,963 open-access coding substitutions; 10,123 patients used genome-wide.
echo "[1/8] TCGA MC3 public MAF"
curl -L --fail -o mc3.v0.2.8.PUBLIC.maf.gz \
  "https://api.gdc.cancer.gov/data/1c8cfe5f-e52d-41ba-94da-f15ea1337efc"

# ------------------------------------------------------------------ 2. cBioPortal — MSK-IMPACT 50k
# Study ID used: msk_impact_50k_2026 (HLA-LOH, within-patient LOH pressure, APM panel-presence).
# Public study — download the bundle from the datahub, or the study "Download" tab:
#   https://www.cbioportal.org/study/summary?id=msk_impact_50k_2026
echo "[2/8] cBioPortal MSK-IMPACT 50k (msk_impact_50k_2026)"
curl -L --fail -o msk_impact_50k_2026.tar.gz \
  "https://cbioportal-datahub.s3.amazonaws.com/msk_impact_50k_2026.tar.gz" \
  || echo "  -> if 404: grab the bundle from the study Download tab (URL above); study ID unchanged."

# ------------------------------------------------------------------ 3. cBioPortal — MSI scores (TCGA PanCancer Atlas)
# MSIsensor (MSI_SENSOR_SCORE) + MANTIS (MSI_SCORE_MANTIS) across the 20 TCGA PanCancer Atlas cohorts
# (8,409 scored samples). Pull the clinical/MSI columns per cohort, e.g. *_tcga_pan_can_atlas_2018.
echo "[3/8] cBioPortal TCGA PanCancer Atlas MSI scores"
echo "  -> Fetch MSI_SENSOR_SCORE / MSI_SCORE_MANTIS from the 20 *_tcga_pan_can_atlas_2018 studies"
echo "     (cBioPortal datahub or web API: https://www.cbioportal.org/). See DATA_ACCESS.md."

# ------------------------------------------------------------------ 4. IPD-IMGT/HLA 3.64.0
# Release 3.64.0, tag v3.64.0-alpha (dated 2026-04-16). Class I protein alignments + allele history.
echo "[4/8] IPD-IMGT/HLA 3.64.0 (ANHIG/IMGTHLA, tag v3.64.0-alpha)"
IMGT_BASE="https://raw.githubusercontent.com/ANHIG/IMGTHLA/v3.64.0-alpha"
for f in alignments/A_prot.txt alignments/B_prot.txt alignments/C_prot.txt Allelelist_history.txt; do
  curl -L --fail --create-dirs -o "imgt/$(basename "$f")" "$IMGT_BASE/$f"
done

# ------------------------------------------------------------------ 5. Allele Frequency Net Database (AFND)
# Dataset: Gragert et al. 2013 US NMDP / Be The Match (EM-estimated, built on IMGT/HLA 3.4.0).
# 21 detailed NMDP subgroups, pop_ids 3201-3223 (3203, 3221 excluded). AFND access date 2026-07-09.
echo "[5/8] AFND — NMDP Gragert 2013 frequencies"
echo "  -> Query per population at http://www.allelefrequencies.net/ (pop_ids 3201-3223)."
echo "     CWD/2-field helper: nmdp-bioinformatics/py-ard (pyard/loader/CWD2.csv). See DATA_ACCESS.md."

# ------------------------------------------------------------------ 6. VDJdb (TCR-diversity arm)
# Release 2026-05-16 "Blooming May" (published 2026-05-18), commit 3389001. sha256 verified below.
echo "[6/8] VDJdb 2026-05-16"
curl -L --fail -o vdjdb-2026-05-16.zip \
  "https://github.com/antigenomics/vdjdb-db/releases/download/2026-05-16/vdjdb-2026-05-16.zip"
echo "0dce79ec55c109000da10b7bc72300e352ffb7df92d5de30682de20bab35a366  vdjdb-2026-05-16.zip" \
  | shasum -a 256 -c - || echo "  WARNING: VDJdb checksum mismatch — re-download."

# ------------------------------------------------------------------ 7. UniProt reviewed human proteome
# reviewed:true AND organism_id:9606, canonical only (20,431 entries; reference proteome UP000005640; release 2026_02).
echo "[7/8] UniProt Swiss-Prot reviewed human (canonical)"
curl -L --fail -o uniprot_reviewed_9606_canonical.fasta.gz \
  "https://rest.uniprot.org/uniprotkb/stream?query=reviewed:true+AND+organism_id:9606&format=fasta&compressed=true"

# ------------------------------------------------------------------ 8. Structural landmarks + inventory
# TCR-pMHC crystal inventory n=243 (TCR3d superset; STCRDab-assigned chains).
# Landmarks: 1AO7 (HLA-A*02:01 / TCR), 1AKJ (CD8 / alpha-3).
echo "[8/8] PDB landmark structures"
for pdb in 1AO7 1AKJ; do
  curl -L --fail -o "${pdb}.pdb" "https://files.rcsb.org/download/${pdb}.pdb"
done
echo "  -> Full 243-complex inventory: TCR3d (https://tcr3d.ibbr.umd.edu/) + STCRDab"
echo "     (https://opig.stats.ox.ac.uk/webapps/stcrdab/). Accessions in arms/engageability provenance."

# ------------------------------------------------------------------ External tools (not data; install separately)
# NetMHCpan-4.1 (DTU academic license) · dNdScv R pkg im3sanger/dndscv (refcds_hg19.rda) ·
# EvoEF2 https://github.com/tommyhuangthu/EvoEF2 · LOHHLA (McGranahan lab) · MSIsensor / MANTIS.

echo
echo "Done. Raw files in $RAW (gitignored). IEDB (used to MEASURE the A*02:01 ascertainment bias that"
echo "disqualified it as a capacity substrate) was queried via the IEDB next-gen API"
echo "(https://www.iedb.org/); see arms/peptide_selection provenance for the exact query."
