% TITLE: Classifier Prediction
%
% SUMMARY: This script makes a prediction of the data based on the weights
% developed in the training data
%
% INPUT: Theta, data_test, and labels_test from the Classifier script
%
% OUTPUT: The percentage of correctly classified trials
%
% Made by: Jonny Giordano
% Started: May 23st, 2019

function [correct] = classifier_score(Theta, data_test, labels_test)
   
    Num_trials = length(labels_test); %Find number of trials
    prediction = length(labels_test); %create array for prediction for same number of trials
    
    z = data_test*Theta;
    h = zeros(size(z));
    h = (1 + exp(-z)).^(-1); %This computes the sigmoid of our data times our weights
                             % ie 'h' is our predicted probability of our
                             % value (h = hypothesis)
    
    correct = 0; %Initialize correct trials
    
    for trial = 1:Num_trials %Check probability, seperate trial hypothesis at 0.5 mark
            if h(trial) >= 0.5
                prediction(trial) = 1; %Predict 1 is the probabilty is greater than or equal to 0.5
            else
                prediction(trial) = 0; %Predict 0 otherwise
            end
            
            if prediction(trial) == labels_test(trial)%If prediction matches label, mark correct response
                correct = correct + 1;
            end
    end
    
    correct = (correct/Num_trials)*100; %Convert to a percentage
end