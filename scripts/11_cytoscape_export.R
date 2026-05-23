library(data.table)

# Load network
network <- fread(
"/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_symbols.tsv")

network_strict <- network[
  abs(Correlation) > 0.9
]

# Keep important columns
cyto <- network[, .(
  Source = Symbol1,
  Target = Symbol2,
  Weight = Correlation
)]

# Save
fwrite(
  cyto,
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/cytoscape_network.tsv",
  sep="\t"
)
