function TRMandNRMplot01(vbark_num,Ms,Area,Volume,VBark,file)
if nargin < 5
    VBark = logspace(log10(5e-9^3), log10(100e-9^3),500);
end
if nargin < 6
    file = load(['D:\MD_modle theory\Coe07\VBark' num2str(vbark_num) '.txt']); 
end

Vbark = VBark(vbark_num);

T = [30 100 200 300 400 420 450 460 470 480 490 500 510 520 530 540 550 560 570 580];

[M0,M1] = magnetization(file,Ms,Vbark,Area,Volume);
p1=plot(T,M0/M0(1),'r');%NRM
hold on;
p2=plot(T,M1/M0(1)-M0/M0(1),'g');%ptRM

legend([p1,p2],{'NRM lost','pTRM acquire'},'FontName','Times New Roman','FontSize',12)

xlabel('Temperature','FontName','Times New Roman','FontSize',12);
ylabel('Remeance','FontName','Times New Roman','FontSize',12);
minx = T(1);
maxx = T(end);
miny = 0;
maxy = 1;
axis([minx,maxx,miny,maxy]);

text(200,0.8*maxy,['Vbark' num2str(Vbark)],'FontName','Times New Roman','FontSize',12);
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1);