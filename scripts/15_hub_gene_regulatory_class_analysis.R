library(data.table)
library(ggplot2)

network <- fread("results/networks/cytoscape_networks_genes_top_hubs.csv")

top_hubs <- network[order(-Degree)]

pdf("figures/hub_genes/top_hub_genes.pdf", width = 8, height = 6)

ggplot(
  top_hubs,
  aes(x = reorder(name, Degree), y = Degree, fill = Degree)
) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Top Hub Genes in Integrated Regulatory Network",
    x = "Gene",
    y = "Degree"
  ) +
  theme_bw(base_size = 14)

dev.off()

regulatory_classes <- data.table(
  Category = c("RNA-binding protein", "Splicing factor / spliceosome regulator", "Transcription factor comparison"),
  RepresentativeGenes = c(
    "NONO; HNRNPK; HNRNPD; DHX9; KHDRBS1",
    "PRPF8; TRA2B; SNRNP200; ACIN1; SNW1",
    "Used as comparison class"
  )
)

fwrite(
  regulatory_classes,
  "results/tables/regulatory_overlap_summary.csv"
)
