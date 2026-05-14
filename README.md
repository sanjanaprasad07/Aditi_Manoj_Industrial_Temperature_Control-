# Aditi_Manoj_Industrial_Temperature_Control-
**1. Project Overview**

This project presents an Industrial-Grade Thermal Control System developed to regulate a high-precision furnace. It showcases the transition from a standard reactive PID setup to a proactive Control Architecture capable of maintaining a stable temperature of 1.0 p.u. (normalized) under variable load conditions.The system is engineered to solve a common industrial challenge: maintaining thermal stability when external disturbances such as heat loss from an open furnace door are introduced at $t = 15s$. By combining Parallel PID action with Feedforward Compensation, this model achieves a "Golden Plot" response, characterized by zero overshoot and instantaneous disturbance rejection.

**Project Milestones:**

Precision Control: Eliminated steady-state error using Integral action to lock the temperature at exactly 1.0 p.u.

System Stability: Implemented Derivative "braking" to achieve 0% overshoot, protecting physical hardware from thermal stress.

Proactive Disturbance Rejection: Developed a Feedforward loop that anticipates and cancels disturbances before they affect the system temperature.

Hardware Realism: Integrated Output Saturation ($0$ to $5$) to ensure the simulation respects the physical power limits of microcontrollers like the ESP32 or Arduino.2. 

**2. System Architecture**

The controller utilizes a Parallel PID structure enhanced with two critical "real-world" engineering components:

A. Feedback Loop (PID)
Proportional (P): Provides the fundamental response to error.
Integral (I): Accumulates past error to ensure the system reaches the exact setpoint without drooping.
Derivative (D): Predicts future error to dampen the approach, preventing overshoot. 

B. Feedforward Compensation
Unlike traditional reactive controllers, this system includes a feedforward path. By injecting an equal and opposite control effort the moment a disturbance is detected at $t=15s$, the system cancels out the heat loss before the temperature can drop.

C. Output Saturation
To mirror physical hardware constraints, the control effort is capped between $0$ and $5$. This prevents the simulation from relying on "infinite power," making the model hardware-ready for embedded implementation.

**3. Results & Visualization**

The following "Golden Plot" demonstrates the system's efficiency, matching the high-performance requirements for precision industrial heating.
Analysis:
1. Rise Phase: The system climbs smoothly to the setpoint using maximum safe power (Saturation).
2. Settling: The Derivative action ensures a "soft landing" at 1.0 p.u. with no oscillation.
3. The 15s Mark: Despite the disturbance being introduced, the temperature remains a perfect flat line due to the Feedforward loop.
   
**4. How to Use**

   **Simulink**
   
   1.Open Furnace_Control.slx.
   
   2.Ensure the solver is set to a fixed-step (e.g., $0.05s$).
   
   3.Run the simulation and open the Scope to view the real-time response.
   
   **MATLAB**
   
   1.Run Furnace_PID_Optimized.m.
   
   2.The script simulates the plant dynamics using Euler integration and generates the finalized performance plot.

   

**5. Future Engineering Directions**

Sensor Filtering: Implementing a Low-Pass filter to handle noise in real-world thermistor data.

Adaptive Tuning: Gain scheduling for systems where plant dynamics change based on the operating temperature range.

Embedded Porting: The discrete-time logic used in the MATLAB script is designed for easy porting to C++ for microcontrollers such as the ESP32 or Arduino

**6. Model and Assumptions**
This section defines the physical behavior of the furnace and the constraints assumed during the simulation.

**Mathematical Model**

The furnace is modeled as a First-Order Plus Dead Time (FOPDT) system, a standard representation for thermal plants. The plant dynamics are governed by the following differential equation:

$$\tau \frac{dy(t)}{dt} + y(t) = K_p \cdot u(t)$$

Time Constant ($\tau$): 10 seconds, representing the thermal inertia of the furnace.

Process Gain ($G_p$): 2.0, defining the steady-state change in temperature for a given change in power.

Integration Method: Euler's method with a fixed step size ($dt = 0.05s$) for discrete-time implementation.

**Key Assumptions**

Normalized Units: All values are represented in p.u. (per-unit), where 1.0 p.u. is the target operating setpoint.

Ideal Sensing: The feedback loop assumes a clean signal (filtering is noted as a future improvement).

Instantaneous Feedforward: The system is assumed to detect the disturbance (door opening) at the exact moment it occurs.

Linearity: The plant gain is assumed to be constant across the operating range, while the controller compensates for non-linearities via gain scheduling.

**7. Controller Parameters**
  
The system uses an Adaptive Gain Scheduling strategy. The PID constants ($K_p$, $K_i$, $K_d$) transition dynamically based on the current state ($T$) of the system to optimize performance.

<img width="713" height="267" alt="image" src="https://github.com/user-attachments/assets/1bb3b530-8d0b-4488-bbb2-374519dee200" />


