% Clears the Command Window
clc;       

% Load the noisy voice signal
[x, Fs] = audioread('C:\Users\HP\Desktop\Assignments\Signal processing assignment 1\Final\voice_noisy.wav');

% Create time vector for plotting in time domain
t = (0:length(x)-1)/Fs;

% Calculate frequency spectrum of the noisy signal
X_F = abs(fft(x));  % Take magnitude of FFT
f = (0:length(X_F)-1)*Fs/length(X_F);  % Frequency axis in Hz

% Design a Butterworth bandpass filter
% Order: 8
% Passband: 1100 Hz to 3000 Hz (targets main speech frequencies)
[b, a] = butter(8, [1100 3000]/(Fs/2), 'bandpass');

% Apply the filter to the signal using zero-phase filtering
% This avoids phase distortion
filtered = filtfilt(b, a, x);

% Calculate frequency spectrum of the filtered signal
Y_F = abs(fft(filtered));

% === PLOT SECTION: Visualize time & frequency domains ===
figure;

% Plot original noisy signal in time domain
subplot(3,2,1);
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy Signal - Time Domain');

% Plot original noisy signal in frequency domain
subplot(3,2,2);
plot(f, X_F);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Noisy Signal - Frequency Domain');

% Plot filtered signal in time domain
subplot(3,2,3);
plot(t, filtered);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal - Time Domain');

% Plot filtered signal in frequency domain
subplot(3,2,4);
plot(f, Y_F);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Filtered Signal - Frequency Domain');

% Overlay noisy and filtered signals in time domain
subplot(3,2,5);
plot(t, x, 'r');         % Noisy in red
hold on;
plot(t, filtered, 'g');  % Filtered in green
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy vs Filtered - Time Domain');
legend('Noisy', 'Filtered');

% Centered frequency spectrum using fftshift 
figure;

% Frequency vector centered around 0 Hz
n = length(x);
f_centered = (-n/2:n/2-1)*(Fs/n);

% Centered FFT magnitudes
X_shifted = fftshift(abs(fft(x)));
Y_shifted = fftshift(abs(fft(filtered)));

% Normalize and plot both spectra for comparison
plot(f_centered, X_shifted/max(X_shifted), 'r'); 
hold on;
plot(f_centered, Y_shifted/max(Y_shifted), 'g');
xlabel('Frequency (Hz)');
ylabel('Normalized Magnitude');
title('Spectrum: Noisy vs Filtered Signal');
legend('Noisy', 'Filtered');
grid on;

% Save filtered audio to a file 
audiowrite('voice_filtered.wav', filtered, Fs);

% SNR Calculation 
% Load a reference signal (assumed to be a cleaner version)
[clean, fs] = audioread('C:\Users\HP\Desktop\Assignments\Signal processing assignment 1\voice_noisy1.wav');

% Load the filtered signal for SNR comparison
[noisy, z] = audioread('voice_filtered.wav');

% Ensure both signals are the same length
minLen = min(length(clean), length(noisy));
clean = clean(1:minLen);
noisy = noisy(1:minLen);

% Estimate noise by subtracting clean from filtered
noise = noisy - clean;

% Compute signal and noise powers
signalPower = mean(clean.^2);
noisePower = mean(noise.^2);

% Compute SNR in decibels
snr_dB = 10 * log10(signalPower / noisePower);

% Also get MATLAB’s built-in SNR estimate (for reference)
snrBefore = snr(clean);     % SNR before filtering
snrAfter = snr_dB;          % SNR after filtering

% Display the results in command window
fprintf('SNR Before Filtering: %.2f dB\n', snrBefore);
fprintf('SNR After Filtering: %.2f dB\n', snrAfter);

% Let user hear the difference

disp('Playing NOISY audio...');
sound(x, Fs);
pause(length(x)/Fs + 1);  % Wait until playback finishes

disp('Playing FILTERED audio...');
sound(filtered, Fs);
pause(length(filtered)/Fs + 1);
