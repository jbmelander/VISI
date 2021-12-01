function [isi_img] = process_isi(fn,stim_period,base_period)
%% Constants to change
trial_duration = 20; 
num_trial = 30;

%% Calculate resultant image
if exist([fn], 'file')
    f = 1;
    for k = 1:num_trial;
        one_trial = read_qcamraw([fn], f:(f+trial_duration-1));
        stim = mean(one_trial(:,:,stim_period),3);
        base = mean(one_trial(:,:,base_period),3);
        if k == 1 
            stimMean = stim;
            baseMean = base;
            diffMean = stim-base;
        else 
            stimMean = (stimMean + stim/(k-1))/(1 + (1/(k-1)));
            baseMean = (baseMean + base/(k-1))/(1 + (1/(k-1)));
            diffMean = (diffMean + (stim-base)/(k-1))/(1 + (1/(k-1)));
        end
        f = f+trial_duration;
    end
else
    error(['Could not find file in current directory!'])
end

%% Resultant Image
m = diffMean;
m = m';
m = -m;
isi_img = m;

G = fspecial('gaussian',[5 5],2);
filtered_isi_img = imfilter(m,G);
isi_img = filtered_isi_img;

figure;
imtool(isi_img,[-3,3]);

