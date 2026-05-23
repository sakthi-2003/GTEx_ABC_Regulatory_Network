library(data.table)
library(org.Hs.eg.db)
library(AnnotationDbi)

network <- fread(
"/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_edges.tsv"
)

genes <- unique(
  c(network$Gene1,
    network$Gene2)
)

genes <- sub("\\..*", "", genes)

mapping <- AnnotationDbi::select(
  org.Hs.eg.db,
  keys = genes,
  keytype = "ENSEMBL",
  columns = c("SYMBOL")
)

mapping <- mapping[
  !is.na(mapping$SYMBOL),
]

head(mapping)
fwrite(
  mapping,
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/gene_mapping.tsv",
  sep="\t"
)
