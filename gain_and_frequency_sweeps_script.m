% Range array
I = meshgrid(5:0.1:6,1:1);

hits = zeros(7,8);
ycounter = 1;
xcounter = 1;

for g = 40:10:100
    for f = 20:10:90
        J = fmcw_range_reconstruct(I,30,0.001,0,1e9*f,128,1024,0.5,g);
        hits(ycounter,xcounter) = max(sum(J(1,2:end)>J(1,1:end-1)), sum(J(1,2:end)<J(1,1:end-1)))/length(J);
        disp(strcat("Reconstructed at Frequency ", string(f), " and Gain ", string(g)));
        xcounter = xcounter + 1;
    end
    ycounter = ycounter + 1;
    xcounter = 1;
end

figure; imagesc(10:10:100,10:10:100,hits); xlabel("Frequency"); ylabel("Gain");