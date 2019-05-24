% TITLE: Plot Electrode Data and Logistic Regression Data Boundary
%
% SUMMARY: This script plots the electrode data and the decision boundary
%
% INPUT: Any Subject/Condition file ie: 01cr.set, 02fa.set, etc.
%
% OUTPUT: Plotted Data
%
% Made by: Jonny Giordano
% Started: May 23st, 2019

%Choose and import data
file = '01cr.set'; %Select file

[data, labels] = extract_data(file); %Call extract data function

%Process data
data_mean = mean(data,2); %Find time averages for all electrodes, for each trial
data_mean = squeeze(data_mean); %Remove unnecessary dimension

%Create indices for Left/Right saccade from label
left = find(labels == 1); %Create array to denote when saccade is to the left from label array
right = find(labels == 2); %Create array to denote when saccade is to the right

%Plot the data
plot(data_mean(1,left), data_mean(2, left), 'X', 'MarkerSize', 12, 'LineWidth', 1.5); %Plot electrode data, left saccade
hold on;
plot(data_mean(1, right), data_mean(2, right), 'O', 'MarkerSize', 10, 'LineWidth', 1.5); %Plot electrode data, right saccade
title({'Right versus Left Saccade','L-HEOG and R-HEOG'});
xlabel('L-HEOG')
ylabel('R-HEOG')
legend('Left Saccade', 'Right Saccade')

hold on;

%%

Theta = [1.7861 -0.4375 0.3633];

%Plot Boundary

end_points_x = [min(data_mean(2,:))-5, max(data_mean(2,:))+5]; %Find the max and min to define end point

end_points_y = (-1./Theta(3)).*(Theta(2).*end_points_x + Theta(1));

plot(end_points_x, end_points_y)
