function J = less_less_basic_range_retrival(I,max_range,range_res,vel,fc,Nd,Nr,Ps,G)
%LESS_BASIC_RANGE_RETRIVAL Summary of this function goes here
%   Detailed explanation goes here
J = zeros(size(I));
for i = 1:size(I,1)
    for j = 1:size(I,2)
        [~,~,~,FMix,~] = less_less_basic_fmcw(double(I(i,j)),max_range,range_res,vel,fc,Nd,Nr,Ps,G);
        FMix = FMix(2:end);
        [~,ids] = maxk(FMix,2);
        index = mean(ids);
        J(i,j) = index;
    end
end
end
