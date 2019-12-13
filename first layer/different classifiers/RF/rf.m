function [ result_class ] = rf( N,m,M,data,label,test_data )
t=cell(1,N);  %cell元组,存储树
%% 训练树
% 形成样本及其标签
for i=1:N %利用m个训练集构造N颗树
    for j=1:m
        r(j)=randi(m,1); %生成1~m的随机数
        if j==1
            train=data(r(j),:);
            train_label=label(r(j));
        else
            train=[train;data(r(j),:)];
            train_label=[train_label;label(r(j))];
        end
    end
    %    生成回归树
    t{i} = classregtree(train,train_label);
end
%% 进行预测
for i=1:M-m
    for j=1:N
        result(i,j)=eval(t{j},test_data(i,:));  %eval获取返回值
    end
end
%% 投票
for i=1:M-m
    sum(i,1:2)=0;
    for j=1:N
        if result(i,j)>=0.8;
            %             阈值可设置
            sum(i,1)=sum(i,1)+1;
        else
            sum(i,2)=sum(i,2)+1;
        end
    end
end

%% 分类结果
% result_class=cell(M-m,1); %M-m 为预测集的数量
result_class=[];
for i=1:M-m
    index=find(sum(i,:)==max(sum(i,:))); %找到第i个序列中树最多的类别
    if index(1)==1
        result_class=[result_class;1];
    else if index(1)==2
            result_class=[result_class;0];
        end
    end
    
end


end

