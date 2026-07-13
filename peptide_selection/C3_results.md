# C3 — Peptide-set selection for the presentation-capacity module

**Arm:** HLA class-I "immunogenic potency" project · presentation-capacity module (C3)
**Status:** Recommendation frozen; peptide files **not yet built** (awaiting go-ahead for C4)
**Governing criterion:** ascertainment independence from HLA

---

## 1. Purpose and the circularity problem

The presentation-capacity module measures **what an allele *can* present** — the size of the
peptide space an allele's binding groove admits. That measurement is only valid if the peptide
set it is computed over was assembled **independently of HLA presentation**. A set whose
membership was itself decided by what got presented makes the measurement partly circular.

The direction of the bias is the reason this matters. Circularity inflates apparent capacity for
exactly the well-studied alleles — HLA-A\*02:01 above all — whose NetMHCpan predictions are also
the best-calibrated. So the **presentation bias** and the **training-support bias** point the same
way; they are not independent noise and they stack. Two concrete traps must be evaluated
explicitly rather than assumed away:

- **Neoepitope sets drawn from sequenced tumors** have been filtered by HLA-dependent
  immunoediting and by the HLA distribution of whatever cohort was sequenced.
- **Epitope sets drawn from IEDB (or any observed-ligand resource)** are filtered by observed
  presentation and are steeply A\*02:01-dominated — the *same* bias as the NetMHCpan training
  data, so such a set would **compound** the training-support confound rather than stand
  independent of it.

---

## 2. Candidate neoepitope sources and scoring

### Criteria (stated before the table)

1. **Ascertainment independence from HLA** (decisive) — was set membership determined by anything
   downstream of HLA presentation?
2. **Public availability without controlled access** — usable without a dbGaP/data-use application.
3. **Size** — enough peptides to reach the resolution the power pre-step (§4) demands.
4. **Peptide-length coverage** — must supply or permit 8–11mers.
5. **Provenance** — fetched citation with a verification note; no size or accession from memory.

### Scored candidates

Every size and accession below was confirmed by independent retrieval this session (see §6).

| Source | Ascertainment independence | Public w/o controlled access | Size (verified) | Verdict |
|---|---|---|---|---|
| **TCGA MC3 public MAF** → mutant peptides | **HLA-independent** — mutation-called; open-access filter is exonic/confidence, *not* HLA | **Yes**, open-access | **3,600,963** open-access variants (10,510 tumors, 33 types); 22,485,627 in controlled MAF | **RECOMMENDED PRIMARY** |
| Simulated missense (COSMIC SBS spectrum) | **HLA-independent by construction** | Yes (generated locally) | arbitrary | Cleanest; **realism cost** → robustness replicate |
| TESLA benchmark (Wells 2020) | **HLA-dependent** — pipeline-prioritized then T-cell assayed | Synapse syn21048999, account + terms | 608 assessed + 310 validation | **DISQUALIFIED as primary**; external validation only |
| NEPdb | **HLA-dependent**; predicted set generated *by NetMHCpan/HLAthena* | Web (nep.whu.edu.cn) | >17,000 validated; predicted 516,036 peptides from 16,745 mutations | **DISQUALIFIED** — maximal circularity |
| IEDB class-I observed ligands | **HLA-dependent, A\*02:01-dominated** — same bias as NetMHCpan training | Yes, open | 49,513 human-host positive class-I linear assays; A\*02:01 = 18,227 (**36.8%**) | **DISQUALIFIED** — compounds the confound |

Full machine-readable table with the `provenance` and `verification` columns:
[neoepitope_candidate_sources.csv]({{artifact:dcb8a5ab-c116-4644-824d-b90d775fb5f2}}).

### The ascertainment bias, quantified

The IEDB disqualification is not asserted — it is measured. Restricting to **human-host**
positive class-I linear-peptide assays (49,513 total), **a single allele, HLA-A\*02:01, carries
36.8% of the entire record**. Feeding that skew into a capacity metric scored by a predictor
trained on the same skew would manufacture the "high-potency = well-studied" artifact the whole
design is built to avoid.

