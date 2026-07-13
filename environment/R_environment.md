# R environment (somatic-selection / dN/dS arm)

The APM somatic-selection arm uses **dNdScv** (trinucleotide-aware dN/dS), which is R.

## Install

```r
install.packages("devtools")
devtools::install_github("im3sanger/dndscv")
# Bioconductor dependencies (as needed):
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("GenomicRanges", "Biostrings", "MASS", "seqinr"))
```

## Configuration used

- Background fit **genome-wide** (all ~3.6M coding substitutions), not restricted to the gene set under test.
- `cv = NULL` as the conservative default; cross-checked against `cv = "hg19"`.
- Per-gene CIs via `geneci()`.
- Consequence classes split: missense (`wmis`) vs truncating (`wnon`) vs frameshift indels.

## Recording your exact environment

Before submitting, capture the exact versions:

```r
writeLines(capture.output(sessionInfo()), "environment/r_session_info.txt")
```

and commit `r_session_info.txt`. If you use `renv`, commit `renv.lock` instead.
