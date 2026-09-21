% Radioactive Chain of Three Elements
% Chain: Ra226 → Rn222 → Po218
% MTH/CSC 4170
%% Clear workspace
clear all;

%% Initialize variables
% Set time increment and vector (array) of x (time) values
deltaX = 0.01;      % time step (days)
tf =400;           % final time (days)
x = 0:deltaX:tf;    % time vector (days)
% Constants
decay_rate_A = 0.00000117;  % disintegration constant of Ra226 (1/day)
decay_rate_B = 0.181;       % disintegration constant of Rn222 (1/day)
A0 = 1;                     % initial mass of substanceA (g)
% Set up our stock variables and initial conditions.
A(1) = A0;  % mass vector of A with initial value in grams
B(1) = 0;   % mass vector of B with initial value in grams
C(1) = 0;   % mass vector of C with initial value in grams
%% Main loop
for i = 2:length(x)
    % Rates of change Forward Euler
    decay_A_to_B = decay_rate_A*A(i-1);
    decay_B_to_C = decay_rate_B*B(i-1);
    % Increase or decrease the mass of each substance (Forward Euler)
    A(i) = A(i-1)+(-decay_A_to_B)*deltaX;
    B(i) = B(i-1)+ (decay_A_to_B -decay_B_to_C) * deltaX;
    C(i) = C(i-1)+(decay_B_to_C)* deltaX;
end
%% Plot Solutions
% SubstanceA
figure()
plot(x, A, 'k', 'LineWidth', 3.0);
% Restrict y-axis
ylim([0.999 1.0002]);
% Label both axes
xlabel('Time (days)', 'fontsize', 18);
ylabel('Mass of Ra-226 (g)', 'fontsize', 18);
% Add plot title
title(['substanceA (Ra-226)'], 'fontsize', 20);

%SubstanceB
figure()
plot(x, B, 'b--', 'LineWidth', 3.0);
% Label both axes
xlabel('Time (days)', 'fontsize', 18);
ylabel('Mass of Rn-222 (g)', 'fontsize', 18);
% Add plot title
title(['substanceB (Rn-222)'], 'fontsize', 20);
