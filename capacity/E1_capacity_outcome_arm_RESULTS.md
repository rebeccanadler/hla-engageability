# E1 — Capacity Outcome Arm: Results

**Question.** Does the C4 *presentation-capacity* axis (how readily an allele's binding groove presents peptide, distinct from engageability and from HED) predict clinical outcomes in the two arms of the antagonistic-pleiotropy test — anti-tumor immunity (ICB benefit) and autoimmune risk?

**Disposition (operative): HONEST-NULL branch.** The capacity axis shows no significant association with outcome in either arm. One arm carries the sign opposite to what the hypothesis predicts; the other carries the predicted sign at a magnitude far inside the noise floor. Neither survives the pre-committed joint-positive bar. This is read as a null on an arm underpowered by construction — not softened into "suggestive."

---

## 1. Provenance and inputs

- **Predictor:** `neo_cap_aff` — neo affinity-capacity, the frozen **PRIMARY** capacity definition (best-window binder fraction ≤500 nM), read verbatim from `capacity_axis_master.csv`. **No capacity value was recomputed** in this arm.
- **Data inputs (all recovered cleanly from saved files):**
  - `capacity_axis_master.csv` — per-allele capacity, 676 common class I alleles.
  - `cancer_arm_supertype_axis.csv` — 12 supertype log-HR + SE (Chowell 2018; melanoma + NSCLC; anti-CTLA-4/PD-1).
  - `autoimmune_risk_axis_ranked.csv` — signed ordinal risk rank (1 protective → 7 risk), 22 disease-anchored entries; 19 rows / 16 unique A/B alleles enter the two-arm test.
  - `supertype_prototype_frequencies_afnd.csv` — AFND page-1 (100-population) median allele frequency per supertype prototype; `log10(freq_median)` used as covariate.
- **S0 provenance (recorded).** S0 = the inherited project-context / session-scope block, **not a persisted artifact** and never one in any arm. The "stop if an input isn't recoverable from a saved file" gate applies to the four DATA tables above, all of which recovered. Substitution logged; S0 satisfied by the inherited scope block.

---

## 2. Resolution first — effective independent-N and MDE

This arm is **underpowered by construction** and the effective-N / minimum-detectable-effect (MDE) are reported *before* any association, so every coefficient is read against what the data could have shown. The two arms share **zero** alleles carrying their own allele-specific outcome measurements; they join only through supertype inheritance (~8 points).

| Arm | Effective independent-N | Basis | MDE (80% power, two-sided α=.05) |
|---|---|---|---|
| **Cancer** | **12 supertype points** | Outcome (log-HR) is supertype-constant → graded on 12 clusters | Spearman **ρ≈0.69–0.73** (analytic n=12 ρ=0.73; sim 0.69) |
| **Cancer (IVW)** | 12 | Supertype-IVW β, 12 points | \|β\|≈**0.64** per unit capacity (**0.050** log-HR per SD capacity) |
| **Autoimmune** | **16 unique alleles** (19 disease-anchored rows, ~8–9 supertypes) | Predictor per-allele; ranks tied-banded | Spearman **ρ≈0.60** (analytic n=19 ρ=0.60; sim 0.60) |

Interpretation: an arm that can only resolve ρ≈0.6–0.7 is being asked to detect effects that, in the analogous engageability run, sat at ρ≈0.1–0.4. A null here is expected regardless of any underlying truth.

Table: [`E1_resolution_mde.csv`]({{artifact:d8c9d39c-c593-4b8f-acaf-4548b4621973}}).

---

## 3. Pre-committed directions (stated before fitting)

From the project hypothesis (high-potency alleles favorable in cancer, risky in autoimmunity) and the standing sign convention (log-HR > 0 = worse ICB):

- **Cancer arm →** high capacity should give a **NEGATIVE β** on supertype log-HR.
- **Autoimmune arm →** high capacity should give a **POSITIVE Spearman ρ** vs signed risk rank.

A POSITIVE counts **only** if it survives frequency control **AND** leave-A\*02:01-out, with the pre-stated sign holding on **each** arm.

---

## 4. Cancer arm — capacity vs ICB benefit

Specification mirrors the engageability two-arm fit row-for-row: per-allele capacity regressed on supertype-constant log-HR, cluster-robust SE on 12 supertypes (400 member alleles), plus a 12-point supertype-IVW fit; raw and +log10(frequency). Small-sample *t* leads.

| Spec | β | SE | p (t) | df | leave-A\*02:01-out β |
|---|---|---|---|---|---|
| allele-clustered raw | **+0.303** | 0.268 | 0.283 | 11 | +0.304 |
| allele-clustered +freq | +0.584 | 0.330 | 0.104 | 11 | +0.583 |
| supertype-IVW raw | +1.178 | 1.264 | 0.373 | 10 | +1.182 |
| supertype-IVW +freq | +2.697 | 1.498 | 0.105 | 9 | +2.705 |

Effective-N read (12-point supertype Spearman): **ρ = +0.476, p = 0.118**.

**Sign is POSITIVE — opposite the pre-stated NEGATIVE — and non-significant everywhere.** Frequency control moves the coefficient *further* from the hypothesized direction, not toward it. Leave-A\*02:01-out shifts every β by ≤0.008 (A\*02:01 is 1 of 39 A02 members; A02's log-HR is supertype-constant, so removing one member barely moves the fit).

Table: [`E1_cancer_arm_capacity_assoc.csv`]({{artifact:aecb1494-b440-45b4-8b34-8ee212a00cda}}).

---

## 5. Autoimmune arm — capacity vs risk rank

Specification mirrors the engageability autoimmune arm: Spearman / rank-partial of capacity vs the signed risk rank across the full protective→risk gradient; raw, +freq, +HED, +freq+HED. 19 disease-anchored rows, 16 unique A/B alleles (HLA-C carries no favorability and is excluded from the two-arm join by construction).

| Control | ρ | p |
|---|---|---|
| raw | +0.072 | 0.771 |
| +freq | +0.195 | 0.438 |
| +HED | +0.070 | 0.784 |
| +freq+HED | +0.193 | 0.458 |

**Sign is POSITIVE — matches the pre-stated direction — but ρ≈0.07–0.20 is roughly one-tenth to one-third of the ρ≈0.60 the data could resolve; non-significant under every control.** Leave-A\*02:01-out is the identity operation here (A\*02:01 is absent from the autoimmune arm).

Table: [`E1_autoimmune_arm_capacity_assoc.csv`]({{artifact:d387ca0c-2f76-4dc0-9422-87d43df041f5}}).

---

## 6. Figure

![E1 two-arm capacity association. (a) Cancer arm: per-supertype mean capacity vs supertype log-HR (12 points, error bars = SE_logHR); the A02 supertype, which contains A*02:01, is ringed. β is positive — opposite the pre-stated negative — and non-significant. (b) Autoimmune arm: per-allele capacity vs signed risk rank (1 protective → 7 risk); ρ=+0.07, right sign but an order below the MDE of ≈0.60.]({{artifact:743e1c4c-a07a-483b-989f-578a962021ac}})

---

## 7. Did each pre-stated direction hold?

- **Cancer:** **NO** — sign reversed (positive, not negative) and non-significant.
- **Autoimmune:** sign held (positive) but magnitude is an order below MDE and non-significant.
- **Joint-positive bar** (survives frequency control AND leave-A\*02:01-out with pre-stated sign on each arm): **not met** — fails at the cancer-arm sign, before any power consideration.

---

## 8. Hard bars honored

- **HLA-C:** carries no favorability and no clean supertype unit — values reported, no per-locus C capacity correlation interpreted.
- Capacity referred to only as **"a measured axis"** — not called orthogonal/independent of HED anywhere (S6 withheld that question and this arm does not reopen it).
- This is capacity-vs-**outcome**, not the capacity-vs-HED question (S6, closed); the two are not conflated.
- Immunoediting demotion stays permanent regardless of sign.
- Every coefficient resolves to a named cell: cancer β's in `E1_cancer_arm_capacity_assoc.csv`; autoimmune ρ's in `E1_autoimmune_arm_capacity_assoc.csv`; N/MDE in `E1_resolution_mde.csv`.

---

## 9. Disposition

**Honest-NULL branch obtained** — the pre-committed, fully-reportable outcome, consistent with every other outcome arm. One arm carries the wrong sign, the other a right-signed effect far inside the noise floor; neither is significant, and the joint-positive bar fails at the cancer-arm sign. Read as a null on an arm underpowered by construction (MDE ρ≈0.6–0.7 against plausible effects of ~0.1–0.5), **not** softened into "suggestive." No subgroup hunting, no near-miss upgrade.

---

### Artifacts referenced

| File | Contents |
|---|---|
| [`fig_E1_capacity_two_arm.png`]({{artifact:743e1c4c-a07a-483b-989f-578a962021ac}}) | Both arms; A02 (A\*02:01-bearing) supertype ringed |
| [`E1_resolution_mde.csv`]({{artifact:d8c9d39c-c593-4b8f-acaf-4548b4621973}}) | Effective-N + MDE, both arms |
| [`E1_cancer_arm_capacity_assoc.csv`]({{artifact:aecb1494-b440-45b4-8b34-8ee212a00cda}}) | Cancer coefficients + leave-A\*02:01-out |
| [`E1_autoimmune_arm_capacity_assoc.csv`]({{artifact:d387ca0c-2f76-4dc0-9422-87d43df041f5}}) | Autoimmune ρ under each control |
