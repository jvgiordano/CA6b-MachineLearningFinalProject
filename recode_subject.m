% This script was taken from Jonny's internship, and heavily modified
%
% SUMMARY: This script takes data froom dssd_divided or flipped_files and
% merges all the cases from a single subject. It labels these cases by 
% replacing the EEG.epoch.eventtype(2) with 1, 2, 3, 4 (CR, FA, Hit, Miss).
% The output single subject file can then be used in ADAM.
%
% INPUT: dssd_divided, flipped_files
%
% OUTPUT: Outputs to "Data/recoded_files", "Data/recoded_files_flipped"
%
% USAGE: USAGE: variable 'subject_n' codes for subject id. It can be set 
% single (subject_n=1), multiple ( subject_n = 1:5 ), or all 
% subjects ( subject_n = 1:19)
% 
% 'trial_type_ind' codes for conditions to process, and can be selected
% similiarly. 1 = "Correct Rejection", 2 = "False Alarm", 3 = "Hit", and
% 4 = "Miss"
%
% Created by: Mehdi Senoussi
% Modified by: Jonathan Giordano
% Date January 30, 2019
%
%

trial_types = ["cr", "fa", "hit", "miss"];
home = pwd;
labels = [];

% loop over all subjects
for subject_n = 1:19
    % create the data directory path
    data_dir = ['./', num2str(subject_n), '/'];
    % loop over the types of trials: hits, false alarms, etc.
        
    %Skip missing subjects 12, 17
    if (subject_n == 12 ) || (subject_n == 17)
        continue
    end
    
    for trial_type_ind = 1:4

        doc = sprintf('%02d%s.set',subject_n,trial_types(trial_type_ind)); %sprintf must be used for newer Matlab versions, filename is of form '01cr.set'
        
        %WINDOWS, choose data folder to recode!
        % Either '\data\train' or '\data\test'
        tmp = pop_loadset('filename',doc,'filepath', strcat(home, '\data\train')); %load in subject data by condition
        
                
        %Create "labels" array, 
        x = size(tmp.data);
        tlabels = trial_type_ind*ones([1,x(3)]); %Set condition by number, CR = 1, FA = 2, Hit = 3, Miss = 4
        labels = [labels tlabels];
        % if this is the first dataset loaded then store it otherwise
        % concatenate it with the previous ones
        if subject_n == 1 && trial_type_ind == 1 
            TMPEEG=tmp;
        else
            TMPEEG=pop_mergeset(TMPEEG, tmp, 0);
        end
        tlabels = [];
    end
    
    %Write over Epochs with new labels
    n_epoch = length(TMPEEG.epoch);
    for epoch_i = 1:n_epoch
        index = cell2mat(TMPEEG.epoch(epoch_i).eventlatency) == 0; %Find event trigger at 0ms
        event = find(index);
        TMPEEG.epoch(epoch_i).eventtype(event) = num2cell(labels(epoch_i)); %replace event types CR = 1, FA = 2, Hit = 3, Miss = 4 
        %TMPEEG.epoch(epoch_i).eventtype(2) = num2cell(labels(epoch_i)); %replace event types CR = 1, FA = 2, Hit = 3, Miss = 4 
    end
        
end

%Save all subjects into one data set
    
%WINDOWS, chooe data_dir to output to
%ie either '\data\combined_test' or '\data\combined_train'
data_dir = strcat(home, '\data\');
eegset_all = pop_saveset(TMPEEG,'filename', sprintf('Train.set',... %Choose Training_data or Testing_data
     subject_n), 'filepath', data_dir);
labels = [];
