function [P_Coe,NRM,pTRM] = Coe(N,Tc,P,Ms,H0,Hk,Vbark,Volume,Area,T0,T,number_of_pin_site,loop_num,t,heating_rate,pinenergy)
% P_Coe,NRM,pTRM are the probobility distribution of pinsite ,the NRM,pTRM
% after Coe procedure
% T0 - the temperature at which the remanence is measured (i.e. room 
% temperature) (scalar) [K] 
% T - the temperature steps (vector) [K]  
% t - hold total time of the temperature (scalar) [s]
if nargin < 16
    pinenergy = ones(1,number_of_pin_site-1);
end
    P1_out = zeros(length(T),length(P));
    P2_out = zeros(length(T),length(P));
    t_measure = 100; % time it takes to measure the sample
    P2 = P;
    for n = 1:length(T) 
        dT = T(n) - T0;       % how many degrees from room T up to target T?
        dt = dT/heating_rate; % time it takes to heat up to T from room T      
        % Heat up
        [P1,M] = AcquireTRMMD(N,Tc,P2,Ms,0,Hk,Vbark,Volume,Area,T(n),T0,number_of_pin_sit,loop_num,dt,pinenergy);
        % Hold 
        [P1,M] = AcquireVRMMD(N,Tc,P1,Ms,0,Hk,T(n),Vbark,Volume,Area,number_of_pin_site,loop_num,t,pinenergy);
        % Cool down
        [P1,M] = AcquireTRMMD(N,Tc,P1,Ms,0,Hk,Vbark,Volume,Area,T0,T(n),number_of_pin_sit,loop_num,dt,pinenergy);
        % Put the sample into zero-field
        [P1,M1] = AcquireVRMMD(N,Tc,P1,Ms,0,Hk,T(n),Vbark,Volume,Area,number_of_pin_site,loop_num,t_measure,pinenergy);
        P1_out(n,:) = P1;
        
        [P2,M] = AcquireTRMMD(N,Tc,P1,Ms,H0,Hk,Vbark,Volume,Area,T(n),T0,number_of_pin_sit,loop_num,dt,pinenergy);
        % Hold 
        [P2,M] = AcquireVRMMD(N,Tc,P2,Ms,H0,Hk,T(n),Vbark,Volume,Area,number_of_pin_site,loop_num,t,pinenergy);
        % Cool down
        [P2,M] = AcquireTRMMD(N,Tc,P2,Ms,H0,Hk,Vbark,Volume,Area,T0,T(n),number_of_pin_sit,loop_num,dt,pinenergy);
        % Put the sample into zero-field
        [P2,M2] = AcquireVRMMD(N,Tc,P2,Ms,0,Hk,T(n),Vbark,Volume,Area,number_of_pin_site,loop_num,t_measure,pinenergy);
        P2_out(n,:) = P2;  
    end
    P_Coe = [P1_out;P2_out];
    NRM = M1;
    pTRM = M2;
end