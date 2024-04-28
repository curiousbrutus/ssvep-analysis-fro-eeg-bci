% Load data
load('classInfo_4_5.m'); % Load class information
load('subject_1_fvep_led_training_1.mat'); % Load data from MAT file

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

% 2. Feature Extraction
% Time-domain features
time_features = [mean(eeg_data,2), var(eeg_data,0,2), skewness(eeg_data,0,2), kurtosis(eeg_data,0,2)];

% Wavelet Transform for each channel separately
num_channels = size(eeg_data, 2);
time_freq_features = []; % Initialize time-frequency features
for ch = 1:num_channels
    [wt, ~] = cwt(eeg_data(:, ch), 'amor', sampling_rate);
    time_freq_features = [time_freq_features; abs(wt)]; % Concatenate wavelet coefficients along rows
end

% Ensure consistent dimensions for feature matrices
assert(size(time_features, 1) == size(time_freq_features, 1), 'Dimensions of feature matrices are not consistent');

% 3. Classification
% Combine features
all_features = [time_features, time_freq_features];

% Train classifiers
% For example, train an SVM classifier
svm_classifier = fitcsvm(all_features, trigger_info);

% 4. Comparison with State-of-the-Art
% Review literature for benchmark results and compare with obtained accuracy
% If possible, implement or adapt algorithms from state-of-the-art research for comparison
% Evaluate and compare the performance of your classifiers with the benchmarks
