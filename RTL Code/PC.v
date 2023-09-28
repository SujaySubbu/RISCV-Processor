`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:27:09
// Design Name: 
// Module Name: PC_value
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

module PC(pc,pc_ID_EX,jumpAddr,state,branch,branch_ID_EX,jump,outcome,clk,reset,stall,ecall);
output reg [31:0]pc;
input [31:0]pc_ID_EX,jumpAddr;
input [1:0]state;
input branch,branch_ID_EX,jump,outcome,clk,reset,stall,ecall;

assign prediction = state[1];

always@(posedge clk, negedge reset)
begin
if (reset==0) pc = 0;
else if(stall==1 || ecall==1) pc = pc + 0;
else if (branch_ID_EX==1 && outcome==1) pc = pc_ID_EX;
else if ( (branch==1 && prediction==1) || jump==1 ) pc = pc + jumpAddr;
else if ( branch_ID_EX==0 || (branch_ID_EX==1 && outcome==0) || (branch==1 && prediction==0) || branch==0 || jump==0 )  pc = pc + 4;
end

endmodule
