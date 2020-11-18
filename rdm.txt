# Control System - Position Control System

Work done in Control Systems 2 in 3rd year of Masters.

# 1st Stage

The position control system consists of a cursor that moves horizontally over a rail.

Its basic principle is a transducer (DC motor) that converts electrical energy into mechanical energy of rotation, which will act on an axis that moves by varying the position of the pointer on the ruler. The position control is done with the use of a potentiometer, which according to the position of your hand will have different resistance values and so it is possible to know the position of the hand along the rail.

The control of this system is made through USB connection and using dedicated MATLAB functions. One of the functions offered allows you to specify the voltage value which is applied to the DC motor (which varies in a range from -5V to 5V) while the other allows reading the current cursor position.

The main objective of this work was to develop basic functions for the machine. Both functions aim at taking the cursor to the position indicated by ReferencePos. The only difference between the two functions is that the second function returns the position measurement vector and the respective time instantiation vector.

In the second part of this work the objective was to obtain a model of the second order system, by frequency response. At this point, values were given to the voltage to be applied to the DC motor in frequency (9 frequencies, from 0.1Hz to 0.9Hz were used for this purpose) and the appropriate measurements were taken and the appropriate analysis made for each frequency. Using MATLAB, it was possible to obtain the amplitude, the phase, the mean value, the gain, the graph of the voltage over time and the graph of the position over time. With this, it was possible to estimate the parameters of the transfer function of the model that represents the system.

# 2nd Stage

One of the techniques used in a control system is to use a proportional controller. For this to be possible, it is necessary to have a system (closed loop) that reads the current value from the position of a sensor and compares it with the desired value.

In this system, the input will be the desired position of the user, the error signal will be the distance of the cursor to the desired position. The compensator output and RT060 system input (Transfer Function G(s)) will be a value (in this case corresponds to a voltage) that depends on the parameter K and the error signal. The system output (Y(s)) will be the current cursor position.

The main objective of this second work was to test the system in open mesh and when negatively fed in a control mesh. In the first part of the work, a tension was applied to the system and its response was verified, here the system was tested in open mesh.
 
In the second part of the work it was proposed to test the system for various compensator values, see the system's response and analyze.
