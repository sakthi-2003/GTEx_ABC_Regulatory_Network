library(data.table)

# Load co-expression network
network <- fread(
"/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_symbols.tsv")

# Load ABC data
abc <- fread(
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/high_confidence_ABC_links.tsv",
)

# Keep only genes present in network
integrated <- abc[
  TargetGene %in%
  c(network$Symbol1,
    network$Symbol2)
]

# Check dimensions
dim(integrated)

# Preview
head(integrated)

# Save
fwrite(
  integrated,
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/integrated_regulatory_network.tsv",
  sep="\t"
)
