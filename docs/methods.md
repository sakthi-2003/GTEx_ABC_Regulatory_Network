# Methods Summary

## Study Design

This project integrates GTEx gene co-expression structure with ABC enhancer-gene interaction data to identify regulatory hubs with strong network centrality and coherent biological function.

## Expression Processing

GTEx expression data were filtered to remove low-information genes. Highly variable genes were retained to prioritize genes with meaningful expression variation across samples.

## Network Construction

Pearson correlation coefficients were computed between selected genes. Strong correlations were retained as co-expression edges, producing a gene-gene network for topology analysis.

## ABC Integration

High-confidence ABC enhancer-gene links were filtered to genes present in the co-expression network. This produced an integrated network connecting transcriptomic structure with candidate enhancer-mediated regulation.

## Topology and Hub Detection

The network was analyzed in Cytoscape. Hub genes were prioritized using centrality metrics, especially degree, betweenness centrality, closeness centrality, and clustering coefficient.

## Functional Enrichment

Hub-associated genes were analyzed with g:Profiler. The strongest biological signals involved RNA splicing, mRNA processing, KEGG spliceosome pathways, RNA-binding proteins, and post-transcriptional regulation.
