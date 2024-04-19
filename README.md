This project illustrates how to evaluate and implement a range of attitude control modes. Besides the
simple PD control uses here, other attitude tracking control solutions could readily be substituted. 


Different mission target frames, such as the sun-pointing frame, nadir-pointing frame, and communication frame, are defined within the 'control.m' file."

During one orbit, the satellite transitions through the three mentioned mission modes. It assesses attitude and rate errors relative to the target mission frame, represented as Modified Rodrigues Parameters (MRPs) and relative angular velocity. These errors are then corrected using linear feedback control to align the body frame with the target frame.

Additional mission modes and control strategies can be implemented within the 'control.m' file.
