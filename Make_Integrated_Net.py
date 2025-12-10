import sys
import operator
import math
import numpy as np
import networkx as nx
import os.path

# Load gene list
def Load_Gene_list(filename):
	Glist = []
	ofile = open(filename, 'r')
	#skip file header line
	ofile.readline()
	for line in ofile.readlines():
		gene = line.strip().split()[0]
		Glist.append( gene )
	ofile.close()
	#safety test
	Gset = set(Glist)
	if len(Gset) <> len(Glist):
		print "!!!! Duplicated genes in gene list"
	return Glist

# Load a matrix
def Load_Matrix(filename):
	G = []
	ofile = open(filename, 'r')
	for line in ofile.readlines():
		row = [float(i) for i in line.strip().split('\t')]
		G.append( row )
	ofile.close()
	return np.array(G)



"""
	Main code starts here
"""


input_Gfactor = './HSA_Generic_iCell_G_k50.csv'
input_Genelist = './HSA_Generic_iCell_genelist.csv'
ofile = 'HSA_Generic_iCell.edglist'

#load genelist, G matrix and building raw integrated network
Glist = Load_Gene_list(input_Genelist)
nb_gene = len(Glist)
G = Load_Matrix(input_Gfactor)
GT = np.transpose(G)
Raw_Net = np.dot(G,GT)

#thresholding integrated network (top 1percent per rwo/column)
ind = int( float(nb_gene)*0.99 )

Int_Net = nx.Graph()
for i in range(nb_gene):
	sorted_row = np.sort( Raw_Net[i], kind='mergesort')
	val  = sorted_row[ind]
	genei = Glist[i]
	for j in range(nb_gene):
		genej = Glist[j]	
		if (genei <> genej) and Raw_Net[i][j]>= val:
			if not(Int_Net.has_edge(genei, genej)):
				Int_Net.add_edge(genei, genej, weigth=Raw_Net[i][j])

#outputing the integrated network				
print "Integrated net has %i nodes and %i edges"%(Int_Net.number_of_nodes(), Int_Net.number_of_edges())
nx.write_edgelist(Int_Net, ofile, data=['weight'])






