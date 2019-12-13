X1=importdata('s500_2mer_24_p.mat');  %28 32 38 54 70
X2=importdata('s500_3mer_24_p.mat');
X=[X1,X2];
save('s500_23mer_24_p','X');