# Methods & provenance — engageability ↔ recruited-TCR-repertoire diversity (VDJdb arm)

Companion to `RESULTS_engageability_tcr_diversity.md`. This file records data provenance, the frozen
pre-registration, the filter/cleaning rules, the effective-N and MDE machinery, and the full confound
design. The governing principle throughout is **fetched-or-flagged** (rule 1): no number, tag,
accession, or statistic enters an artifact without in-session retrieval.

---

## 1. Data provenance (recorded at fetch)

| field | value |
|---|---|
| database | VDJdb (`github.com/antigenomics/vdjdb-db`) — **VDJdb only**, no McPAS/IEDB pooling |
| release tag | **2026-05-16** ("Blooming May release"), published 2026-05-18T21:39:08Z |
| master commit SHA | `33890018950e8bb607fe50537a01389b1160d5ac` |
| download | `vdjdb-2026-05-16.zip`, sha256 `0dce79ec55c109000da10b7bc72300e352ffb7df92d5de30682de20bab35a366`, 34,643,377 bytes |
| access (UTC) | 2026-07-09T18:10:08Z |
| table | `vdjdb.txt` (full), 228,034 data rows |

Pooling McPAS/IEDB is explicitly excluded — it would corrupt the reference structure the analysis
controls for. Full text: [`vdjdb_provenance.txt`]({{artifact:70fa676f-e2f3-4333-9648-83d860504a6a}}).

---

## 2. Pre-registration (frozen before any data was fetched)

The complete frozen prereg is [`prereg_engageability_tcr_diversity.md`]({{artifact:d0dd3522-d539-4458-aa4e-c0b390cf3fd0}}).
It commits, before fetch, to: the diversity measure (mean pairwise normalized Levenshtein among
CDR3β, normalized by max length, rarefied, within-epitope then averaged); thresholds
(K = 20 / M = 3 / depth d = 5 primary, plus (10,2,5) and (50,5,10)); confidence cutoff
(vdjdb.score ≥ 1); 4-digit-resolvable HLA only, coarse excluded and counted; the dedup key; the
effective-N (independent-profile) rule; the sign convention (higher engageability → higher recruited
diversity; a significant **negative** is falsification, not reframed); and the Gate-1 lift condition
(rule 6) verbatim. It names **no** VDJdb version — the tag, SHA, and access date were recorded at
fetch time.

**Amendments folded in before execution** (all made while blind, under the correction license):
- **A1** — effective N reports (i) exact-identity profile count, (ii) Hamming and Grantham ε-ladder
  clustering, (iii) the engageability_A distribution of qualifiers vs the 676-allele catalog.
- **A2** — the MDE injects per-profile rarefaction SE as measurement noise on simulated diversity;
  "compute NO diversity index" relaxed to "diversity is blind until engageability is joined."
- **A3** — the null is built at entry grain (block-resample references within alleles) because the
  allele × reference bipartite structure is material.
- **A4** — no memory-typed items: the dual-role crest/pocket overlap is derived at runtime from
  structures, never pre-answered; release tags never typed from memory.
- **R1** no powered/not-powered gate (MDE reported alongside the association always); **R2** rule 6(e)
  → per-locus descriptive, leave-one-locus-out; **R3** rule 6(c) → sign retained & |Δρ| ≤ ½ primary;
  **R4** entry-grain fallback = reference-clustered bootstrap; **6(f)** (added blind, now frozen) — the
  Gate-1 bound cannot lift from an analysis whose blind power ≤ 0.16 regardless of p.

---

## 3. Cleaning and the filter waterfall

| step | rows retained |
|---|---|
| 0. VDJdb full table (data rows) | 228,034 |
| 1. gene == TRB | 124,913 |
| 2. species == HomoSapiens | 114,128 |
| 3. mhc.class == MHCI | 110,972 |
| 4. vdjdb.score ≥ 1 | 12,945 |
| 5. valid CDR3β aa (≥5, canonical) | 12,945 |
| 6. V and J gene present | 12,945 |
| 7. antigen.epitope present | 12,945 |
| 8. HLA resolvable to 4-digit (942 coarse excluded) | 12,003 |
| 9. dedup (allele, epitope, cdr3b, V, J) | **5,430** |

