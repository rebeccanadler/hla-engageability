# Results — Allele-frequency floors for the capacity panel

**Arm:** frequency-floor pre-step for HLA class I capacity panel selection.
**Status:** counts and frequencies only. No capacity, engageability, or HED value is
computed, read, or related to frequency anywhere in this arm. No floor is recommended;
threshold and scope are scientist decisions.

A companion file, [METHODS_allele_frequency_floors.md]({{artifact:art_cf9e1e6a-596e-4330-87d5-a7b76ccfa2cb}}),
documents provenance, the fetch, the subgroup→broad-group map, and every collapse.

---

## Summary

The 676-allele capacity catalog (HLA-A 218 / B 331 / C 127) was exported from the saved
engageability and HED tables — which have **identical membership** — and matched against
ancestry-stratified allele frequencies from the US NMDP registry (Gragert et al. 2013, via
AFND). For each allele the **frequency floor is the maximum across all 21 detailed NMDP
subgroups** (never pooled, never sample-size-weighted), so an allele common in one ancestry
and rare in others is not treated as rare. Five quantities are reported at
f ∈ {0.0005, 0.001, 0.005, 0.01, 0.02, 0.05}: alleles retained, distinct engageability
profiles (effective df), supertype coverage, per-population chromosome coverage, and loss of
project anchors.

Key structural facts a floor decision depends on:

- **20 of 676 alleles carry no registry frequency** and are held as a separate stratum that no
  floor removes. All 20 were verified as genuinely absent (their 2-field names existed in IMGT
  nomenclature at 3.4.0 but were unobserved in the panel), not nomenclature drift.
- **Distinct profiles are more robust to the floor than allele count.** The effective df — the
  quantity that governs statistical resolution — falls more slowly than the raw retained count as
  the floor rises, so a floor costs proportionally fewer profiles than alleles.
- **All 12 A/B supertypes remain represented at every floor** tested (≥1 member each).
- **Chromosome coverage is ancestry-unequal at high floors**: at f=0.05, HLA-B coverage is
  ~61 % in the Hispanic reference population versus ~81 % in Asian/Pacific Islander.
- **Two project anchors (A\*32:01, B\*39:06) are lost only at f=0.05**; all others survive to f=0.02.

---

## (1) Alleles retained

Floor = max frequency across the 21 detailed NMDP subgroups; matched stratum only (the 20
unmatched alleles are counted separately and retained at every floor).

| floor | A | B | C | A+B | total (matched) |
|------:|---:|---:|---:|----:|----------------:|
| 0.0005 | 72 | 149 | 43 | 221 | 264 |
| 0.001  | 64 | 133 | 39 | 197 | 236 |
| 0.005  | 45 | 89  | 33 | 134 | 167 |
| 0.01   | 39 | 76  | 33 | 115 | 148 |
| 0.02   | 32 | 58  | 27 | 90  | 117 |
| 0.05   | 23 | 30  | 22 | 53  | 75  |

Unmatched stratum (constant, kept at all floors): **A 7 / B 4 / C 9 = 20**.
Full catalog = 656 matched + 20 unmatched = 676.

![Retained allele count versus frequency floor, per locus. A+B pooled shown dashed; the 20 unmatched alleles are held as a separate stratum retained at every floor.]({{artifact:art_9c94f9fa-2648-419a-b2ed-6feffa9e88b7}})

---

## (2) Distinct engageability profiles (effective df)

Distinct profiles among retained alleles, using the project crest14 surface string with
complete-linkage clustering at three resolutions: exact identity (ceiling), Hamming ε=2, and
Grantham ε=6 (project weights). This is the quantity that governs effective degrees of freedom,
not the allele count.

**Baseline (no floor)** establishes the ceiling each floor is measured against:

| stratum | n_alleles | identity | Hamming ε=2 | Grantham ε=6 |
|---------|----------:|---------:|------------:|-------------:|
| A       | 218 | 81  | 27 | 16 |
| B       | 331 | 51  | 18 | 12 |
| C       | 127 | 20  | 6  | 5  |
| A+B     | 549 | 132 | 44 | 28 |
| all 676 | 676 | 150 | 49 | 30 |

**A+B pooled, across floors:**

| floor | alleles | identity | Hamming ε=2 | Grantham ε=6 |
|------:|--------:|---------:|------------:|-------------:|
| (none) | 549 | 132 | 44 | 28 |
| 0.0005 | 221 | 72  | 29 | 20 |
| 0.001  | 197 | 68  | 28 | 20 |
| 0.005  | 134 | 53  | 25 | 17 |
| 0.01   | 115 | 49  | 23 | 16 |
| 0.02   | 90  | 42  | 20 | 16 |
| 0.05   | 53  | 30  | 18 | 15 |

At Grantham ε=6, A+B holds 28 distinct profiles unfloored and still 20 at f=0.001, but falls to
15 at f=0.05. Over the same unfloored→f=0.05 range the A+B allele count falls 549→53 (a ~90 %
loss) while distinct profiles fall only 28→15 (~46 %): the floor compresses the effective df far
less than the allele count. The profile count is the constraint that matters for downstream power.

![Distinct engageability profiles versus floor at three resolutions (exact identity, Hamming ε=2, Grantham ε=6), per locus and A+B pooled. Effective df collapses more slowly than allele count.]({{artifact:art_c22f4ead-ad22-44d6-b9fd-ef5522d93955}})

---

## (3) Supertype coverage

Using the project A/B supertype map. **HLA-C has no supertype assignment in that map**
(`NULL_C_by_design`, 127 alleles) and is not scored here.

