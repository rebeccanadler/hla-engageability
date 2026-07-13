# LOH Arm Results — Reader's Guide

## For Different Audiences

### **For a Quick Overview (5 minutes)**
→ Start with **RESULTS_LOH_arm_INDEX.md**
- Read the "Quick Summary: Key Findings" section
- Skim the "Key Interpretation Points" (6 bullet points)
- Done.

### **For a Presentation/Talk (15 minutes)**
→ **RESULTS_LOH_arm_INDEX.md** + **RESULTS_LOH_arm_tables.md** (Table 1)
- Intro: "Quick Summary" from INDEX
- Main findings: Table 1 from TABLES (established alleles)
- Slide 1: fig_loh_BT_strengths.png (Bradley–Terry results)
- Negative control: Table 3 from TABLES (reference divergence)
- Slide 2: fig_s11_negcontrol.png (divergence vs frac_lost)
- Conclusion: "Key Interpretation Points" from INDEX

### **For Understanding the Methods (20 minutes)**
→ **LOH_arm_00_overview.md** (methods & provenance)
- Sections 1–2: LOH caller identity, reference construction
- Section 3: Event definition with explicit QC thresholds
- Then read: **RESULTS_LOH_arm_INDEX.md** → "Statistical Methods at a Glance" table

### **For Full Scientific Review (1–2 hours)**
→ Read in this order:
1. **LOH_arm_00_overview.md** — Cohort, methods, counts
2. **RESULTS_LOH_arm_comprehensive.md** — Full results with interpretation
3. **LOH_arm_01_negcontrol_S11.md** — Negative control details
4. **LOH_arm_02_loss_preference.md** — Statistical details (8 dimensions)
5. **RESULTS_LOH_arm_tables.md** — Reference tables as needed
6. **RESULTS_LOH_arm_figures.md** — Figure captions and interpretation

### **For Data Analysis / Reproducibility (varies)**
→ Start with **s10_provenance_ledger.md**
- Extract environment snapshot (conda file)
- Download code scripts in listed order
- Run R/Python code following the documented sequence
- Verify checksums: `s10_checksums.sha256`
- All p-values use fixed seeds (B=20,000) for bit-identical reproduction

### **For a Journal Manuscript**
→ Structure:
- **Methods:** LOH_arm_00_overview.md (event definition, QC) + RESULTS_LOH_arm_INDEX.md (statistical methods table)
- **Results:** RESULTS_LOH_arm_comprehensive.md (main findings)
- **Figure 1:** fig_loh_BT_strengths.png
- **Supplementary Figure 1:** fig_s11_negcontrol.png + LOH_arm_01_negcontrol_S11.md
- **Supplementary Tables:** RESULTS_LOH_arm_tables.md (Tables 1–6)
- **Supplementary Methods:** LOH_arm_02_loss_preference.md (full statistical detail)

---

## Document Map

```
RESULTS_LOH_arm_INDEX.md
├─ START HERE for overview
├─ Navigation map to other documents
├─ Key findings summary (table)
└─ Statistical methods reference

├── RESULTS_LOH_arm_comprehensive.md
│   └─ Full narrative results (best for understanding)
│
├── RESULTS_LOH_arm_tables.md
│   └─ Quick-reference tables (Table 1–6)
│
├── RESULTS_LOH_arm_figures.md
│   └─ Figure index, captions, interpretations
│
├── LOH_arm_00_overview.md
│   └─ Cohort, methods, event counts (for peer review)
│
├── LOH_arm_01_negcontrol_S11.md
│   └─ Negative control design & results (artifact test)
│
└── LOH_arm_02_loss_preference.md
    └─ Detailed 8-part statistical analysis (all numbers)

[Figures]
├─ fig_loh_BT_strengths.png (main result)
├─ fig_s11_negcontrol.png (negative control)
└─ [6 supplementary figures in project store]

[Data & Reproducibility]
├─ s10_provenance_ledger.md (code, environment, checksums)
├─ s10_checksums.sha256 (SHA256 verification)
└─ [110+ data tables in CSV/Parquet format]
```

---

## Key Sections by Topic

### **"Which alleles are established?"**
→ RESULTS_LOH_arm_tables.md, Table 1  
→ RESULTS_LOH_arm_comprehensive.md, "Primary Estimand: Bradley–Terry Loss-Preference Ranking"

### **"Is this a read-mapping artifact?"**
→ LOH_arm_01_negcontrol_S11.md (full discussion)  
→ RESULTS_LOH_arm_tables.md, Table 3 (quick summary)  
→ RESULTS_LOH_arm_figures.md (Figure 2 caption)

### **"How strong is each locus-level signal?"**
→ RESULTS_LOH_arm_tables.md, Table 2  
→ RESULTS_LOH_arm_comprehensive.md, "Locus-Level Tests of Heterogeneity"

### **"Do alleles with identical crests show identical loss-preference?"**
→ LOH_arm_02_loss_preference.md, Section 5 (detailed)  
→ RESULTS_LOH_arm_tables.md, Table 4 (summary)  
→ RESULTS_LOH_arm_comprehensive.md, "Crest-Surface Structure" section

### **"Is this haplotype-driven?"**
→ LOH_arm_02_loss_preference.md, Section 8  
→ RESULTS_LOH_arm_tables.md, Table 5  
→ RESULTS_LOH_arm_comprehensive.md, "Haplotype Concordance"

