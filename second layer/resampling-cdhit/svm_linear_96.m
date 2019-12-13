function parameter=svm_linear_96()
%% 主程序
X1=importdata('96_3mer_24_p.mat');
X2=importdata('96_2mer_24_p.mat');
data=[X1,X2];
datap=data(1:96,:);
datan=data(97:576,:);
%% 五折调参
% [bestc, bestAcc, bestSn, bestSp, bestMCC] = svmcg( data ,cstep,cmin,cmax,c0,acc0)
[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg(data,datap,datan,1,-5,4,0,0);
parameter=[bestc,bestSn,bestSp,bestacc,bestMCC];
end