All **12 of 12** A/B supertypes stay represented (minimum ≥1 member each) at every floor from
0.0005 through 0.05 — no supertype is lost even at the most aggressive floor. The two bridge
supertypes A01A03 and A01A24 carry only 1–2 members throughout, so they are the first that a
higher floor would threaten.

| floor | supertypes represented | min alleles per supertype | supertypes lost |
|------:|:----------------------:|:-------------------------:|:----------------|
| 0.0005–0.05 | 12 / 12 | 1 | (none) |

![Retained allele count per A/B supertype across floors (log-scaled cells). All 12 supertypes remain represented at every floor; HLA-C carries no supertype assignment.]({{artifact:art_b9f2a7dc-ba73-405a-aa2f-af77bf7621f4}})

---

## (4) Chromosome coverage by reference population

Coverage = fraction of chromosomes at a locus carrying a retained allele, computed **per
reference population separately** (an average would hide ancestry disparity). Broad-group
HLA-B coverage at f=0.05:

| reference population | HLA-B coverage at f=0.05 |
|----------------------|:------------------------:|
| European American     | 76.8 % |
| African American      | 63.5 % |
| Hispanic              | 61.3 % |
| Asian/Pacific Islander| 81.0 % |
| Native American       | 77.3 % |

The gap between Hispanic (61 %) and API (81 %) at the same floor is an ancestry-equity signal,
not a rounding difference. At lower floors the gap closes (all groups >98 % at f=0.001).

**Minimum coverage across detailed subgroups (the equity number).** Reported two ways because
AFND's own data completeness varies:

| floor | locus | min across 21 (worst subgroup) | min across **data-complete** subgroups (worst) |
|------:|:-----:|:-------------------------------|:-----------------------------------------------|
| 0.01  | B | 6.1 % (Black S/C American — *data-incomplete*) | 92.0 % (Hispanic S/C American) |
| 0.05  | B | 0.0 % (Black S/C American — *data-incomplete*) | **60.2 %** (Hispanic S/C American) |
| 0.05  | A | 8.5 % (Black S/C American — *data-incomplete*) | 78.1 % (African) |
| 0.05  | C | 11.4 % (Black S/C American — *data-incomplete*) | 94.2 % (African) |

The raw min-across-21 is pinned at every floor to the **Black South or Central American**
subgroup, whose AFND frequencies sum to only 0.56 / 0.77 / 0.55 (A/B/C) across *all* its listed
alleles — an AFND data-completeness artifact, independent of any floor. One other subgroup is
mildly incomplete (Japanese, B-locus sum 0.91); the remaining 19 sum to ≈1.0. The meaningful
worst-covered subgroup at f=0.05 is **Hispanic S/C American HLA-B at 60.2 %**.

![Chromosome coverage versus floor per reference population (five broad groups), with the minimum across data-complete detailed subgroups overlaid. The equity gap widens at high floors.]({{artifact:art_9bd88764-2a25-455b-9728-a73dfc3e1bfb}})

---

## (5) Project anchors lost at each floor

Anchors are HLA alleles carrying a disease or ICB association used elsewhere in the project.
Losing one to a floor is a scope decision that must be visible before the floor is chosen.

**2-field anchors** — all survive to f=0.02; two are lost only at f=0.05:

| anchor | floor (max across 21) | lost at |
|--------|:---------------------:|:--------|
| B\*57:01 | 0.0676 | — |
| B\*27:05 | 0.0890 | — |
| B\*15:01 | 0.0850 | — |
| A\*31:01 | 0.0849 | — |
| B\*58:01 | 0.0874 | — |
| B\*13:01 | 0.0635 | — |
| A\*32:01 | 0.0493 | **f=0.05** |
| B\*39:06 | 0.0287 | **f=0.05** |

**A\*03 (allele GROUP, Naranbhai — not a 2-field allele).** 10 matched two-field members in the
catalog, plus A\*03:26 in the unmatched stratum (11 rows total). The group stays represented at
every floor via A\*03:01 (floor 0.14); the next-commonest member A\*03:02 (0.0175) drops at f≥0.02.
At f=0.05 only 1 of the 10 matched members survives, but the group is not lost.

**B44 driver set (five alleles sharing ONE grouped ICB estimate — reported together, not
collapsed).** B\*44:02 (0.095) and B\*44:03 (0.095) survive all floors; B\*44:05 drops at f≥0.005;
B\*44:04 drops at f≥0.001; **B\*44:27 is in the unmatched-kept-separate stratum**. The set retains
≥2 members at every floor.

---

## Deliverables

| file | contents |
|------|----------|
| [allele_catalog.tsv]({{artifact:art_420db791-6f08-41ae-a303-98ce3e69d28f}}) | 676-row catalog of record (`catalog_allele`, `locus`), sha256 in header |
| [allele_catalog_panel.tsv]({{artifact:art_d3f21c11-70d3-4fcb-be25-b1eaba8976b1}}) | 236-row floored panel (max-across-21 ≥ 0.001, 20 unmatched excluded), sha256 in header |
| [allele_panel_frequencies.tsv]({{artifact:art_5c5077c2-9425-4142-b5e4-fda21cab6b70}}) | full annotated table: per-subgroup frequencies, max-across-21 floor, per-value verification, absent classification, supertype, profile id, retained flags per floor |

Supporting per-quantity tables (`report_q1`–`report_q5`, populations, AFND completeness,
unmatched classification, baseline profile counts) are saved as CSV artifacts alongside.

No floor is selected. No capacity is computed. No relationship between frequency and
engageability is inspected. Those are scientist decisions.
