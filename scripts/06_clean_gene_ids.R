library(data.table)

# Load network
network <- fread("/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_edges.tsv")

# Remove version numbers
network$Gene1 <- sub("\\..*", "", network$Gene1)
network$Gene2 <- sub("\\..*", "", network$Gene2)

# Save cleaned network
fwrite(network,
       "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_clean.tsv", sep="\t")

library(data.table)

abc <- fread(
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/AllPredictions.AvgHiC.ABC0.015.minus150.ForABCPaperV3.txt",
  nrows = 5
)

colnames(abc)
