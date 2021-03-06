% Created by: Anthony H. Le
% Last updated: 03-01-2019

% CHE 581: Assignment 5
% Textbook Problems 22.1, 22.6, 22.10, 22.11, 22.12. 22.14
% Due: 03-01-2019
%% Problem 22.1
close all; % close all figures
clear; % clear workspace
clc; % clear command window

disp('Problem 22.1');
disp('See pdf file for written work.');
disp('See Figure 1');

dydt = @(t, y) (y * t^2) - (1.1 * y);
y = @(t) exp((t.^3 / 3) - 1.1 .* t);

figure();
% (a) analytically
a = (0:0.001:1);
y_a = y(a);
plot(a, y_a);
title('22.1 IVP for t = 0 to 1, where y(0) = 1');
xlabel('t');
ylabel('y');
hold on;

% (b) Euler's method w/ h = 0.5, 0.25
% for h = 0.5
h_b1 = 0.5;
inv_b1 = (0:h_b1:1);
n_b1 = length(inv_b1);
y_b1 = y(0) * ones(n_b1, 1);

for i = 1:n_b1-1
   y_b1(i+1) = y_b1(i) + dydt(inv_b1(i), y_b1(i)) * h_b1; 
end

plot(inv_b1, y_b1, '-o');

% [t_b1, y_b1] = eulode(dydt, [0, 1], y(0), h_b1);
% plot(t_b1, y_b1, '-o');

% for h = 0.25
h_b2 = 0.25;
inv_b2 = (0:h_b2:1);
n_b2 = length(inv_b2);
y_b2 = y(0) * ones(n_b2, 1);

for i = 1:n_b2-1
   y_b2(i+1) = y_b2(i) + dydt(inv_b2(i), y_b2(i)) * h_b2; 
end

plot(inv_b2, y_b2, '-o');

% [t_b2, y_b2] = eulode(dydt, [0, 1], y(0), h_b2);
% plot(t_b2, y_b2, '-o');

% (c) midpoint method w/ h = 0.5
h_c = 0.5;
inv_c = (0:h_c:1);
n_c = length(inv_c);
y_c = y(0) * ones(n_c, 1);
y_predc = zeros(n_c-1, 1);
yp_midc = zeros(n_c-1, 1);


for i = 1:n_c-1
    yp_intc = dydt(inv_c(i), y_c(i));
    y_predc(i) = y_c(i) + yp_intc * (h_c / 2); % predictor, compute y @ midpoint
    yp_midc(i) = dydt(inv_c(i)+(h_c/2), y_predc(i)); % use predictor y to predict slope @ midpoint
    y_c(i+1) = y_c(i) + yp_midc(i) * h_c; % corrector, compute improved y
end

plot(inv_c, y_c, '-o');

% [t_c, y_c] = midptode(dydt, [0, 1], y(0), h_c, [], [], []);
% plot(t_c, y_c, '-o');

% (d) 4th-order RK method w/ h = 0.5
h_d = 0.5;
inv_d = (0:h_d:1);
n_d = length(inv_d);
y_d = y(0) * ones(n_d, 1);
k1 = zeros(n_d-1, 1);
k2 = zeros(n_d-1, 1);
k3 = zeros(n_d-1, 1);
k4 = zeros(n_d-1, 1);
y_mid1 = zeros(n_d-1, 1);
y_mid2 = zeros(n_d-1, 1);
y_end = zeros(n_d-1, 1);
phi = zeros(n_d-1, 1);

for i = 1:n_d-1
    k1(i) = dydt(inv_d(i), y_d(i)); % compute slope @ beginning of interval
    y_mid1(i) = y_d(i) + k1(i) * (h_d / 2); % compute y @ midpoint
    k2(i) = dydt(inv_d(i)+(h_d/2), y_mid1(i)); % compute slope @ midpoint
    y_mid2(i) = y_d(i) + k2(i) * (h_d / 2); % compute y @ another midpoint
    k3(i) = dydt(inv_d(i)+(h_d/2), y_mid2(i)); % compute slope @ another midpoint
    y_end(i) = y_d(i) + k3(i) * h_d; % compute y @ end of interval
    k4(i) = dydt(inv_d(i+1), y_end(i)); % compute slope @ end of interval
    phi(i) = (1 / 6) * (k1(i) + (2 * k2(i)) + (2 * k3(i)) + k4(i)); % compute average slope
    y_d(i+1) = y_d(i) + phi(i) * h_d; % compute final y prediction
end

plot(inv_d, y_d, '-o');

% [t_d, y_d] = rk4ode(dydt, [0, 1], y(0), h_d, [], [], []);
% plot(t_d, y_d, '-o');

legend('(a) analytically', '(b) Euler''s method, h = 0.5', '(b) Euler''s method, h = 0.25', '(c) midpoint method, h = 0.5', '(d) 4th-order RK method, h = 0.5');
hold off;

disp('-------------------------------------------------');

