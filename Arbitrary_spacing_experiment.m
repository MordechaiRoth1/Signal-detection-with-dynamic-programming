%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

%% Measurement length increase Experiment 
% We start by running the experiment simulation and then we plot the
% relevant figure:

%%%%%%%%%%%%%%%%%%
%Arbitrary spacing:
%%%%%%%%%%%%%%%%%%


%Run experiment:
runCode_240522;

% unknown K, L_hat/L=0.8
% Figure 5b
figure(4)
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
% Figure 3a
figure(5)
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
% Figure 5d
figure(6)

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
% Figure 5a
figure(7)

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
% Figure 2a
figure(8)

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
% Figure 5c
figure(9)
plot(VarVec,100*SNR_F1scoreOursKnown(:,3),'-r','LineWidth',2)
hold on;

plot(VarVec,100*SNR_F1scoreBemchmarkKnown(:,3),'-b','LineWidth',2)
plot(VarVec,100*SNR_F1scoreRandom(:,3),'k','LineWidth',2)
xlabel('\fontsize{40}\sigma^2')% if flag_num==1
ylabel(['\fontsize{40}F_1'])
set(gca,'FontSize',40)
ylim([min(min(100*SNR_F1scoreRandom(:,3))),(100*SNR_F1scoreOursKnown(1,3))])
legend('Algorithm 1', 'Algorithm 2','Random detection')


