function [P_VRM,VRM] = AcquireVRMMD(N,Tc,P,Ms,H,Hk,Temperature,Vbark,Volume,Area,number_of_pin_site,loop_num,t,pinenergy)
% Calculate the pinn site probability distribution after time t at fixed temperature 
if nargin < 14
    pinenergy = ones(1,number_of_pin_site-1);
end

[export_file] = Distributionvstime(N,Tc,P,Ms,H,Hk,Temperature,Vbark,Volume,Area,number_of_pin_site,loop_num,pinenergy);
timelist = export_file(1:end,end-1);

if t< timelist(1)
    P_VRM = P;
    VRM = export_file(1,end);
elseif t>timelist(end)
    P_VRM = export_file(end,1:number_of_pin_site);
    VRM = export_file(end,end);
else
    deltt = t- timelist;
    x = find(deltt<0,1);
    P_VRM = export_file(x,1:number_of_pin_site);
    VRM = export_file(x,end);
end