**HLA resolution rule:** keep `locus*field1:field2`, truncate 3rd/4th fields, drop any entry with no
2nd field (coarse) — the 942 coarse entries are counted, not silently dropped. **Dedup key:**
(allele, epitope, cdr3b, V, J). Final: **5,430 distinct clonotypes, 48 class I alleles, 330 epitopes**
(locus rows A = 3,702 / B = 1,671 / C = 57). Donor (`meta.subject.id`) is present in 88% of the clean
set and is carried where parseable; because it is often absent, `reference` is the primary handle on
study structure (raising the stakes on the A3 entry-grain null). Table:
[`vdjdb_filter_waterfall.csv`]({{artifact:d535946c-a31e-46f0-9cba-636a8ccc9968}}).

---

## 4. Effective N and profile clustering

An allele **qualifies** at threshold (K, M, d) if ≥ K distinct TCRs are seen across ≥ M epitopes each
reaching depth d, and (item-1 rule, settled blind) receives a diversity value only if ≥ 2 of its
epitopes reach depth d (`m_d ≥ 2`) — otherwise its "diversity" would rest on a single epitope with no
cross-epitope average. This drops A\*68:01 and B\*15:01 from the primary set (15 → 13 alleles).

**Profiles** are exact-identity clusters on the **14 engageability-determining crest positions**
(62, 63, 65, 66, 69, 70, 73, 76, 151, 152, 158, 163, 166, 167). The 13 primary alleles → **11 exact
profiles** (merges: {B\*35:01, B\*35:08} and {B\*08:01, B\*18:01}). Grantham weighting uses coefficients
α = 1.833, β = 0.1018, γ = 0.000399; complete-linkage across the ε-ladder. Tables:
[`qualifying_by_threshold_md2.csv`]({{artifact:a3be7e1c-357c-414e-9371-a44264c034c9}}),
[`profile_epsilon_ladder_md2.csv`]({{artifact:b289a8f4-13ff-4b6d-a7fe-a4cb35419c75}}).

**Crest-merge verification** — the two merges were checked independently against IPD-IMGT/HLA
`B_prot.txt` (reference B\*07:02:01:01), a different parse path from the crest table:
{B\*08:01, B\*18:01} = `RNQITNTERVATEW` (identical, different supertypes B08/B44, 7/27 pocket diffs);
{B\*35:01, B\*35:08} = `RNQITNTERVALEW` (same B07 family). No indexing bug.
[`crest_merge_verification.csv`]({{artifact:8ec80d99-cff4-45d6-8761-f85c0fc8530c}}).

---

## 5. Diversity index and MDE machinery

**Index:** mean pairwise normalized Levenshtein among CDR3β (÷ max length), rarefied to depth d = 5
within each epitope, averaged over B = 200 rarefaction draws, then averaged across an allele's/
profile's epitopes. Per-allele rarefaction SE comes from the draw spread; the reference-block SE
(A3) from resampling references within each allele.

**MDE:** power simulated via a Gaussian copula (4,000 sims/point) at n = 11–13 profiles, α = 0.05
two-sided, **one** primary estimand → no multiplicity correction. Three arms: noise-free;
+ rarefaction noise (per-profile SE injected on simulated diversity, the A2-mandated lead read);
+ reference-clustered noise. The permutation null critical value is derived from B = 20,000
within-structure permutations (MC-SE ~0.001). Inversion (profiles needed to detect ρ = 0.4 at 80%)
computed on the same noise model. Tables:
[`mde_spearman.csv`]({{artifact:3ab961b1-d583-4f71-b222-b33e76da1fcd}}),
[`mde_across_ladder.csv`]({{artifact:bb07353e-1c21-43a5-b3d9-ac5cb178eaf7}}),
[`mde_inversion.csv`]({{artifact:55597527-65b9-43a1-83df-dadb82f76b82}}),
[`catalog_profile_universe.csv`]({{artifact:59834cf6-7910-4714-8c0c-efb9a0ceb459}}).

---

## 6. Confound design (proposed after seeing data shape, before any association)

**One primary estimand:** Spearman ρ between engageability_A and the primary within-epitope rarefied
CDR3β diversity, at profile grain, K = 20 / M = 3. Every other layer is reported **only** as a Δ from
the primary (sign retained? |Δρ| vs primary magnitude?) — no layer gets its own featured p-value, so a
subset can never be promoted against the full-set sign.

