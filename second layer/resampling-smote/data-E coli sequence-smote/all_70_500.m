function data=all_70_500()
data0=read_data('all.txt');
data24=data0(1:489,:);
data28=data0(490:626,:);
data32=data0(627:921,:);
data38=data0(922:1147,:);
data54=data0(1148:1243,:);
data70=importdata('70_500.txt');
data=[data24;data28;data32;data38;data54;data70];
save 'all_sequence_70_500.mat'
end