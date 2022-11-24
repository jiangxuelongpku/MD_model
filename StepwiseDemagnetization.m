function P_out = StepwiseDemagnetization(V, VBark, Area,HK0,P,T0,T,H0,number_of_pin_site,heating_rate, t)
% T0 - the temperature at which the remanence is measured (i.e. room 
% temperature) (scalar) [K] 
% T - the temperature steps (vector) [K]  
% t - hold total time of the temperature (scalar) [s]
    P_out = size(length(T),length(P));
    t_measure = 100; % time it takes to measure the sample
    for n = 1:length(T) 
        dT = T(n) - T0;       % how many degrees from room T up to target T?
        dt = dT/heating_rate; % time it takes to heat up to T from room T      
        % Heat up
        P1 = AcquireTRMMD(V, VBark, Area,HK0,P,T(n),T0,dt, H0,number_of_pin_site);
        % Hold 
        P1 = AcquireVRMMD(V, VBark,Area, HK0,P1, T(n), t, H0,number_of_pin_site);
        % Cool down
        P1 = AcquireTRMMD(V, VBark, Area,HK0,P1,T0,T(n),dt, H0,number_of_pin_site);
        % Put the sample into zero-field
        P1 = AcquireVRMMD(V, VBark,Area, HK0,P1, T(n), t_measure, H0,number_of_pin_site);
        P_out(n,:) = P1;
    end
end