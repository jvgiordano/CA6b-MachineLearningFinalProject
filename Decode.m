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

%Choose Training File and Import
file = '01cr.set'; %Select file

[data, labels] = extract_data(file); %Call extract data function

%Process data, Add Intercept of '1'
data_mean = mean(data,2); %Find time averages for all electrodes, for each trial
data_mean = squeeze(data_mean); %Remove unnecessary dimension

data_mean = transpose(data_mean); %Switch to vertical style
[rows column] = size(data_mean); %Find dimensions of data
data_mean = [ones(rows, 1) data_mean]; %Add interncept of '1'



%Initialize our Theta

Theta = zeros(column+1, 1);

%Develop our cost function

cost = 0; %Set cost to 0
gradient = zeros(size(Theta)); %Set gradient to zeros






