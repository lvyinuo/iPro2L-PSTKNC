%% svmcg函数
function [bestc, bestAcc, bestMCC, bestSn, bestSp] = svmcg(data,datap,datan,cstep,cmin,cmax,c0,acc0)
% 生成标签
label=[ones(size(datap,1),1);zeros(size(datan,1),1)];
% 生产网格
[X,Y] = meshgrid(cmin:cstep:cmax);
[m,n] = size(X);
% 初始值,用于比较
bestc = c0;
bestAcc = acc0;
basenum = 2;
bestSn=0;
bestSp=0;
bestMCC=0;
% 输入五折分包系数
indices=create_indices(); 
for x = 1:m
    cmd = [' -t ', num2str(0),' -c ',num2str( basenum^X(1,x))];
    for i = 1:5
        %   获取编号
        test = (indices == i);  %获得test集元素在数据集中对应的单元编号
        train = ~test;  %train集元素的编号为非test元素的编号
        %   数据集
        train_data=data(train,:);   %从数据集中划分出train样本的数据
        train_label=label(train,:);   %获得样本集的测试目标，在本例中是实际分类情况
        %   测试集
        test_data=data(test,:); %test样本集
        test_label=label(test,:);
        %   预测
        model = svmtrain( train_label, train_data, cmd );
%         [predict_label, accuracy, dec_values] = svmpredict(test_label, test_data,model);
        [predict_label] = svmpredict(test_label, test_data,model);
        [Sn_i,Sp_i,MCC_i,Acc_i]=perf_svm(predict_label,test_label);
        Acc(1,i)=Acc_i;
        Sn(1,i)=Sn_i;
        Sp(1,i)=Sp_i;
        MCC(1,i)=MCC_i;
        %[A,B,THRE,AUC] = perfcurve(test_label,dec_values(:,1),'1');
        %auc(1,i)=AUC;
    end
    tem_Acc=sum(Acc)/5;
    tem_Sn=sum(Sn)/5;
    tem_Sp=sum(Sp)/5;
    tem_MCC=sum(MCC)/5;
    if tem_Acc > bestAcc
        bestAcc = tem_Acc;
        bestSn=tem_Sn;
        bestSp=tem_Sp;
        bestMCC=tem_MCC;
        bestc = basenum^X(x,1);
    end
    if ( tem_Acc == bestAcc && bestc > basenum^X(x,1) )
        bestAcc = tem_Acc;
        bestSn=tem_Sn;
        bestSp=tem_SP;
        bestMCC=tem_MCC;
        bestc = basenum^X(x,1);
    end
    
end