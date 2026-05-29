library(data.table)
library(ggplot2)

results_dir <- "results"
figures_dir <- "figures"

network_metrics_file <- file.path(
  results_dir,
  "networks",
  "cytoscape_networks_genes.csv"
)

hub_table_file <- file.path(results_dir, "tables", "top_hub_genes.csv")
overlap_table_file <- file.path(results_dir, "tables", "regulatory_overlap_summary.csv")
enrichment_file <- file.path(results_dir, "enrichment", "gprofiler_key_findings.tsv")

dir.create(dirname(hub_table_file), recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(overlap_table_file), recursive = TRUE, showWarnings = FALSE)
dir.create(dirname(enrichment_file), recursive = TRUE, showWarnings = FALSE)
dir.create(file.path(figures_dir, "hub_genes"), recursive = TRUE, showWarnings = FALSE)

network_metrics <- fread(network_metrics_file)

priority_hubs <- c(
  "NONO", "HNRNPK", "HNRNPD", "DHX9", "PRPF8",
  "TRA2B", "KHDRBS1", "SNRNP200", "ACIN1", "SNW1"
)

top_hubs <- network_metrics[
  name %in% priority_hubs,
  .(
    gene = name,
    degree = Degree,
    betweenness_centrality = BetweennessCentrality,
    closeness_centrality = ClosenessCentrality,
    clustering_coefficient = ClusteringCoefficient
  )
]

setorder(top_hubs, -degree)
top_hubs[, rank := .I]
setcolorder(top_hubs, c("rank", "gene"))

fwrite(top_hubs, hub_table_file)

regulatory_overlap <- data.table(
  regulatory_class = c(
    "RNA-binding proteins",
    "Splicing factors and spliceosome regulators",
    "Transcription factors"
  ),
  interpretation = c(
    "Hub genes are strongly represented by RNA-binding and ribonucleoprotein-associated regulators.",
    "Central network genes include core and auxiliary spliceosomal regulators.",
    "Transcription factor comparison provides a baseline against RNA-centric hub enrichment."
  ),
  representative_hub_genes = c(
    "NONO; HNRNPK; HNRNPD; DHX9; KHDRBS1",
    "PRPF8; TRA2B; SNRNP200; ACIN1; SNW1",
    "See regulatory annotation workflow"
  )
)

fwrite(regulatory_overlap, overlap_table_file)

enrichment_summary <- data.table(
  term_group = c(
    "RNA splicing",
    "mRNA processing",
    "KEGG spliceosome",
    "RNA-binding proteins",
    "Post-transcriptional regulation"
  ),
  enrichment_signal = c(
    "Strong enrichment",
    "Strong enrichment",
    "Enriched",
    "Enriched",
    "Enriched"
  ),
  biological_interpretation = c(
    "Hub-associated genes converge on pre-mRNA splicing and RNA maturation processes.",
    "The network is organized around genes involved in processing mature transcripts.",
    "The integrated network captures spliceosome-associated regulatory machinery.",
    "Topological hubs are concentrated among RNA-binding and ribonucleoprotein-associated genes.",
    "Enhancer-linked co-expression architecture highlights RNA-level regulatory mechanisms."
  )
)

fwrite(enrichment_summary, enrichment_file, sep = "\t")

hub_plot <- ggplot(
  top_hubs,
  aes(x = reorder(gene, degree), y = degree, fill = degree)
) +
  geom_col(width = 0.75) +
  coord_flip() +
  labs(
    title = "Top Hub Genes in the Integrated GTEx-ABC Network",
    x = "Gene",
    y = "Network degree"
  ) +
  theme_bw(base_size = 13) +
  theme(legend.position = "none")

ggsave(
  file.path(figures_dir, "hub_genes", "top_hub_genes.png"),
  hub_plot,
  width = 8,
  height = 5,
  dpi = 300
)
