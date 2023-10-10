# RISCV-Processor

This repository contains the code for RISC-V based 5 stage pipelined processor implementation with 4 pipeline registers that supports forwarding , stalling along with static branch prediction to deal with control hazards. R-type instructions , Lw - Sw instructions , beq and jump have been incorporatd in the mini processor.

This has been a combined effort by Sujay Krishnan Subramanian and Vaishnav A (students from Department of Electrical and Electronics Engineering) , as a part of our coursework at BITS Pilani Hyderabad Campus.

This repository is based on a 5 stage pipelined processor implementation with 4 pipeline registers.The biggest advantage of pipelining is that it reduces the processor's cycle time. This is because it can process more instructions simultaneously, while reducing the delay between completed instructions.

The RISC V Datapath consisting of 4 pipeline registers and 5 stages (IF,ID,EX,MEM and WB) is as follows :

![20230419_025319](https://github.com/SujaySubbu/RISCV-Processor/assets/134432333/72a15fe2-dc03-4e8a-9174-56fa637be382)

# Truth table for Control Signals

| Instruction | Reg Write | ALU Src | Branch | Jump | MemWrite | MemtoReg | MemRead | ALU Control | ECALL |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Add	| 1	| 0	| 0 |	0 |	0 |	0 |	0	| 0000 | 0 |
| Sub	| 1	| 0	| 0 |	0 |	0 |	0 |	0	| 0001 | 0 |
| SLL	| 1	| 0	| 0 |	0 |	0 |	0 |	0	| 0010 | 0 |
| SRL	| 1	| 0	| 0 |	0 |	0 |	0 |	0	| 0011 | 0 |
| SLT	| 1	| 0	| 0 |	0 |	0 |	0 |	0	| 0100 | 0 |
| ADDI | 1	| 1	| 0 |	0 |	0 |	0 |	0	| 0000 | 0 |
| LW | 1	| 1	| 0 |	0 |	0 |	1 |	1	| 0000 | 0 |
| SW | 0	| 1	| 0 |	0 |	1 |	x |	0	| 0000 | 0 |
| BEQ	| 0	| 0	| zero |	0 |	0 |	x |	0	| 0001 | 0 |
| JAL	| 1	| x	| 0 |	1 |	0 |	x |	0	| xxxx | 0 |
| BLT	| 0	| 0	| less |	0 |	0 |	x |	0	| 0001 | 0 |
| ECALL | -	| -	| - |	- |	0 |	- |	-	| ---- | 1 |

# Branch Prediction
Static Branch Prediction has been used here, more specifically branch not taken scheme. This basically means we always assuming that branch will not be taken , and checking if the condition has been satisfied at the end of EX stage. In case , the condition is not satisfied , i.e. the Branch has to be taken , we flush the previous two piepline registers and reload the PC with the branch target address.

# Hazards
1. EX/MEM Hazard
   When the destination register of first instruction is the same as the source register of the next instruction this cause EX Hazard. In order to fix this we have a forwarding unit which forwards the value of the first operation from EX/MEM directly to ALU so it can be used by second instruction. For example take instruction “add s2, s1, s0”. Let ‘s0’ store 4 and ‘s1’ store 6, the result is '10’ which has to be written back to the register for the next instruction “add s3,s2,s0” to use. Hence, the forward unit sets the Forward_A and Forward_B signal to ‘01’ to implement an execution to execution forwarding.
2. MEM/WB Hazard
   When the destination register of first instruction is the same as the source register of the next to next instruction this causes MEM Hazard. In order to fix this we have a forwarding unit which forwards the value of the first operation from MEM/WB directly to ALU so it can be used by third instruction. For example take instruction “add s2, s1, s0”. Let ‘s0’ store 4 and ‘s1’ store 6, the result is '10’ which has to be written back to the register for the next to next instruction “add s3,s2,s0” to use. Hence, the forward unit sets the Forward_A and Forward_B signal to ‘10’ to implement an execution to execution forwarding.
3. Load Use Hazard
   When we have a load instruction, followed by an instruction that uses the value of the destination register as source, we need to stall that instruction by 1 cycle so that the value can be forwarded to the next instruction. For example, we have instructions ‘lw s4, 12(s0)’ and ‘add s3, s4, s0’ . As it takes an extra cycle to load word into the memory, the stalling unit inserts a ‘NOP’ and the PC doesn’t increment for another cycle. In this case, the stall signal is ‘1’ after ‘lw s4, 12(s0)’ instruction and PC remains same for 2 clock cycles.





