# S10 — Somatic-Selection Crest: Does HLA Engageability Predict Which Homolog Is Lost?

**Arm:** Somatic HLA-LOH selection (Class I). **Cohort:** MSK-IMPACT 50k.
**Status:** B1 power gate + B2 confirmatory primary + degeneracy re-anchor complete. Numbers reported;
disposition is Rebecca's. **Binding spec:** S10 prereg §2–§6 + Amendment A.

---

## 0. Question and contribution

Among informative allele-specific HLA-LOH events, **is the LOST homolog the higher-engageability one
more often than chance, conditional on Δ_PHBR?** Engageability (the α1/α2 crest metric `engageability_A`)
measures how permissive an allele's surface is to diverse TCR docking. Conditioning on Δ_PHBR is the
whole point: *unconditioned*, "lost = higher-engageability" would merely recover the well-known fact that
better-presenting alleles are preferentially lost. The confirmatory claim is whether the crest adds
anything **beyond the groove**.

**Honest framing.** The depletion + PHBR engine reproduces Marty 2017 (PMID 29107334) — that is
implementation, not novelty; novelty is against the field, not the source paper. HED and the trade-off
concept are prior work. The **only novel claim in this arm is the crest homolog-contrast.** The
within-patient homolog design is immune to the Van den Eynden trinucleotide critique (mutational context
is identical across a patient's two homologs).

---

## 1. B1 — Power gate (pre-stated, before the direction was seen)

The detectable-effect floor was fixed *before* any association direction was inspected. Effective sample
size is **N_eff = 134** (Simpson), not the 1,866 focal-event rows: the 1,866 events collapse to 590
distinct allele pairs → Simpson 1/Σpᵢ² = 134, so event count overstates power ~13.9×.

Expressed as **π = P(lost homolog has higher engageability)** (null π = 0.5, set by the label-flip
permutation):

| anchor | π_MDE | OR_MDE |
|---|---|---|
| **Magnitude-weighted (model-faithful, headline)** | **0.654** | **1.89** |
| Magnitude-agnostic sign test (floor) | 0.621 | 1.64 |

Monte-Carlo verification reproduced the analytic values (MC π_MDE ≈ 0.655 vs analytic 0.654). Because
|Δ_ENG| magnitudes are heterogeneous (CV = 0.79), a few large contrasts dominate, so the model-faithful
test is *less* powerful than an equal-weight sign test — the higher MDE (0.65) is the honest headline.

**Pre-registered resolution-limit rule.** If the true conditional crest π sits below ~0.62–0.65, this
design at N_eff = 134 cannot reach 80% power; a released-B2 null would then be a **RESOLUTION-LIMIT**
result (bounded by ~134 effective contrasts), not a biological null — same disposition as E-HED-PC / E-REP.

![B1 power gate: crest MDE power curves (both anchors) and the Δ_ENG magnitude marginal over the 1,866 focal events]({{artifact:7f7b80b9-2c60-4a94-bbb7-a65e8349e126}})

*Figure 1. Left: power vs true crest preference π at N_eff = 134, two-sided α = 0.05; the magnitude-weighted anchor (red, π_MDE = 0.65) is less powerful than the equal-weight sign test (blue, π_MDE = 0.62). Right: |Δ_ENG| per focal event (mean 0.77, SD 0.60, rms 0.97).*

---

## 2. B2 — Confirmatory primary and control battery

**Freeze:** `g3_primary_focal_events.csv`, N = 1,866, not rebuilt. Composite
**engageability_A = (z_het − z_absnetchg − z_hydimb)/3** (exact). Exposure Δ_ENG = eng(lost) − eng(retained);
covariate Δ_PHBR = presentation(retained) − presentation(lost) on the patient's own carried hotspots.

**Estimator (stated; prereg leaves it to the executor):** paired conditional logit (Bradley–Terry /
event-stratum form), statistic **β_ENG** = within-event log-odds that the lost homolog is
higher-engageability, holding the covariates. Anchor = joint label-flip permutation (B = 10,000, canonical
seed). Ties (Δ_ENG = 0, n = 64) excluded. Descriptive proportion π and Wilcoxon reported alongside.

> **A methods correction is folded into these numbers.** The first B2 pass conditioned via the intercept
> of an OLS on mean-centered covariates — which is algebraically forced to equal the unconditioned mean and
> therefore did *no* conditioning. It was replaced with the paired conditional logit above, whose β_ENG
> genuinely moves when covariates are added. All values below are from the corrected estimator.

### 2.1 Event / exclusion counts
1,866 focal events; 64 ties excluded → **1,802 informative**. Δ_PHBR defined for **1,048** events (1,022
informative) — the patient carries ≥1 of the 190 panel hotspots; undefined for 818 by construction of the
estimand (those patients carry none of the panel hotspots).

### 2.2 Unconditional correlations (reported up front — the artifact controls)
|Δ_ENG| is positively selected on divergence and reference-likeness distance, exactly as at the Stage A
per-het-locus level (0.367 / 0.163) — which is *why* divergence/Δ_REF is the decisive artifact control:

| correlation (focal events, Spearman ρ) | ρ | p | n |
|---|---|---|---|
| \|Δ_ENG\| vs divergence | +0.284 | 5.5e-36 | 1,866 |
| \|Δ_ENG\| vs \|Δ_REF\| | +0.199 | 4.3e-18 | 1,866 |
| \|Δ_ENG\| vs \|Δ_FREQ\| | +0.131 | 1.9e-08 | 1,837 |
| \|Δ_ENG\| vs \|HED (Δ_PBD)\| | +0.062 | 7.6e-03 | 1,866 |

### 2.3 Primary result (event-unit anchor)
| analysis | n | β_ENG | OR per unit Δ_ENG (95% CI) | perm p | π (descr.) | Wilcoxon |
|---|---|---|---|---|---|---|
| Unconditioned | 1,802 | +0.1549 | 1.168 (1.063–1.282) | 0.0013 | 0.5405 | 2e-4 |
| **Δ_PHBR-conditioned** | 1,022 | **+0.1580** | **1.171 (1.035–1.326)** | **0.0113** | 0.5372 | 7e-3 |

Conditioning on Δ_PHBR does **not** attenuate the crest — β_ENG rises slightly (0.155 → 0.158) and
presentation does not predict the direction. On the event unit, the crest adds signal beyond the groove.

### 2.4 Controls — all eight, signal survives every covariate (event unit)
| control | n | β_ENG | OR per unit (95% CI) | perm p |
|---|---|---|---|---|
| unconditioned | 1,802 | +0.1549 | 1.168 (1.063–1.282) | 0.0013 |
| +Δ_PHBR (primary) | 1,022 | +0.1580 | 1.171 (1.035–1.326) | 0.0113 |
| +Δ_PBD (HED) | 1,022 | +0.1762 | 1.193 (1.052–1.352) | 0.0052 |
| +Δ_REF (divergence undirected → uncond only) | 1,022 | +0.1748 | 1.191 (1.051–1.350) | 0.0048 |
| +Δ_FREQ | 1,007 | +0.1565 | 1.169 (1.033–1.324) | 0.0134 |
| European-only (cond) | 786 | +0.2050 | 1.227 (1.069–1.410) | 0.0035 |
| leave-A*02:01-out (uncond) | 1,435 | +0.2316 | 1.261 (1.111–1.431) | 0.0002 |
| leave-A*02:01-out (cond) | 815 | +0.2219 | 1.248 (1.058–1.473) | 0.0084 |

- **No artifact control attenuates β_ENG;** adding HED or Δ_REF slightly *increases* it.
- **Negative control** (engageability permuted within locus, 5 trials): π = 0.491, 0.480, 0.500, 0.509,
  0.501 → mean 0.496, all perm p non-significant (0.088–0.784). Centres on null. ✓
- **leave-A*02:01-out** *strengthens* the signal (β 0.155 → 0.232, p = 0.0002) — A*02:01 is not leverage.
  NB A*02:01 is preferentially lost (the selection direction), so the drop removes events in the signal
  direction yet the effect grows; this is not bias-correction.
- **Per-locus (all three):** A π = 0.534, **B π = 0.605**, C π = 0.503. Signal is strongest at **locus B**,
  not A — the source reports A strongest for loss, so an A-driven caller artifact would predict A strongest;
  here B carries it and C is null.
- **Per-component:** z_het π = 0.549 (p < 1e-4) and hydrophobic_imbalance π = 0.536 (p = 5e-4) carry the
  signal; abs_net_charge is null (π = 0.489, p = 0.88); CONSERVED group near-invariant (392 informative).

### 2.5 Novelty — HED is not engageability
Cohort event-weighted r = −0.050; frozen catalog r = −0.029 (Spearman −0.038, n = 676). Both near zero
→ engageability is not HED. One value per claim, weighting stated (not averaged).

![B2 primary and control battery]({{artifact:22d9ac5d-f742-4af8-b1d9-5effd01b60da}})

*Figure 2. (a) Conditional-logit OR per unit Δ_ENG with 95% CI — primary and all covariate/subset controls, every interval excluding 1.0 at the event unit. (b) Negative control (engageability permuted within locus) centres on the null; true assignment is the red diamond. (c) Per-component: the crest is carried by heterogeneity and hydrophobic imbalance, not net charge.*

---

## 3. Degeneracy re-anchor — the independence unit matters

Per prereg §4 ("event count is not power"), the label-flip anchor was re-run at three independence units,
reusing the identical β_ENG estimator and canonical seed (β_ENG is invariant across anchors; only the
permutation-null SD changes). The 130 focal alleles carry only **56 distinct engageability values** — below
the 134 distinct-pair Simpson N — so supertype-identical alleles (e.g. B*57:01 ≡ B*58:01) share one value.
Because an event is a *contrast between two* values, the faithful degeneracy-collapsed unit is the
**value-pair** (274 units on the full informative set), not a single-value partition; 56 is the ~55-contrast
theoretical ceiling, not a realizable flip-partition count.

| primary | anchor | indep. units | β_ENG | perm-null SD | perm p |
|---|---|---|---|---|---|
| Unconditioned | event | 1,802 | +0.1549 | 0.0477 | 0.0013 |
| Unconditioned | allele pair | 575 | +0.1549 | 0.0523 | 0.0022 |
| Unconditioned | value-pair | 274 | +0.1549 | 0.0593 | 0.0073 |
| Δ_PHBR-cond | event | 1,022 | +0.1580 | 0.0627 | 0.0113 |
| Δ_PHBR-cond | allele pair | 405 | +0.1580 | 0.0702 | 0.0242 |
| Δ_PHBR-cond | value-pair | 218 | +0.1580 | 0.0885 | **0.0708** |

The null SD widens monotonically as the unit coarsens (the E-HED-PC direction: the event unit understates
because it prices independence at the row count). **Where each primary crosses p = 0.05:**

- **Unconditioned:** significant at every unit (max p = 0.0073 at value-pair).
- **Δ_PHBR-conditioned (the sole confirmatory claim):** crosses 0.05 **between the pair unit (0.0242) and
  the value-pair unit (0.0708)** — it is **not significant at the degeneracy-collapsed value-pair unit.**

**Locus-B decomposition** (B is the whole signal; B is also the canonical degeneracy locus, B*57:01 ≡
B*58:01): π_B = 0.605, β_ENG(B) = +0.601; **224 distinct allele pairs, 98 value-pairs, 20 distinct values**;
top pair 2.8% (B*07:02 / B*57:01). The B result rests on **98 independent value-pair contrasts** and holds
at **p = 0.0001** under both the pair and value-pair anchors — B does not lose significance under coarsening.

![B2 degeneracy re-anchor]({{artifact:1e02d9ff-aa45-46c3-90eb-4806ba76c4d9}})

*Figure 3. (a) Permutation-null SD of β_ENG widens as the flip unit coarsens (event → allele pair → value-pair), for both the unconditioned and Δ_PHBR-conditioned primaries. (b) Two-sided perm p on the same axis; the conditioned primary crosses p = 0.05 at the value-pair (degeneracy-collapsed) unit while the unconditioned primary stays below it.*

---

## 4. What stands, and the open disposition

- **Point estimate (all units):** β_ENG = +0.158 conditioned on Δ_PHBR, OR ≈ 1.17 per unit Δ_ENG,
  π ≈ 0.54. The direction — lost homolog is the higher-engageability one — is stable and **not** explained
  by presentation (Δ_PHBR), repertoire breadth (HED), caller mapping bias (Δ_REF / divergence), frequency,
  ancestry, or A*02:01 leverage. The negative control centres on null.
- **Inference depends on the independence unit.** At the event and allele-pair units the conditioned
  primary is significant (p = 0.011, 0.024); at the honest value-pair unit it is not (p = 0.071). This is
  the pre-registered resolution-limit regime (B1: MDE π ≈ 0.62–0.65; observed π ≈ 0.54 sits below it).
- **Locus B** carries the signal and survives coarsening (p = 0.0001 at 98 value-pair contrasts), but B is
  also the canonical supertype-collapse locus — per the pre-committed dispositions, a result that lives or
  dies on B and the degeneracy audit is the standing supertype-collapse mode, reported not featured.

**No verdict.** Whether the governing independence unit is the event, the allele pair, or the value-pair —
and therefore whether this is the metric's first outcome-anchored positive or its first properly powered
resolution-limited null — is Rebecca's disposition, against B1's MDE and the 56 < 134 resolution floor.

---

*Companion tables and frozen inputs: `S10_results_tables.md`. Underlying CSVs: `b2_primary.csv`,
`b2_controls.csv`, `b2_perlocus.csv`, `b2_negcontrol.csv`, `b2_percomponent.csv`,
`b2_unconditional_corr.csv`, `b2_reanchor_units.csv`, `b2_locusB_decomposition.csv`. Per-event master
table: `b2_master_events.parquet`. Stage reports: `stage_b1_mde_report.md`, `s10_b2_primary_report.md`,
`s10_b2_reanchor_report.md`.*
