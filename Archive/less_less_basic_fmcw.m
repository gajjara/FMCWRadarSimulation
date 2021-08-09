function [Tx,Rx,Mix,FMix,FMix2] = less_less_basic_fmcw(range_obj,max_range,range_res,vel,fc,Nd,Nr,Ps,G)
%LESS_BASIC_FMCW Summary of this function goes here
%   Detailed explanation goes here

% Nd: number of chirps
% Nr: number of samples on each chirp


% Speed of light
c = 3e8;

% Bandwidth
B = c/(2*range_res);

% Chirp Time
Tchirp = 2*(max_range/c);

% Slope for frequnecy difference
slope = B/Tchirp;

% Time axis
t = linspace(0,Nd*Tchirp,Nr*Nd);

% Time-dependent range
r_t = range_obj + (vel.*t);

% Time delay
td = (2*r_t)/c;

% Gain linear
G = 10^(G/10);

% Tx signal
Tx = Ps.*cos(2.*pi.*(fc.*t + (slope.*t.^2)./2));

% Power recieved at Rx
Pe = Ps*(((G^2)*((c/fc)^2))/(((4*pi)^3)*(range_obj^4)));

% Rx signal
Rx = Pe.*cos(2.*pi.*(fc.*(t -td) + (slope.*(t-td).^2)./2));
% Set the radar cross section to a lot smaller
% Cross section area
    % Assume antenna beam is circle
    % Increase in diameter as you are far way
    % For a speciifc angle of cone-triangle point
    % Should be able to calculate what the area of the circle for a given
    % distance away
    % Assume object takes entire circle (whether or not we detect it with
    % the case)

% Refimenemnt steps
    % Radar cross section
    % What angle and range resolution
    
% For noise
    % Assume a loss factor

% Mixed signal
quant = Tx + Rx;
Mix = quant + ((1/2).*quant.^2);% + ((1/6).*quant.^3) + ((1/24).*quant.^4) + ((1/120).*quant.^5);

% Range retrival
Mix2 = reshape(Mix,[Nr,Nd]);
FMix = abs(fft(Mix2,Nr));
FMix = FMix./max(FMix);
FMix = FMix(1 : Nr/2-1);

% Range-Doppler retrival
FMix2 = fft2(Mix2,Nr,Nd);
FMix2 = FMix2(1:Nr/2,1:Nd);
FMix2 = fftshift(FMix2);
FMix2 = abs(FMix2);
FMix2 = 10*log10(FMix2);

end

