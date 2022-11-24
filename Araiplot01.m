function Araiplot01(Ms,Area,Volume)
T = [30 100 200 300 400 420 450 460 470 480 490 500 510 520 530 540 550 560 570 580]+273;

VBark = logspace(log10(5e-9^3), log10(100e-9^3),20);
M0 = zeros(1,20);
M1 = zeros(1,20);
Vbark = VBark(1:20);
for i =1:20
    for j = 1:20
        file = load(['D:\MD_modle theory\Coe11\VBark' num2str(i) 'num' num2str(j) '.txt']);
        [m0,m1] = magnetization(file,Ms,Vbark(i),Area,Volume);
        M0 = M0+m0;
        M1 = M1+m1;
    end
end

scatter(M1/M0(1)-M0/M0(1),M0/M0(1),30)
hold on;
plot(M1/M0(1)-M0/M0(1),M0/M0(1))

for i =1:length(M0)
    text(M1(i)/M0(1)-M0(i)/M0(1),M0(i)/M0(1)+0.05,num2str(T(i)-273));
end

xlabel('TRM/NRM0');
ylabel('NRM/NRM0');
text(0.7,0.7,'V = 1 (mium)^3');
