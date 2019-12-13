function data=delete70_500()
data=read_data('70_690.txt');
rand=size(data,1);  %与data等长的列向量
randnum=randperm(rand);  %随机将rand重新排列
randnum=randnum(1:500);  %取前500个
data=data(randnum,:);  %取这500个的内容
save '70_500.txt'
end