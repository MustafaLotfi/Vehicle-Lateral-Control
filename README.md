# Vehicle-Lateral-Control
## Problem
In this project, lateral movement of a vehicle (a nonholonomic robot) has been controlled. A harmonic path has been considered as the trajectory of the robot in the 2D space. The robot model is a simple bicycle model which is suitable when the velocity is lower than 15 km/h. The controller is a modified PID. To find the best PID gains, a Gradient Descent Optimization Algorithm was utilized.


## Dynamical system, inputs and other variables
<div align="left">
  <img src="https://github.com/MustafaLotfi/Vehicle-Lateral-Control/blob/main/docs/images/1.png">
</div>

## Preview
<div align="center">
  <img src="https://github.com/MustafaLotfi/Vehicle-Lateral-Control/blob/main/docs/images/2.gif">
</div>

## System input
<div align="left">
  <img src="https://github.com/MustafaLotfi/Vehicle-Lateral-Control/blob/main/docs/images/3.jpg">
</div>

## How to run
1.Clone the repository.

2.Change initial conditions in initialize.m file if you want.

3.Run main.m in Matlab.
