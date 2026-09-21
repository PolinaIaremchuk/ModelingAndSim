% Radioactive Chain of Three Elements
% Chain: Ra226 -> Rn222 -> Po218
% MTH/CSC 4170
%% Clear workspace
clear all;
%% Initialize variables
%Time increment and vector (array) of x (time) values
deltaX = 0.01;      % time step (days)
tf = 400;         % final time (days)
x = 0:deltaX:tf;   % time vector(days)
% Constants
decay_rate_A = 0.00000117; % disintegration constant of Ra226 (1/day)
decay_rate_B = 0.181;     % disintegration constant of Rn222 (1/day)
A0 = 1;          % initial mass of substanceA (g)
%stock variables and initial conditions.
A(1) = A0;  % mass vector of A with initial value in g
B(1) = 0;   % mass vector of B with initial value in g
C(1) = 0;   % mass vector of C with initial value in g

%% Main loop
for i = 2:length(x)
    % Compute the rates of change (grams per day) (Forward Euler)
    decay_A_to_B = decay_rate_A* A(i-1);
    decay_B_to_C = decay_rate_B* B(i-1);
    % Increase or decrease the mass of each substance (Forward Euler)
    A(i) = A(i-1) +(-decay_A_to_B)*deltaX;
    B(i) = B(i-1)+(decay_A_to_B -decay_B_to_C)*deltaX;
    C(i) = C(i-1)+(decay_B_to_C)*deltaX;

end

%% Maximum of substanceB
[B_max, i_max] = max(B);    % max of B and its position
disp(['Maximum mass of Rn222: ', num2str(B_max, 5), ' g']);
disp(['Time of the maximum:   ', num2str(x(i_max)), ' days']);