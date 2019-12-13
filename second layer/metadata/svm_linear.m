function parameter=svm_linear()
%% 主程序
X1=importdata('3mer_24_p.mat');  %28 32 38 54 70
X2=importdata('2mer_24_p.mat');
data=[X1,X2];
datap=data(1:489,:);  %137 295 226 96 1390
datan=data(490:2633,:);  %138 296 227 97 1391
p=size(datap,1);
%% 五折调参
% [bestc, bestAcc, bestSn, bestSp, bestMCC] = svmcg( data ,cstep,cmin,cmax,c0,acc0)
[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg(p,data,datap,datan,1,-5,4,0,0);
parameter=[bestc,bestSn,bestSp,bestacc,bestMCC];
end