![IEDB class-I positive assays are dominated by a single allele: HLA-A*02:01 accounts for 18,227 of 49,513 human-host positive class-I linear-peptide assays (36.8%).]({{artifact:70fa1d91-fda1-4009-9c77-ee8a32185200}})

*Figure 1. Ascertainment bias in observed-ligand resources. HLA-A\*02:01 alone accounts for ~37%
of all positive human-host class-I linear-peptide T-cell assays in IEDB (18,227 / 49,513;
all-host unfiltered total 72,255). Any capacity metric computed over such a set inherits this
skew. Source: IEDB next-gen query API, fetched 2026.*

---

## 3. Recommendation, with the tradeoff explicit

**Primary: TCGA MC3 public MAF → tiled mutant peptides.** Ascertainment is by *mutation calling*.
The open-access filtering that reduces 22.5M → 3.6M variants is exonic-region and caller-confidence
filtering — **not** HLA filtering — so it does not reintroduce presentation circularity. It is
open-access (no controlled application), and 3.6M variants yield far more 8–11mers than any
resolvable design needs.

**The tradeoff, stated not resolved.** MC3 is not perfectly clean. Two residual, *bounded* biases
remain and are labeled in the methods:

- **Immunoediting** — surviving tumors may be depleted of the most immunogenic mutations; an
  HLA-linked filter, but it acts on *tumor survival*, not on mutation-calling ascertainment, and
  is far weaker than presentation-based selection.
- **Cohort HLA composition** — TCGA is European-ancestry-skewed, so the *mutation* spectrum
  carries a mild population imprint. This touches which genes mutate, not which peptides an allele
  can bind, so it does not directly inflate any single allele's capacity.

The genuinely clean option — **simulated missense from a COSMIC spectrum** — costs realism:
simulated peptides have no relationship to real tumor antigen space, so a capacity computed on
them measures affinity for *spectrum-shaped random sequence*, not for peptides a tumor would
generate. **Adopted posture:** MC3 as primary; the COSMIC-spectrum simulation as a
pre-registered **robustness replicate**. If the between-allele capacity ranking is stable across
MC3 and the HLA-independent simulation, residual MC3 immunoediting is not driving the result.

No option is perfectly clean. MC3 is the least circular *realistic* option and its residual
bounds are stateable — that meets the "bounded, honestly-labeled" bar for a **primary**, not
merely a secondary. TESLA/NEPdb/IEDB are not admissible as the capacity set; TESLA is reserved
only as a downstream external-validation set for the immunogenicity arm.

---

## 4. Resolution pre-step (power on binder counts)

Pre-registration-safe: these counts do not reveal the effect. Binder count *k* ~ Binomial(*N*, *p*);
Poisson SE = √(*Np*); SE of an allele-vs-allele difference = √(2*Np*); minimum resolvable relative
difference (MRD) at 2σ ≈ 1.96·√(2*Np*)/(*Np*).

| N | Strong binder (rank≤0.5%, p≈0.005) | Weak binder (rank≤2%, p≈0.02) |
|---|---|---|
| 50,000 | μ≈250, MRD ≈ **17.5%** | μ≈1,000, MRD ≈ **8.8%** |
| **100,000** | μ≈500, MRD ≈ **12.4%** | μ≈2,000, MRD ≈ **6.2%** |
| 200,000 | μ≈1,000, MRD ≈ 8.8% | μ≈4,000, MRD ≈ 4.4% |
| 500,000 | μ≈2,500, MRD ≈ 5.5% | μ≈10,000, MRD ≈ 2.8% |

![At the frozen N=100k, the minimum resolvable between-allele difference is ~12% (strong) and ~6% (weak) relative — far below the ≥100% real between-allele spread. Poisson noise is not the limiting factor.]({{artifact:1270be7a-4c2d-41a4-b4ab-995ae75b56c3}})

