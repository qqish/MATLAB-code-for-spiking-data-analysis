%% PCA Analysis to calculate PC score and Euclidean Distance for later comparison
% then to compare the Euclidean distance of CT-NCT and NCTHR-NCT 
clc;
clear;
close all;

%% choose brain area(OFC or PRL) and mode(lick or poke).
area = 'OFC';% or 'PRL'
modes={'lick','poke','initial follow'};
Norm_True=1;% whether normalized
data_path = '/';

for m=1:3
mode = modes{m};
%% load spiking data
spiking_data_path = [data_path,area,'_',mode,'data.mat'];
load(spiking_data_path);
data_0 = data(:,1);
data_1 = data(:,2);
data_2 = data(:,3);
%% Compute the PC score
[score_co, score_noco,score_noco_re,explained_all]=pca_score(data_0,data_1,data_2,Norm_True);
%% Euclidean Distance
[euc_d_co, euc_d_re, euc_d_co_12]=euc_distance_compare(score_co, score_noco, score_noco_re, area, mode);
%% Plot PC score
plot_pc(score_co, score_noco, score_noco_re);
end