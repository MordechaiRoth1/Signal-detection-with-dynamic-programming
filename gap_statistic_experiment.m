%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

%% Gap Statistic Experiment
% We start by running the experiment simulation and then we plot the
% relevant figure:

%Run experiment:
runCode_240522_changedforgappicture;

load('GapExperiment.mat')
% Figure 4a
figure(17)
plot(tempObjectiveOursMat,'LineWidth',2)
hold on
plot(NullOursMat,'LineWidth',2)
plot([N_IDX,N_IDX],[39.7,max(tempObjectiveOursMat)],'LineWidth',2)
ylim([39.7,max(tempObjectiveOursMat)])
legend({'$g(N,k)$','$\sum_{i=1}^{10}(g_i(N,k))/10$','$\hat{K}$'},'Interpreter','latex','FontSize',40) % R2018a and earlier
set(gca,'FontSize',40)
xlabel('\fontsize{40}K')
ylabel(['\fontsize{40}g'])

%Figure 4b
figure(18)
plot(tempBenchmarkMat,'LineWidth',2)
hold on
plot(NullBenchmarkMat,'LineWidth',2)
plot([N_IDX_Benchamrk,N_IDX_Benchamrk],[39.7,max(tempBenchmarkMat)],'LineWidth',2)
ylim([39.7,max(tempBenchmarkMat)])
legend({'$\gamma_{K}$','$\sum_{i=1}^{10}\tilde{\gamma}_{k,i}/10$','$\hat{K}$'},'Interpreter','latex','FontSize',40) % R2018a and earlier
set(gca,'FontSize',40)
xlabel('\fontsize{40}K')
ylabel(['\fontsize{40}\gamma'])


