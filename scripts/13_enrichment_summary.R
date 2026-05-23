library(data.table)

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

fwrite(
  enrichment_summary,
  "results/enrichment/gprofiler_key_findings.tsv",
  sep = "\t"
)
