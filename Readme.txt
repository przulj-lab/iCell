Folder Input_Net :-> three input networks to test our framework iCell (human generic PPI, COEX and GI networks)


Step 1: in Matlab, type 'run_SSNMTF()'. It will load the three network and call SSNMTF.m to perform iCell's data integration.
	The script wil output three files: Matrix factor G, matrix factor S, and the correspondance between genes and rows in G.

Step 2: in a terminal, type 'python Make_Integrated_Net.py'. It will load the G factor and the correspondance file, and will use them to create the integrated network.
	The script will output the integrated network, 'HSA_Generic_iCell.edgelist'