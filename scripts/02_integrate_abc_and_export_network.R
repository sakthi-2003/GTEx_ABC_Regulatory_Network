library(data.table)
library(org.Hs.eg.db)
library(AnnotationDbi)

data_dir <- "data"
external_dir <- file.path(data_dir, "external")
processed_dir <- file.path(data_dir, "processed")
network_dir <- file.path(data_dir, "network_edges")
results_network_dir <- file.path("results", "networks")

dir.create(processed_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(network_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(results_network_dir, recursive = TRUE, showWarnings = FALSE)

coexpression_edges <- fread(file.path(network_dir, "coexpression_network_edges.tsv"))

genes <- unique(c(coexpression_edges$Gene1, coexpression_edges$Gene2))

gene_mapping <- AnnotationDbi::select(
  org.Hs.eg.db,
  keys = genes,
  keytype = "ENSEMBL",
  columns = "SYMBOL"
)

gene_mapping <- as.data.table(gene_mapping)[!is.na(SYMBOL)]

map_gene1 <- copy(gene_mapping)
setnames(map_gene1, c("ENSEMBL", "SYMBOL"), c("Gene1", "Symbol1"))

map_gene2 <- copy(gene_mapping)
setnames(map_gene2, c("ENSEMBL", "SYMBOL"), c("Gene2", "Symbol2"))

network_symbols <- merge(coexpression_edges, map_gene1, by = "Gene1", all.x = TRUE)
network_symbols <- merge(network_symbols, map_gene2, by = "Gene2", all.x = TRUE)
network_symbols <- network_symbols[!is.na(Symbol1) & !is.na(Symbol2)]

fwrite(network_symbols, file.path(network_dir, "coexpression_network_symbols.tsv"), sep = "\t")

abc_file <- file.path(
  external_dir,
  "AllPredictions.AvgHiC.ABC0.015.minus150.ForABCPaperV3.txt"
)

abc <- fread(abc_file)

abc_filtered <- abc[
  `ABC.Score` > 0.1,
  .(chr, start, end, TargetGene, ABC.Score, CellType)
]

fwrite(abc_filtered, file.path(processed_dir, "high_confidence_ABC_links.tsv"), sep = "\t")

integrated_abc <- abc_filtered[
  TargetGene %in% c(network_symbols$Symbol1, network_symbols$Symbol2)
]

fwrite(integrated_abc, file.path(results_network_dir, "integrated_abc_links.tsv"), sep = "\t")

cytoscape_edges <- network_symbols[
  abs(Correlation) > 0.9,
  .(
    Source = Symbol1,
    Target = Symbol2,
    Weight = Correlation
  )
]

fwrite(cytoscape_edges, file.path(results_network_dir, "cytoscape_network_edges.tsv"), sep = "\t")
