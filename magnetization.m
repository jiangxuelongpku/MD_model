function [M0,M1] = magnetization(file,Ms,Vbark,Area,Volume)
[L,H] = size(file);
file1= file(1:L/2,:);
file2 = file(L/2+1:end,:);
X = zeros(1,H);
for i =1:H
    if mod(H,2) == 1 %It's an odd number
        y = -(floor(H/2)-i+1)*Vbark/Area;        
    else
        y = -(H/2-i+0.5)*Vbark/Area;
    end
    X(i) = y;
end
M = 2*Ms*Area*X/Volume;

M0 = zeros(1,L/2);
M1 = zeros(1,L/2);
for i = 1:L/2
    M0(i) = sum(file1(i,:).*M);
    M1(i) = sum(file2(i,:).*M);
end
    

