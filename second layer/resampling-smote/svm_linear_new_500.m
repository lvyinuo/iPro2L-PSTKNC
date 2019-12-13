function parameter=svm_linear_new_500()
%% 主程序
data=importdata('smote_23mer_24.csv');  
label24=[ones([489,1]);zeros([1254,1]);ones([11,1]);zeros([1246,1])];
label28=[zeros([489,1]);ones([137,1]);zeros([1128,1]);ones([363,1]);zeros([883,1])];
label32=[zeros([626,1]);ones([295,1]);zeros([1196,1]);ones([205,1]);zeros([678,1])];
label38=[zeros([921,1]);ones([226,1]);zeros([1175,1]);ones([274,1]);zeros([404,1])];
label54=[zeros([1147,1]);ones([96,1]);zeros([1353,1]);ones([404,1])];
label70=[zeros([1243,1]);ones([500,1]);zeros([1257,1])];
%% 五折调参
% [bestc, bestAcc, bestSn, bestSp, bestMCC] = svmcg( data ,cstep,cmin,cmax,c0,acc0)
[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg_500(data,label24,1,-5,4,0,0);
%[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg_500(data,label28,1,-5,4,0,0);
%[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg_500(data,label32,1,-5,4,0,0);
%[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg_500(data,label38,1,-5,4,0,0);
%[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg_500(data,label54,1,-5,4,0,0);
%[bestc, bestacc, bestMCC, bestSn, bestSp] = svmcg_500(data,label70,1,-5,4,0,0);
parameter=[bestSn,bestSp,bestacc,bestMCC];
end

