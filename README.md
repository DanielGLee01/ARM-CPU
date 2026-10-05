# Overview

This repository aims to create a 32 bit ARM CPU inside of SystemVerilog, to gain a deeper understanding of how a CPU fundamentally works. As of now, functionality of a single-cycle CPU has been completed, with some physical interaction on the I/O of the De0_SoC-CV board (documented in the README in the fpga-bringup branch).

## Workflow (currently im adding a bunch of functionality notes that should really be in the explanation, so change that when I can)

I started this project by creating a 1 bit adder. These 1 bit adders were ripple-chained together to create a 32 bit adder, as the CPU in this project is a 32 bit ARM CPU.

After the 32 bit adder module was created, the addition and subtraction operations were implemented into the ALU. With addition and subtraction operations also came the zero, negative, overflow and carry flags. Bitwise AND, OR and XOR were added shortly afterwards. My initial implementation of the ALU used a 3 bit opcode, however this was changed later to accomodate more operations thta the ALU could support.

I then created a global parameter file containing some parameters for my design. These include the value of the width of the data (which is 32 bits), the amount of registers I have (which is 16) and the width of my program counter (which is 11). This is because the instruction memory defined in this program holds 512 words, with each word being a 4 byte instruction, making my instruction memory 2048 bytes. To properly cover all addresses, this requires 11 bits, because $ 2^{11} = 2048 $. There is a caveat however - we increment the program counter by 4 to go to the next instruction, so that would mean that the bottom two bits of the program counter would never be manipulated and would always stay at 0. 

## Explanation of each component:

### ALU

### Register File
The register file is a module that can read and write data to two different addresses. The register file in this module has 16 registers, each being 32 bits wide. The module has 5 inputs:
- write_en is a 1 bit input that tells the register file whether to write to a specific register or not. If this input is low, no data will be written to any of the registers, preserving data.
- write_addr specifies the specific register to write data to. Because there are 16 registers in this file, this input is 4 bits wide to account for all 16 registers. Only one register can be written to at a time.
- write_data is a 32 bit long input that carries data to write to the register. Each of the 16 registers is 32 bits long, which carries information 

### Program Counter
The Program Counter is a module that increments its own value by 4 every rising clock edge. The program counter in this CPU is 11 bits wide - this is because our instruction memory can store up to 512 words, with each word being 4 bytes. In order to properly iterate through every word in the instruction memory, we need enough bits to be able to cover all words. We have $ 4\, \text{bytes} \times 512\, \text{words} = 2048\, \text{bytes total} $, and in order to cover all 2048 bytes, we need a sufficient amount of bits, which would be 11, because $ 2^{11} = 2048$. However, because we only have and want to access 512 words, we have to increment our program counter by 4 instead of 1, because $ 2048 ÷ 4 = 512 $. 

### Instruction Memory
The Instruction Memory is a module that initializes an empty array of 512 words that are each 32 bits (or 4 bytes) each. The [instruction_memory.hex](instruction_memory.hex) file in this project contains instructions that the CPU will use to execute operations, which are each mapped into the array. Because there are only 512 "spaces", we use a 9 bit address as an input to grab the instructions, since $ 2^9 = 512 $. In this CPU, because of the constraint listed above with the Program Counter, we truncate the two least significant bits because they are never being touched when incrementing the 11 bit Program Counter value. The module then takes whatever address it got (which should just be a number from 0 to 511) and then grabs the instruction at that index as an output.

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
- Bit 25 is the **I bit**, which distinguishes between whether or not operand 2 (bits 11:0) is an immediate (fixed or constant value) or a register (which points to data). If this bit is high (1) then operand 2 is an immediate. If this bit is low (0) then operand 2 points to a register.
- Bits 24:21 is the **opcode**, which tells the control unit which operation should be performed on the data. The control unit takes this signal and interprets in a way that another hardware module (such as the ALU) can properly recieve and execute on.
- Bit 20 is the **S bit**, which updates the persistent flags register if asserted (see condition field). 
- Bits 19:16 is **Rn**, which specifies the first source operand register.
- Bits 15:12 is **Rd**, which specifies the destination register.
- Bits 11:0 specifies the second source operand register. Depending on whether this in immediate or register mode, the data in the bits change.
    - If this is in immediate mode, then the first 4 bits of the field are the rotate field, indicating how many bits to rotate the immediate value by, and the last 8 bits is interpreted as the immediate value itself (so the raw data). This operation is completed by the [Register Rotator](#register-rotator).
    - If this is in register mode, then bits 11 to 4 are all set to 0. Bits 3 to 0 indicate the second source operand register.1010
### Register Rotator
If and only if the data from the second operand is an immediate from the decoder, this module takes in that data and splits it into two different fields - one 4 bit field which is described as the rotate field, indicating how many bits to rotate the number by, and another 8 bit immediate field which has the data itself.  


###### Sources:
- https://student.cs.uwaterloo.ca/~cs452/docs/ts7200/arm-architecture.pdf
- https://www.mi.fu-berlin.de/inf/groups/ag-tech/projects/ScatterWeb/moduleComponents/ARM7_DDI0027D_7di_ds.pdf