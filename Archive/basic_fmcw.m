function [Tx,Rx,Mix,FMix,FMix2] = basic_fmcw(range_obj,max_range,range_res,vel,fc,Nd,Nr)
%BASIC_FMCW Summary of this function goes here
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

% Tx signal
Tx = cos(2.*pi.*(fc.*t + (slope.*t.^2)./2));

% Rx signal
Rx = cos(2.*pi.*(fc.*(t -td) + (slope.*(t-td).^2)./2));

% Mix signal
Mix = Tx.*Rx;

% Range retrival processing
Mix2 = reshape(Mix,[Nr,Nd]);
FMix = abs(fft(Mix2,Nr));
FMix = FMix./max(FMix);
FMix = FMix(1 : Nr/2-1);

% Doppler-Range retrival processing
FMix2 = fft2(Mix2,Nr,Nd);
FMix2 = FMix2(1:Nr/2,1:Nd);
FMix2 = fftshift(FMix2);
FMix2 = abs(FMix2);
FMix2 = 10*log10(FMix2);

end

