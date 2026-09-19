% Radioactive Chain of Three Elements
% Chain: Bi210 -> Po210 -> Pb206
% MTH/CSC 4170

%% Clear workspace
clear all;

%% Initialize variables

% Set up the time increment and vector (array) of x (time) values
deltaX = 0.01;      % time step (days)
tf = 800;           % final time (days)
x = 0:deltaX:tf;    % time vector (days)

% Constants
decay_rate_A = 0.0137;  % disintegration constant of Bi210 (1/day)
decay_rate_B = 0.0051;  % disintegration constant of Po210 (1/day)
% There is no decay rate for substanceC because Pb206 is stable
A0 = 1;                 % initial mass of substanceA (g)

% Set up our stock variables and initial conditions.
A(1) = A0;  % mass vector of A with initial value in grams
B(1) = 0;   % mass vector of B with initial value in grams
C(1) = 0;   % mass vector of C with initial value in grams

%% Main loop
% Loop tarting with i=2 bc we already set up the initial conditions at i=1 for simulation
for i = 2:length(x)
    % Compute the rates of change (g per day) (Forward Euler)
    decay_A_to_B = decay_rate_A * A(i-1);
    decay_B_to_C = decay_rate_B * B(i-1);

    % Increase or decrease the mass of each substance based on the
    % rates of change for this time step (Forward Euler)
    A(i) = A(i-1) + (-decay_A_to_B) * deltaX;
    B(i) = B(i-1) + (decay_A_to_B - decay_B_to_C) * deltaX;
    C(i) = C(i-1) + (decay_B_to_C) * deltaX;

end

%% Plot
% Plot masses over time
figure()
plot(x, A, 'k', x, B, 'b--', x, C, 'r:', 'LineWidth', 3.0);

% Label axes
xlabel('Time (days)', 'fontsize', 18);
ylabel('Mass (g)', 'fontsize', 18);

% Add legend
legend({' substanceA (Bi-210)', ' substanceB (Po-210)', ...
    ' substanceC (Pb-206)'}, 'fontsize', 18, 'location', 'east');

% Add plot title
title(['Masses in a Three Element Radioactive Chain'], 'fontsize', 20);