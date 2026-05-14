%% Finalized Industrial PID: Perfect Disturbance Rejection
% Goal: 0% Overshoot, Zero Steady-State Error, Flatline at t=15s
clear; clc;

%% 1. Simulation Parameters
dt = 0.05;              % Finer sampling for better accuracy
t = 0:dt:50;            
n = length(t);

% Plant Constants
tau = 10; 
gain_p = 2;

%% 2. Optimized Gains (Matching your Simulink "Winner")
Kp = 0.8;               
Ki = 0.08;              
Kd = 1.5;               
Kff = 1/gain_p;         % Feedforward Gain must be 0.5 if plant gain is 2

%% 3. Constraints & Initial Conditions
u_max = 5;              
u_min = 0;              

temp = zeros(1, n);     
error_int = 0;          
prev_error = 0;         
setpoint = 1.0;         

%% 4. Simulation Loop
for i = 2:n
    % Define Disturbance (Heat loss at t = 15s)
    dist = 0;
    if t(i) >= 15
        dist = 0.4;     
    end
    
    % --- PID Calculation ---
    current_error = setpoint - temp(i-1);
    
    % Integral
    error_int = error_int + (current_error * dt);
    
    % Derivative (The "Brake")
    error_der = (current_error - prev_error) / dt;
    
    % Feedback Effort
    u_fb = (Kp * current_error) + (Ki * error_int) + (Kd * error_der);
    
    % --- Feedforward Calculation ---
    % Since the disturbance is a LOSS, we add power to cancel it.
    u_ff = dist; 
    
    % Total Control Effort
    u_total = u_fb + u_ff;
    
    % --- Saturation ---
    u_final = max(u_min, min(u_max, u_total));
    
    % --- Plant Dynamics (The Critical Correction) ---
    % The plant "sees" the heater (u_final) minus the heat loss (dist)
    temp_dot = (gain_p * (u_final - dist) - temp(i-1)) / tau;
    temp(i) = temp(i-1) + (temp_dot * dt);
    
    prev_error = current_error;
end

%% 5. Plotting the Result
figure('Color', 'w', 'Name', 'Hackathon Final Output'); %[output:552c2f2e]
plot(t, temp, 'b', 'LineWidth', 2.5); %[output:552c2f2e]
hold on; %[output:552c2f2e]
yline(setpoint, 'r--', 'Setpoint', 'LineWidth', 1.5); %[output:552c2f2e]
grid on; %[output:552c2f2e]
set(gca, 'Color', [0.1 0.1 0.1], 'GridColor', [0.5 0.5 0.5]); % Dark mode like Scope %[output:552c2f2e]
title('Final Efficiency Output: Feedforward PID'); %[output:552c2f2e]
xlabel('Time (seconds)'); %[output:552c2f2e]
ylabel('Temperature'); %[output:552c2f2e]
axis([0 50 0 1.2]); %[output:552c2f2e]
