%% Function for SVM decoding.
function [ACC,ACC_shuffle] = decoding_svm(data_0,data_1,NeuronNum,trial_num,TRIAL_REPEAT,NEURON_REPEAT,Norm_method)
%% Normlaization
if Norm_method==0
    data_nor_0 = data_0';
    data_nor_1 = data_1';
elseif Norm_method==1
    data_nor_0 = Norm(data_0);
    data_nor_1 = Norm(data_1);
end
%% Randomly select randomly select NeuronNum neurons, and then randomly select trial_num trials.
for Neuron_repeat = 1:NEURON_REPEAT
    total_Neuron_Number = size(data_nor_0,2);
    r_neuron = randperm(total_Neuron_Number);
    for i=1:NeuronNum
        data_0{i} = data_nor_0{r_neuron(1,i)};
        data_1{i} = data_nor_1{r_neuron(1,i)};
    end
    for Trial_repeat = 1:TRIAL_REPEAT
        %% Randomly select trial_num trials
        for i=1:NeuronNum
            r0 = randperm(size(data_0{i},1));
            r1 = randperm(size(data_1{i},1));
            data_0_new(:,i,:)=data_0{i}(r0(1,1:trial_num),:);
            data_1_new(:,i,:)=data_1{i}(r1(1,1:trial_num),:);
        end
        %% Label cooperation or not and shuffle that(True1 or False0).
        data = [data_0_new;data_1_new];
        label(1:trial_num,1) = ones(1,trial_num);
        label(trial_num+1:2*trial_num,1) = repmat(0,1,trial_num);%data(trial,neuron,time,label)
        r = randperm(size(data,1));
        data_shuffle = data(r,:,:);
        label_shuffle = label(r,1);
        r_label = randperm(size(label_shuffle,1));
        label_random_shuffle = label_shuffle(r_label,:);
        %% Construct SVM Model and predict with it. 
        for Time_repeat=1:size(data_shuffle,3)
            SVMModel_rbf = fitcsvm(data_shuffle(:,:,Time_repeat), label_shuffle);
            SVMModel_rbf_shuffle = fitcsvm(data_shuffle(:,:,Time_repeat), label_random_shuffle);
            CVSVMModel = crossval(SVMModel_rbf, 'KFold', 10);
            CVSVMModel_shuffle = crossval(SVMModel_rbf_shuffle, 'KFold', 10);
            classLoss = kfoldLoss(CVSVMModel, 'LossFun','ClassifError');
            classLoss_shuffle = kfoldLoss(CVSVMModel_shuffle, 'LossFun','ClassifError');
            ACC(Trial_repeat,Neuron_repeat,Time_repeat) = 1-classLoss;
            ACC_shuffle(Trial_repeat,Neuron_repeat,Time_repeat) = 1-classLoss_shuffle;
        end
    end
end
end
