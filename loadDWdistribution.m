function [file] = loadDWdistribution(Vbark)
[VBark,P,yr] = SetupVariables(10);
VBark = 0.1*VBark;

deltV = Vbark- timelist;
x = find(deltt<0,1);
P_out = export_file(x,1:number_of_pin_site);
    
filepath = ['D:\MD_modle theory\MD_modle theory\magnetite\VRM\' 'Vbark' num2str(Vbark*10^18) 'Ms' num2str(Ms) ...
    'Hk' num2str(Hk) 'V' num2str(V*10^18) 'A' num2str(A*10^12) 'Dir' num2str(Dir) '\particle01_Hk'];

filelist = xlsread(filepath);
Hlist = filelist(:,3);
Tlist = filelist(:,5);

Hpostion = find(Hlist ==H);
Tpostion = find(Tlist ==T);
 
filenamenum = intersect(Hpostion,Tpostion);

fileloc = ['D:\MD_modle theory\MD_modle theory\magnetite\VRM\' 'Vbark' num2str(Vbark*10^18) 'Ms' num2str(Ms) ...
    'Hk' num2str(Hk) 'V' num2str(V*10^18) 'A' num2str(A*10^12) 'Dir' num2str(Dir) '\file' num2str(filenamenum) '.txt'];

file = load(fileloc);