function parameter=svm_linear()
%% ������
data=importdata('all_2+3mer.mat');
datap=data(1:2633,:);
datan=data(2634:5266,:);
%% ���۵���
% [bestc, bestAcc, bestSn, bestSp, bestMCC] = svmcg( data ,cstep,cmin,cmax,c0,acc0)
[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg(data,datap,datan,1,-5,4,0,0);
parameter=[bestc,bestSn,bestSp,bestacc,bestMCC];
end

