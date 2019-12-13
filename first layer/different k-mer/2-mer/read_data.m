function data=read_data(filename)
data=importdata(filename);
data=data(2:2:end,:); %读取数据集中的序列
end

