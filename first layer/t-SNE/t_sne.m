function t_sne
data=importdata('all_2mer.mat');  %feature matrix 2-mer
%data=importdata('all_3mer.mat');  %feature matrix 3-mer
label=importdata('label_all.xlsx');
rng default %for reproducibility
no_dims = 2;
initial_dims = 50;
perplexity = 30;
mappedX=tsne(data,[],no_dims,initial_dims,perplexity);
gscatter(mappedX(:,1),mappedX(:,2),label);
end