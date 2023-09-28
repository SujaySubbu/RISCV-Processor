`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2023 16:07:58
// Design Name: 
// Module Name: Stalling_unit
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

module Hazard_detection(stall,memRead_ID_EX,rd_ID_EX,rs1_IF_ID,rs2_IF_ID,reset);
output reg stall;
input [4:0]rd_ID_EX,rs1_IF_ID,rs2_IF_ID;
input memRead_ID_EX,reset;

always@(negedge reset)
begin
if(reset==0) stall=0;
end

always@(*)
begin
if(memRead_ID_EX==1 && ((rd_ID_EX==rs1_IF_ID)||(rd_ID_EX==rs2_IF_ID))) stall = 1;
else stall = 0;
end

endmodule

