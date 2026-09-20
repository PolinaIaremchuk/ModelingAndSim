% Radioactive Chain of Three Elements
% Chain: Bi210 -> Po210 -> Pb206
% MTH/CSC 4170

% R= decay_A_to_B + decay_B_to_C = a*A + b*B
%% Clear workspace
clear all;
%% Initialize variables

% set up for time increments, vector (array) of x (time) values
deltaX = 0.01;      % time step (days)
tf = 20;             % final time (days)
x = 0:deltaX:tf;    % time vector (days)
% Constants
a1 = 0.1;     % decay rate of substanceA (1/day)
a2 = 0.4;     % decay rate of substanceA 1/day)
a3 = 0.7;     % decay rate of substanceA (1/day)
a4 = 1;       % decay rate of substanceA(1/day)
b  = 1;       % decay rate of substanceB(1/day)
A0 = 1;       % initial mass of substanceA (g)
% Stock vars and initial conditions
% substanceC is stable and not needed for total radioactivity
A1(1) = A0;   B1(1) = 0;    % a1 mass vectors (g)
A2(1) = A0;   B2(1) = 0;    % a2 mass vectors (g)
A3(1) = A0;   B3(1) = 0;    % a3 mass vectors (g)
A4(1) = A0;   B4(1) = 0;    % a4 mass vectors (g)

%% Main loop
for i = 2:length(x)
    % Forward Euler
    A1(i) = A1(i-1) + (-a1*A1(i-1))* deltaX;
    B1(i) = B1(i-1)+ (a1*A1(i-1) - b*B1(i-1))* deltaX;
    A2(i) = A2(i-1) + (-a2*A2(i-1)) *deltaX;
    B2(i) = B2(i-1) +(a2*A2(i-1) - b*B2(i-1))* deltaX;
    A3(i) = A3(i-1)+ (-a3*A3(i-1)) * deltaX;
    B3(i) = B3(i-1) + (a3*A3(i-1) - b*B3(i-1))* deltaX;
    A4(i) = A4(i-1)+ (-a4*A4(i-1)) *deltaX;
    B4(i) = B4(i-1) + (a4*A4(i-1) - b*B4(i-1)) * deltaX;

end
%% Total radioactivity in grams per day
R1 = a1*A1 + b*B1;
R2 = a2*A2 + b*B2;
R3 = a3*A3 + b*B3;
R4 = a4*A4 + b*B4;

%% max R is total radioactivity per i iteration which represents time. gets the point of max total radioactivity for each of 4 cases
[R1_max, i1]=max(R1);
[R2_max, i2]=max(R2);
[R3_max, i3]=max(R3);
[R4_max, i4]= max(R4);
%displaying the values for discussion
disp(['a(0.1):  maximum at t = ', num2str(x(i1)), ' days']);
disp(['a(0.4:  maximum at t = ', num2str(x(i2)), ' days']);
disp(['a = 0.7:  maximum at t = ', num2str(x(i3)), ' days']);
disp(['a = 1.0:  maximum at t = ', num2str(x(i4)), ' days']);

%% Plot Solutions
figure()
plot(x, R1, 'k', x, R2, 'b--', x, R3, 'r:', x, R4, 'm-.', 'LineWidth', 3.0);
% Label both axes
xlabel('Time (days)', 'fontsize', 18);
ylabel('Total radioactivity (g/day)', 'fontsize', 18);
% Add legend
legend({' a1 = 0.1', ' a2 = 0.4', ' a3 = 0.7', ' a4 = 1.0'}, ...
    'fontsize', 18, 'location', 'northeast');
% Add plot title
title(['Total Radioactivity for Increasing a (b = 1.0)'], 'fontsize', 20);