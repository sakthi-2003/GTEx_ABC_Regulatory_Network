library(data.table)

network_metrics <- fread("results/networks/cytoscape_networks_genes.csv")

top_hub_genes <- network_metrics[
  order(-Degree)
][
  name %in% c(
    "NONO", "HNRNPK", "HNRNPD", "DHX9", "PRPF8",
    "TRA2B", "KHDRBS1", "SNRNP200", "ACIN1", "SNW1"
  ),
  .(
    gene = name,
    degree = Degree,
    betweenness_centrality = BetweennessCentrality,
    closeness_centrality = ClosenessCentrality,
    clustering_coefficient = ClusteringCoefficient
  )
]

setorder(top_hub_genes, -degree)
top_hub_genes[, rank := .I]
setcolorder(top_hub_genes, c("rank", "gene"))

fwrite(
  top_hub_genes,
  "results/tables/top_hub_genes_from_network.csv"
)
