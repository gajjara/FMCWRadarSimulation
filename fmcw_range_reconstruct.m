function J = fmcw_range_reconstruct(I,max_range,range_res,target_vel,fc,Nd,Nr,Ps,G)
% FMCW_RANGE_RECONSTRUCT- Perform an fmcw range reconstruction on a 2D array
% 
% Syntax: J =
% fmcw_range_reconstruct(I,max_range,range_res,vel,fc,Nd,Nr,Ps,G);
% 
% Inputs:
%	max_range - the maximum measurement range for the radar
%   range_res - the desired range resolution of the radar system
%   target_vel - the initial velocity of all targets (to change this later)
%   fc - the carrier frequency of the radar
%   Nd - the number of chirps to perform
%   Nr - the number of samples on each chirp
%   Ps - the power of the TX on the radar
%   G - the gain of the RX antenna on the radar
%
% Outputs:
%   J - the 2D array of the reconstructed range
% 
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% 
% See also: FMCW_TARGET
J = zeros(size(I));
for i = 1:size(I,1)
    for j = 1:size(I,2)
        [~,~,~,FMix,~] = fmcw_target(double(I(i,j)),max_range,range_res,target_vel,fc,Nd,Nr,Ps,G);
        FMix = FMix(2:end);
        [~,ids] = maxk(FMix,2);
        index = mean(ids);
        J(i,j) = index;
    end
end
end
