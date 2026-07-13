#!/usr/bin/env bash
# Copy your local "Claude Science Hackathon" arm folders into this repo's arms/ structure.
# Run this LOCALLY (on your Mac), from the repo root, after unzipping the scaffold.
#
#   bash assemble_local.sh "/Users/rnadler/Desktop/Claude Science Hackathon"
#
# It copies each arm folder to a clean slug under arms/. It does NOT copy anything into git
# by itself — review the result and let .gitignore exclude large raw files before committing.
set -euo pipefail

SRC="${1:-}"
if [[ -z "$SRC" || ! -d "$SRC" ]]; then
  echo "usage: bash assemble_local.sh \"/path/to/Claude Science Hackathon\"" >&2
  exit 1
fi

copy () {  # copy "<src subdir>" "<dest slug>"  (merges if dest exists)
  local from="$SRC/$1" to="arms/$2"
  if [[ -d "$from" ]]; then
    mkdir -p "$to"
    rsync -a --exclude '.DS_Store' "$from"/ "$to"/
    echo "  $1  ->  arms/$2"
  else
    echo "  (skip, not found) $1" >&2
  fi
}

echo "Assembling arms/ from: $SRC"
copy "engageability arm"              "engageability"
copy "engageability master"          "engageability"
copy "engageability-tcr diversity arm" "engageability_tcr_diversity"
copy "HED arm"                       "hed"
copy "HED pos control arm"           "hed_positive_control"
copy "capacity arm"                  "capacity"
copy "peptide selection"             "peptide_selection"
copy "HLA allele freq"               "allele_frequency"
copy "a3 domain arm"                 "alpha3_cd8"
copy "cancer arm"                    "cancer"
copy "autoimmune risk arm"           "autoimmune_risk"
copy "tradeoff arm"                  "tradeoff"
copy "drug hsr arm"                  "drug_hsr"
copy "infection control arm"         "infection_control"
copy "LOH arm"                       "loh"
copy "LOH arm comprehensive"         "loh"
copy "S11"                           "loh"
copy "msk50k internal arm"           "msk50k_internal"
copy "somatic selection of apm arm"  "somatic_selection_apm"
# NOTE: "cancer mimic demo arm" (viral/molecular-mimicry demo) is intentionally excluded from the submission.

echo
echo "Done. Next:"
echo "  1. Move the frozen pre-registration .md files into prereg/"
echo "  2. Export analysis code from your Claude sessions into code/"
echo "  3. Copy small aggregated CSVs into data/derived/ and point the notebook at them"
echo "  4. Review for large raw files (.maf/.fasta/.tgz) — .gitignore should exclude them"
