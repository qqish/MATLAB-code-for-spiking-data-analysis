%% Function for ploting the PC score of each group.
function plot_pc(score_co, score_noco, score_noco_re)
pc_n=4;% plot previous numbers of PCs
for i=1:pc_n
    figure();
    plot(score_co(:,i),'r','LineWidth',3);
    hold on;
    plot(score_noco(:,i),'b','LineWidth',3);
    hold on;
    plot(score_noco_re(:,i),'k','LineWidth',3);
    legend('CT','NCT','NCTHR');
    title([area,' ',' PC ',num2str(i)]);
    xlabel({'Time (s)'});
    ylabel({'Score'});
    set(gca,'XTick',0:10:100);
end