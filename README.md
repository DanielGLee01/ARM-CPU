# Overview

This repository aims to create a ARM CPU inside of SystemVerilog, to gain a deeper understanding of how a CPU fundamentally works. Eventually,
this will be implemented onto an FPGA, with physical I/O.

## Workflow

I started this project by creating a 1 bit adder. These 1 bit adders were ripple-chained together to create a 32 bit adder, as the CPU in this project is a 32 bit ARM CPU.

After the 32 bit adder module was created, the addition and subtraction operations were implemented into the ALU. With addition and subtraction operations also came the zero, negative, overflow and carry flags. Bitwise AND, OR and XOR were added shortly afterwards.

## Explanation of each component:

### ALU

### Register File

### Program Counter

### Instruction Memory

### Decoder
The Decoder takes in the instruction data provided from the instruction memory module, and splits the fields into multiple different fields:
- Bits 31:28 are the **condition field**, which look at each of the flags (Carry, Overflow, Negative and Zero) that are currently set in a persistent flags register. This register is only updated by the S bit (bit 20) when it is asserted. Different bit patterns for the condition field show information about different meanings related to the registers - negative, positive, equal, etc.
- Bits 27:26 are the **class identifier field**, which tell the control unit how to interpret the rest of the instruction. There are 4 ways to interpret the instruction based on the 4 different bit patterns:
    | Bit Pattern | Function |
    | :---        |     :----: |
    | 00 | Data Processing |
    | 01 | Load/Store |
    | 10 | Branch and Block Data Transfer |
    | 11 | Coprocessor instructions and software interrupts |
- Bit 25 is the **I bit**, which distinguishes between whether or not operand 2 (bits 11:0) is an immediate (fixed or constant value) or a register (which points to data).
- Bits 24:21 is the **opcode**, which tells the control unit which operation should be performed on the data. The control unit takes this signal and interprets in a way that another hardware module (such as the ALU) can properly recieve and execute on.
- Bit 20 is the **S bit**, which updates the persistent flags register if asserted (see condition field). 
- Bits 19:16 is **Rn**, which specifies the first source operand register.
- Bits 15:12 is **Rd**, which specifies the destination register.
- Bits 11:0 specifies the second source operand register. Depending on whether this in immediate or register mode, the data in the bits change.
    - If this is in immediate mode, then the first 4 bits of the field are the rotate field, indicating how many bits to rotate the immediate value by, and the last 8 bits is interpreted as the immediate value itself (so the raw data). This operation is completed by the [Register Rotator](#register-rotator).
    - If this is in register mode, then... ***TODO***
### Register Rotator
If and only if the data from the second operand is an immediate from the decoder, this module takes in that data and splits it into two different fields - one 4 bit field which is described as the rotate field, indicating how many bits to rotate the number by, and another 8 bit immediate field which has the data itself.  
