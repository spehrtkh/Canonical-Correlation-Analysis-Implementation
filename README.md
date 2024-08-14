# SSVEP-CCA Analysis

This repository contains MATLAB code for performing Steady-State Visual Evoked Potential (SSVEP) frequency recognition using Canonical Correlation Analysis (CCA). The code is designed to process EEG data from multiple subjects and evaluate the performance of the SSVEP frequency recognition across different subjects.

## Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Functions Overview](#functions-overview)
- [License](#license)

## Introduction
SSVEP is an oscillatory brain response elicited by visual stimuli flickering at specific frequencies. This project aims to recognize the frequency of the stimulus by analyzing EEG data using CCA. The code evaluates the accuracy of frequency recognition across multiple subjects and runs, providing a comprehensive analysis of SSVEP-based brain-computer interface (BCI) systems.

## Installation
To use this project, you need to have MATLAB installed on your system. Additionally, you will need the following files:
- EEG data files for each subject, named in the format `s<subject_number>.mat` (e.g., `s1.mat`, `s2.mat`, etc.).
- The `freq_phase.mat` file, which contains the stimulus frequencies and phases.

### Steps
1. Download or clone the repository:
   ```bash
   git clone https://github.com/yourusername/SSVEP-CCA-Analysis.git
   ```

2. Place all EEG data files and the `freq_phase.mat` file in the `SSVEP-CCA-Analysis` directory:
   - The directory should look like this:
     ```
     SSVEP-CCA-Analysis/
     ├── SSVEP_CCA_Analysis.m
     ├── generate_reference_signals.m
     ├── concatenate_runs.m
     ├── apply_car_filter.m
     ├── myCCA.m
     ├── compute_accuracy.m
     ├── s1.mat
     ├── s2.mat
     ├── ... (other subject files)
     └── freq_phase.mat
     ```

3. Open MATLAB and set the current directory to the `SSVEP-CCA-Analysis` directory:
   ```matlab
   cd 'path_to_SSVEP-CCA-Analysis'
   ```

## Usage
1. Ensure that your EEG data files are named in the format `s<subject_number>.mat`, where `<subject_number>` is the identifier for each subject (e.g., `s1.mat`, `s2.mat`, etc.).
2. Run the main analysis script `SSVEP_CCA_Analysis.m` in MATLAB:
   ```matlab
   SSVEP_CCA_Analysis
   ```
3. The script will load the necessary EEG data, process it using bandpass filtering and CAR filtering, and then apply CCA to recognize the SSVEP frequency. The accuracy of the recognition will be displayed for each subject, and the overall average accuracy across subjects will be reported.

## Functions Overview
- **SSVEP_CCA_Analysis.m**: Main script that orchestrates the analysis process, including loading data, filtering, frequency recognition using CCA, and performance evaluation.
  
- **generate_reference_signals.m**: Generates reference signals for each stimulus frequency based on harmonics. These reference signals are used in the CCA to match with the EEG data.
  
- **concatenate_runs.m**: Concatenates EEG data across multiple runs for a single subject, preparing it for analysis.
  
- **apply_car_filter.m**: Applies the Common Average Reference (CAR) filter to the EEG data to remove common noise across channels.
  
- **myCCA.m**: Performs Canonical Correlation Analysis (CCA) between the EEG data and reference signals to determine the frequency with the highest correlation.
  
- **compute_accuracy.m**: Computes the accuracy of the SSVEP frequency recognition by comparing the recognized frequencies with the true frequencies.


