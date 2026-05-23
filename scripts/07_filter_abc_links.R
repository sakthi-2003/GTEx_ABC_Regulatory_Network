library(data.table)

# Load ABC data
abc <- fread("/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/AllPredictions.AvgHiC.ABC0.015.minus150.ForABCPaperV3.txt")

# Keep important columns
abc_small <- abc[, .(
  chr,
  start,
  end,
  TargetGene,
  ABC.Score,
  CellType
)]

# Filter strong ABC scores
abc_filtered <- abc_small[
  ABC.Score > 0.1
]

# Check dimensions
dim(abc_filtered)

# Preview
head(abc_filtered)

# Save
fwrite(
  abc_filtered,
  "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/high_confidence_ABC_links.tsv",
  sep="\t"
)
