%% SVM decoding main function
clc;
clear;
close all;
%% Choose brain area(OFC or PRL) and mode(lick or poke).
area = 'OFC'; % or 'PRL'
mode_all = {'lick';'poke'};
data_path = '/';
for m=1:size(mode_all,1)
mode = mode_all{m};
%% Load spiking data
spiking_data_path = [data_path,area,'_',mode,'data.mat'];
save_path = [data_path,area,'/',mode,'/'];
load(spiking_data_path);

data_0 = data(:,1);
data_1 = data(:,2);
data_2 = data(:,3);
%% Parameter setting
NeuronNum = 400;% the number of randomly selected neurons to do the SVM
trial_num = 20; % the number of randomly selected trials
TRIAL_REPEAT = 50;% repeat times to randomly choose the trials
NEURON_REPEAT = 10;% repeat times to randomly choose the neurons
Norm_method=1;% Norm_method=0: raw data;1:Normalized data

%% Decoding with SVM Model
[ACC,ACC_shuffle] = decoding_svm(data_0,data_1,NeuronNum,trial_num,TRIAL_REPEAT,NEURON_REPEAT,Norm_method);
[ACC_2,ACC_shuffle_2] = decoding_svm(data_2,data_1,NeuronNum,trial_num,TRIAL_REPEAT,NEURON_REPEAT,Norm_method);
end