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


function plot_boundary(Theta, data_train, labels_train)

data_train = transpose(data_train);
labels_train = transpose(labels_train);

%Create indices for Left/Right saccade from label
left = find(labels_train == 0); %Create array to denote when saccade is to the left from label array
right = find(labels_train == 1); %Create array to denote when saccade is to the right
%}

%Plot the data, note, plotted data comes from data_train!
plot(data_train(2,left), data_train(3, left), 'X', 'MarkerSize', 12, 'LineWidth', 1.5); %Plot electrode data, left saccade
hold on;
plot(data_train(2, right), data_train(3, right), 'O', 'MarkerSize', 10, 'LineWidth', 1.5); %Plot electrode data, right saccade
title({'Right versus Left Saccade - Training Set','L-HEOG and R-HEOG'});
xlabel('L-HEOG mean voltage across trial')
ylabel('R-HEOG mean voltage across trial')
legend('Left Saccade', 'Right Saccade')
hold on;

%Plot the boundary line, note boundary line comes from data_train!

%Our decision boundary occurs when  0 = Theta(1) + Theta(2)x2 + Theta(3)x3
%and we so we can rearrange this as: 
% x3 = (Theta(1) + Theta(2)x2)/ -Theta(3))
% Choose the max/min data points in x2 axis, and find the corresponding points
% in the x3 axis and plot

bottom_point = min(data_train(2,:)); %Check each electrode, find minimum point

top_point = max(data_train(2,:)); %Check each electrode, find maximum point

end_points_x = [bottom_point-5, top_point+5]; %Extend 'x-axis' end points

end_points_y = (Theta(1) + Theta(2).*end_points_x)./(-Theta(3));

plot(end_points_x, end_points_y)
legend('Left Saccade', 'Right Saccade','Classifier Boundary')

end