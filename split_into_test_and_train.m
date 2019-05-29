% SUMMARY: The purpose of this script is to seperate the data in testing
% and training files. ~90% of the cases will be for training, and ~10% for
% training
%
% INPUT: Data files in /Data
%
% OUPUT: Data files will carry the same names as the original
% subject/condition file, but will be placed in /Data/Test and /Data/Train
%
% Made by: Jonny Giordano
% Date May 29th, 2019

trial_types = ["cr", "fa", "hit", "miss"];
home = pwd;
output_dir_test = strcat(home, '\Data\Test');
output_dir_train = strcat(home, '\Data\Train');
labels = [];

% loop over all subjects
for subject_n = 1:1
    % create the data directory path
    data_dir = ['./', num2str(subject_n), '/'];
    % loop over the types of trials: hits, false alarms, etc.
        
    %Skip missing subjects 12, 17
    if (subject_n == 12 ) || (subject_n == 17)
        continue
    end
    
    for trial_type_ind = 1:4

        doc = sprintf('%02d%s.set',subject_n,trial_types(trial_type_ind)); %sprintf must be used for newer Matlab versions, filename is of form '01cr.set'
        
        %WINDOWS
        tmp = pop_loadset('filename',doc,'filepath', strcat(home, '\data\')); %load in subject data by condition
        
        how_many = size(tmp.data, 3); %Find out how many trials there are
        test_size = round(0.10*how_many); %Find out how many trials are in testing set and round up, 10% of trials are for testing
        selection = zeros(1, how_many); %Initialize selection array
        
        for i = 1:(how_many-test_size) %Select the first ~90% of trials
            selection(i) = 1; 
        end
        
        tmp_test = pop_rejepoch(tmp, selection, 0); %Remove the first 90%, create test_set
        title = strcat(num2str(subject_n), sprintf('%s.set', trial_types(trial_type_ind)));
        EEG_test = pop_saveset(tmp_test, 'filename', ...
            title, ...
            'filepath', output_dir_test);
        
        selection = logical(selection); %Convert to logical array
        selection = ~selection; %Change selection, select last 10% of trials to remove
         
        tmp_train = pop_rejepoch(tmp, selection, 0); %Remove the first 90%, create test_set
        EEG_train = pop_saveset(tmp_train, 'filename', ...
            title, ...
            'filepath', output_dir_train);
        
    end
        
    
end