function data=delete96(filename)
data=read_data(filename);
rand=size(data,1);  %��data�ȳ���������
randnum=randperm(rand);  %�����rand��������
randnum=randnum(1:96);  %ȡǰ96��
data=data(randnum,:);  %ȡ��96��������
end