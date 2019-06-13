% TITLE: Classify Data
%
% SUMMARY: This script classifies the data
%
% INPUT: Any Subject/Condition file ie: 01cr.set, 01hit.set, etc.
%
% OUTPUT: Plotted Data with Classifier boundary for training and test set.
% Percentage of correctly classified trials.
%
% Made by: Jonny Giordano
% Date: May 21st, 2019

% Break down of code
% 1. Extract data
% 2. Adjust Data Matrix, Add Intercept
% 3. Initialize Theta
% 4. Call Cost Function
% 5. fminuc (Minimizing function instead of gradient descent)
% 6. Plot Decision Boundary
% 7. Test on another data set
%

%% 1. Choose Training File and Import
file = '01cr.set'; %Select file

[data_dirty, labels_train] = extract_data_basic(file); %Call extract data function, labels denotes trial outcomes/condition

%% 2. Process data, Add Intercept of '1', Adjust labels
data_mean = mean(data_dirty,2); %Find time averages for all electrodes, for each trial
data_mean = squeeze(data_mean); %Remove unnecessary dimension

data_mean = transpose(data_mean); %Switch to vertical style
[rows, column] = size(data_mean); %Find dimensions of data
data_mean = [ones(rows, 1) data_mean]; %Add interncept of '1'
data_train = double(data_mean); %Convert to double to used by fminunc later on, data_train

labels_train = labels_train - 1; %Previously,  '2' = right, '1' = left
                   %For our cost calculate, set '1' = right, '0' = left
labels_train = transpose(labels_train); %Switch to verticle style

%% 3. Initialize our Theta

Theta = zeros(column+1, 1); %Initialize our Theta to a vector with number of data sources (electrodes) plus an intercept


%% 4. Call our cost function

initial_theta = [0; 0.1; 0.1];

[cost, gradient] = compute_cost_basic(initial_theta, data_train, labels_train);

%% 5. Minimizing our cost

%We use Matlab's fminunc function which allows us to find the minimum of
%the cost function. An alternative would be to use gradient descent, but
%this way eliminates the necessity of choosing the right number of
%iterations and and the learning rate

options = optimset('GradObj', 'on', 'MaxIter', 30); %Set options for fminuc call

[Theta, cost] = fminunc(@(x)(compute_cost_basic(x, data_train, labels_train)), initial_theta, options); %Call fminunc


%% 6. Plot our data and decision boundary


%Call Plot Boundary Function
figure(1)
plot_boundary_train(Theta, data_train, labels_train)


%% Test on another data set, repeat of above 6 steps but with testing set

%Extract data
file = '01miss.set'; %Select file that is different from training set

[data_dirty, labels_test] = extract_data_basic(file);

data_mean = mean(data_dirty,2); %Find time averages for all electrodes, for each trial
data_mean = squeeze(data_mean); %Remove unnecessary dimension

data_mean = transpose(data_mean); %Switch to vertical style
[rows, column] = size(data_mean); %Find dimensions of data
data_mean = [ones(rows, 1) data_mean]; %Add interncept of '1'
data_test = double(data_mean); %Convert to double to used by fminunc later on, name data_test

labels_test = labels_test - 1; %Previously,  '2' = right, '1' = left
                               %For our cost calculate, set '1' = right, '0' = left
labels_test = transpose(labels_test); %Switch to verticle style

%Plot data_test, decision boundary
figure(2)
plot_boundary_test(Theta, data_train, data_test, labels_test)


%Check performance

correct = classifier_score(Theta, data_test, labels_test); %Call classifier_score function

disp('The logistic classifier had an accuracy (%) of: ')
disp(correct)


