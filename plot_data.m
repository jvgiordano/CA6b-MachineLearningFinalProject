% TITLE: Plot Electrode Data
%
% SUMMARY: This script plots the electrode data
%
% INPUT: Any Subject/Condition file ie: 01cr.set, 02fa.set, etc.
%
% OUTPUT: Plotted Data
%
% Made by: Jonny Giordano
% Data: May 21st, 2019

file = '01cr.set'; %Select file

[data, labels] = extract_data(file); %Call extract data function

data_mean = mean(data,2); %Find time averages for all electrodes

left = find(labels == 1);
right = find(labels == 2);

plot(data_mean(1,left), data_mean(2, left), 'X'); %Plot electrode data first left saccade
hold on;
plot(data_mean(1, right), data_mean(2, right), 'O'); %Plot electrode data for right saccade
title({'Right versus Left Saccade','L_HEOG and R_HEOG'});
xlabel('L_HEOG')
ylabel('R_HEOG')
legend('Left Saccade', 'Right Saccade')

