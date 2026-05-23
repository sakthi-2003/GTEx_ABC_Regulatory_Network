library(data.table)

# Load filtered expression data
expr <- fread("/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/filtered_expression.tsv")

# Extract expression matrix
expr_matrix <- as.matrix(expr[, -(1:2)])

# Calculate variance for each gene
gene_variance <- apply(expr_matrix, 1, var)

# Add variance column
expr$Variance <- gene_variance

# Sort by variance
expr_sorted <- expr[order(-Variance)]

# Select top variable genes
top_expr <- expr_sorted[1:5000]

# Check dimensions
dim(top_expr)

# Save
fwrite(top_expr, "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/top5000_variable_genes.tsv", sep = "\t")