**Included layers (each justified without reference to any result):**
- **L1 rarefaction** — mandatory; depth is wildly unequal (A\*02:01 3,080 vs A\*68:01 31 entries).
- **L2 reference / entry-grain null** — the named live risk (rule 3); bipartite structure material
  (29/165 refs span >1 allele, 37% of entries) → entry-grain null; R4 = reference-clustered bootstrap.
- **L3 leave-A2-supertype-out** — A\*02:01 = 57% of entries; criterion sign retained & |Δρ| ≤ ½ primary
  (R3). In the m_d≥2 set A\*02:01 is the only A02 member, so this is operationally leave-A\*02:01-out.
- **L4 HED-partial** — engageability must predict beyond peptide-repertoire breadth to be a distinct axis.
- **L5 AFND frequency control** — a signal that vanishes under frequency control **is** the finding.
- **L6 per-locus** — descriptive (A/B/C), leave-one-locus-out (R2); C contributes near-zero qualifiers.
- **L7 dual-role crest split** — runtime audit (A4): peptide-contacting MHC positions = heavy-chain
  residues ≤ 4.0 Å from peptide in RCSB **1HHK, 1AKJ, 3PWN**, consensus ≥ 2/3. **8 of 14 crest positions
  are dual-role** (63, 66, 70, 73, 76, 152, 163, 167); 6 crest-only (62, 65, 69, 151, 158, 166). Because
  8/14 are dual-role, engageability is not structurally orthogonal to the peptide groove, so the primary
  is re-run on the 6 crest-only positions as a fixed (untuned) sensitivity. Provenance:
  [`dual_role_audit.json`]({{artifact:d1276546-2bea-418d-9f86-4eaad70868d8}}).

**Declined layer (recorded decision):**
- **D1 CDR3β length partial** — normalized Levenshtein tracks CDR3β length, but the primary index is
  within-epitope, and epitope (15.7%) + V-gene (12.0%) explain most length variance while median
  within-epitope length SD is only 1.6 aa. A length partial would remove real repertoire signal more
  than artifact; length is instead reported descriptively. A length-partialled sensitivity is flagged
  as trivially addable, not silently omitted.

Full text: [`confound_design.md`]({{artifact:7e1a853c-9879-4e4c-9c32-9d35fdd9375f}}).

---

## 7. Artifact index (latest version_ids)

**Documents** — prereg `d0dd3522-d539-4458-aa4e-c0b390cf3fd0` · confound design
`7e1a853c-9879-4e4c-9c32-9d35fdd9375f` · full blind+Part-2 report
[`report_engageability_tcr_diversity.md`]({{artifact:645fd000-7293-4c15-8228-3afb1ddcef93}}).

**Data tables** — filter waterfall `d535946c-a31e-46f0-9cba-636a8ccc9968` · qualifying-by-threshold
`a3be7e1c-357c-414e-9371-a44264c034c9` · ε-ladder `b289a8f4-13ff-4b6d-a7fe-a4cb35419c75` ·
reference/donor structure `1ed15c0d-0191-4e19-9b29-b6d989b331d2` · within-subset HED
`f30ea192-e0a4-4842-8890-d25d6a3421fd` · crest-merge verification
`8ec80d99-cff4-45d6-8761-f85c0fc8530c` · MDE `3ab961b1-d583-4f71-b222-b33e76da1fcd` · MDE ladder
`bb07353e-1c21-43a5-b3d9-ac5cb178eaf7` · MDE inversion `55597527-65b9-43a1-83df-dadb82f76b82` ·
catalog profile universe `59834cf6-7910-4714-8c0c-efb9a0ceb459` · Part-2 full results
`d06ca4a0-39bd-4d55-a786-f8f6b0360bb9` · Part-2 profile table `ec4f74f9-4fec-49cc-8ce7-4bbed4b33547` ·
Gate-1 evaluation `62afc82e-4635-485a-8df3-5488615588c2`.

**Figures** — filter flow `17f95bab-9156-46ea-afd8-e8e29bd0adba` · effective N
`f5ee4cd0-8d91-46fd-8f6c-a6adc535d986` · reference structure `86eae14f-822a-4668-a931-4b6d4f63e1a7` ·
MDE power curve `624b0cc1-5f02-4f35-a38a-a359a01dab67` · MDE ladder/inversion
`9934a812-2d73-4801-8085-88c247634887` · Part-2 association `1367a413-0ea5-435f-abb8-1839d0fbd861` ·
Part-2 forest `888fcd10-72fa-4745-bb23-b1d56198c47d`.
