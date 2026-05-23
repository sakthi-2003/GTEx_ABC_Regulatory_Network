# Data Directory

This directory is reserved for input and derived data files.

- `raw/`: original GTEx expression matrices or downloaded source files
- `processed/`: filtered expression matrices, correlation matrices, and processed network inputs
- `external/`: external annotation resources, such as ABC enhancer-gene links and regulatory class lists
- `network_edges/`: network-oriented outputs used for Cytoscape and topology analysis
- `enrichment_outputs/`: compact functional enrichment summaries and exported g:Profiler tables

Large expression matrices and controlled-access data should not be committed to GitHub. Add download instructions, accession information, or checksums here when preparing the repository for public release.
