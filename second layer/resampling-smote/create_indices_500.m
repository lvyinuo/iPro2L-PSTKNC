function indices=create_indices_500()
%% 5折分包（第一次运行时执行，此后不再执行！保证5折的划分一致。）
label24=ones(500,1);
label28=ones(500,1)*2;
label32=ones(500,1)*3;
label38=ones(500,1)*4;
label54=ones(500,1)*5;
label70=ones(500,1)*6;
% 5折分包
indices24 = crossvalind('Kfold',label24,5); %5为交叉验证折数
indices28 = crossvalind('Kfold',label28,5); %5为交叉验证折数
indices32 = crossvalind('Kfold',label32,5); %5为交叉验证折数
indices38 = crossvalind('Kfold',label38,5); %5为交叉验证折数
indices54 = crossvalind('Kfold',label54,5); %5为交叉验证折数
indices70 = crossvalind('Kfold',label70,5); %5为交叉验证折数
indices=[indices24(1:489,:);indices28(1:137,:);indices32(1:295,:);indices38(1:226,:);indices54(1:96,:);indices70;indices24(490:500,:);indices28(138:500,:);indices32(296:500,:);indices38(227:500,:);indices54(97:500,:)];
save('indices.mat','indices'); %将indices保存在indices.mat文件中
%此后所有实验均使用本次生成的indices.mat文件
end