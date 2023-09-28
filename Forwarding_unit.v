`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2023 15:46:37
// Design Name: 
// Module Name: Forwarding_unit
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

module Forwarding_unit(forwardRs1,forwardRs2,rs1_ID_EX,rs2_ID_EX,rd_EX_MEM,rd_MEM_WB,
                       regWrite_EX_MEM,regWrite_MEM_WB);
output reg [1:0]forwardRs1,forwardRs2;
input [4:0]rs1_ID_EX,rs2_ID_EX,rd_EX_MEM,rd_MEM_WB;
input regWrite_EX_MEM,regWrite_MEM_WB;

always@(*)
begin
if      (regWrite_EX_MEM==1 && rd_EX_MEM!=5'b00000 && rd_EX_MEM==rs1_ID_EX) forwardRs1=2'b01;
else if (regWrite_MEM_WB==1 && rd_MEM_WB!=5'b00000 && rd_MEM_WB==rs1_ID_EX) forwardRs1=2'b10;
else forwardRs1=2'b00;
end

always@(*)
begin
if      (regWrite_EX_MEM==1 && rd_EX_MEM!=5'b00000 && rd_EX_MEM==rs2_ID_EX) forwardRs2=2'b01;
else if (regWrite_MEM_WB==1 && rd_MEM_WB!=5'b00000 && rd_MEM_WB==rs2_ID_EX) forwardRs2=2'b10;
else forwardRs2=2'b00;
end

endmodule
