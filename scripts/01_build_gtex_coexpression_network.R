library(data.table)

data_dir <- "data"
raw_dir <- file.path(data_dir, "raw")
processed_dir <- file.path(data_dir, "processed")
network_dir <- file.path(data_dir, "network_edges")

dir.create(processed_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(network_dir, recursive = TRUE, showWarnings = FALSE)

gtex_expression_file <- file.path(
  raw_dir,
  "GTEx_Analysis_2025-08-22_v11_RNASeQCv2.4.3_gene_tpm.gct"
)

min_tpm <- 1
min_sample_fraction <- 0.20
top_variable_genes <- 5000
correlation_threshold <- 0.80

read_gct_table <- function(path) {
  first_line <- readLines(path, n = 1)
  skip_lines <- if (startsWith(first_line, "#")) 2 else 0
  fread(path, skip = skip_lines)
}

expr <- read_gct_table(gtex_expression_file)

gene_columns <- intersect(c("Name", "Description"), names(expr))
expr_matrix <- as.matrix(expr[, !gene_columns, with = FALSE])

keep_genes <- rowSums(expr_matrix > min_tpm) > (min_sample_fraction * ncol(expr_matrix))
filtered_expr <- expr[keep_genes]

fwrite(filtered_expr, file.path(processed_dir, "filtered_expression.tsv"), sep = "\t")

filtered_matrix <- as.matrix(filtered_expr[, !gene_columns, with = FALSE])
gene_variance <- apply(filtered_matrix, 1, var)

filtered_expr[, Variance := gene_variance]
variable_expr <- filtered_expr[order(-Variance)][seq_len(top_variable_genes)]

fwrite(variable_expr, file.path(processed_dir, "top5000_variable_genes.tsv"), sep = "\t")

genes <- variable_expr$Name
expression_matrix <- as.matrix(variable_expr[, !c(gene_columns, "Variance"), with = FALSE])
rownames(expression_matrix) <- genes

expression_matrix <- log2(expression_matrix + 1)
correlation_matrix <- cor(t(expression_matrix), method = "pearson")

saveRDS(correlation_matrix, file.path(processed_dir, "correlation_matrix.rds"))

correlation_table <- as.data.frame(as.table(correlation_matrix))
setDT(correlation_table)
setnames(correlation_table, c("Gene1", "Gene2", "Correlation"))

coexpression_edges <- correlation_table[
  Gene1 != Gene2 &
    abs(Correlation) > correlation_threshold &
    as.character(Gene1) < as.character(Gene2)
]

coexpression_edges[, Gene1 := sub("\\..*", "", Gene1)]
coexpression_edges[, Gene2 := sub("\\..*", "", Gene2)]

fwrite(coexpression_edges, file.path(network_dir, "coexpression_network_edges.tsv"), sep = "\t")
