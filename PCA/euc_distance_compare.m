%% Function for ploting the Euclidean distance of each group and compare them.
function [euc_d_co, euc_d_re, euc_d_co_12]=euc_distance_compare(score_co, score_noco, score_noco_re, area, mode)
    pc_number=40;
    time_bin=100;
    euc_d_co = [];
    euc_d_re = [];
    euc_d_co_12 = [];
    expained_per = sum(explained(1:pc_number),1);% explained percent
    for i=1:time_bin
        d_co = euc_distance(score_co(i,1:pc_number),score_noco(i,1:pc_number));
        d_re = euc_distance(score_noco(i,1:pc_number),score_noco_re(i,1:pc_number));
        d_co_12 = euc_distance(score_co(1:pc_number,i)',score_noco_re(1:pc_number,i)');
        euc_d_co = [euc_d_co, d_co];
        euc_d_re = [euc_d_re, d_re];
        euc_d_co_12 = [euc_d_co_12, d_co_12];
    end
    figure();
    Shadederrorbar(euc_d_co,'r-','LineWidth',2);
    hold on;
    Shadederrorbar(euc_d_re,'b-','LineWidth',2);
    title(['PCA Euclidean Distance of ',area,' ',mode]);
    xlabel({'Time (s)'});
    ylabel({['Euclidean Distance of Top ',num2str(pc_number), ' PCs']});
    set(gca, 'LineWidth',1);
    set(gca,'XTick',0:10:100);
    set(gca,'XTicklabel',TimeL,'FontSize',20,'FontWeight','bold');
    set(gca,'tickdir','out');
    legend('CT-NCT','NCTHR-NCT');
end