% Created by: Anthony H. Le
% Last updated: 03-12-2019

% CHE 581: Assignment 6
% Textbook Problems 24.8, 24.11, Additional Problems 1, 2
% Due: 03-13-2019
%% Additional Problem 1
close all; % close all figures
clear; % clear workspace
clc; % clear command window

disp('Additional Problem 1');
disp('See pdf file for written work.');

disp('-------------------------------------------------');

%% Additional Problem 2 (a)
close all;
clear;
clc;

disp('Additional Problem 2 (a)');

xpde_addprb_2amod

disp('See Figure 1 for simulation');
disp('See Figure 2 for time-space-concentration surface plot');
disp('See Figure 3 for non-reactive time-total system mass plot');

disp('-------------------------------------------------');

%% Additional Problem 2 (b) & (c)
close all;
clearvars -except Q_a;
clc;

disp('Additional Problem 2 (b) & (c)');

xpde_addprb_2bcmod

disp('See Figure 1 for simulation');
disp('See Figure 2 for time-space-concentration surface plot');
disp('See Figure 3 for non-reactive & reactive time-total system mass plots');

disp('-------------------------------------------------');