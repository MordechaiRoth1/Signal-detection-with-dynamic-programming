%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

%% Measurement length increase Experiment 
% We start by running the experiment simulation and then we plot the
% relevant figure:

%Run experiment:
runCode_220522_length_increase_dense;

meas_length=[100,200,400,800,1600];

%F1-score for measurement length increase
%Figure 7a
figure(2)
plot(meas_length,100*SNR_F1score(:,2),'-r','LineWidth',2)
hold on;
plot(meas_length,100*SNR_F1scoreBemchmark(:,2),'-b','LineWidth',2)
xlabel('\fontsize{40}Samples')
set(gca,'FontSize',40)
ylabel(['\fontsize{40}[%]'])
ylabel(['\fontsize{40}F_1'])
xlabel('\fontsize{40}N')
legend('Algorithm 3', 'Algorithm 4')
xlim([100,1600])

%K estimation error plot
%Figure 7b
figure(3)
num_change_points_length=[3,6,12,24,48].';
plot(meas_length,1-numChangeFoundOurs(:,2)./num_change_points_length,'LineWidth',2,'Color','r')
hold on
plot(meas_length,1-numChangeFoundBenchmark(:,2)./num_change_points_length,'LineWidth',2,'Color','b')
ylabel({'$|\hat{K}/K-1|$'},'Interpreter','latex','FontSize',40) % R2018a and earlier
set(gca,'FontSize',40)
xlabel('\fontsize{40}N')
xlim([100,1600])
legend('Algorithm 3', 'Algorithm 4')

