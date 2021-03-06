% TITLE: Cost Function
%
% SUMMARY: Computes the current function cost and gradient
%
% INPUT: Theta, data, and labels, should be for training data
%
% OUTPUT: Plotted Data
%
% Made by: Jonny Giordano
% Date: May 21st, 2019

function [cost, gradient] = compute_cost(Theta, data, labels);

cost = 0; %Initialize cost variable
gradient = zeros(size(Theta)); %Creates vertical array of 0s with as many rows as Theta

N = length(labels); %Find number of trials

z = data*Theta;
h = zeros(size(z));
h = (1 + exp(-z)).^(-1); %This computes the sigmoid of our data times our weights
                         % ie 'h' is our predicted value

cost = (1/N) * sum(-labels.*log(h)-(1-labels).*log(1-h)); %Calculate the cost
gradient = (1/N)*sum((h-labels).*data); %Calculate the gradient

end