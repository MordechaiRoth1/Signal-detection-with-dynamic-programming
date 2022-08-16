%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

%% Super Resolution Experiment
% We start by running the experiment simulation and then we plot the
% relevant figure:

%Run experiment:
runCode_140822_Convex;

%Figure 8:

plot((1:1:12)/6,SNR_F1scoreOursKnown(1:varStep)*100,'LineWidth',2)
hold on
plot((1:1:12)/6,100*SNR_F1scoreBemchmarkKnown(1:varStep),'LineWidth',2)
plot((1:1:12)/6,100*SNR_F1scoreSR(1:varStep),'LineWidth',2)
legend('Algorithm 1', 'Algorithm 2','Convex optimization')
set(gca,'FontSize',40)
xlabel('\fontsize{40}\sigma^2')
ylabel(['\fontsize{40}F_1'])
ylim([100*min(SNR_F1scoreSR(1:12,1)),100])
xlim([1/6,2])

