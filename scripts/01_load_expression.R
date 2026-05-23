# Load libraries
library(data.table)

# Load GTEx expression matrix
expr <- fread("/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/GTEx_Analysis_2025-08-22_v11_RNASeQCv2.4.3_gene_tpm.gct")

# Check dimensions
dim(expr)

# Remove Name and Description columns
expr_matrix <- as.matrix(expr[, -(1:2)])

# Keep genes expressed in at least 20% samples
keep <- rowSums(expr_matrix > 1) > (0.2 * ncol(expr_matrix))

filtered_expr <- expr[keep]

# Dimensions after filtering
dim(filtered_expr)

# Save filtered data
fwrite(filtered_expr, "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/filtered_expression.tsv", sep="\t")
