`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:24:18
// Design Name: 
// Module Name: Instruction_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Instruction_memory(inCode,pc,reset);
output reg [31:0] inCode;
input [31:0] pc;
input reset;

reg [7:0] mem[43:0];

always@(*)
begin
if(pc[1:0]==2'b00) inCode = {mem[pc+3],mem[pc+2],mem[pc+1],mem[pc]};
end

always@(negedge reset)
begin
if(reset==0) //code for gcd
    begin
        mem[3] = 8'h00; mem[2] = 8'h02; mem[1] = 8'ha3; mem[0] = 8'h03;     // lw t1,0(t0)
        mem[7] = 8'h00; mem[6] = 8'h42; mem[5] = 8'h82; mem[4] = 8'h93;     // addi t0,t0,4
        mem[11] = 8'h00; mem[10] = 8'h02; mem[9] = 8'ha3; mem[8] = 8'h83;   // lw t2,0(t0)
        mem[15] = 8'h00; mem[14] = 8'h73; mem[13] = 8'h0c; mem[12] = 8'h63; // loop: beq t1,t2,exit
        mem[19] = 8'h00; mem[18] = 8'h73; mem[17] = 8'h46; mem[16] = 8'h63; // blt t1,t2,L1
        mem[23] = 8'h40; mem[22] = 8'h73; mem[21] = 8'h03; mem[20] = 8'h33; // sub t1,t1,t2
        mem[27] = 8'hff; mem[26] = 8'h5f; mem[25] = 8'hf0; mem[24] = 8'h6f; // j loop
        mem[31] = 8'h40; mem[30] = 8'h63; mem[29] = 8'h83; mem[28] = 8'hb3; // L1: sub t2,t2,t1
        mem[35] = 8'hfe; mem[34] = 8'hdf; mem[33] = 8'hf0; mem[32] = 8'h6f; // j loop
        mem[39] = 8'h00; mem[38] = 8'h62; mem[37] = 8'ha2; mem[36] = 8'h23; // exit: sw t1,4(t0)
        mem[43] = 8'h00; mem[42] = 8'h00; mem[41] = 8'h00; mem[40] = 8'h73; // ecall




    end
end

endmodule
