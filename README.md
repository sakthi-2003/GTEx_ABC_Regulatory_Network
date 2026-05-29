# Integrative Multi-Omics Regulatory Network Analysis using GTEx Co-expression and ABC Enhancer-Gene Interactions

![Project Status](https://img.shields.io/badge/status-analysis%20complete-2ea44f)
![R](https://img.shields.io/badge/R-4.x-276DC3?logo=r&logoColor=white)
![Cytoscape](https://img.shields.io/badge/Cytoscape-network%20topology-6A7FDB)
![g:Profiler](https://img.shields.io/badge/g%3AProfiler-functional%20enrichment-1f6f8b)
![Domain](https://img.shields.io/badge/domain-computational%20biology-0b7285)
![Omics](https://img.shields.io/badge/multi--omics-regulatory%20networks-bf5af2)

## 🧬 Overview

This project builds an integrative regulatory network by combining GTEx transcriptomic co-expression patterns with ABC enhancer-gene interaction data. The goal is to identify highly connected genes and regulatory modules that link gene expression structure to putative enhancer-mediated regulation.

The analysis integrates:

- GTEx-derived gene expression profiles
- Highly variable gene selection
- Pearson correlation-based co-expression network construction
- ABC enhancer-gene interaction filtering and integration
- Cytoscape-based network topology analysis
- Hub gene detection
- Functional enrichment analysis with g:Profiler
- Comparison of hub genes against RNA-binding proteins, splicing factors, and transcription factors

**Main conclusion:** the integrated GTEx-ABC regulatory network is strongly organized around RNA-binding proteins, spliceosomal regulators, and post-transcriptional regulatory mechanisms.

---

## 🧭 Biological Motivation

Gene regulatory programs are shaped by both transcriptional coordination and enhancer-mediated regulation. GTEx co-expression captures genes that vary together across transcriptomic samples, while ABC enhancer-gene maps provide candidate regulatory links between noncoding regulatory elements and target genes.

By integrating these two layers, this project asks a systems-level question: **which genes become central when expression similarity and enhancer-linked regulation are considered together?** The resulting network highlights regulatory hubs that may coordinate broad RNA-processing programs across the transcriptome.

---

## 🔬 Workflow

```mermaid
flowchart LR
    A["GTEx expression matrix"] --> B["Gene filtering"]
    B --> C["Highly variable genes"]
    C --> D["Pearson correlation matrix"]
    D --> E["Co-expression network"]
    F["ABC enhancer-gene links"] --> G["High-confidence ABC filtering"]
    E --> H["Integrated GTEx-ABC network"]
    G --> H
    H --> I["Cytoscape topology analysis"]
    I --> J["Hub gene discovery"]
    J --> K["RBP / splicing factor / TF comparison"]
    J --> L["g:Profiler enrichment"]
    L --> M["Biological interpretation"]
```

---

## 🧪 Methods

### 1. GTEx Expression Processing

GTEx transcriptomic data were loaded and filtered to remove genes with low or uninformative expression. This reduced technical noise and focused downstream analysis on genes with meaningful expression variation across samples.

### 2. Highly Variable Gene Selection

Highly variable genes were prioritized to capture the most informative expression signals. This step improves network interpretability by focusing the correlation analysis on genes with stronger biological variability.

### 3. Co-expression Network Construction

A Pearson correlation matrix was computed across selected genes. Strong gene-gene correlations were retained as network edges, producing a co-expression graph where nodes represent genes and edges represent coordinated expression patterns.

### 4. ABC Enhancer-Gene Integration

Activity-by-Contact enhancer-gene links were filtered for high-confidence interactions and mapped onto genes present in the co-expression network. This added a regulatory genomics layer to the transcriptomic network.

### 5. Cytoscape Network Topology Analysis

The integrated network was exported for Cytoscape analysis. Network topology metrics were used to identify highly connected genes and prioritize candidate regulatory hubs.

### 6. Functional Enrichment Analysis

Hub genes and network-associated gene sets were analyzed with g:Profiler to identify enriched Gene Ontology terms, pathways, and biological processes.

### 7. Regulatory Class Comparison

Top hub genes were compared against known RNA-binding proteins, splicing factors, and transcription factors to determine whether specific regulatory classes were overrepresented among central network nodes.

---

## 📊 Results

### Integrated Network

The GTEx co-expression network, after integration with ABC enhancer-gene interactions, revealed a regulatory structure enriched for genes involved in RNA processing and post-transcriptional regulation.

![Cytoscape network visualization](figures/network/cytoscape_network.tsv.png)

PDF version: [figures/network/cytoscape_network.tsv.pdf](figures/network/cytoscape_network.tsv.pdf)

### Top Hub Genes

The most connected genes included:

| Rank | Gene | Degree | Interpretation |
| ---: | --- | ---: | --- |
| 1 | `NONO` | 265 | RNA-binding protein; splicing and RNA processing regulator |
| 2 | `HNRNPK` | 192 | Heterogeneous nuclear ribonucleoprotein |
| 3 | `HNRNPD` | 212 | RNA-binding protein involved in mRNA stability |
| 4 | `DHX9` | 203 | RNA helicase linked to RNA processing |
| 5 | `PRPF8` | 189 | Core spliceosome component |
| 6 | `TRA2B` | 201 | Alternative splicing factor |
| 7 | `KHDRBS1` | 190 | RNA-binding and splicing-associated regulator |
| 8 | `SNRNP200` | 203 | Spliceosome RNA helicase |
| 9 | `ACIN1` | 196 | RNA splicing-associated protein |
| 10 | `SNW1` | 208 | Splicing and transcriptional co-regulatory factor |

Hub gene plot exports:

- [Top hub genes](figures/hub_genes/top_hub_genes.pdf)
- [Hub gene regulatory classes](figures/hub_genes/hub_gene_regulatory_classes.pdf)
- [Top hub gene table](results/tables/top_hub_genes.csv)
- [Regulatory overlap summary](results/tables/regulatory_overlap_summary.csv)

Markdown placeholders for README-ready PNG exports:

```markdown
![Top hub genes by network centrality](figures/hub_genes/top_hub_genes.png)
![Hub genes by regulatory class](figures/hub_genes/hub_gene_regulatory_classes.png)
```

### Functional Enrichment

Functional enrichment analysis showed strong enrichment for RNA-centric regulatory processes, including RNA splicing, mRNA processing, spliceosome-associated pathways, RNA-binding proteins, and post-transcriptional regulation.

| Enrichment Signal | Interpretation |
| --- | --- |
| RNA splicing | Central hubs converge on pre-mRNA splicing and transcript maturation. |
| mRNA processing | The network is organized around genes involved in mature RNA production. |
| KEGG spliceosome | Spliceosome machinery is a major pathway-level signal. |
| RNA-binding proteins | Topological hubs are enriched for RNA-binding and ribonucleoprotein-associated genes. |
| Post-transcriptional regulation | Enhancer-linked co-expression architecture highlights RNA-level regulation. |

![g:Profiler enrichment plot](figures/enrichment/gProfiler_hsapiens.png)

![g:Profiler enrichment summary](figures/enrichment/gProfiler_hsapiens_1.png)

Curated enrichment summary: [results/enrichment/gprofiler_key_findings.tsv](results/enrichment/gprofiler_key_findings.tsv)

Markdown placeholder for additional enrichment visualizations:

```markdown
![Functional enrichment dot plot](figures/enrichment/enrichment_dotplot.png)
![Functional enrichment bar plot](figures/enrichment/enrichment_barplot.png)
```

---

## 🧠 Biological Insights

The central genes in the integrated GTEx-ABC network are not random high-degree nodes. They are concentrated among RNA-binding proteins and spliceosomal regulators, suggesting that post-transcriptional regulation is a major organizing axis of the network.

Several hub genes, including `NONO`, `HNRNPK`, `HNRNPD`, `DHX9`, and `PRPF8`, have well-established roles in RNA metabolism, splicing, transcript stability, and ribonucleoprotein complex function. The enrichment of spliceosome and mRNA processing pathways supports a model in which enhancer-linked regulatory architecture converges on genes involved in RNA maturation and post-transcriptional control.

Overall, this analysis suggests that integrating enhancer-gene interaction maps with co-expression topology can reveal regulatory hubs that are not only highly connected, but also biologically coherent.

---

## 🛠️ Technologies Used

| Category | Tools |
| --- | --- |
| Programming | R, data.table |
| Transcriptomics | GTEx expression data |
| Regulatory genomics | ABC enhancer-gene interactions |
| Network analysis | Pearson correlation, graph edge filtering, Cytoscape |
| Functional enrichment | g:Profiler |
| Visualization | Cytoscape, exported network figures, enrichment plots |
| Reproducibility | Ordered scripts, structured results directories, GitHub-ready documentation |

---

## 📁 Repository Structure

```text
.
|-- README.md
|-- CITATION.cff
|-- LICENSE
|-- data/
|   |-- README.md
|   |-- network_edges/
|   |   |-- README.md
|   |   `-- cytoscape_networks_genes.csv
|   |-- enrichment_outputs/
|   |   |-- README.md
|   |   `-- gprofiler_key_findings.tsv
|   |-- raw/
|   |   `-- README.md
|   |-- processed/
|   |   `-- README.md
|   `-- external/
|       `-- README.md
|-- docs/
|   |-- README.md
|   `-- methods.md
|-- figures/
|   |-- README.md
|   |-- network/
|   |   |-- cytoscape_network.tsv.png
|   |   `-- cytoscape_network.tsv.pdf
|   |-- enrichment/
|   |   |-- gProfiler_hsapiens.png
|   |   `-- gProfiler_hsapiens_1.png
|   `-- hub_genes/
|       |-- top_hub_genes.pdf
|       `-- hub_gene_regulatory_classes.pdf
|-- results/
|   |-- README.md
|   |-- networks/
|   |   `-- cytoscape_networks_genes.csv
|   |-- enrichment/
|   |   |-- gprofiler_key_findings.tsv
|   `-- tables/
|       |-- top_hub_genes.csv
|       `-- regulatory_overlap_summary.csv
|-- scripts/
|   |-- 01_build_gtex_coexpression_network.R
|   |-- 02_integrate_abc_and_export_network.R
|   `-- 03_analyze_hubs_enrichment_and_plots.R
`-- archive/
    `-- legacy_scripts/
```

---

## 📌 Script Guide

| Script | Purpose |
| --- | --- |
| `01_build_gtex_coexpression_network.R` | Load GTEx expression data, filter genes, select highly variable genes, compute Pearson correlations, and export a co-expression edge list. |
| `02_integrate_abc_and_export_network.R` | Map gene IDs, filter ABC enhancer-gene links, integrate ABC targets with the co-expression network, and export Cytoscape-ready network tables. |
| `03_analyze_hubs_enrichment_and_plots.R` | Summarize hub genes, regulatory-class overlaps, enrichment findings, and publication-style hub gene plots. |

---

## 🚀 Future Directions

- Parameterize file paths with a project-level configuration file.
- Add an `renv.lock` file for exact R package reproducibility.
- Export hub gene plots as PNG or SVG for inline GitHub rendering.
- Add Cytoscape session files and style legends for reproducible network visualization.
- Include a workflow diagram with input, intermediate, and output file names.
- Add tissue-specific GTEx network comparisons.
- Quantify overlap significance for RBPs, splicing factors, and transcription factors.
- Add community detection to identify regulatory modules.
- Compare hub genes with disease-associated gene sets or GWAS catalogs.
- Package the workflow as a reproducible Snakemake or Nextflow pipeline.

## ⭐ Suggested Repository Improvements

- Add a graphical abstract summarizing GTEx co-expression, ABC integration, hub discovery, and enrichment analysis.
- Create a `docs/methods.md` page with full parameter settings, thresholds, and dataset versions.
- Add a `results/tables/top_hub_genes.csv` table with degree, betweenness, closeness, and regulatory class annotations.
- Add publication-style figure captions under each README figure.
- Include a short demo dataset so reviewers can run the workflow without controlled-access GTEx files.
- Add a GitHub Actions workflow to lint R scripts and validate file structure.
- Add a `CITATION.cff` file so the project is easy to cite in portfolios and applications.

---

## 📚 References

- GTEx Consortium. The GTEx Consortium atlas of genetic regulatory effects across human tissues. *Science*.
- Fulco CP et al. Activity-by-contact model of enhancer-promoter regulation from thousands of CRISPR perturbations. *Nature Genetics*.
- Shannon P et al. Cytoscape: a software environment for integrated models of biomolecular interaction networks. *Genome Research*.
- Raudvere U et al. g:Profiler: a web server for functional enrichment analysis and conversions of gene lists. *Nucleic Acids Research*.
- Gerstberger S, Hafner M, Tuschl T. A census of human RNA-binding proteins. *Nature Reviews Genetics*.

---

## 🏷️ GitHub Repository Metadata

**Concise repository description:**

> Integrative GTEx co-expression and ABC enhancer-gene network analysis identifying RNA-binding and spliceosomal hub regulators.

**Recommended topics/tags:**

`bioinformatics`, `computational-biology`, `multi-omics`, `gtex`, `abc-model`, `enhancer-gene-interactions`, `gene-regulatory-networks`, `coexpression-network`, `network-biology`, `cytoscape`, `gprofiler`, `functional-enrichment`, `rna-binding-proteins`, `spliceosome`, `post-transcriptional-regulation`, `systems-biology`, `rstats`
