
% basic input/output
netlist={
'./Input_Nets/HSA_Generic_PPI.edgelist',
'./Input_Nets/HSA_Generic_COEX.edgelist',
'./Input_Nets/HSA_Generic_GI.edgelist'
};

ofname='./HSA_Generic_iCell';


% setting up random number generator
seed = 1856279083;
rand('seed',seed); 

%default SSNMTF parameters
k=50;
iter = 1000;


% Loading the input networks
A = {};
sizes = [];
label_list={};
dif_ind={};

for ii=1:length(netlist)
	[nodes_i,nodes_j,w_ij] = textread(netlist{ii},'%s %s %n\n');
	cut_idx = length(w_ij);
	if sum(w_ij)==0
		w_ij=ones(size(nodes_i));
	end;
	[indx,labels] = grp2idx([nodes_i',nodes_j']);
	A{ii} = spconvert([[indx(1:cut_idx);max(indx)],[indx(cut_idx+1:end);max(indx)],[w_ij;0.0]]);
	A{ii} = A{ii} + A{ii}'-diag(diag(A{ii})); % symmetric adjacency matrix
	s = size(A{ii});
	sizes(ii) = s(1); % number of nodes in each network
	label_list{ii} = labels';
	net_name = strread(netlist{ii},'%s','delimiter','/');
	net_name = char(net_name(end));
	fprintf('[%i] has Loaded network %s!\n',i, netlist{ii})
end;
	
	
% Using same node ordering on all networks
B=cell(1,length(A));
all_labels=[];
for ii=1:length(netlist)
	all_labels = [all_labels; label_list{ii}'];
end;
unique_labels = unique(all_labels);
diff=cell(1,length(label_list));
indLabels=cell(1,length(label_list));
diff_ind=cell(2,length(label_list));
for ui=1:length(diff);
	diff{ui}=setdiff(unique_labels,label_list{ui});
	[C] = union(label_list{ui},diff{ui},'stable');
	[CS,IS]=sort(C);
	dif_ind{1,ui} = IS;
	dif_ind{2,ui} = CS;
end;
for ii=1:length(label_list)
	AA=blkdiag(A{ii},sparse(length(diff{ii}),length(diff{ii})));
	B{ii}=AA(dif_ind{1,ii},dif_ind{1,ii});
end;
		
% Running data integration
[S, G, RSE] = SSNMTF(B(1:length(netlist)), {}, k, [], iter);
glist = cell2table(unique_labels);
writetable(glist, sprintf('%s_genelist.csv', ofname) );
dlmwrite(sprintf('%s_G_k%i.csv', ofname, k), G, 'delimiter', '\t');
dlmwrite(sprintf('%s_S_k%i.csv', ofname, k), S, 'delimiter', '\t');