*Figure 2. Resolution pre-step. Minimum resolvable between-allele difference (2σ, relative) versus
peptide-set size, at strong- and weak-binder thresholds. At the frozen N = 100,000, the noise
floor is ~12% (strong) / ~6% (weak) — an order of magnitude below the ≥100% (2–5×) spread reported
across common HLA-A/B/C alleles. Lower = finer resolution.*

**Finding.** At **N = 100,000**, plausible between-allele capacity differences (tens to hundreds
of percent) exceed the Poisson noise floor by roughly an order of magnitude. **N = 100,000
comfortably resolves plausible differences; Poisson noise is not the limiting factor.** Per the
pre-registration discipline, N was **not** enlarged to chase resolvability and the threshold was
**not** relaxed — N = 100k already clears the bar, so the smaller set is retained. This applies
symmetrically to the neoepitope set, which will be at least as large.

---

## 5. Self-peptide set — frozen decisions

Sampled from the UniProt **reviewed** human proteome (verified live: 20,431 reviewed *Homo
sapiens* entries; 20,416 within reference proteome UP000005640; 190,278 unreviewed — excluded).

| Decision | Frozen value | Rationale |
|---|---|---|
| Reviewed vs isoforms | **Reviewed canonical only** (Swiss-Prot, no isoforms) | Curated, non-redundant; isoforms inflate near-duplicate peptides |
| Sampling unit | **Peptide** (tile then sample peptides) | Capacity is per-peptide; protein-unit sampling over-weights long proteins |
| Tiled lengths | **8, 9, 10, 11mers**, sliding window step 1 | Matches class-I range; identical distribution across alleles |
| Sample size | **N = 100,000 peptides** | Meets resolution target (§4); bounds NetMHCpan runtime |
| Length mix | **Fixed proportions**, identical for every allele | Length composition must not vary between alleles |
| RNG seed | **20260709** | Reproducibility |
| WT counterparts of neoepitopes | **Excluded** | Prevents leakage/pairing artifacts between arms |

**Stated bound (once).** Antigen processing (proteasomal cleavage, TAP transport) is **not**
modeled, and a proteome sample is a crude self-proteome proxy — so autoantigen capacity is
inherently noisier than neoantigen capacity, and the self arm is interpreted with that caveat.

The frozen machine-readable spec that C4 will consume is in
[C3_frozen_spec.md]({{artifact:12407130-f8a3-438d-9d68-ba60550d27a8}}).

---

## 6. Provenance (fetched-or-flagged)

Every source, size, and accession below was confirmed by independent retrieval this session — not
typed from memory.

| Item | Verified value | Method |
|---|---|---|
| TCGA MC3 | 3,600,963 open-access / 22,485,627 controlled variants; 10,510 tumors | Full text fetched (Ellrott 2018, *Cell Syst* 6:271, PMC6075717); read verbatim from STAR Methods |
| UniProt reviewed human | 20,431 entries (2026 query) | Live REST count, `reviewed:true AND organism_id:9606` |
| IEDB class-I bias | 49,513 human-host positive class-I linear assays; A\*02:01 = 18,227 (36.8%); all-host 72,255 | Live query API with `host_organism_name = Homo sapiens (human)` |
| TESLA | 608 assessed + 310 validation epitopes; Synapse syn21048999 | Abstract fetched (10.1016/j.cell.2020.09.015); verbatim |
| NEPdb | >17,000 validated; 516,036 predicted peptides from 16,745 mutations; NetMHCpan 4.0 + HLAthena | PDF fetched (Xia 2021, 10.3389/fimmu.2021.644637); verbatim |

---

## 7. Files in this arm

- C3_results.md — this document (you are here)
- [C3_frozen_spec.md]({{artifact:12407130-f8a3-438d-9d68-ba60550d27a8}}) — frozen spec C4 will consume
- [neoepitope_candidate_sources.csv]({{artifact:dcb8a5ab-c116-4644-824d-b90d775fb5f2}}) — full scored candidate table with provenance/verification columns
- Figure 1 — IEDB ascertainment bias
- Figure 2 — resolution pre-step / power curve