%% Problem 22.6
close all;
clear;
clc;

disp('Problem 22.6');
disp('See Figure 1');

h = 0.5; % s, step size, delta t
% t_span = [0, 1000]; % s, time interval
t_span = 0:h:500;
v0 = 1500; % m/s, initial velocity @ t = 0
x0 = 0; % m, initial position @ t = 0

g0 = 9.81; % m/s^2, gravitational acceleration at earth's surface
R = 6.37 * 10^6; % m, earth's radius
dvdt = @(t, x) -g0 * (R^2 / (R + x)^2);
% dxdt = @(t, x) -g0 * (R^2 / (R + x).^2) .* t;

v = v0 * ones(length(t_span), 1);
x = x0 * ones(length(t_span), 1);

for i = 1:length(t_span)-1
    v(i+1) = v(i) + dvdt(t_span(i), x(i)) * h;
    x(i+1) = x(i) + v(i) * h;
end

max_x = max(x);
ind_x = find(x == max_x);
v_max_x = v(ind_x);

max_label = ['max height = ' num2str(max_x) ' m @ time = ' num2str(t_span(ind_x)) ' s'];

figure();
yyaxis left;
plot(t_span, v);
xlabel('Time (s)');
ylabel('Upward velocity (m/s)');
hold on;
plot(t_span(ind_x), v_max_x, '*');
yyaxis right;
plot(t_span, x);
plot(t_span(ind_x), max_x, '*');
text(t_span(ind_x)-20, max_x+30000, max_label);
ylabel('Position (m)');
grid on;
hold off;

disp('-------------------------------------------------');

%% Problem 22.10
close all;
clear;
clc;

disp('Problem 22.10');
disp('See Figure 1');

% provided in prb 22.5
h = 5; % yrs, step size
t_span = [1950, 2050]; % yr
k_gm = 0.026; % per yr
p_max = 12000; % million people
p0 = 2555; % million people in 1950

e_critn = 0.1; % percent, corrector error criterion

dpdt = @(t, p) k_gm * (1 - (p / p_max)) * p; % function provided in prb 22.5
% y_prime = @(t, y) 4 * exp(0.8 * t) - 0.5 * y; % example 22.2

% labels for plot
title = '22.10 World''s Population from 1950 to 2050';
xlabel = 'Year';
ylabel = 'Population (million ppl)';

[~, p1] = heunode(dpdt, t_span, p0, h, e_critn, title, xlabel, ylabel); % calls Heun's method function file
% [t_ex, y_ex] = heunode(y_prime, [0, 4], 2, 1, 0.00001); % example 22.2

disp('-------------------------------------------------');

%% Problem 22.11
close all;
clear;
clc;

disp('Problem 22.11');
disp('See Figure 1');

% provided in prb 22.5
h = 5; % yrs, step size
t_span = [1950, 2050]; % yr
k_gm = 0.026; % per yr
p_max = 12000; % million people
p0 = 2555; % million people in 1950

dpdt = @(t, p) k_gm * (1 - (p / p_max)) * p; % function provided in prb 22.5
% y_prime = @(t, y) 4 * exp(0.8 * t) - 0.5 * y; % example 22.2

% labels for plot
title = '22.11 World''s Population from 1950 to 2050';
xlabel = 'Year';
ylabel = 'Population (million ppl)';

[~, p2] = midptode(dpdt, t_span, p0, h, title, xlabel, ylabel); % calls midpoint method function file
% [t_ex, y_ex] = midptode(y_prime, [0, 4], 2, 1, 0.00001); % example 22.2

disp('-------------------------------------------------');

%% Problem 22.12
close all;
clear;
clc;

disp('Problem 22.12');
disp('See Figure 1');

% provided in prb 22.5
h = 5; % yrs, step size
t_span = [1950, 2050]; % yr
k_gm = 0.026; % per yr
p_max = 12000; % million people
p0 = 2555; % million people in 1950

dpdt = @(t, p) k_gm * (1 - (p / p_max)) * p; % function provided in prb 22.5
% y_prime = @(t, y) 4 * exp(0.8 * t) - 0.5 * y; % example 22.2

% labels for plot
title = '22.12 World''s Population from 1950 to 2050';
xlabel = 'Year';
ylabel = 'Population (million ppl)';

[~, p3] = rk4ode(dpdt, t_span, p0, h, title, xlabel, ylabel); % calls midpoint method function file
% [t_ex, y_ex] = rk4ode(y_prime, [0, 4], 2, 1, 0.00001); % example 22.2

disp('-------------------------------------------------');

%% Problem 22.14
close all;
clear;
clc;

disp('Problem 22.14');

% provided coefficient values
a = 0.23; % prey growth rate
b = 0.0133; % rate characterizing the effect of predator-prey interactions on prey death
c = 0.4;  % predator death rate
d = 0.0004; % rate characterizing the effect of predator-prey interactions on predator growth

