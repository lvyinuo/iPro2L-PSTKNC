data=importdata('all_2+3mer.mat');
datap=data(1:2633,:);     %������(��)
datan=data(2634:5266,:);    %������(��)
random_forest(data,datap,datan);
%random_forest_new(data,datap,datan); %or can use this?