clc;
clear;
close all;

%% Parameters
Fs = 250;                   % Sampling rate (Hz)
Nh = 5;                     % Number of harmonics
duration = 3;               % Duration of the signal (seconds)
channels = [52 53 55 56 57 58 61 62 63]; % EEG channels
frequency_band = [8 90];    % Bandpass filter frequency range (Hz)
n_subjects = 35;            % Number of subjects
n_runs = 240;               % Number of runs per subject
n_classes = 40;             % Number of classes

%% Load stimulus frequencies and phases
load('freq_phase.mat'); 
fstim = freqs;
clear freqs;

%% Create reference signals for each class
Len = duration * Fs;
t = linspace(0, duration, Len);
Xref = generate_reference_signals(fstim, Nh, t);

%% Bandpass filter design
[b, a] = butter(3, frequency_band / (Fs / 2), 'bandpass');

%% SSVEP frequency recognition and performance evaluation
Ave_Acc_across_groups = zeros(n_subjects, 1);

for sbj = 1:n_subjects
    subject_name = sprintf('s%d.mat', sbj);
    load(subject_name);
    
    EEGdata = concatenate_runs(data);
    
    outputs = zeros(1, n_runs);
    for run = 1:n_runs
        X = EEGdata(:,:,run)';
        
        % Band-pass filter
        X = filtfilt(b, a, X);
        
        % CAR filter
        X = apply_car_filter(X);
        
        % SSVEP frequency recognition using CCA
        Rho = zeros(1, size(Xref, 3));
        for j = 1:size(Xref, 3)
            % Extract the segment of X for the relevant time window and channels
            X_segment = X(find(t >= 0.5 & t <= 0.5 + duration), channels)';
        
            % Perform CCA between the extracted segment and the reference signal
            [Wx, Wy, Rho(j)] = myCCA(X_segment, Xref(:,:,j)');
        end
    
        % Determine the frequency with the highest canonical correlation
        [~, outputs(run)] = max(Rho);
        
        % Save result
        save(sprintf('%d_%d.mat', sbj, run), 'Rho');
    end
    
    % Performance evaluation
    labels = repmat(1:n_classes, 1, n_runs / n_classes);
    TotalAccuracy = compute_accuracy(labels, outputs);
    Ave_Acc_across_groups(sbj) = TotalAccuracy;
    
    disp(['Total accuracy(', num2str(sbj), '): ', num2str(TotalAccuracy), ' %']);
end

%% Final results
stderror = std(Ave_Acc_across_groups) / sqrt(length(Ave_Acc_across_groups));
Ave_Acc_across_sbjs = mean(Ave_Acc_across_groups);
plusminu = char(177);
disp(['Average accuracy: ', num2str(Ave_Acc_across_sbjs), ' ', plusminu, ' ', num2str(stderror), ' %']);
