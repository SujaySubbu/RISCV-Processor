`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:23:03
// Design Name: 
// Module Name: EX_MEM
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

module EX_MEM_reg(returnAddr_EX_MEM,regWrite_EX_MEM,memWrite_EX_MEM,memRead_EX_MEM,
              memToReg_EX_MEM,rd_EX_MEM,aluResult_EX_MEM,data2_EX_MEM,jump_EX_MEM,
              regWrite_ID_EX,memWrite_ID_EX,memRead_ID_EX,returnAddr_ID_EX,
              memToReg_ID_EX,rd_ID_EX,aluResult,data2,jump_ID_EX,clk,reset);
output reg [31:0]aluResult_EX_MEM,data2_EX_MEM,returnAddr_EX_MEM;
output reg [4:0]rd_EX_MEM;
output reg regWrite_EX_MEM,memWrite_EX_MEM,memRead_EX_MEM,memToReg_EX_MEM,jump_EX_MEM;
input [31:0] aluResult,data2,returnAddr_ID_EX;
input [4:0]rd_ID_EX;
input regWrite_ID_EX,memWrite_ID_EX,memRead_ID_EX,memToReg_ID_EX,jump_ID_EX,clk,reset;

always@(posedge clk, negedge reset)
begin
if(reset==0) 
    begin 
        returnAddr_EX_MEM = 0;
        regWrite_EX_MEM = 0;
        memWrite_EX_MEM = 0;
        memRead_EX_MEM = 0;
        memToReg_EX_MEM = 0;
        rd_EX_MEM = 0;
        aluResult_EX_MEM = 0;
        data2_EX_MEM = 0;
        jump_EX_MEM = 0;
    end

else
    begin 
        returnAddr_EX_MEM = returnAddr_ID_EX;
        regWrite_EX_MEM = regWrite_ID_EX;
        memWrite_EX_MEM = memWrite_ID_EX;
        memRead_EX_MEM = memRead_ID_EX;
        memToReg_EX_MEM = memToReg_ID_EX;
        rd_EX_MEM = rd_ID_EX;
        aluResult_EX_MEM = aluResult;
        data2_EX_MEM = data2;
        jump_EX_MEM = jump_ID_EX;
    end
end

endmodule
