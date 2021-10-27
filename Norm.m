%% Function for Normalization
function [data_nor,mean_time] = Norm(data)
for i=1:size(data,1)
    Bincount = data{i,1};
    T = size(Bincount,2);
    mean_trial = mean(Bincount,1);
    mean_time = mean(mean_trial,2);
    mean_time_rep = repmat(mean_time,1,T);
    data_nor{i} = Bincount-mean_time_rep;
end
end