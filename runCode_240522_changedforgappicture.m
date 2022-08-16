%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

clear all;
clc;
close all;

rng(120)
osf=3;

MeasurementLength=osf;
num_signals=1;
sparseFlag=0;
signal_length=300;
snr=1; %not really, just used for initilaizing the signal creation with chosen noise later on
num_change_points=6;
num_change_to_find=2*num_change_points;
max_times=2;
Template_Length=1e-3*osf;
signal_flag=1;
varStep=0;
initialVariance=1.25+1e-12;
FinalVariance=1.25+1e-12;
VarianceJump=0.1;
pwVec=0.5*MeasurementLength:10:1.5*MeasurementLength;
VarVec=(initialVariance:VarianceJump:FinalVariance);
density=8/15;

% num_change_points_vec=8:4:3900;    
% signal_length_vec=round((num_change_points_vec/density)*MeasurementLength);


numVar=length(VarVec);
pw=Template_Length;
fs=1e4;
% pw_eff=[0.8*pw,1*pw,1.2*pw];
pw_eff=pw;
% load('ChangePointsPool_8_lengthTemplate10_lengthSignal150.mat');



%%
       %% preallocate all
 change_points_var_num_tot=3;   
 SNR_F1score=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreBemchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreBemchmarkKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreBemchmarkKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_F1scoreOursKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreOursKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_F1scoreRandom=zeros(numVar,change_points_var_num_tot);        
 
 SNR_Precision=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionBemchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionBemchmarkKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionBemchmarkKnownPW=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionOursKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionOursKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_PrecisionRandom=zeros(numVar,change_points_var_num_tot);        
 
 SNR_RandBenchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_RandBenchmarkKnownNumber=zeros(numVar,change_points_var_num_tot);        
 SNR_RandOurKnownNumber=zeros(numVar,change_points_var_num_tot);        
 SNR_RandOursFull=zeros(numVar,change_points_var_num_tot);        
 SNR_RandRandom=zeros(numVar,change_points_var_num_tot);        
 
 SNR_Recall=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallBemchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallBemchmarkKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallBemchmarkKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_RecallOursKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallOursKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_RecallRandom=zeros(numVar,change_points_var_num_tot);        
 
 
 
 numChangeFoundBenchmark=zeros(numVar,change_points_var_num_tot);        
 numChangeFoundOurs=zeros(numVar,change_points_var_num_tot); 
 
 SNR_PWours=zeros(numVar,change_points_var_num_tot);
 SNR_PWbenchmark=zeros(numVar,change_points_var_num_tot);
 
 SNR_Iours=zeros(numVar,change_points_var_num_tot);
 SNR_Ibenchmark=zeros(numVar,change_points_var_num_tot);
 SNR_IoursKnown=zeros(numVar,change_points_var_num_tot);
 SNR_IbenchmarkKnown=zeros(numVar,change_points_var_num_tot);
%%

for k=1:1
    change_points_var_num=k;
    %% alocate
    L=3;
    pw_ours=zeros(max_times,L);
    pw_benchmark=zeros(max_times,L);
    
    RandBenchmark=zeros(max_times,L);
    RandOursFull=zeros(max_times,L);
    RandOurKnownNumber=zeros(max_times,L);
    RandBenchmarkKnownNumber=zeros(max_times,L);
    RandRandom=zeros(max_times,L);
    
    F1score=zeros(max_times,L);
    F1scoreBemchmark=zeros(max_times,L);
    F1scoreBemchmarkKnown=zeros(max_times,L);
    F1scoreBemchmarkKnownPW=zeros(max_times,L);

    F1scoreOursKnown=zeros(max_times,L);
    F1scoreOursKnownPW=zeros(max_times,L);

    F1scoreRandom=zeros(max_times,L);
    
    Prec=zeros(max_times,L);
    PrecBemchmark=zeros(max_times,L);
    PrecBemchmarkKnown=zeros(max_times,L);
    PrecOursKnown=zeros(max_times,L);
    PrecBemchmarkKnownPW=zeros(max_times,L);
    PrecOursKnownPW=zeros(max_times,L);
    PrecRandom=zeros(max_times,L);
    
    Rec=zeros(max_times,L);
    RecBemchmark=zeros(max_times,L);
    RecBemchmarkKnown=zeros(max_times,L);
    RecOursKnown=zeros(max_times,L);
    
    RecBemchmarkKnownPW=zeros(max_times,L);
    RecOursKnownPW=zeros(max_times,L);
    
    RecRandom=zeros(max_times,L);
    
    NumChangeOurs=zeros(max_times,L);
    NumChangeBenchmark=zeros(max_times,L);
    
    %% 
%     varianceAmp=initialVariance;

        for varianceAmp=VarVec
            
            varStep=varStep+1;
            timeOurs=zeros(1,max_times);
            timeBenchmark=zeros(1,max_times);

        for times=1:max_times
%            [~,Yclean,t,fs,changeIdx,pw] =unsynchronized_pulses_func(num_change_points,num_signals,snr,signal_length,Template_Length);
%             Yclean=Yclean(1:signal_length);
           Terminate=1;
           while Terminate==1
%                 changeIdx=DrawChangePoints(pw,fs,signal_length,num_change_points)+1;
                
                [changeIdx,Terminate] = DrawChangePoints_220522v2(pw,fs,signal_length,num_change_points,sparseFlag);
                changeIdx=changeIdx+1;
           end
            YcleanCreate;
            noise=wgn(1,signal_length,pow2db(varianceAmp));
            
            Y=signal_flag*Yclean(1:signal_length)+noise(1:signal_length);
        
            signal=Y.';
            SignalNoNoise=Yclean.';
            num_change_to_find=num_change_points*2;
            
            ActualChangePoint=changeIdx';
            PwOptions=pw*[0.8,1,1.3];
