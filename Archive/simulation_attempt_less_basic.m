%% Parameters

max_range = 30;
range_res = 3;
fc = 30e9;
Nd = 128;
Nr = 1024;
P = 0.5;
G = 65;

%% Range Map
I = meshgrid(2:2:12,2:2:12);

%% Range Retreival
J = zeros(size(I));

for i = 1:size(I,1)
    for j = 1:size(I,2)
        range_obj = I(i,j);
        [~,~,~,FMix,~] = less_basic_fmcw(range_obj,max_range,range_res,0,fc,Nd,Nr,P,G);
        FMix = FMix(2:end);
        %figure(1); plot(FMix); title(string(range_obj)); pause(0.5);
        [~,ids] = maxk(FMix,2);
        index = mean(ids);
        J(i,j) = index;
    end
    disp(i);
end
%J = max(J,[],'all') - J;

%%
figure; subplot(1,2,1); imagesc(I); colorbar;
subplot(1,2,2); imagesc(J); colorbar;