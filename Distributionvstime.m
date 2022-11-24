function [distribution] =Distributionvstime(N,Tc,P,Ms,H,Hk,Temperature,Vbark,Volume,Area,number_of_pin_site,loop_num,pinenergy) 
% this simulate a Rectangular particle with two domains.

%N is the demagnetizing factor of domain structure. 0.127 for two domain particle
%Tc is the Curie temperature.853.15 K for magnetite.
%P is the Initial distribution of pinsite probability.
%Ms is the spontaneous magnetization at room temperature, the unite is A/m.
%H is the applied field, the unite is T
%HK is the microscopic coercivity at room temperature,the unite is T
%Temperature is the temperature of environment,the unite is K
%Vbark is the Barkhausen volume,the unite is m3
%Volume is the volume of the particle,the unite is m3
%Area is the area that parallel to the domain wall,the unite is m2
% number_of_pin_site is the number ofpin_site
%loop_num is the number of loop time to prevent endless circulation.
%pinenergy is the pinenergy energy barrier between pinsite.
if nargin < 13
    pinenergy = ones(1,number_of_pin_site-1);
end

u0 = 4*pi*10^-7;% permeability of Vacuum in SI unit
kB = 1.380649*10^-23;% Boltzmann constant
tao0 = 1*10^-9;%interval between successive thermal excitations

% for magnetite,we can calculte the Ms and Hk at different temperature in
% follow way

H = 1e4*(4*pi)^-1*1000*H;% applied field,convert the unite to A/m
Hk = 1e4*(4*pi)^-1*1000*Hk;%corcivity at 290K,convert the unite to A/m

gama = 0.43;
Ms = Ms*(Tc-Temperature)^gama*(Tc-300)^-gama;
Hk = Hk*(Tc-Temperature)^gama*(Tc-300)^-gama;

% don't calculate the part higher than curie temperature to save resource.
if Temperature > Tc
    Temperature = Tc;
end

%Location of pin site,They are evenly distributed around the central of the particle
X = zeros(1,number_of_pin_site);
for i =1:number_of_pin_site
    if mod(number_of_pin_site,2) == 1 %It's an odd number
        y = -(floor(number_of_pin_site/2)-i+1)*Vbark/Area;        
    else
        y = -(number_of_pin_site/2-i+0.5)*Vbark/Area;
    end
    X(i) = y;% the distance the pin site to the central of the particle.
end

M = 2*Ms*Area*X/Volume; %net magnetization of the grain
% K1 and K2 is the rate at which jumps occur to the left and to the right respectively:
K1 = 1/tao0*exp((u0*Vbark*Ms*(H-N*M+Hk*[1,pinenergy]))/(-kB*Temperature)); K1(1) = 0;
K2 = 1/tao0*exp((u0*Vbark*Ms*(N*M-H+Hk*[pinenergy,1]))/(-kB*Temperature)); K2(end) = 0;

P_matrix = zeros(loop_num,length(P));
dt_list = zeros(loop_num,1);%dt is the time step for each jump
sumM = zeros(loop_num,1);
dt_uperlimt = 0.5*(max(max(K1),max(K2)))^-1;% to avoid negative number of probability

P1 = P; 
for i =1:loop_num
    jumpout = -P1.*(K1+K2);
    P1_1 = [P1(2:end),0];
    P2_1 = [0,P1(1:end-1)];
    K1_1 = [K1(2:end),0];
    K2_1 = [0,K2(1:end-1)];
    jumpin = P1_1.*K1_1+P2_1.*K2_1;
    varp = jumpin+jumpout; %varp is dP/dt 
    % the block follow used to get the proper dt . |dP|<<P
    %|dP/dt|dt<<P.
    %dt<min(P|dt/dP|)
    dt = 0.1*min(P1.*(abs(varp)).^-1);
    if dt >dt_uperlimt 
        dt = dt_uperlimt;
    elseif dt  == 0
        dt = 0.01*max(P1.*(abs(varp)).^-1);
    end
    dP = dt*varp;
    P1 = dP+P1;   
    P_matrix(i,:) = P1;
    sumM(i) = sum(P1.*M);  
    dt_list(i) = dt;
    dpmax = max(abs(dP));
    if dt>1E18 %higher than the age of the universe
        break
    end
    if dpmax<10^-5 %Reach steady state
        break
    end
end

% find where dose the loop break
c = sum(P_matrix,2);
if c(end) ==0
    p = find(c == 0); p = p(1)-1;
else
    p = length(c) -1;
end
P_matrix = P_matrix(1:p,:);
Sum_t = zeros(p,1);
Sum_t(1) = dt_list(1);
for i = 2:p
    Sum_t(i) = dt_list(i-1)+Sum_t(i-1);
end
Sum_t = Sum_t(1:p,:);
sumM = sumM(1:p,:);
distribution = [P_matrix,Sum_t,sumM];



