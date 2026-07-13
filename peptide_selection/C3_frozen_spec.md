# C3 — Frozen peptide-set spec (consumed by C4)

**This is the spec C4 will build to. No peptide file exists yet.** The `sha256` fields are
`<pending build>` because, per instruction, no peptide file has been written. On go-ahead, C4
builds to exactly this spec and emits the hashes.

## Invariants (both arms)

- Identical peptide set for every allele.
- Identical length distribution across alleles **and** across the two arms.
- 8/9/10/11mers, fixed proportions, sliding window step 1.
- RNG seed = **20260709**.
- N = **100,000** peptides per arm (resolves plausible between-allele differences; see resolution
  pre-step — Poisson noise floor ~12% strong / ~6% weak at this N).

## Neoepitope set (primary)

```
source:     TCGA MC3 public MAF (open-access)
accession:  gdc.cancer.gov/about-data/publications/mc3-2017  (Ellrott 2018, PMC6075717)
size(src):  3,600,963 open-access somatic variants (10,510 tumors, 33 cancer types)
procedure:  nonsynonymous SNV -> mutant 8-11mer tiling (window centered on mutated residue)
N:          100,000 peptides (subsampled; matched length distribution)
lengths:    8/9/10/11mer, fixed proportions identical across alleles
seed:       20260709
filters:    open-access MAF only; nonsynonymous coding; drop peptides identical to any WT self peptide
robustness: COSMIC-SBS simulated-missense replicate (HLA-independent), same N/lengths/seed
sha256:     <pending build>
```

## Neoepitope robustness replicate (pre-registered)

```
source:     simulated missense under COSMIC SBS mutational signatures (v3)
ascertain:  HLA-independent by construction
N/lengths:  identical to primary (100,000; 8-11mer, same proportions)
seed:       20260709
purpose:    ranking-stability check against MC3 immunoediting; NOT a capacity value on its own
sha256:     <pending build>
```

## Self-peptide set

```
source:     UniProt Swiss-Prot reviewed human (organism_id 9606), canonical only
accession:  reviewed:true AND organism_id:9606  (20,431 entries, verified 2026)
N:          100,000 peptides
lengths:    8/9/10/11mer, same fixed proportions as neoepitope set
seed:       20260709
filters:    reviewed-only; no isoforms; exclude WT counterparts of neoepitope set
bound:      antigen processing (proteasome, TAP) NOT modeled; proteome sample is a crude
            self-proteome proxy -> autoantigen capacity noisier than neoantigen
sha256:     <pending build>
```

## Binder threshold (set by C4)

Power was evaluated at both conventional NetMHCpan %rank thresholds:
- strong binder: %rank ≤ 0.5 (p ≈ 0.005)
- weak binder:   %rank ≤ 2.0 (p ≈ 0.02)

Both resolve plausible between-allele differences at N = 100,000. C4 freezes the operative
threshold; the threshold is **not** to be relaxed to manufacture resolvability.
