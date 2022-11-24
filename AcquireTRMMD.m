function [P_TRM,TRM] = AcquireTRMMD(N,Tc,P,Ms,H,Hk,Vbark,Volume,Area,toT,fromT,number_of_pin_sit,loop_num,t,pinenergy)
% Calculate the pinn site probability distribution after temperature change
% from fromT to toT.(Uniform cooling)
if nargin < 14
    pinenergy = ones(1,number_of_pin_site-1);
end

TT = linspace(fromT,toT,10*min(50,1+ceil(abs(fromT-toT)/5))); 
P1 = P;
for n = 1:length(TT)   
    [P_VRM,VRM] = AcquireVRMMD(N,Tc,P1,Ms,H,Hk,TT(n),Vbark,Volume,Area,number_of_pin_sit,loop_num,t./length(TT),pinenergy);   
    P1 = P_VRM; 
end
P_TRM = P1;
TRM = VRM;


