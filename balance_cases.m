% TITLE: Balance Classes
%
% SUMMARY: This script balances the conditions to attempt to provide better
% classification results
%
% INPUT: Data_dirty from Classify
%
% OUTPUT: Balanced data_dirty with equal number of Correct_Rejection and
% Miss cases
%
%
% Made by: Jonny Giordano
% Date: June 12th, 2019

function [data_dirty labels] = balance_cases(data_dirty, labels)

correct_rejection = find(labels == 0); %Create array with correct_rejections marked in data set

miss = find(labels == 1); %Create array with misses marked in data_set

if length(correct_rejection) > length (miss) %Determine in which case there are more trials
    eliminate = length( correct_rejection) - length (miss);
    
    while eliminate ~= 0
        index = round(length(labels)*rand); %Create random index
        
        if labels(index) == 0 %Because CR has too many, check if it is a CR, if so, remove
            labels(index) = []; %Remove in labels
            data_dirty(:,:,index) = []; %remove in data_dirty
            eliminate = eliminate - 1; %Shorten counter
            disp(eliminate)
        end
            
    end
    
else
    eliminate = length(miss) - length(correct_rejeciton);
    
        while eliminate ~= 0
            index = round(length(labels)*rand); %Create random index

            if labels(index) == 1 %Because miss has too many, check if it is a miss, if so, remove
                labels(index) = []; %Remove in labels
                data_dirty(:,:,index) = []; %remove in data_dirty
                eliminate = eliminate - 1; %Shorten counter
        end
            
    end
    
end

end