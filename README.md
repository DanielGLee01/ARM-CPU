# Overview

This repository aims to create a ARM CPU inside of SystemVerilog, to gain a deeper understanding of how a CPU fundamentally works. Eventually,
this will be implemented onto an FPGA, with physical I/O.

### Workflow

I started this project by creating a 1 bit adder. These 1 bit adders were ripple-chained together to create a 32 bit adder, as the CPU in this project is a 32 bit ARM CPU.

After the 32 bit adder module was created, the addition and subtraction operations were implemented into the ALU. With addition and subtraction operations also came the zero, negative, overflow and carry flags. Bitwise AND, OR and XOR were added shortly afterwards.

### Explanation of each component:

##### ALU

##### Register File

##### Program Counter

##### Instruction Memory

##### Decoder