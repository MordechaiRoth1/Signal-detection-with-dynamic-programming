%Written by: Mordechai Roth
%Last updated: Aug 16, 2022


%% Measurement length increase Experiment 
% We start by running the experiment simulation and then we plot the
% relevant figure:

%%%%%%%%%%%%%%%
%Well separated
%%%%%%%%%%%%%%%
runCode_240522_sparse

% unknown K, L_hat/L=0.8
% Figure 6b
figure(11)
plot(VarVec(:),100*SNR_F1score(:,1),'-r','LineWidth',2)
hold on;

plot(VarVec(:),100*SNR_F1scoreBemchmark(:,1),'-b','LineWidth',2)
plot(VarVec(:),100*SNR_F1scoreRandom(:,1),'k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,1))),100])
legend('Algorithm 3', 'Algorithm 4','Random detection')

% unknown K, L_hat/L=1
% Figure 3b
figure(12)
plot(VarVec(:),100*SNR_F1score(:,2),'-r','LineWidth',2)
hold on;

plot(VarVec(:),100*SNR_F1scoreBemchmark(:,2),'-b','LineWidth',2)
plot(VarVec(:),100*SNR_F1scoreRandom(:,2),'k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,2))),100])
legend('Algorithm 3', 'Algorithm 4','Random detection')


% unknown K, L_hat/L=1.3
% Figure 6d
figure(13)

plot(VarVec(:),100*SNR_F1score(:,3),'-r','LineWidth',2)
hold on;

plot(VarVec(:),100*SNR_F1scoreBemchmark(:,3),'-b','LineWidth',2)
plot(VarVec(:),100*SNR_F1scoreRandom(:,3),'-k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,3))),(100*SNR_F1score(1,3))])
legend('Algorithm 3', 'Algorithm 4','Random detection')

% known K, L_hat/L=0.8
% Figure 6a
figure(14)

plot(VarVec,100*SNR_F1scoreOursKnown(:,1),'-r','LineWidth',2)
hold on;

plot(VarVec,100*SNR_F1scoreBemchmarkKnown(:,1),'-b','LineWidth',2)
plot(VarVec,100*SNR_F1scoreRandom(:,1),'k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,1))),100])
legend('Algorithm 1', 'Algorithm 2','Random detection')

% known K, L_hat/L=1
% Figure 2b
figure(15)

plot(VarVec,100*SNR_F1scoreOursKnown(:,2),'-r','LineWidth',2)
hold on;

plot(VarVec,100*SNR_F1scoreBemchmarkKnown(:,2),'-b','LineWidth',2)
plot(VarVec,100*SNR_F1scoreRandom(:,2),'k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,2))),100])
legend('Algorithm 1', 'Algorithm 2','Random detection')

% known K, L_hat/L=1.3
% Figure 6c
figure(16)
plot(VarVec,100*SNR_F1scoreOursKnown(:,3),'-r','LineWidth',2)
hold on;

plot(VarVec,100*SNR_F1scoreBemchmarkKnown(:,3),'-b','LineWidth',2)
plot(VarVec,100*SNR_F1scoreRandom(:,3),'k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')% if flag_num==1
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,3))),(100*SNR_F1scoreOursKnown(1,3))])
legend('Algorithm 1', 'Algorithm 2','Random detection')