### **"What's the effect of divergence / allele frequency?"**
→ LOH_arm_02_loss_preference.md, Section 6  
→ RESULTS_LOH_arm_comprehensive.md, "Paired Conditional Logistic Regression"

### **"Has this been published before?"**
→ LOH_arm_02_loss_preference.md, Section 9 (literature search)  
→ RESULTS_LOH_arm_comprehensive.md, "Published-Novelty Delineation"

### **"How is this statistically robust?"**
→ LOH_arm_02_loss_preference.md, Section 4 (jackknife drop-one analysis)  
→ RESULTS_LOH_arm_comprehensive.md, "Highest-Influence Alleles (Jackknife)"

### **"What are the multiple testing corrections?"**
→ LOH_arm_02_loss_preference.md, Section 7  
→ RESULTS_LOH_arm_tables.md, Tables 1 & 6

---

## Figure Guide

| Figure | File | Main Finding | Best For |
|--------|------|--------------|----------|
| **Figure 1** | fig_loh_BT_strengths.png | Per-allele Bradley–Terry strengths per locus; 8 alleles significant at HLA-B | Presentation slides, manuscript Figure 1 |
| **Figure 2** | fig_s11_negcontrol.png | Divergence vs frac_lost scatter (rules out read-mapping artifact) | Supplementary Figure 1; showing artifact test is passed |
| Supp Fig S1 | fig_g1_positive_control.png | Positive control (R175H TP53 example) | Validation of methods |
| Supp Fig S2 | fig_g3_breadth.png | TCR-repertoire breadth metrics | Engagement / HED context |
| Supp Fig S3 | fig_g4_divergence.png | Divergence-by-domain breakdown | Methods details |
| Supp Fig S4 | fig_g4_per_allele_loss.png | Per-allele loss-frequency heatmap | Exploratory view of all 110 alleles |
| Supp Fig S5 | fig_loh_directionality.png | Allele-level loss vs retention bias | Supplementary context |
| Supp Fig S6 | fig_cap_loh.png | Meta-analysis integration (CAP cohort) | External validation |

---

## Checklist: What This Arm Includes

### ✓ Results Documentation
- [x] Main results narrative (comprehensive.md)
- [x] Summary tables (tables.md)
- [x] Figure index with captions (figures.md)
- [x] Master index & quick reference (INDEX.md)

### ✓ Methods & Rigor
- [x] Full methods section (overview.md)
- [x] Pre-registered negative control (negcontrol_S11.md)
- [x] Detailed statistical analysis (loss_preference.md)
- [x] Multiple comparison corrections (BH-FDR + Bonferroni)
- [x] Sensitivity/robustness checks (jackknife, leave-one-out, partials)

### ✓ Figures
- [x] 2 main publication-quality figures
- [x] 6 supplementary exploratory figures
- [x] All at 300 dpi PNG with consistent styling

### ✓ Data & Reproducibility
- [x] 15,704 event-level observations
- [x] 110 alleles in panel
- [x] Per-locus summary tables
- [x] Per-allele Bradley–Terry strengths
- [x] Full code & environment snapshot
- [x] SHA256 checksums for all outputs
- [x] Fixed random seeds (B=20,000; exact reproduction possible)

### ✓ Interpretation & Novelty
- [x] Biological interpretation section
- [x] Published-novelty delineation (literature search)
- [x] Open questions for future work
- [x] Connection to immunogenicity hypothesis

---

## Common Questions Answered in These Documents

**Q: Which alleles are most loss-biased? Most retention-biased?**  
A: Table 1 in RESULTS_LOH_arm_tables.md. TL;DR: B\*58:01 (loss); B\*08:01, B\*07:02, A\*01:01 (retention).

**Q: Is this finding statistically significant?**  
A: Yes. HLA-B: LRT p<0.001 (strong). HLA-A: p=0.013 (significant). HLA-C: p=0.164 (no).

**Q: Might this be a read-mapping artifact?**  
A: No. Divergence-from-reference test rules it out (HLA-A shows opposite-sign correlation; detailed in LOH_arm_01_negcontrol_S11.md).

**Q: Are these results haplotype-driven?**  
A: No. Haplotype concordance only marginally elevated (p=0.056, not significant). See Table 5 in RESULTS_LOH_arm_tables.md.

**Q: Why don't HLA-A and HLA-C have as many significant alleles?**  
A: Weaker locus-level signals (A: p=0.013 borderline, C: p=0.164 null). See Table 2 in RESULTS_LOH_arm_tables.md.

**Q: Has this been published?**  
A: No. Bandlamudi et al. (same cohort) only report loss under driver-mutation conditioning. This arm reports unconditional, allele-intrinsic loss-preference. See LOH_arm_02_loss_preference.md, Section 9.

**Q: Can I reproduce these results?**  
A: Yes. Full code, environment, checksums in s10_provenance_ledger.md. All p-values use fixed seeds (B=20,000) for bit-identical reproduction.

---

## Estimated Reading Times

| Document | Reading Time | Use Case |
|----------|--------------|----------|
| INDEX.md | 10 min | Overview & navigation |
| comprehensive.md | 30 min | Full scientific understanding |
| tables.md | 5 min | Quick reference |
| figures.md | 10 min | Figure interpretation |
| overview.md | 15 min | Methods & data provenance |
| negcontrol_S11.md | 10 min | Artifact test details |
| loss_preference.md | 45 min | Complete statistical detail |
| | **125 min (~2 hours)** | **Full review end-to-end** |

