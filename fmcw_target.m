function [Tx,Rx,Mix,FMix,FMix2] = fmcw_target(target_range,max_range,range_res,target_vel,fc,Nd,Nr,Ps,G)
%FMCW_TARGET - Performs a simulation of FMCW radar on a single target with
%a starting range and velocity
% 
% Syntax: [Tx,Rx,Mix,FMix,FMix2] =
% fmcw_target(target_range,max_range,range_res,target_vel,fc,Nd,Nr,Ps,G);
% 
% Inputs:
%   target_range - the initial range of the target in meters
%   max_range - the maximum measurement range for the radar
%   range_res - the desired range resolution of the radar system
%   target_vel - the initial velocity of the target
%   fc - the carrier frequency of the radar
%   Nd - the number of chirps to perform
%   Nr - the number of samples on each chirp
%   Ps - the power of the TX on the radar
%   G - the gain of the RX antenna on the radar
%
% Outputs:
%   Tx - the time domain Tx signal
%   Rx - the time domain Rx signal
%   Mix - the time domain Mix signal
%   FMix - the processed frequency domain signal of the Mix signal sampled
%   at Nd (this signal provides the range of the object)
%   FMix2 - the processed frequency domain signal of the Mix signal
%   sampled in 2D at Nd and Nr (this singal provides the range-doppler of
%   the object)
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also:  none

% Time-independent parameters
c = 3e8; % Speed of light
B = c/(2*range_res); % Bandwidth
Tchirp = 2*(max_range/c); % Chirp Time
slope = B/Tchirp; % Slope for frequnecy difference
G = 10^(G/10); % Gain linear
lambda = (c/fc); % Wavelength
A_e = (G*lambda^2)/(4*pi); % Effective radar aperture

% Time-dependent parameters
t = linspace(0,Nd*Tchirp,Nr*Nd); % Time axis
r_t = target_range + (target_vel.*t); % Time-dependent range
td = (2*r_t)/c; % Time delay

% Tx signal
Tx = Ps.*cos(2.*pi.*(fc.*t + (slope.*t.^2)./2));

% Radar cross section
cross = ((4*pi)*(0.1^2)*(0.1^2))/(lambda^2);

% Recieved power at Rx
Pe = cross*A_e*Ps*G*((1/(4*pi*(target_range^2)))^2);

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

