library(data.table)

# Load correlation matrix
cor_matrix <- readRDS("/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/correlation_matrix.rds")

# Convert matrix to table
cor_df <- as.data.frame(as.table(cor_matrix))

# Rename columns
colnames(cor_df) <- c("Gene1", "Gene2", "Correlation")

# Remove self-correlations
cor_df <- cor_df[cor_df$Gene1 != cor_df$Gene2, ]

# Keep strong correlations
network_edges <- cor_df[abs(cor_df$Correlation) > 0.8, ]

# Remove duplicate edges
network_edges <- network_edges[
  as.character(network_edges$Gene1) <
  as.character(network_edges$Gene2), ]

# Check dimensions
dim(network_edges)

# Preview
head(network_edges)

# Save edge list
fwrite(network_edges, "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/coexpression_network_edges.tsv", sep = "\t")