% provided data
filename = 'moose_versus_wolf.csv'; % assign filename
data = csvread(filename, 1, 0); % read .csv file, all data, 48 by 3 mat
Year = data(:, 1); % create separate 48 by 1 col vec
Moose = data(:, 2); % create separate 48 by 1 col vec
Wolves = data(:, 3); % create separate 48 by 1 col vec

% parameters for integration methods
h = 1;
t_span = [1960, 2020];
y0 = [610, 22];

% (a)
disp('(a) See Figure 1 & 2');

% x or y(1) = number of prey (i.e., moose)
% y or y(2) = number of predators (i.e., wolves)

% dxdt = @(t, x, y) (a * x) - (b * x * y);
% dydt = @(t, x, y) -(c * y) + (d * x * y);

% predprey function file holds the two Lotka-Volterra eqs, predator-prey model 
[t1, y1] = rk4sys(@predprey, t_span, y0, h, a, b, c, d); % calls rk4sys method function file
[t2, y2] = eulsys(@predprey, t_span, y0, h, a, b, c, d); % calls eulsys method function file

% determine sum of squares of residuals b/w RK4 model and data
yresid_prey_rk4 = Moose(2:length(Moose)) - y1(1:length(Moose)-1, 1);
yresid_pred_rk4 = Wolves(2:length(Wolves)) - y1(1:length(Wolves)-1, 2);
SSresid_prey_rk4 = sum(yresid_prey_rk4.^2);
SSresid_pred_rk4 = sum(yresid_pred_rk4.^2);

prey_rsq_rk4 = ['Prey RSS = ' num2str(SSresid_prey_rk4)]; % plot label
pred_rsq_rk4 = ['Predator RSS = ' num2str(SSresid_pred_rk4)]; % plot label

% determine sum of squares of residuals b/w Euler's model and data
yresid_prey_eul = Moose(2:length(Moose)) - y2(1:length(Moose)-1, 1);
yresid_pred_eul = Wolves(2:length(Wolves)) - y2(1:length(Wolves)-1, 2);
SSresid_prey_eul = sum(yresid_prey_eul.^2);
SSresid_pred_eul = sum(yresid_pred_eul.^2);

prey_rsq_eul = ['Prey RSS = ' num2str(SSresid_prey_eul)]; % plot label
pred_rsq_eul = ['Predator RSS = ' num2str(SSresid_pred_eul)]; % plot label

% plot time-series plot comparing rk4 method simulation w/ data
figure();
yyaxis left;
plot(t1, y1(:, 1));
title('Time-Series Plot: Simulated Model (RK4 Method) vs Recorded Data');
xlabel('Year');
ylabel('Prey Population (Moose)');
hold on;
plot(Year, Moose, '-.');
yyaxis right;
plot(t1, y1(:, 2));
plot(Year, Wolves, '-.');
ylabel('Predator Population (Wolves)');
legend('simulated prey', 'recorded prey', 'simulated predator', 'recorded predator');
xlim([1959 2020])
text(1961, 48, prey_rsq_rk4);
text(1961, 45.7, pred_rsq_rk4);
hold off;

%plot time-series plot comparing euler's method simulation w/ data
figure();
yyaxis left;
plot(t2(1:length(Moose)-1), y2(1:length(Moose)-1, 1)); % model restricted from 1960 to 2006
title('Time-Series Plot: Simulated Model (Euler''s Method) vs Recorded Data');
xlabel('Year');
ylabel('Prey Population (Moose)');
hold on;
plot(Year, Moose, '-.');
yyaxis right;
plot(t2(1:length(Wolves)+1), y2(1:length(Wolves)+1, 2)); % model restricted from 1960 to 2006
plot(Year, Wolves, '-.');
ylabel('Predator Population (Wolves)');
legend('simulated prey', 'recorded prey', 'simulated predator', 'recorded predator');
xlim([1959 2006])
text(1961, 133, prey_rsq_eul);
text(1961, 125.5, pred_rsq_eul);
hold off;

% (b)
disp('(b) See Figure 3 & 4');

% plot phase-plane plot comparing rk4 method simulation w/ data
figure();
plot(y1(:, 1), y1(:, 2));
title('Phase-Plase Plot: Moose vs Wolves (RK4 Method)');
xlabel('Prey Population (Moose)');
ylabel('Predator Population (Wolves)');
hold on;
plot(Moose, Wolves, '-.');
legend('simulated', 'recorded');
hold off;

% plot phase-plane plot comparing euler's method simulation w/ data
figure();
plot(y2(1:length(Moose)-1, 1), y2(1:length(Wolves)-1, 2)); % model restricted from 1960 to 2006
title('Phase-Plase Plot: Moose vs Wolves (Euler''s Method)');
xlabel('Prey Population (Moose)');
ylabel('Predator Population (Wolves)');
hold on;
plot(Moose, Wolves, '-.');
legend('simulated', 'recorded');
hold off;

disp('-------------------------------------------------');
