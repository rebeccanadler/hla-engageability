# Figure index — each figure → the claim it supports → the arm/code that made it

Reproducibility contract: every figure below traces to a script in `code/` (or the arm folder) and reads from `data/derived/` or a `data/download/` fetch. Filenames in the right column are the source figures in the `arms/` folders; copy the ones you use into `figures/` for the write-up.

| Claim | Figure (source) | Arm folder |
|---|---|---|
| The hypothesis (antagonistic pleiotropy) | `figures/fig_hypothesis_schematic.png` (custom) | — |
| What engageability measures (TCR-facing crest) | `F2_tcr_footprint.png` | `arms/engageability` |
| Engageability is a new axis, r = −0.02 vs HED | `F1_engageability_vs_HED.png` | `arms/engageability` |
| Potency is multi-axis (HED vs engageability, same spec) | `fig_hed_vs_engageability_sidebyside.png` | `arms/hed_positive_control` |
| Capacity is a third axis; ceiling at supertype grain | `fig_capacity_vs_hed.png` | `arms/capacity` |
| Non-identifiability of escape vs elimination | `identifiability_theory.png` | `arms/identifiability` |
| Underpowered by construction (blind power curve) | `fig_mde_power_curve.png` | `arms/engageability_tcr_diversity` |
| The two-arm trade-off, honestly null | `fig_tradeoff_engageability_two_arm.png` | `arms/tradeoff` |
| B2M positive control / HLA-C negative control (dN/dS) | `fig_dnds_stratified.png`, `fig_dnds_apm.png` | `arms/somatic_selection_apm` |
| **B\*58:01 preferential loss (Bradley–Terry)** | `fig_loh_BT_strengths.png` | `arms/loh` |
| Loss is not a mapping artifact (negative control) | `fig_s11_negcontrol.png` | `arms/loh` |
| Reproduced published positive control (KRAS G12V) | `fig_g1_positive_control.png` | `arms/loh` |
| Translational: deleted vs retained → therapy targets | `figures/fig_translational_targets.png` (custom) | — |
| Summary / close | `figures/fig_summary_close.png` (custom) | — |

See `docs/SLIDE_MAP.md` for the full presentation ordering and `docs/FRAMING.md` Part 2 for the graded figure list.
