% Radioactive Chain of Three Elements
% Chain: Bi210 -> Po210 -> Pb206
% MTH/CSC 4170
% a>b
%% Clear workspace
clear all;
%% Initialize variables
% Set up the time increment and vector (array) of x (time) values
deltaX = 0.01;      % time step (days)
tf = 10;           % final time (days)
x = 0:deltaX:tf;    % time vector (days)
% Constants
a1 = 0.2;   b1 = 0.1;     % decay rates, case 1 (1/day)
a2 = 0.6;   b2 = 0.3;     % decay rates, case 2 (1/day)
a3 = 0.9;   b3 = 0.7;     % decay rates, case 3 (1/day)
A0 = 1;                     % initial mass of substanceA (g)
% Set up stock variables and initial conditions
% B/A
A1(1) = A0;   B1(1) = 0;    % case 1 mass vectors (g)
A2(1) = A0;   B2(1) = 0;    % case 2 mass vectors (g)
A3(1) = A0;   B3(1) = 0;    % case 3 mass vectors (g)
%% Main loop
for i = 2:length(x)
    % Update each case (Forward Euler)
    A1(i) = A1(i-1) + (-a1*A1(i-1)) * deltaX;
    B1(i) = B1(i-1) + (a1*A1(i-1) - b1*B1(i-1)) * deltaX;
    A2(i) = A2(i-1) + (-a2*A2(i-1)) * deltaX;
    B2(i) = B2(i-1) + (a2*A2(i-1) - b2*B2(i-1)) * deltaX;
    A3(i) = A3(i-1) + (-a3*A3(i-1)) * deltaX;
    B3(i) = B3(i-1) + (a3*A3(i-1) - b3*B3(i-1)) * deltaX;
end
%% Table
% Ratio B/A every 2.5 days
for t = [2.5 5 7.5 10]
    i = round(t/deltaX) + 1;
    disp(['t = ', num2str(t), ' days:   case 1 B/A = ', num2str(B1(i)/A1(i)), ...
        ',   case 2 B/A = ', num2str(B2(i)/A2(i)), ...
        ',   case 3 B/A = ', num2str(B3(i)/A3(i))]);
end
%% Plot Solutions
% Plot the ratios B/A over time
figure()
plot(x, B1./A1, 'k', x, B2./A2, 'b--', x, B3./A3, 'r:', 'LineWidth', 3.0);

% Label both axes
xlabel('Time (days)', 'fontsize', 18);
ylabel('B / A', 'fontsize', 18);

% Add legend
legend({' a = 0.2, b = 0.1', ' a = 0.6, b = 0.3', ' a = 0.9, b = 0.7'}, ...
    'fontsize', 18, 'location', 'northwest');

% Add plot title
title(['Ratio B/A when a > b'], 'fontsize', 20);
