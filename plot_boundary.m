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


%{ 
This is a vestige from the original plot_data function, no longer need for
function call

%Choose and import data
file = '01cr.set'; %Select file

[data, labels] = extract_data(file); %Call extract data function

%Process data
data_mean = mean(data,2); %Find time averages for all electrodes, for each trial
data_mean = squeeze(data_mean); %Remove unnecessary dimension

%}


function plot_boundary(Theta, data, labels)

data = transpose(data);
labels = transpose(labels);

%Create indices for Left/Right saccade from label
left = find(labels == 0); %Create array to denote when saccade is to the left from label array
right = find(labels == 1); %Create array to denote when saccade is to the right
%}

%Plot the data
plot(data(2,left), data(3, left), 'X', 'MarkerSize', 12, 'LineWidth', 1.5); %Plot electrode data, left saccade
hold on;
plot(data(2, right), data(3, right), 'O', 'MarkerSize', 10, 'LineWidth', 1.5); %Plot electrode data, right saccade
title({'Right versus Left Saccade','L-HEOG and R-HEOG'});
xlabel('L-HEOG mean voltage across trial')
ylabel('R-HEOG mean voltage across trial')
legend('Left Saccade', 'Right Saccade')
hold on;

%Plot the boundary line

bottom_point = min([min(data(1,:)), min(data(2,:))]); %Check each electrode, find minimum point

top_point = max([max(data(1,:)), max(data(2,:))]); %Check each electrode, find maximum point

end_points_x = [bottom_point-10, top_point+10]; %Extend 'x-axis' end points

end_points_y = -1*(Theta(2).*end_points_x + Theta(1)); %Calculate line between x-values using slope equation, this is wrong

%end_points_x = [min(data(2,:))-5, max(data(2,:))+5]; %Find the max and min

end_points_y = -(1./Theta(3)).*(Theta(2).*end_points_x + Theta(1)); %This
%is right

plot(end_points_x, end_points_y)
legend('Left Saccade', 'Right Saccade','Classifier Boundary')

end