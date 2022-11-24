function distributionplot01(vbark_num,VBark,file)
if nargin < 2
    VBark = logspace(log10(5e-9^3), log10(100e-9^3),500);
end
if nargin < 3
    file = load(['D:\MD_modle theory\Coe07\VBark' num2str(vbark_num) '.txt']); 
end

Vbark = VBark(vbark_num);
[l,n]  = size(file);

%T = [30 100 200 300 400 420 450 460 470 480 490 500 510 520 530 540 550 560 570 580]+273;
%T1 = zeros(1,l);
%for i = 1:l
    %if mod(i,2) == 0
        %T1(i) = T(i/2);
    %else
       % T1(i) = T(i/2+0.5);
   % end
%end

m=linspace(0.5,0.9,l/2);
for i  = 1:l/2 %NRM
    plot(file(i,:),'color',[m(i),1,m(i)]);
    hold on;
end

for i  = l/2+1:l % pTRM
    plot(file(i,:),'color',[1,m(i-l/2),m(i-l/2)]);
    hold on;
end
p1 = plot(file(1,:),'r');
p2 = plot(file(l,:),'g');
legend([p1,p2],{'NRM lost','pTRM acquire'},'FontName','Times New Roman','FontSize',8)

xlabel('Pin site','FontName','Times New Roman','FontSize',12);
ylabel('probability','FontName','Times New Roman','FontSize',12);
minx = 1;
maxx = n;
miny = 0;
maxy = 1.2*max(max(file));
axis([minx,maxx,miny,maxy]);

text(5,0.8*maxy,['Vbark' num2str(Vbark)],'FontName','Times New Roman','FontSize',8);
text(5,0.7*maxy,['Volume' num2str(1e-18)],'FontName','Times New Roman','FontSize',8);
text(5,0.6*maxy,['Hk' num2str(40)],'FontName','Times New Roman','FontSize',8);

set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1);