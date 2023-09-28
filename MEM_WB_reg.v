`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:23:23
// Design Name: 
// Module Name: MEM_WB
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

module MEM_WB_reg(returnAddr_MEM_WB,regWrite_MEM_WB,memToReg_MEM_WB,
              data_MEM_WB,aluResult_MEM_WB,rd_MEM_WB,jump_MEM_WB,
              regWrite_EX_MEM,memToReg_EX_MEM,data,aluResult_EX_MEM, 
              rd_EX_MEM,jump_EX_MEM,returnAddr_EX_MEM,clk,reset);
output reg [31:0] returnAddr_MEM_WB,data_MEM_WB,aluResult_MEM_WB;
output reg [4:0] rd_MEM_WB;
output reg regWrite_MEM_WB,memToReg_MEM_WB,jump_MEM_WB;
input [31:0] returnAddr_EX_MEM,data,aluResult_EX_MEM;
input [4:0] rd_EX_MEM;
input regWrite_EX_MEM,memToReg_EX_MEM,jump_EX_MEM,clk,reset;

always@(posedge clk, negedge reset)
begin
if(reset==0) 
    begin 
        returnAddr_MEM_WB = 0;
        regWrite_MEM_WB = 0;
        memToReg_MEM_WB = 0;
        data_MEM_WB = 0;
        aluResult_MEM_WB = 0;
        rd_MEM_WB = 0;
        jump_MEM_WB = 0;
    end
             
else
    begin 
        returnAddr_MEM_WB = returnAddr_EX_MEM;
        regWrite_MEM_WB = regWrite_EX_MEM;
        memToReg_MEM_WB = memToReg_EX_MEM;
        data_MEM_WB = data;
        aluResult_MEM_WB = aluResult_EX_MEM;
        rd_MEM_WB = rd_EX_MEM;
        jump_MEM_WB = jump_EX_MEM;
    end
end

endmodule
