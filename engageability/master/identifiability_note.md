# Escape confounds elimination: an identifiability result for allele-level ICB associations

**Scope.** This is a theory note. It develops the identifiability consequences of the
escape/elimination structure for per-allele immune-checkpoint-blockade (ICB) outcome
associations. No observed effect size is referenced. All propositions are verified
symbolically (`sympy`) or numerically; the verification code is the artifact that
accompanies this note.

---

## 1. Model

Let `e ≥ 0` be an allele's per-allele immunogenic potency (the engagement axis). Two
processes both increase in `e`:

- **elimination pressure** `s(e)` — the rate at which the allele's presentation drives
  T-cell killing of tumor cells; increasing, `s(0)=0`.
- **escape probability** `h(e) ∈ [0,1)` — the probability the tumor has already
  disabled this allele's presentation (HLA-LOH, B2M loss, APM silencing) by the time of
  treatment; increasing.

An escaped tumor derives no benefit from the allele's presentation, so the expected
allele-level effect is the product

```
Δ(e) = (1 − h(e)) · s(e).
```

Observed ICB log-hazard-ratio is taken to be **decreasing in Δ** (more benefit → lower
hazard). The observable, per allele, is a single scalar tied to `Δ(e)`; across a panel
of alleles the observable is the curve `Δ(·)` sampled at the alleles' potencies. Nothing
else about `s` or `h` is observed at the allele level.

I keep the concrete forms `s(e)=a·e`, `h(e)=1−e^{−b·e}` (so `Δ=a·e·e^{−b e}`) as a
worked instance, but every claim below is stated at the level of generality it actually
holds, and I flag where the concrete forms are doing load-bearing work.

---

## 2. Results

### 2.1 Δ is non-monotone — but this is a property of the *tail*, not of "any increasing h"

For the concrete forms,

```
Δ(e) = a e e^{−b e},   Δ'(e) = a e^{−b e}(1 − b e),
```

so `Δ` rises then falls with a single interior peak at

