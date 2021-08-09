function J = basic_range_retrival(I,max_range,range_res,vel,fc,Nd,Nr)
%BASIC_RANGE_RETRIVAL Summary of this function goes here
%   Detailed explanation goes here
J = zeros(size(I));
for i = 1:size(I,1)
    for j = 1:size(I,2)
        [~,~,~,FMix,~] = basic_fmcw(double(I(i,j)),max_range,range_res,vel,fc,Nd,Nr);
        index = find(max(FMix,[],'all')==FMix);
        J(i,j) = index;
    end
end
end

