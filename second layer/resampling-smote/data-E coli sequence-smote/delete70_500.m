function data=delete70_500()
data=read_data('70_690.txt');
rand=size(data,1);  %��data�ȳ���������
randnum=randperm(rand);  %�����rand��������
randnum=randnum(1:500);  %ȡǰ500��
data=data(randnum,:);  %ȡ��500��������
save '70_500.txt'
end