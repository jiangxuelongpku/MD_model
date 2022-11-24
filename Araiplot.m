function Araiplot(Ms,Area,Volume)
T = [100:50:500]+273;
[VBark,P,yr] = SetupVariables(10);
M0 = zeros(1,17);
M1 = zeros(1,17);
for i =1:50
    Vbark = VBark(i);
    file = load(['D:\MD_modle theory\Coe02\VBark' num2str(i) '.txt']);
    [M01,M11] = magnetization(file,Ms,Vbark,Area,Volume);
    M0 = M0+M01;
    M1 = M1+M11;
end
M0 = M0/50;
M1 = M1/50;

scatter(M1/M0(1),M0/M0(1))
plot(M1/M0(1),M0/M0(1))

for i =1:length(M0)
    text(M1(i)/M0(1),M0(i)/M0(1),num2str(T(i)));
end

xlabel('TRM/NRM0');
ylabel('NRM/NRM0');

