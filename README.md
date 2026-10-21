# Towards a Data-Integrated Cell

**N. Malod-Dognin, J. Petschnigg, S.F.L. Windels, J. Povh, H. Hemmingway, R. Ketteler and N. Pržulj**

Corresponding author: Prof. N. Pržulj, natasa.przulj@mbzuai.ac.ae

<img src="iCell.png" alt="iCell" width="300">

## Downloads

**The two scripts needed to generate an iCell:**

- [Main file](https://github.com/przulj-lab/iCell/releases/download/v1.0/iCell_basic_package.zip)

**All the scripts and datasets used in the paper (all 4 parts are needed):**

- [Part 1](https://github.com/przulj-lab/iCell/releases/download/v1.0/iCell_full_package.zip.001)
- [Part 2](https://github.com/przulj-lab/iCell/releases/download/v1.0/iCell_full_package.zip.002)
- [Part 3](https://github.com/przulj-lab/iCell/releases/download/v1.0/iCell_full_package.zip.003)
- [Part 4](https://github.com/przulj-lab/iCell/releases/download/v1.0/iCell_full_package.zip.004)

Put all 4 parts in one folder, then join and extract them:

macOS / Linux:
```bash
cat iCell_full_package.zip.00{1,2,3,4} > iCell_full_package.zip
unzip iCell_full_package.zip
```

Windows (Command Prompt):
```
copy /b iCell_full_package.zip.001+iCell_full_package.zip.002+iCell_full_package.zip.003+iCell_full_package.zip.004 iCell_full_package.zip
```
Then extract `iCell_full_package.zip` as usual.

## Generating an iCell (Main file)

The `Input_Nets` folder contains three human generic networks to test the framework: PPI, co-expression (COEX) and genetic interaction (GI).

**Step 1** (MATLAB):
```matlab
run_SSNMTF()
```
Loads the three networks and runs `SSNMTF.m` for the data integration. Outputs the matrix factors G and S, and the correspondence between genes and rows of G.

**Step 2** (terminal):
```bash
python Make_Integrated_Net.py
```
Uses the G factor and the gene correspondence file to build the integrated network, `HSA_Generic_iCell.edgelist`.

## Contents of the full package

Each folder contains its own `Readme.txt`.

- **1–2:** Generic and tissue-specific PPI, co-expression and genetic interaction networks
- **3–5:** SSNMTF parameter setting (number of clusters, number of iterations, choice of input networks)
- **6–9:** What is an iCell: integrated networks, graphlet degree vectors, model fitting, clustering and enrichment
- **10–12:** Cancer-specific study: rewiring, driver gene enrichment, esiRNA experiments
- **13:** Pan-cancer study

## Citation

N. Malod-Dognin, J. Petschnigg, S.F.L. Windels, J. Povh, H. Hemmingway, R. Ketteler and N. Pržulj. Towards a data-integrated cell. *Nature Communications* 10, 805 (2019). https://doi.org/10.1038/s41467-019-08797-8
