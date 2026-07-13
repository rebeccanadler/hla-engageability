# Results — S10 Locus-B: is the within-patient engageability→loss signal at HLA-B a finding or a B-specific artifact?

*Arm: S10 Locus-B artifact battery. Class I only, allele-level, within-patient homolog contrasts on public MSK-IMPACT 50K LOH events. All inputs read-only and frozen; nothing rebuilt. Every value ○ (provisional) pending Rebecca's reconciliation.*

---

## Summary

The engageability→loss "crest" is strongest at HLA-B (π_B = 0.605), and locus B is the only within-patient, outcome-anchored signal in the project that did **not** collapse under degeneracy re-anchoring (β_B ≈ 0.60, perm p = 0.0001 at the value-pair unit). We asked at HLA-B specifically whether that β_B ≈ 0.60 is crest signal or a B-specific artifact.

β_B **survives** the caller (divergence/Δ_REF), marginal-leverage, and leave-out controls, but is **absorbed by Bw4/Bw6**: adjusting for the Bw4/Bw6 dimorphism nearly halves β_B (0.60 → 0.33) and drops it below significance, robustly to removing B\*57:01/B\*58:01. Because the Bw4/Bw6 epitope (α1 residues 77–83) lies **outside** the engageability crest footprint, a genuine crest signal should have been orthogonal to it; instead it is fully explained by it. The obtained branch is therefore **"survives but attributable to Bw4/Bw6 → KIR-ligand confound, not crest."** β_B ≈ 0.60 at HLA-B does not graduate as crest signal.

---

## Data and freeze checks

| input | check | status |
|---|---|---|
| `g3_primary_focal_events.csv` | frozen focal set, **N = 1,866** confirmed on load | ✓ |
| `engageability_scores.csv` | **N = 676** confirmed | ✓ |
| `b2_master_events.parquet` | 1,866 events × 16 cols; carries the LOH / Δ_PHBR / Δ_REF / divergence / Δ_FREQ / HED fields B2 used | ✓ |
| estimator | paired conditional logit (Bradley–Terry, Newton-IRLS) + joint label-flip permutation, seed 20260711 — carried **verbatim** from the B2 reanchor lineage, not reinvented | ✓ |
| reproduction | β_B = **0.6008**; per-pair perm p = 0.0001 (224 units); per-value-pair perm p = 0.0001 (98 units) — exact match to `s10_b2_reanchor_report.md` | ✓ |

**Locus-B subset.** 366 B events; **354 informative** (Δ_ENG ≠ 0); π_B = 0.6045; 224 distinct allele pairs; **98 distinct engageability value-pairs** (the independence unit); 20 distinct single engageability values; 60 distinct B alleles. All permutation anchors below use the **value-pair unit** — the most conservative, degeneracy-collapsed choice.

**Bw4/Bw6 assignment.** Assigned from α1 residues 77–83 in the frozen alignment (canonical serological discriminator: Arg83 → Bw4, Gly83 → Bw6). Motifs reproduce known serology exactly (B\*57:01/58:01/44:02/51:01/27:05/13:02 → Bw4; B\*07:02/08:01/35:01/15:01 → Bw6). Full coverage of all 60 B alleles, zero ambiguous calls (23 Bw4, 37 Bw6).

---

## Figure

![S10 Locus-B artifact battery. (a) β_B under each covariate control at the value-pair permutation anchor; β_B survives divergence/Δ_REF/PHBR/HED/FREQ but collapses under Bw4/Bw6 (red = perm p ≥ 0.05). (b) Per-B-allele marginal loss fraction (lollipop; dot size ∝ n events; black ring = binomial q < .05 for loss ≠ 0.5), colored by Bw class — preferentially-lost alleles are disproportionately Bw4. (c) Within-B leave-outs; β_B stays 0.46–0.59 (p ≤ 0.0015) and is not driven by B\*57:01 or B\*57/58. (d) Bw4 alleles trend higher-engageability, and in Bw-discordant events the lost homolog is Bw4 73% and the higher-engageability homolog is Bw4 75%.]({{artifact:art_2c1130f6-4491-4c6d-8f6f-df8b77150618}})

---

## The four checks at HLA-B

### 1. Reference / divergence (the caller keys on divergence) — β_B **survives**
Within B, corr(|Δ_ENG|, divergence) = Spearman ρ = 0.211 (p = 6.5e-5) — present but weaker than the panel-wide 0.367 ○; corr(|Δ_ENG|, |Δ_REF|) = 0.018 (n.s.). Adding the directional caller control leaves β_B unmoved: **+Δ_REF → β_B = 0.587, p = 0.0001**; +Δ_REF+Δ_PHBR → 0.634, p = 0.0005. **The caller-artifact branch is not obtained.**

### 2. Marginal per-B-allele loss (leverage?) — β_B is **not** leverage
Leave-one-allele-out never removes more than 0.063 of β_B (largest: B\*57:01, 0.601 → 0.538; then B\*14:02 −0.050, B\*38:01 −0.045). No allele carries the signal. Per-allele loss fractions do track Bw class: preferentially-**lost** alleles are Bw4 (B\*57:01 0.83, B\*58:01 0.85, B\*49:01 0.85, B\*13:02 0.72, B\*27:05 0.75); preferentially-**kept** are Bw6 (B\*07:02 0.34, B\*08:01 0.25, B\*14:02 0.27). **The leverage/collapse branch is not obtained.** Full breakdown in `s10_locusB_per_allele_loss.csv`.

