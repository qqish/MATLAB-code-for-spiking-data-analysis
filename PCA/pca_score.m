%% Function for computing the PC score for each task condition.
function [score_co, score_noco,score_noco_re,explained_all]=pca_score(data_0,data_1,data_2,Norm_True)
    if Norm_True==1 % Normalization is True
        data_nor_0 = Norm(data_0);
        data_nor_1 = Norm(data_1);
        data_nor_2 = Norm(data_2);
        Norm_type=' Norm';
    else % Normalization is False,raw data
        data_nor_0 = data_0';
        data_nor_1 = data_1';
        data_nor_2 = data_2';
        Norm_type='';
    end
    %% randomly choose 20 trials
    time_bin = 100;
    neuron_num = size(data_0,1);
    distance_co = [];
    distance_re = [];
    distance_co_12 = [];
    % for triali=1:TRIAL_REPEAT
    trial_num = 20;
    clear data_0 data_1
    % Shuffle the order of neurons
    for i=1:neuron_num
        r0 = randperm(size(data_nor_0{i},1));
        r1 = randperm(size(data_nor_1{i},1));
        r2 = randperm(size(data_nor_2{i},1));
        data_0{i} = data_nor_0{i}(r0(1,1:trial_num),:);
        data_1{i} = data_nor_1{i}(r1(1,1:trial_num),:);
        data_2{i} = data_nor_2{i}(r2(1,1:trial_num),:);
    end
    %% compute the PC scores
    for i=1:neuron_num
        tmp_co = mean(data_0{i},1);% cooperative task
        data_co = [data_co;tmp_co];
        tmp_noco = mean(data_1{i},1);% non-cooperative task
        data_noco = [data_noco;tmp_noco];
        tmp_noco_re = mean(data_nor_2{i},1);% high-reward task
        data_noco_re = [data_noco_re;tmp_noco_re];
    end
    data = [data_co';data_noco';data_noco_re'];
    [coeff, score, latent, tsquared, explained] = pca(data,'Centered',true);% compute the parameters of PCA
    explained_all{m} = roundn(explained, -2);% compute the explained percent
    score_co = score(1:time_bin,:);% PC score for cooperative task
    score_noco = score(time_bin+1:2*time_bin,:);% PC score for non-cooperative task
    score_noco_re = score(2*time_bin+1:3*time_bin,:);% PC score for high-reward task
end