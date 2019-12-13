function indices=create_indices()
%% 5折分包（第一次运行时执行，此后不再执行！保证5折的划分一致。）
p=2633;
n=5266-p;
plabel=ones(p,1);
nlabel=zeros(n,1);
label=[plabel;nlabel];
% 5折分包
indices = crossvalind('Kfold',label,5); %5为交叉验证折数
save('indices.mat','indices'); %将indices保存在indices.mat文件中
%此后所有实验均使用本次生成的indices.mat文件
end