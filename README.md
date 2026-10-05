# Overview

This branch of the project aims to implement the CPU on a Terasic De0_SoC board. The user manual for this specific board can be found [here](DE0_CV_User_Manual_112.pdf) 

## Implementation Features

The FPGA board can currently see the contents of each register (R0 to R15) on the HEX lights. HEX3 to HEX0 each display one hexadecimal value which each corresponds to 4 bits in the register. SW4 determines whether the upper half of the bits or the lower half of the bits are displayed - if SW4 is high, then the upper 16 bits will be displayed as 4 hexadecimal values, and if SW4 is low, then the lower 16 bits will be displayed as 4 hexadecimal values. 

Currently, because the CPU is single-cycle, the FPGA can also proceed one instruction with the KEY3 pushbutton. As of writing this README, there are currently 7 instructions loaded into **instruction_memory.hex**. 