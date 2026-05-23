library(data.table)

# Load network
network <- fread(
"/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_edges.tsv"
)

# Remove version numbers
network$Gene1 <- sub("\\..*", "", network$Gene1)
network$Gene2 <- sub("\\..*", "", network$Gene2)

# Load mapping
mapping <- fread(
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/gene_mapping.tsv",
)

# Rename columns for merge
map1 <- copy(mapping)
colnames(map1) <- c("Gene1", "Symbol1")

map2 <- copy(mapping)
colnames(map2) <- c("Gene2", "Symbol2")

# Merge Gene1
network <- merge(
  network,
  map1,
  by = "Gene1",
  all.x = TRUE
)

# Merge Gene2
network <- merge(
  network,
  map2,
  by = "Gene2",
  all.x = TRUE
)

# Remove missing symbols
network <- network[
  !is.na(Symbol1) &
  !is.na(Symbol2)
]

# Preview
head(network)

# Save
fwrite(
  network,
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_symbols.tsv",
  sep="\t"
)