% PwOptions=pw*[1,1,1];
%             PwOptions=pw;
            
          
%             [LocationsOurs,LocationsOursKnownK,LocationsOursKnownPW,BenchmarkLocations,BenchmarkLocationsKnownK,BenchmarkLocationsKnownPW,tempObjectiveOursMat,tempBenchmarkMat,timeObjective,timeCorr,NullOursMat,...
%              NullBenchmarkMat,NumChangeOurs(times,:),NumChangePointsBenchmarkFull(times,:),NumChangePointsBenchmarkKnownNumber(times,:)] = KnownIntervals_5(signal,pw,fs,num_change_points,num_change_to_find,0);
%             
            
            for l=2:2
            [LocationsOurs,pw_ours(times,l),LocationsOursKnownK,LocationsOursKnownPW,BenchmarkLocations,pw_benchmark(times,l),BenchmarkLocationsKnownK,BenchmarkLocationsKnownPW,tempObjectiveOursMat,tempBenchmarkMat,timeObjective,timeCorr,NullOursMat,...
             NullBenchmarkMat,NumChangeOurs(times,l),NumChangePointsBenchmarkFull(times,l),NumChangePointsBenchmarkKnownNumber(times,l)] = KnownIntervals_5_gap(signal,PwOptions(l),fs,num_change_points,round(signal_length/(PwOptions(l)*fs)),1);
            
            LocationsOursFull=LocationsOurs;
            LocationsOursKnownNumber=LocationsOursKnownK;
            LocationBenchmarkFull=BenchmarkLocations;
            LocationBenchmarkKnownNumber=BenchmarkLocationsKnownK;
            RandomChangePoints=DrawChangePoints(pw,fs,signal_length,num_change_points);
            
            
            %% Calcualte Recall, Precision and F1-score
            
            [Rec(times,l),Prec(times,l),F1score(times,l)] = F1_score_4(num_change_points,NumChangeOurs(times,l),ActualChangePoint,LocationsOursFull,50,round(pw*fs),round(pw_ours(times,l)*fs),signal_length) ;
            [RecOursKnown(times,l),PrecOursKnown(times,l),F1scoreOursKnown(times,l)] = F1_score_4(num_change_points,num_change_points,ActualChangePoint,LocationsOursKnownNumber,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
            [RecOursKnownPW(times,l),PrecOursKnownPW(times,l),F1scoreOursKnownPW(times,l)] = F1_score_4(num_change_points,length(LocationsOursKnownPW),ActualChangePoint,LocationsOursKnownPW,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
            [RecBemchmark(times,l),PrecBemchmark(times,l),F1scoreBemchmark(times,l)] = F1_score_4(num_change_points,NumChangePointsBenchmarkFull(times,l),ActualChangePoint,LocationBenchmarkFull,50,round(pw*fs),round(pw_benchmark(times,l)*fs),signal_length) ;
            [RecBemchmarkKnownPW(times,l),PrecBemchmarkKnownPW(times,l),F1scoreBemchmarkKnownPW(times,l)] = F1_score_4(num_change_points,length(BenchmarkLocationsKnownPW),ActualChangePoint,BenchmarkLocationsKnownPW,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
            [RecBemchmarkKnown(times,l),PrecBemchmarkKnown(times,l),F1scoreBemchmarkKnown(times,l)] = F1_score_4(num_change_points,NumChangePointsBenchmarkKnownNumber(times,l),ActualChangePoint,LocationBenchmarkKnownNumber,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
%             [RecRandom(times,l),PrecRandom(times,l),F1scoreRandom(times,l)] = F1_score(num_change_points,num_change_points,ActualChangePoint,RandomChangePoints,50,round(pw*fs)) ;
            [RecRandom(times,l),PrecRandom(times,l),F1scoreRandom(times,l)] = F1_score_4(num_change_points,num_change_points,ActualChangePoint,RandomChangePoints,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
        
            %% Calcualte Rand-Index
%                 [Partition] = PartitionChange(ActualChangePoint,num_change_points,length(signal));
%                 [PartitionOursFull] = PartitionChange(LocationsOursFull,NumChangeOurs(times,l),length(signal));
%                 [PartitionOurKnownNumber] = PartitionChange(LocationsOursKnownNumber,num_change_points,length(signal));
%                 [PartitionBenchmark] = PartitionChange(LocationBenchmarkFull,NumChangePointsBenchmarkFull(times,l),length(signal));
%                 [PartitionBenchmarkKnownNumber] = PartitionChange(LocationBenchmarkKnownNumber,NumChangePointsBenchmarkKnownNumber(times,l),length(signal));
%                 [PartitionRandom] = PartitionChange(RandomChangePoints,num_change_points,length(signal));
                
%                 RandOursFull(times,l)=rand_index(Partition,PartitionOursFull);
%                 RandOurKnownNumber(times,l)=rand_index(Partition,PartitionOurKnownNumber);
%                 RandBenchmark(times,l)=rand_index(Partition,PartitionBenchmark);
%                 RandBenchmarkKnownNumber(times,l)=rand_index(Partition,PartitionBenchmarkKnownNumber);
%                 RandRandom(times,l)=rand_index(Partition,PartitionRandom);
                
            end
            
            waitbar((times+(varStep-1)*max_times)/(max_times*numVar))
                
            %% 
        
        
        
        end
   
%     
    
    
        
    end
        

end


