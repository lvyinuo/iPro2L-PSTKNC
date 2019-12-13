function data=delete96(filename)
data=read_data(filename);
rand=size(data,1);  %与data等长的列向量
randnum=randperm(rand);  %随机将rand重新排列
randnum=randnum(1:96);  %取前96个
data=data(randnum,:);  %取这96个的内容
end