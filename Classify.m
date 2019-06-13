% TITLE: Classify Data
%
% SUMMARY: This script classifies the data
%
% INPUT: Train and Test Data sets
%
% OUTPUT: Plotted Data with Classifier boundary for test set.
% 
% Made by: Jonny Giordano
% Date: May 30th, 2019

% Break down of code
% 1. Extract data
% 2. Adjust Data Matrix, Add Intercept
% 3. Initialize Theta
% 4. Call Cost Function
% 5. fminuc (Minimizing function instead of gradient descent)
% 6. Plot Decision Boundary
% 7. Test on another data set
%



%% 1. Choose Training File and Import, Select Feature to Classify
file = 'Train.set'; %Select file

experiment_type = "saccade"; %Choose analysis, "saccade" for saccadic direction, anything else for stimulus jump/no-jump
[data_dirty, labels_train] = extract_data(file, experiment_type); %Call extract data function, labels denotes trial outcomes/condition

[data_dirty, labels_train] = balance_cases(data_dirty, labels_train); %Balance number of trials per condition by randomly removing trials from greater class

%%
accuracy = zeros(1, size(data_dirty, 2)); %Initialize array to hold classification accuracies for each time
for time = 1:2:size(data_dirty, 2) %Loop through every single time point, across all electrodes and trials
disp(time)
%% 2. Process data, Add Intercept of '1', Adjust labels

data_select = data_dirty(:,time,:); %Select time point to classify at
data_select = squeeze(data_select); %Remove unnecessary dimension

data_select = transpose(data_select); %Switch to vertical style
[rows, column] = size(data_select); %Find dimensions of data
data_select = [ones(rows, 1) data_select]; %Add interncept of '1'
data_train = double(data_select); %Convert to double to used by fminunc later on, data_train

if experiment_type == "saccade"
    labels_train = labels_train - 1; %Previously,  '2' = right, '1' = left, change labels to '1' = right, '0' = left
end

if isrow(labels_train) %Make sure labels is not a row vector
    labels_train = transpose(labels_train); %Switch to verticle style
end
%% 3. Initialize our Theta

Theta = zeros(column+1, 1); %Initialize our Theta to a vector with number of data sources (electrodes) plus an intercept


%% 4. Call our cost function

initial_theta = Theta; %Initialize to some arbitrary Theta, here we choose Theta of all zero values

[cost, gradient] = compute_cost(initial_theta, data_train, labels_train);

%% 5. Minimizing our cost

%We use Matlab's fminunc function which allows us to find the minimum of
%the cost function. An alternative would be to use gradient descent, but
%this way eliminates the necessity of choosing the right number of
%iterations and and the learning rate

options = optimset('GradObj', 'on', 'MaxIter', 30); %Set options for fminuc call

[Theta, cost] = fminunc(@(x)(compute_cost(x, data_train, labels_train)), initial_theta, options); %Call fminunc

%% 6. Test on another data set, repeat above 5 steps but with testing set

file = 'Test.set'; %Select file

[data_dirty, labels_test] = extract_data(file, experiment_type); %Call extract data function, labels denotes trial outcomes/condition

data_select = data_dirty(:,time,:); %Select time point to classify at
data_select = squeeze(data_select); %Remove unnecessary dimension

data_select = transpose(data_select); %Switch to vertical style
[rows, column] = size(data_select); %Find dimensions of data
data_select = [ones(rows, 1) data_select]; %Add interncept of '1'
data_test = double(data_select); %Convert to double to used by fminunc later on, data_test

if experiment_type == "saccade"
    labels_test = labels_test - 1; %Previously,  '2' = right, '1' = left, change labels to '1' = right, '0' = left
end

if isrow(labels_test) %Make sure labels is not a row vector
    labels_train = transpose(labels_test); %Switch to verticle style
end

%Check performance

correct = classifier_score(Theta, data_test, labels_test); %Call classifier_score function

accuracy(time) = correct;

end

%% 7. Plot Classification Accuracy Across Time

t = -200:4:598; %Create time points in trial, -200ms to 598ms
plot(t, accuracy(1:2:400))

if experiment_type == "saccade"
    title({'Classification Accuracy - Logistic Regression','Right versus Left Saccade','All Electrodes'});
else
    title({'Classification Accuracy - Logistic Regression','CR vs Miss','All Electrodes'});
end

xlabel('Time (ms)')
ylabel('Accuracy (percentage)')
hold on

chance = 50*ones(1,length(accuracy)); %Plot chance level
plot(t, chance(1:2:400), '--')
legend('Classification accuracy','Chance Level')

axis([-200 598 45 100])



