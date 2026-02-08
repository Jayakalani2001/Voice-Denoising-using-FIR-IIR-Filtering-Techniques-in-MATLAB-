# Voice-Denoising-using-FIR-IIR-Filtering-Techniques-in-MATLAB-
MATLAB based voice denoising using Butterworth IIR band-pass filtering with SNR evaluation.

This project implements voice denoising using an 8th-order Butterworth band-pass IIR filter in MATLAB. 
Time- and frequency-domain analysis is used to identify noise components, and filtering performance 
is evaluated using Signal-to-Noise Ratio (SNR).

## Objective
To reduce background noise in a recorded speech signal while preserving essential voice components 
using digital filtering techniques.

## Methodology
1. Record a noisy speech signal (10–15 seconds).
2. Analyze the signal in time and frequency domains.
3. Identify dominant noise frequency components.
4. Design an 8th-order Butterworth band-pass IIR filter.
5. Apply zero-phase filtering using `filtfilt`.
6. Evaluate performance using SNR improvement.

## Filter Design
- Filter Type: Butterworth IIR Band-pass
- Filter Order: 8
- Passband Frequency Range: 1100 Hz – 3000 Hz
- Filtering Method: Zero-phase filtering using `filtfilt`

## Results
- SNR Before Filtering: -21.97 dB
- SNR After Filtering: 1.01 dB
- Significant reduction of noise observed in both time and frequency domains.

## Tools & Technologies
- MATLAB
- Digital Signal Processing
- Butterworth IIR Filters


