library(data.table)

# Load top variable genes
expr <- fread("/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/top5000_variable_genes.tsv")

# Extract gene names
genes <- expr$Name

# Expression matrix
expr_matrix <- as.matrix(expr[, -(1:3)])

# Assign gene names as rownames
rownames(expr_matrix) <- genes

# Log transform
expr_matrix <- log2(expr_matrix + 1)

# Transpose: rows = samples, columns = genes
expr_matrix <- t(expr_matrix)

# Pearson correlation
cor_matrix <- cor(expr_matrix, method = "pearson")

# Check dimensions
dim(cor_matrix)

# Save correlation matrix
saveRDS(cor_matrix, "/data/sata_data/home/diptanil/sakthi/GTEx_ABC_Regulatory_Network/data/correlation_matrix.rds")
