% TITLE: Classifier Prediction
%
% SUMMARY: This script makes a prediction of the data based on the weights
% developed on the training data
%
% INPUT: 
%
% OUTPUT: 
%
% Made by: Jonny Giordano
% Started: May 23st, 2019

function [correct] = classifier_score(Theta, data_test, labels_test)
   
    Num_trials = length(labels_test); %Find number of trials
    prediction = length(labels_test);
    
    z = data_test*Theta;
    h = zeros(size(z));
    h = (1 + exp(-z)).^(-1); %This computes the sigmoid of our data times our weights
                             % ie 'h' is our predicted probability of our
                             % value
    
    correct = 0; %Initialize correct trials
    
    for trial = 1:Num_trials %Check probabiliy, seperate at 0.5 mark
            if h(trial) >= 0.5
                prediction(trial) = 1;
            else
                prediction(trial) = 0;
            end
            
            if prediction(trial) == labels_test(trial)%If prediction matches label, mark correct response
                correct = correct + 1;
            end
    end
    
    correct = (correct/Num_trials)*100; %Convert to a percentage
end