### 3. Bw4/Bw6 as a separate covariate — β_B **collapses** (the decisive control)
The frozen crest footprint (§8.5 audit) is {58, 62, 63, 65, 66, 68–70, 72, 73, 75, 76, 146–167} — residues **77–83 are not in it**. Per §8.5, a β_B surviving Bw4/Bw6 adjustment would have been positive evidence for crest. β_B does the opposite:

| model | β_B | perm p |
|---|---|---|
| unconditioned | 0.6008 | 0.0001 |
| **+ Bw4/Bw6** | **0.3251** | **0.067** |
| + Δ_REF + Bw4/Bw6 | 0.3532 | 0.052 |
| full (+Δ_REF+Δ_PHBR+HED+Δ_FREQ+Bw4) | 0.3972 | 0.085 |
| leave-B\*57/58-out **+ Bw4** | 0.2924 | 0.069 |

Adjusting for Bw4/Bw6 nearly halves β_B and drops it below significance — and it stays down after also removing B\*57:01/58:01, so this is not a two-allele coincidence.

### 4. Within-B leave-outs (incl. standing leave-B\*57:01-out rule) — β_B **robust**, range 0.46–0.59
| leave-out | n | β_B | perm p |
|---|---|---|---|
| leave-B\*57:01-out | 325 | 0.5379 | 0.0002 |
| leave-B\*57/58-out | 312 | 0.4860 | 0.0010 |
| leave-Bw4-crest-out (B57/58/27/53/51) | 270 | 0.4619 | 0.0015 |
| leave-top-lost-out (B57:01/58:01/49:01/13:02) | 270 | 0.5884 | 0.0001 |

β_B is not the property of any allele set, including B\*57:01. But this robustness is to **allele identity**, not to the Bw4/Bw6 epitope — which is shared across every leave-out set.

---

## Mechanism (stated, not asserted)

Candidate mechanisms {Bw4/Bw6, B\*57/B\*58 biology, crest structure}:

- **Bw4/Bw6 — supported / decisive.** β_B collapses to 0.29–0.40 (n.s.) under Bw4/Bw6 adjustment, robustly to dropping B\*57/58. The mechanism is coherent and external to the metric: Bw4 (residues 77–83) is the **KIR3DL1/DS1 ligand epitope**. Bw4 alleles trend higher-engageability (mean 0.35 vs 0.14; corr(Δ_ENG, Δ_Bw4) = 0.39). Among the 187 Bw-discordant events, the **lost homolog is the Bw4 allele in 73.3%** (binomial p < 0.0001 vs 0.5) and the **higher-engageability homolog is the Bw4 allele in 74.9%** — loss and engageability both track the Bw4 epitope. β_B is reading Bw4-preferential loss (NK/KIR-driven), which correlates with engageability but is not caused by the crest.
- **B\*57/B\*58 biology — excluded as sole driver.** Leave-B\*57/58-out leaves β_B = 0.49 (p = 0.001).
- **Crest structure — excluded.** The crest footprint deliberately omits 77–83, so a crest signal should be orthogonal to Bw4/Bw6; instead it is fully absorbed. No crest-specific residual survives.

**Branch obtained:** *"survives but attributable to Bw4/Bw6 → KIR confound, not crest."*

---

## Interpretation and limits

β_B ≈ 0.60 at HLA-B is robust to the caller and to allele leave-outs — which is why it alone did not collapse under degeneracy re-anchor — but that robustness traces to the Bw4/Bw6 KIR-ligand epitope, which lies outside the engageability crest. The signal is a **B-specific KIR-ligand confound, not the somatic-selection crest.** This is a candidate/artifact verdict, not a headline: it does not displace the S10 §2 null-panel primary, and it reopens no frozen rule. Immunoediting stays demoted (untouched here). One HED–engageability correlation per claim (none re-derived here).

The graduate/dissolve and admission call is Rebecca's; this arm reports the numbers, the branch, and the mechanism.

---

## Artifacts

- `RESULTS_s10_locusB.md` — this file
- `fig_s10_locusB_battery.png` — 4-panel battery figure (embedded above)
- `s10_locusB_disposition.md` — disposition memo (decision card; provenance ○/✓ per value)
- `s10_locusB_controls.csv` — β_B under each covariate control (Fig a)
- `s10_locusB_leaveouts.csv` — within-B leave-out battery (Fig c)
- `s10_locusB_leave_one_allele.csv` — leave-one-allele-out impact on β_B (Fig b support)
- `s10_locusB_per_allele_loss.csv` — per-B-allele loss fractions, Bw class, binomial test (Fig b)

*Inputs (read-only, frozen): `g3_primary_focal_events.csv` (1,866), `engageability_scores.csv` (676), `b2_master_events.parquet`, `alpha1_alpha2_alignment.parquet`. Estimator and permutation anchor carried verbatim from the B2 reanchor lineage. Data source per the S10 Stage-A provenance ledger (`s10_provenance_ledger.md`, fetched-and-verified upstream, not re-verified here): public MSK-IMPACT 50K — Zenodo 10.5281/zenodo.18445440; cBioPortal msk_impact_50k_2026; PMID 41895280.*