> **e\* = 1/b,  Δ(e\*) = a·e_E⁻¹/b ≈ 0.368·a/b**  (here `e_E` is Euler's number, distinct from the potency variable `e`).

The peak location `e\* = 1/b` depends **only on the escape parameter** `b`; the
elimination parameter `a` does not appear. The peak height is **linear in `a`**. (Verified:
`Δ'` factors as `−a(be−1)e^{−be}`, second derivative at `e\*` is `−abe^{−1}<0`.)

**Honest scope — the brief gestured that non-monotonicity might hold for any increasing
`h`; it does not.** An interior peak requires the product `(1−h)s → 0`, i.e. escape must
eventually win *fast enough to overcome the growth of `s`*. Counterexample (verified):
take `h(e)=½(1−e^{−e})`, which is strictly increasing but bounded above by ½, and
`s(e)=e`. Then `Δ(e)=e(1+e^{−e})/2 → ∞`: **monotone increasing, no peak.** So
non-monotonicity is **not** implied by "h increasing." The correct statement is:

> **Proposition 1 (peak).** If `s` is increasing with `s(0)=0` and the escape hazard
> `η(e) := h'(e)/(1−h(e))` eventually exceeds the log-growth rate `s'(e)/s(e)` of
> elimination, then `Δ` has at least one interior maximum. `Δ'>0 ⇔ s'/s > η`. The
> peak is where the log-growth of elimination falls to the escape hazard.

This is the general engine; `e\*=1/b` is its specialization (`s'/s=1/e`, `η=b`, cross at
`e=1/b`). The economically meaningful case — escape approaches certainty at high potency
(`h→1`) — does force `(1−h)s→0` whenever `s` grows sub-exponentially, and then a peak
exists. I state Proposition 1 rather than "always non-monotone" because the latter is
false.

### 2.2 The sign of the marginal association is controlled by escape; elimination sets magnitude only

Write `s(e)=a·g(e)` with `a>0` a pure scale and `g` the shape. Then
`Δ = a·(1−h)·g` and

```
Δ'(e) = a · [ (1−h)g' − h'g ].
```

Dividing by `a>0` leaves the bracket unchanged (verified symbolically). Therefore:

> **Proposition 2 (sign vs. magnitude).** The elimination scale `a` is a strictly
> positive multiplier. It **cannot change the sign of `Δ'` anywhere, nor move any
> stationary point.** The sign of the local ICB association — and the location of the
> peak — is fixed entirely by the *shape* of elimination `g` and the escape curve `h`;
> `a` rescales the whole curve vertically.

The qualifier matters: it is the **scale** of elimination that is sign-irrelevant, not
every feature of elimination. If elimination *shape* `g` is also unknown, both `g` and
`h` influence the sign jointly (the bracket `(1−h)g'−h'g`). The clean statement the
brief asked about — "sign set by escape, elimination affects magnitude only" — holds
**exactly when elimination enters as a scale factor** (concrete linear `s=a e` is the
leading case, `g'=const`), and holds **approximately** whenever the escape curve varies
more sharply across the allele panel than the elimination shape does. It is not an
unconditional truth for arbitrary `(g,h)`, and I do not claim it as one.

### 2.3 What is and is not identified — and under which assumption

**Headline (corrected).** *Escape sensitivity is not identified **without functional-form
assumptions on elimination**. It is the joint flexibility of `(s,h)` that destroys
identification — not escape per se.* An earlier draft of this note claimed escape
sensitivity is "not estimable from allele-level outcome data regardless of cohort count."
That is **false as written**, and the correction is the substance of this section.

**A demoted observation (not a theorem about this system).** Fix any observed curve
`Δ(·)`. For any admissible escape curve `h`, set `s := Δ/(1−h)`; this reproduces `Δ`
exactly, and where the implied `s` is increasing, `(s,h)` is observationally equivalent.
This is nothing more than the elementary fact that **a product does not determine its
factors** — it holds for any bilinear observable `f·g` and carries no information specific
to the escape/elimination model. I record it only to set it aside. It is an observation,
not a result.

**The identified set depends entirely on what is held parametric — name the restriction.**
The half-line result below is derived under a specific and asymmetric restriction that
the earlier draft never stated: **`h` parametric, `s` nonparametric.** Under that choice,
for the true curve `Δ=a e e^{−b₀e}`, a candidate escape sensitivity `b` implies
`s(e)=a e e^{(b−b₀)e}`, which is increasing on `[0,∞)` iff `b ≥ b₀` (verified:
`d/de[e e^{ke}] = e^{ke}(1+ke) ≥ 0 ∀e ⇔ k≥0`). Hence:

> **Case A — `h` parametric, `s` nonparametric.** The identified set for escape
> sensitivity is the half-line `b ∈ [b₀, ∞)` — bounded below, unbounded above. Escape
> sensitivity is partially identified with a nondegenerate, unbounded identified set: the
> data cannot rule out arbitrarily escape-sensitive alleles. (Relax `s` to merely
> non-negative and the set becomes all of `(0,∞)`; the endpoint `b₀` is an artifact of
> the monotonicity requirement, but nondegeneracy is not.)

The opposite restriction collapses the set to a point:

> **Case B — both parametric (`s=a·e`, `h=1−e^{−b·e}`).** Then `Δ=a·e·e^{−b e}`, and
> `log Δ − log e = log a − b·e` is **affine in `e`**: its slope is `−b` and its intercept
> is `log a`. Equivalently the peak sits at `e\*=1/b`. So `(a,b)` are **point-identified
> from the shape of the curve alone** (verified symbolically; the map `(a,b) ↦ Δ(·)` is
> injective on this family). Under a fully parametric model, escape sensitivity **is**
> estimable from the allele-level curve.

Cases A and B are not in tension; they are the same fact viewed from two restrictions.
Identification here is not a property of the data volume — cohort count only sharpens the
estimate of the one observable curve — but a property of **which of `s` and `h` the
analyst is willing to constrain by assumption.** This reframes the whole question:

> **The analyst faces a choice, not a theorem.** Either (i) **measure escape** directly
> and condition on it, or (ii) **defend an untestable parametric restriction on
> elimination** (e.g. `s=a·e`) that the outcome data cannot check. There is no third
> option in which escape sensitivity falls out of the marginal outcome association
> "for free." The design implication in §3 is invariant to which case obtains — it is the
> one conclusion that survives every restriction, and it is the strongest thing in this
> note.

**Remark — a third unidentified object.** The observable is not `Δ` itself but `φ(Δ)` for
some **unknown strictly decreasing** link `φ` (outcome is monotone in benefit, but the
scale is not pinned). Everything above assumes `φ` known; relaxing it only enlarges the
identified sets — Case B's point-identification, in particular, requires the curve's
*shape* in `Δ`-units, which an unknown `φ` distorts. So `φ` is a further reason
identification leans on assumptions, never a reason it becomes easier.

---

## 3. What this means for the project

Stated only where the math supports it (§2), dropped otherwise.

1. **An against-prior sign is a prediction, not an anomaly.** By Proposition 2 + the peak
   in Proposition 1: alleles whose potencies lie *above* `e\*` sit on the descending limb,
   where higher potency predicts *less* net benefit. A negative allele-level ICB
   association for high-potency alleles is exactly what the escape/elimination structure
   generates — it need not be explained away. **Firewall:** this holds for *any*
   escape-like process occupying the `h` term. Immunoediting and differential HLA-LOH
   propensity are two candidates, on equal footing here. Łuksza et al. (2022) present
   evidence of neoantigen immunoediting in human pancreatic-cancer survivors; even taking
   that finding at face value, it changes nothing for this note, because our result is
   orthogonal to whether any particular escape process operates — the allele-level model
   cannot attribute an observed sign to immunoediting versus HLA-LOH versus any other
   process that makes `h` increasing. The citation reports a mechanism in one setting; it
   does not license asserting that mechanism as *the* explanation of a sign here. The
   prediction is about the *structure*, not the mechanism.

2. **A null trade-off test can coexist with a strong trade-off.** A marginal regression
   of benefit on potency recovers an average slope. If the allele population straddles
   `e\*`, ascending-limb (+) and descending-limb (−) portions average toward zero even
   when both `s` and `h` are strong (verified numerically; the illustrative straddling
   population in §4 is chosen for exposition, not fitted). This is not special pleading:
   Lakatos et al. (2020) establish the same qualitative phenomenon in a neighbouring
   system — the site-frequency spectrum of variants under negative selection looks *more*
   neutral as selection strengthens. A near-neutral / null readout is therefore
   uninformative about the strength of the underlying selection (here, the trade-off),
   not evidence against it. Three explanations remain observationally tangled behind a
   null — (a) a capable design detecting a true null, (b) an underpowered design, (c) a
   design measuring the wrong estimand — and only a **design-level positive control**
   (a contrast known a priori to produce a signal, e.g. the E-HED-PC connection where the
   presentation-breadth axis is expected to move the readout) can arbitrate among them.
   The null alone cannot.

3. **The decisive design implication — escape must be *measured*, not inferred.**
   §2.3 shows the escape term is not recoverable from the marginal outcome association
   without an untestable restriction on elimination — and this conclusion is invariant to
   which identification case obtains. The only assumption-free way to break the confound
   is to **observe escape directly.** A
   **within-patient homolog contrast conditional on differential presentation** does
   this: comparing two HLA homologs in the same patient that differ in predicted
   presentation of the tumor's antigens, and reading out which homolog is retained vs.
   lost (LOH) / down-regulated, measures `h` (or its allele-differential) directly,
   holding patient, tumor, and treatment fixed. That observed escape term can then be
   conditioned on — turning the unidentified product `(1−h)s` into an estimable `s` given
   measured `h`. **This is the strongest practical consequence: the escape variable has
   to enter the design as an observed covariate; it can never be identified from the ICB
   outcome association, so an analysis that only regresses outcome on allele potency is
   structurally incapable of separating the two arms of the trade-off.**

---

## 4. Verification

Every quantitative claim was checked in `identifiability_check.py`:
peak `e\*=1/b` and height `a·e_E⁻¹/b` (`e_E`=Euler's number ≈0.368, symbolic); `a` sign-neutral (symbolic, `Δ'/a`
independent of `a`); the bounded-`h` counterexample to universal non-monotonicity
(symbolic limit `→∞`); Case A admissible set `b∈[b₀,∞)` (numeric monotonicity scan +
analytic `1+ke≥0` argument); Case B point-identification of `(a,b)` via the affine
`log Δ − log e = log a − b e` (symbolic); exact reproduction of `Δ` by every Case-A
decomposition (residual `~1e-16`); null-averaging across the peak (numeric slope `≈0`).
No value in this note is fitted, estimated, or tuned; all curve parameters are chosen for
exposition.

---

## 5. Figure

![Non-identification of the escape/elimination decomposition]({{artifact:9a15e8a9-2d3f-48a2-8233-17c3623e028b}})

**Figure F5 — Non-identification of escape from elimination.** *Illustrative;
parameters chosen for exposition; no data used; nothing fitted.* Latent immunogenic
potency `e` (arbitrary units) on x, expected effect `Δ` (arbitrary units) on y. The heavy
navy curve is the single observable `Δ(e)=a·e·e^{−b e}`; it is **identical** for every
value of the escape parameter shown. Dotted curves are escape survival `1−h` and dashed
curves the implied elimination `s` (vertically scaled to fit the panel) for
`b = 1.0, 1.8, 3.0` — three distinct `(escape, elimination)` factorizations that all
reproduce the same `Δ`. The shaded region marks where `dΔ/de < 0`; the turning point sits
at `e\*=1/b`. The figure demonstrates non-identification (under the Case-A restriction of
§2.3), not a result. No allele identifiers or data are shown.

---

## 6. Relation to prior work (novelty delineation)

The decomposition of anti-tumor immune effect into a **presentation** term and a
**T-cell-recognition** term is **not novel here.** Łuksza et al. (2017) introduced a
neoantigen fitness model in which "two main factors determine neoantigen fitness: its
likelihood of presentation by the [MHC] and its subsequent T-cell recognition," estimated
from MHC binding affinity and sequence similarity to known antigens — a decomposition
operating at the **neoantigen** level. **The presentation × recognition decomposition is
credited to Łuksza et al. (2017)**; this note does **not** claim it. Łuksza et al. (2022)
is a distinct, later contribution — it applies a neoantigen-quality fitness model to
predict how tumor clone fitness evolves *over time* (immunoediting in pancreatic-cancer
survivors) — and is credited for that clone-fitness-over-time result, not for the
decomposition.

The contribution claimed here is narrower and at a different level of aggregation: an
**allele-level recognition (engagement) axis** — a per-allele scalar `e` summarizing how
permissive an allele's α1/α2 surface is to diverse TCR docking — and the **identifiability
analysis** of what an allele-level marginal ICB association can and cannot recover about
the escape/elimination structure built on that axis. The neoantigen-level fitness models
do not address the allele-level identification question, which is the object of §2.3.

---

## 7. References

Retrieved by DOI via full-text fetch during this pass (Łuksza 2017 and Lakatos 2020 from
PubMed Central as text; Łuksza 2022 from the publisher as PDF), saved locally under
`articles/` (`10.1038_nature24473.txt`, `10.1038_s41586-022-04735-9.pdf`,
`10.1038_s41588-020-0687-1.txt`). Abstracts confirmed against the characterizations used;
no numeric value or quantitative claim is imported from any of them:

1. Łuksza M. et al. (2017) *A neoantigen fitness model predicts tumour response to
   checkpoint blockade immunotherapy.* **Nature** 551:517–520.
   doi:10.1038/nature24473. — presentation × recognition decomposition at the neoantigen
   level (§6).
2. Łuksza M. et al. (2022) *Neoantigen quality predicts immunoediting in survivors of
   pancreatic cancer.* **Nature** 606:389–395. doi:10.1038/s41586-022-04735-9. —
   clone-fitness evolution over time; immunoediting cited as one candidate escape process
   (§3, firewall) — not credited for the decomposition, which is 2017.
3. Lakatos E. et al. (2020) *Evolutionary dynamics of neoantigens in growing tumours.*
   **Nature Genetics** 52:1057–1066. doi:10.1038/s41588-020-0687-1. — site-frequency
   spectra under negative selection appear more neutral as selection strengthens; anchors
   the "null is uninformative about trade-off strength" corollary (§3, point 2).

---

## 8. Files-read manifest

**Required deliverable. Split into (i) project data — expected none — and (ii) literature
and briefs, which are permitted and enumerated.**

**(i) Project data — expected empty; a non-empty entry here would be a finding.**

| Source | Read? |
|---|---|
| project files, tables, databases | **NO — none opened** |
| IMGT / AFND / cBioPortal | **NO — none queried** |
| any cohort / effect-size table | **NO — none opened** |

*None.* No project data of any kind was read, queried, or loaded.

**(ii) Literature and briefs — permitted; fully enumerated.**

| Path / source | Type | Read? | Notes |
|---|---|---|---|
| `articles/10.1038_nature24473.txt` | literature | yes | Łuksza 2017; full text on disk (69,508 B); used for novelty §6 |
| `articles/10.1038_s41586-022-04735-9.pdf` | literature | yes | Łuksza 2022; full text on disk (9,477,766 B); firewall §3, clone-fitness credit §6 |
| `articles/10.1038_s41588-020-0687-1.txt` | literature | yes | Lakatos 2020; full text on disk (81,368 B); null corollary §3.2 |
| task briefs (attachments) | instructions | yes | derivation brief, completion-pass brief, this closeout brief |

Full texts are present locally (not just abstracts). Provenance verified in §7: titles
match the fetched files, and the only paper-attributed numbers in this note are
bibliographic (volume:pages), each traced to its fetched file. No scientific value or
quantitative claim is imported from any paper.

---

## 9. Draft — Section 9 (≤ 600 words; this draft: 590 words by whitespace count, 599 by a token-split count that treats math fragments as words — under cap by both)

*Derived results, surviving corollaries, firewall, novelty. No gate, no disposition, no
results claim.*

This section makes no claim about any sign observed in this project's cancer arm. It
establishes, prospectively and before any outcome is examined, what allele-level ICB
data can and cannot identify.

We model an allele's expected contribution to anti-tumor immunity under checkpoint
blockade as a product of two processes that both increase in a latent per-allele
immunogenic-potency (engagement) axis `e`: elimination pressure `s(e)` and the probability
`h(e)` that the tumor has escaped presentation of that allele. Net expected effect is
`Δ(e) = (1−h(e))·s(e)`; the allele-level observable is a monotone transform of `Δ` sampled
across alleles. We establish four results, each verified symbolically or numerically.

*(i) Shape.* `Δ` is conditionally non-monotone: `Δ'(e) > 0 ⇔ s'(e)/s(e) > η(e)`,
`η = h'/(1−h)`. A bounded increasing `h` keeps `Δ` monotone; for `s=a e`, `h=1−e^{−b e}`,
peak at `e*=1/b`.

*(ii) Sign vs. magnitude.* The *scale* of elimination is sign-irrelevant: writing
`s=a·g`, the factor `a>0` cannot change the sign of `Δ'` or move any turning point. But
elimination *shape* `g` is not sign-irrelevant — sign is governed jointly by `g` and `h`
through `(1−h)g' − h'g`. We claim only the weaker, correct statement.

*(iii) Identification.* Escape sensitivity is **not identified without functional-form
assumptions on elimination.** That a product does not determine its factors is elementary
and carries no model-specific content; we set it aside. What matters is the asymmetry: if
`h` is parametric and `s` nonparametric, escape sensitivity is only partially identified
(an unbounded identified set); if *both* are parametric, `log Δ − log e = log a − b e` is
affine and `(a,b)` are point-identified from the curve's shape. Identification is thus a
property of which function the analyst restricts, not of cohort count. The unknown
strictly-decreasing outcome link `φ` is a third unidentified object that only enlarges the
sets. The analyst therefore chooses between **measuring escape** and **defending an
untestable restriction on elimination**; there is no free lunch from the marginal
association.

*Surviving corollaries.* (a) An against-prior negative sign for high-potency alleles is a
structural prediction (descending limb above `e*`), not an anomaly. (b) A null trade-off
test is consistent with a strong underlying trade-off: as in Lakatos et al. (2020), where
negative selection makes site-frequency spectra look *more* neutral as it strengthens, a
null is uninformative about trade-off strength; only a design-level positive control —
the E-HED-PC control, a contrast known a priori to move the readout — arbitrates among
true-null, underpowered, and wrong-estimand explanations. (c) The one
assumption-free consequence — invariant across all identification cases — is that escape
must enter the design as an *observed* covariate: a within-patient homolog contrast
conditional on differential presentation measures escape directly.

*Firewall.* The `h` term stands for **any** escape-like process. Immune-driven neoantigen
editing and germline-driven (non-selective) differential HLA-LOH propensity are two
candidates on equal footing here — the model requires only that `h` be increasing, and is
indifferent to whether the increase arises from selection or from reference-, capture-, or
linkage-driven artifact; Łuksza et al. (2022)
present evidence of neoantigen immunoediting in human pancreatic-cancer survivors, and
even taking that finding at face value it changes nothing here, because the result is
orthogonal to whether any given escape process operates — the allele-level model cannot
attribute a sign to one process over another. Naming a mechanism is not asserting it as
the explanation.

*Novelty.* The presentation × recognition decomposition is prior work at the neoantigen
level (Łuksza et al. 2017); Łuksza et al. (2022) separately established clone-fitness
evolution over time. We claim only the allele-level engagement axis and the
identifiability analysis built on it.
