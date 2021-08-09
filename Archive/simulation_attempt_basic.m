%% Parameters

max_range = 300;
range_res = 0.1;
fc = 77e9;
Nd = 128;
Nr = 1024;


%% Range Map
I = double(255-rgb2gray(imread("/Users/Anuj/Downloads/unnamed copy.png")));
I = I - min(I,[],'all');
I = I./max(I,[],'all');
I = I.*50;

%% Attempting Multiple Ranges
J = zeros(size(I));

for i = 1:size(I,1)
    for j = 1:size(I,2)
        [~,~,~,FMix,~] = basic_fmcw(double(I(i,j)),max_range,range_res,0,fc,Nd,Nr);
        index = find(max(FMix,[],'all')==FMix);
        J(i,j) = index;
    end
    disp(i);
end
