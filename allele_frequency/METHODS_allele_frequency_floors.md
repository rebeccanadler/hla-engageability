# Methods — Allele-frequency floors for the capacity panel

Companion to [RESULTS_allele_frequency_floors.md]({{artifact:art_dd4dc6b9-209f-4df4-925b-3e691036eb54}}).
This arm is a counts/frequencies pre-step: no capacity, engageability, or HED value is
computed or read here.

---

## 1. Catalog (exported, not re-derived)

The 676-allele catalog was taken verbatim from the membership of two saved project tables,
not re-pulled from IMGT (a newer release would silently desync capacity from every other axis):

- `engageability_scores.csv` (version 5f19dea6-f51d-4aa4-bd9e-0c4fe3d4e62c)
- `hed_per_allele.csv` (version c6390124-6e26-4efa-a732-6a36ebb349b4)

**Membership gate.** The two tables were checked for identical membership before any downstream
work; the gate passed (676 = 676, symmetric difference empty). Per locus: A 218, B 331, C 127.
The IMGT/HLA release the saved tables were built from is **3.64.0** (α1/α2 alignments fetched
2026-04-16), confirmed from the version header of the `A_prot.txt`/`B_prot.txt`/`C_prot.txt`
alignment files that are direct lineage inputs to the HED table.

---

## 2. Frequencies (fetched, not remembered)

**Source.** Allele Frequency Net Database (allelefrequencies.net); dataset = Gragert et al.
2013, *Human Immunology* 74:1313–1320 — six-locus high-resolution HLA haplotype frequencies for
the entire US NMDP / Be The Match registry, EM-estimated, built on IMGT/HLA 3.4.0. AFND access
date **2026-07-09**. The dataset identity was confirmed from the AFND population detail page
(citation, sample sizes) rather than assumed.

**Population enumeration (fetched, not typed).** The NMDP population list was retrieved from
AFND. It contains **21 detailed subgroups** with pop_ids 3201–3223; 3203 and 3221 are not NMDP
populations (that gap explains any "3201–3223 = 23" miscount). Sample sizes match Gragert 2013
exactly, from European Caucasian (n = 1,242,890) down to Alaska Native or Aleut (n = 1,376).
The full ID/name/n list is saved as `report_nmdp_populations.csv`.

**Fetch.** For each of 21 subgroups × 3 loci, all paginated result pages were fetched and
parsed to (allele, frequency, sample n). 7,918 allele-frequency rows total, zero duplicate
(allele, population) rows, spot-checked against source HTML. Raw parsed long table saved as the
checkpoint `afnd_nmdp_raw.parquet`.

**Resolution / caveat.** Gragert frequencies are EM-estimated from registry typing, much of it
low- or intermediate-resolution imputed to high resolution. Two-field frequencies for rare
alleles therefore carry more uncertainty than their point estimates imply.

---

## 3. Matching and collapses

**2-field matching.** The AFND NMDP data are already reported at 2-field resolution, so **no
4-field → 2-field summing and no catalog collapse were required**. This was verified, not
assumed (all 7,918 rows parsed to exactly 2 fields).

**Absent stratum (absent ≠ zero).** 20 of 676 catalog alleles have no AFND row in any subgroup
(A 7 / B 4 / C 9). Rather than assign them frequency 0 (which every floor would cut), they are
held as a **separate visible stratum that no floor removes**. Each was classified as genuinely
absent versus nomenclature drift by fetching the authoritative IMGT/HLA records —
`Allelelist_history.txt` (the name each allele carried at every release, including 3.4.0) and
`Deleted_alleles.txt` — and comparing the 3.4.0 column against 3.64.0. **All 20 are genuinely
absent**: their 2-field names already existed in IMGT nomenclature at 3.4.0 but were unobserved
in the NMDP panel, consistent with being rare. None is a case of the catalog name differing
from what Gragert would have reported. Classification table: `report_unmatched_classification.csv`.

Whether the 20 unmatched alleles enter the panel is a scope decision, not a threshold's — the
floored panel catalog excludes them by construction, but they remain in the catalog of record.

---

## 4. Floor definition

For each allele, **floor = max frequency across all 21 detailed NMDP subgroups** — no weighting,
no collapse to broad groups. Rationale: registry sample sizes reflect who enrolled, not
population sizes, so a broad-group frequency is a recruitment-weighted average dominated by the
largest-recruited subgroup. Taking the max across detailed subgroups prevents an allele common
in one ancestry and rare in others from being diluted to a middling value and cut. An
empty per-subgroup frequency cell means the allele is absent from that subgroup's panel
(distinct from an observed 0.0).

---

## 5. Broad-group map (chromosome coverage only)

The 5 broad NMDP reference groups are used **only** for the per-population chromosome coverage
in Results §4, where a population-level frequency is the quantity of interest. The floor never
uses them. Assignment of the 21 subgroups → 5 broad groups (standard NMDP race scheme):

- **European American:** European Caucasian; Middle Eastern or North Coast of Africa †
- **African American:** African American pop 2; Caribbean Black; African; Black S/C American
- **Hispanic:** Mexican or Chicano; Hispanic S/C American; Caribbean Hispanic
- **Asian/Pacific Islander:** South Asian Indian; Chinese; Korean; Filipino; Vietnamese;
  Southeast Asian; Japanese; Caribbean Indian †; Hawaiian or other Pacific Islander
- **Native American:** North American Amerindian; American Indian S/C America; Alaska Native or Aleut

† Two placements are analyst judgment calls flagged for review (the floor is unaffected, as it
uses all 21 subgroups directly): MENA → European American, and Caribbean Indian (South-Asian
ancestry) → Asian/Pacific Islander.

**AFND data completeness.** Per-subgroup allele-frequency sums were checked against the expected
≈1.0. 19 of 21 subgroups are complete; two are not — Black South or Central American
(A/B/C sums 0.56/0.77/0.55) and Japanese (B-locus 0.91). This is recorded in
`report_afnd_completeness.csv` and is why the minimum-coverage equity number in Results §4 is
reported both raw-across-21 and across data-complete subgroups.

---

## 6. Distinct-profile method

Distinct engageability profiles (Results §2) use the project's established method, reproduced
from the `profile_epsilon_ladder` lineage: each allele is reduced to its **crest14** string (14
TCR-facing α1/α2 surface residues); pairwise distances are Hamming (residue mismatches) or
Grantham (project weights α=1.833, β=0.1018, γ=0.000399); alleles are clustered by
complete linkage and profiles counted at ε ∈ {0 (exact identity), 2 (Hamming), 6 (Grantham)}.
Validated against the full catalog (150 identity profiles among 676). This is a count of
surface diversity; it reveals no capacity or engageability effect and is pre-registration-safe.

---

## 7. Floored panel catalog

`allele_catalog_panel.tsv` is the subset of the catalog of record with max-across-21 frequency
≥ 0.001, all three loci, excluding the 20 unmatched alleles: **236 rows (A 64 / B 133 / C 39)**,
matching the pre-registered expectation exactly. The 676-row `allele_catalog.tsv` is retained
unchanged as the catalog of record. Both files carry N, per-locus counts, floor definition,
source tables, IMGT release, and a sha256 of the data body in their header comments.
