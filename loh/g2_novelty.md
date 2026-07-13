# G2 — NOVELTY: claim provenance (before any modeling)

Every claim in the surrounding program, tagged **published-by-source** (the specific prior paper
made this exact claim), **published-in-field** (established in the literature broadly), or
**not-present** (no prior source). Binding constraint honored: **the only potentially novel claim
is Δengageability→loss conditional on Δ_PHBR (the helix crest).** Everything else is credited.

| # | Claim | Status | Prior credit | Our role |
|---|---|---|---|---|
| 1 | PHBR quantifies HLA-allele presentation of a mutant driver peptide | published-in-field | Marty 2017 (PMID 29107334) | **Implementation** (MHCflurry PHBR engine) |
| 2 | Depletion: carriage ~ log-PHBR (poorly-presented mutations enriched) | **published-by-source** | Marty 2017 (PMID 29107334) | **Reproduction** |
| 3 | Somatic HLA LOH is immune escape; restricting allele can be preferentially lost | published-in-field | McGranahan 2017 (LOHHLA); Bandlamudi 2026 (PMID 41895280 †) | **Reproduction** (G1) |
| 4 | Δ_PHBR → which allele is lost (better presenter lost), cancer/mutation-specific | **published-by-source** | Bandlamudi 2026 Fig 6F-G (PMID 41895280 †) | **Generalization** of Bandlamudi+Marty+McGranahan; reproduced in G1, **not** claimed novel |
| 5 | HED / HLA evolutionary divergence shapes anti-tumor immunity & ICB outcome | published-in-field | Pierini & Lenz 2018; Chowell 2019 (Nat Med) | **Prior work** — HED is *distinct* from engageability; credited |
| 6 | Cancer/autoimmunity antagonistic-pleiotropy trade-off on one HLA potency axis | published-in-field | immunogenetics literature | **Prior concept** — framing credited |
| 7 | **Δ_engageability (helix-crest TCR-docking permissiveness gap) → which allele is lost, CONDITIONAL on Δ_PHBR** | **not-present** | — | **THE ONLY POTENTIALLY NOVEL CLAIM (the crest).** NOT tested here (report-then-stop). |

## Binding statement
- The PHBR engine and the depletion result (carriage ~ log-PHBR) are **implementations/reproductions
  of Marty 2017** — no novelty claimed.
- **Δ_PHBR → loss generalizes Bandlamudi + Marty + McGranahan** — reproduced as the G1 positive control,
  explicitly **not** claimed as this program's contribution.
- The single potentially novel claim is **Δengageability → loss conditional on Δ_PHBR (the helix crest)**.
  This Stage-A battery is a **pre-modeling audit**; it does **not** test this claim (no engageability ×
  LOH-outcome quantity is computed). Δ_ENG enters later gates **only as a covariate** in bias diagnostics.

*Engageability is distinct from HED (peptide-repertoire breadth) and from PHBR (peptide-specific
presentation): it scores how permissive an allele's α1/α2 crest is to DIVERSE TCR docking, not
clone-specific contacts and not repertoire size.*

---
† **PMID provenance:** the source task document names *Bandlamudi 2026* without a PMID. PMID **41895280** was resolved independently and verified **live via NCBI E-utilities** (bidirectional: esummary PMID→DOI and esearch DOI[AID]→PMID both return `10.1016/j.ccell.2026.03.003`, *Cancer Cell*). It is not transcribed from the source doc.
