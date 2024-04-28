% EEG Data Visualization
figure;
for i = 1:size(eeg_data, 2)
    subplot(size(eeg_data, 2), 1, i);
    plot(eeg_data(:, i));
    title(['EEG Channel ', num2str(i)]);
    xlabel('Time');
    ylabel('Amplitude');
end

% Frequency Domain Visualization
figure;
for i = 1:size(eeg_data, 2)
    [pxx, f] = pwelch(eeg_data(:, i), [], [], [], sampling_rate);
    subplot(size(eeg_data, 2), 1, i);
    plot(f, 10*log10(pxx));
    title(['Power Spectral Density of EEG Channel ', num2str(i)]);
    xlabel('Frequency (Hz)');
    ylabel('Power/Frequency (dB/Hz)');
    xlim([0 50]); % Limit frequency range for better visualization
end

% Time-Frequency Analysis Visualization
figure;
for i = 1:size(eeg_data, 2)
    [wt, f] = cwt(eeg_data(:, i), 'amor', sampling_rate);
    subplot(size(eeg_data, 2), 1, i);
    imagesc(1:length(eeg_data), f, abs(wt));
    title(['Wavelet Transform of EEG Channel ', num2str(i)]);
    xlabel('Time');
    ylabel('Frequency (Hz)');
    colorbar;
end

% If you have classification results, you can visualize them here
% For example, plotting confusion matrix or ROC curve

