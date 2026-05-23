library(data.table)
library(ggplot2)

top_hubs <- fread("results/tables/top_hub_genes.csv")

hub_plot <- ggplot(
  top_hubs,
  aes(x = reorder(gene, degree), y = degree, fill = degree)
) +
  geom_col(width = 0.75) +
  coord_flip() +
  labs(
    title = "Top Hub Genes in the Integrated GTEx-ABC Network",
    x = "Gene",
    y = "Network degree"
  ) +
  theme_bw(base_size = 13) +
  theme(legend.position = "none")

ggsave(
  "figures/hub_genes/top_hub_genes.png",
  hub_plot,
  width = 8,
  height = 5,
  dpi = 300
)
