function indices=create_indices_500()
%% 5�۷ְ�����һ������ʱִ�У��˺���ִ�У���֤5�۵Ļ���һ�¡���
label24=ones(500,1);
label28=ones(500,1)*2;
label32=ones(500,1)*3;
label38=ones(500,1)*4;
label54=ones(500,1)*5;
label70=ones(500,1)*6;
% 5�۷ְ�
indices24 = crossvalind('Kfold',label24,5); %5Ϊ������֤����
indices28 = crossvalind('Kfold',label28,5); %5Ϊ������֤����
indices32 = crossvalind('Kfold',label32,5); %5Ϊ������֤����
indices38 = crossvalind('Kfold',label38,5); %5Ϊ������֤����
indices54 = crossvalind('Kfold',label54,5); %5Ϊ������֤����
indices70 = crossvalind('Kfold',label70,5); %5Ϊ������֤����
indices=[indices24(1:489,:);indices28(1:137,:);indices32(1:295,:);indices38(1:226,:);indices54(1:96,:);indices70;indices24(490:500,:);indices28(138:500,:);indices32(296:500,:);indices38(227:500,:);indices54(97:500,:)];
save('indices.mat','indices'); %��indices������indices.mat�ļ���
%�˺�����ʵ���ʹ�ñ������ɵ�indices.mat�ļ�
end