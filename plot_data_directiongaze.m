% two_dmatrix is name of data matrix, 'output from extract eeg data' function
% Find Indices of Left and Right Examples
left = find(label==1); right = find(label == 2);
% Plot Examples
plot(two_dmatrix(left, 1), two_dmatrix(left, 2), 'k+','LineWidth', 2, ...
'MarkerSize', 7);
hold on
plot(two_dmatrix(right, 1), two_dmatrix(right, 2), 'ko', 'MarkerFaceColor', 'y', ...
'MarkerSize', 7);

xlabel('mean voltage per trial in electrode 1')
ylabel('mean voltage per trial in electrode 2')
title('distribution of ocular electrodes mean voltage as a function of electrode channel')

legend('left saccadic eye movement','right saccadic eye movement')