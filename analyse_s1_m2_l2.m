% Load data
load('classInfo_4_5.m'); % Load class information
load('subject_1_fvep_led_training_2.mat'); % Load data from MAT file

% Extract relevant information
stimulation_frequencies = [9, 10, 12, 15]; % Frequencies in Hz
sampling_rate = 256; % Sampling rate in Hz
eeg_data = y(:, 2:9); % EEG data from channels 2 to 9
trigger_info = y(:, 10); % Trigger information from channel 10

% 1. Data Pre-processing
% Implement artifact rejection techniques (Replace this with your artifact rejection function)
cleaned_data = eeg_data;

% Apply bandpass filter with relaxed specifications
try
    filtered_data = bandpass(cleaned_data, [7 16], sampling_rate); % Bandpass filter between 7 and 16 Hz
catch ME
    warning("Filtering failed: %s", ME.message);
    % Handle filtering failure gracefully, or consider relaxing filter specifications
end

