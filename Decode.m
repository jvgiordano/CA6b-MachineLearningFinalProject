% TITLE: Classify Data
%
% SUMMARY: This script classifies the data
%
% INPUT: Any Subject/Condition file ie: 01cr.set, 02fa.set, etc.
%
% OUTPUT: Plotted Classification accuracy
%
% Made by: Jonny Giordano
% Date: May 21st, 2019

% Break down of code
% 1. Extract data
% 2. Adjust Data Matrix, Add Intercept
% 3. Initialize Theta
% 4. Call Cost Function
% 5. Gradient Descent
% 6. Plot Decision Boundary
% 7. Test on another data set
%

%% 1. Choose Training File and Import
file = '01cr.set'; %Select file

[data_dirty, labels] = extract_data(file); %Call extract data function, labels denotes trial outcomes/condition

%% 2. Process data, Add Intercept of '1', Adjust labels
data_mean = mean(data_dirty,2); %Find time averages for all electrodes, for each trial
data_mean = squeeze(data_mean); %Remove unnecessary dimension

data_mean = transpose(data_mean); %Switch to vertical style
[rows, column] = size(data_mean); %Find dimensions of data
data_mean = [ones(rows, 1) data_mean]; %Add interncept of '1'
data = data_mean;

labels = labels-1; %Previously,  '2' = right, '1' = left
                   %For our cost calculate, set '1' = right, '0' = left
labels = transpose(labels); %Switch to verticle style

%% 3. Initialize our Theta

Theta = zeros(column+1, 1); %Initialize our Theta to a vector with number of data sources (electrodes) plus an intercept


%% 4. Call our cost function

[gradient, cost] = compute_cost(data, labels, Theta);


%% 5. 



%% 6.






