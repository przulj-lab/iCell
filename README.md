# iCell: Towards a Data-Integrated Cell

Tools and scripts for integrating heterogeneous biological data into a unified cellular network representation.

## Authors

- N. Malod-Dognin
- J. Petschnigg
- S. F. L. Windels
- J. Povh
- H. Hemmingway
- R. Ketteler
- N. Przulj

**Corresponding Author:** Prof. Natasa Przulj  
📧 natasa.przulj@mbzuai.ac.ae

## Overview

This repository provides the computational framework for generating an **iCell** - an integrated cellular network that combines multiple types of biological data into a unified, analyzable representation. The approach enables comprehensive analysis of cellular systems by integrating diverse data sources including protein interactions, gene expression, pathways, and more.

**Paper:** "Towards a Data-Integrated Cell"

## Components

### Core Scripts

- **[Main File](link)** - Primary scripts for generating an iCell

### Complete Dataset Package

All scripts and datasets used in the paper are available in four parts:

- **[Part 1](http://www0.cs.ucl.ac.uk/staff/natasa/iCell/iCell_full_package.zip.001)**
- **[Part 2](http://www0.cs.ucl.ac.uk/staff/natasa/iCell/iCell_full_package.zip.002)**
- **[Part 3](http://www0.cs.ucl.ac.uk/staff/natasa/iCell/iCell_full_package.zip.003)**
- **[Part 4](http://www0.cs.ucl.ac.uk/staff/natasa/iCell/iCell_full_package.zip.004)**

*Note: All four parts are required for complete functionality. If download links don't work when clicked, copy and paste the URLs directly into your browser's address bar.*

## Requirements

- **MATLAB** - For running SSNMTF data integration (Step 1)
- **Python** - For generating the integrated network (Step 2)
- Sufficient storage space for network data and intermediate files
- Unix/Linux environment recommended (Windows may require adjustments)

## Installation

```bash
git clone https://github.com/przulj-lab/iCell.git
cd iCell

# Download all four data parts
# Extract and organize data parts into the appropriate directory structure
```

## Data Structure

The complete package includes:

1. **Scripts** - Computational tools for data integration
2. **Datasets** - Biological data used in the analysis
   - Protein-protein interaction networks
   - Gene expression data
   - Pathway information
   - Functional annotations
   - Other relevant biological data

## Usage

### Prerequisites

- **MATLAB** - Required for Step 1 (data integration using SSNMTF)
- **Python** - Required for Step 2 (network generation)

### Input Data

The repository includes a test dataset in the `Input_Net/` folder containing three human networks:

1. **Generic PPI Network** - Protein-protein interaction network
2. **COEX Network** - Co-expression network
3. **GI Network** - Genetic interaction network

### Step-by-Step Workflow

#### Step 1: Data Integration with SSNMTF

Run the Semi-Supervised Non-negative Matrix Tri-Factorization (SSNMTF) algorithm in MATLAB:

```matlab
% In MATLAB console
run_SSNMTF()
```

**What this does:**
- Loads the three input networks from `Input_Net/`
- Calls `SSNMTF.m` to perform iCell's data integration
- Performs matrix factorization to identify shared patterns across networks

**Output files:**
1. **Matrix factor G** - Gene/protein factors
2. **Matrix factor S** - Network-specific factors
3. **Gene correspondence file** - Maps genes to rows in matrix G

#### Step 2: Generate Integrated Network

Create the final integrated network using Python:

```bash
# In terminal
python Make_Integrated_Net.py
```

**What this does:**
- Loads the G factor matrix from Step 1
- Loads the gene correspondence file
- Constructs the integrated network based on the factorization

**Output:**
- `HSA_Generic_iCell.edgelist` - The final integrated cellular network in edge list format

### Complete Example

```bash
# 1. Start MATLAB and run data integration
matlab -nodisplay -r "run_SSNMTF(); exit;"

# 2. Generate integrated network
python Make_Integrated_Net.py

# 3. View the output
head HSA_Generic_iCell.edgelist
```

### Output Format

The integrated network (`HSA_Generic_iCell.edgelist`) is in edge list format:
```
gene1 gene2
gene3 gene4
gene5 gene6
...
```

Each line represents an edge (interaction) in the integrated cellular network.

## What is an iCell?

An **iCell** (integrated Cell) is a comprehensive computational representation of cellular systems that:

- **Integrates multiple data types** - Combines protein interactions, gene expression, pathways, and functional data
- **Enables systems-level analysis** - Provides a unified framework for studying cellular processes
- **Supports data-driven discovery** - Facilitates identification of novel biological relationships
- **Allows cross-dataset queries** - Enables questions spanning multiple data modalities

## Applications

The iCell framework can be used for:

- **Systems biology research** - Understanding cellular organization and function
- **Disease mechanism studies** - Identifying disease-related network perturbations
- **Drug target discovery** - Finding potential therapeutic intervention points
- **Pathway analysis** - Investigating biological pathways and their interactions
- **Functional prediction** - Inferring functions of uncharacterized genes/proteins
- **Network medicine** - Integrating clinical and molecular data

## File Organization

```
iCell/
├── run_SSNMTF.m                # MATLAB script for data integration (Step 1)
├── SSNMTF.m                    # Semi-Supervised NMF implementation
├── Make_Integrated_Net.py      # Python script for network generation (Step 2)
├── Input_Nets/                  # Test input networks
│   ├── PPI_network.txt        # Human protein-protein interaction network
│   ├── COEX_network.txt       # Co-expression network
│   └── GI_network.txt         # Genetic interaction network
├── output/                     # Generated files (created by scripts)
│   ├── G_factor.mat           # Matrix factor G (genes/proteins)
│   ├── S_factor.mat           # Matrix factor S (network-specific)
│   └── gene_correspondence.txt # Gene-to-row mapping
├── HSA_Generic_iCell.edgelist # Final integrated network output
└── README.md
```

## Data Integration Approach

The iCell framework uses **Semi-Supervised Non-negative Matrix Tri-Factorization (SSNMTF)** to integrate heterogeneous biological networks:

### Algorithm Overview

1. **Input**: Multiple biological networks (PPI, COEX, GI)
2. **Matrix Factorization**: SSNMTF decomposes the networks into shared and network-specific factors
   - **G factor**: Captures shared patterns across all networks (genes/proteins)
   - **S factor**: Captures network-specific characteristics
3. **Integration**: Uses the G factor to construct a unified network representation
4. **Output**: Integrated cellular network combining information from all input networks

### Key Advantages

- **Handles heterogeneous data**: Integrates different types of biological networks
- **Preserves network-specific information**: S factor maintains unique characteristics
- **Identifies shared patterns**: G factor reveals common biological relationships
- **Semi-supervised**: Can incorporate prior knowledge or constraints
- **Non-negative**: Ensures biologically interpretable factors

### Mathematical Foundation

The method factorizes multiple network adjacency matrices simultaneously:
- Each network is approximated as a product of shared and specific factors
- Optimization finds factors that best explain all networks jointly
- Result captures both shared biological signal and network-specific noise

## Output

### Intermediate Files (from Step 1)

1. **G factor matrix** - Gene/protein factor matrix capturing shared patterns
2. **S factor matrix** - Network-specific factor matrices
3. **Gene correspondence file** - Mapping between gene identifiers and matrix rows

### Final Output (from Step 2)

**`HSA_Generic_iCell.edgelist`** - The integrated human cellular network

- **Format**: Edge list (space or tab-separated)
- **Content**: Gene-gene interactions derived from integrated data
- **Representation**: Combines evidence from PPI, co-expression, and genetic interactions
- **Use**: Can be analyzed with standard network analysis tools

### Using the Output

```python
# Load the integrated network in Python
import networkx as nx
G = nx.read_edgelist('HSA_Generic_iCell.edgelist')

# Basic network statistics
print(f"Nodes: {G.number_of_nodes()}")
print(f"Edges: {G.number_of_edges()}")
print(f"Density: {nx.density(G)}")
```

```r
# Load the integrated network in R
library(igraph)
g <- read_graph('HSA_Generic_iCell.edgelist', format='edgelist')

# Basic network statistics
vcount(g)  # Number of nodes
ecount(g)  # Number of edges
```

## Troubleshooting

### MATLAB Issues

**MATLAB not found:**
```bash
# Check MATLAB installation
which matlab
# Or specify full path
/path/to/matlab/bin/matlab -nodisplay -r "run_SSNMTF(); exit;"
```

**Out of memory errors:**
- Increase MATLAB's Java heap space
- Process smaller networks
- Use a machine with more RAM

### Python Issues

**Module import errors:**
```bash
# Install required packages
pip install numpy scipy networkx
```

**File not found errors:**
- Ensure Step 1 completed successfully
- Check that output files from SSNMTF exist
- Verify file paths in `Make_Integrated_Net.py`

## Reproducibility

This repository provides all scripts and test datasets used in the published study, enabling:

- Complete reproduction of published results
- Extension of methods to new datasets
- Validation and benchmarking of alternative approaches

## Related Publications

If you use this code or data in your research, please cite:

```
N. Malod-Dognin, J. Petschnigg, S.F.L. Windels, J. Povh, H. Hemmingway, R. Ketteler and N. Przulj
Towards a Data-Integrated Cell
Nat Commun 10, 805 (2019). https://doi.org/10.1038/s41467-019-08797-8
```

## Contact

**Prof. Natasa Przulj**  
📧 natasa.przulj@mbzuai.ac.ae

For technical questions, please open an issue on GitHub or contact the corresponding author.
