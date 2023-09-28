`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:22:43
// Design Name: 
// Module Name: ID_EX
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

module ID_EX_reg(pc_ID_EX,returnAddr_ID_EX,data1_ID_EX,data2_ID_EX,rd_ID_EX,aluOp_ID_EX,
             regWrite_ID_EX,rs1_ID_EX,rs2_ID_EX,branch_ID_EX,jump_ID_EX,inCode14_ID_EX,address_ID_EX,
             memRead_ID_EX,memWrite_ID_EX,memToReg_ID_EX,aluSrc_ID_EX,state_ID_EX,immVal_ID_EX,
             data1,data2,rd,aluOp,regWrite,rs1,rs2,returnAddr_IF_ID,branch_IF_ID,jump_IF_ID,pc_IF_ID,address_IF_ID,
             inCode_IF_ID,jumpAddr_IF_ID,state_IF_ID,memRead,memWrite,memToReg,aluSrc,immVal,clk,reset,flush,stall);
output reg [31:0]pc_ID_EX,data1_ID_EX,data2_ID_EX,returnAddr_ID_EX,immVal_ID_EX;
output reg [4:0]rs1_ID_EX,rs2_ID_EX,rd_ID_EX;
output reg [3:0]aluOp_ID_EX;
output reg [1:0]address_ID_EX,state_ID_EX;
output reg regWrite_ID_EX,branch_ID_EX,jump_ID_EX,memRead_ID_EX,memWrite_ID_EX,
           memToReg_ID_EX,aluSrc_ID_EX,inCode14_ID_EX;
input [31:0]pc_IF_ID,data1,data2,returnAddr_IF_ID,jumpAddr_IF_ID,inCode_IF_ID,immVal;
input [4:0]rs1,rs2,rd;
input [3:0]aluOp;
input [1:0]address_IF_ID,state_IF_ID;
input branch_IF_ID,jump_IF_ID,memRead,memWrite,memToReg,aluSrc,regWrite,clk,reset,flush,stall;

always@(posedge clk, negedge reset)
begin
if(reset==0 || flush==1 || stall==1) 
    begin 
        pc_ID_EX = 0;
        inCode14_ID_EX = 0;
        returnAddr_ID_EX = 0;
        data1_ID_EX = 0;
        data2_ID_EX = 0;
        rd_ID_EX = 0; 
        aluOp_ID_EX = 0; 
        regWrite_ID_EX = 0;
        rs1_ID_EX = 0; 
        rs2_ID_EX = 0;
        branch_ID_EX = 0;
        jump_ID_EX = 0;
        address_ID_EX = 0;
        state_ID_EX = 0;
        memRead_ID_EX = 0;
        memWrite_ID_EX = 0;
        memToReg_ID_EX = 0;
        aluSrc_ID_EX = 0;
        immVal_ID_EX = 0;
    end
                         
else 
    begin 
        pc_ID_EX = pc_IF_ID + jumpAddr_IF_ID;
        inCode14_ID_EX = inCode_IF_ID[14];
        returnAddr_ID_EX = returnAddr_IF_ID;
        data1_ID_EX = data1;
        data2_ID_EX = data2;
        rd_ID_EX = rd; 
        aluOp_ID_EX = aluOp; 
        regWrite_ID_EX = regWrite;
        rs1_ID_EX = rs1; 
        rs2_ID_EX = rs2;
        branch_ID_EX = branch_IF_ID;
        jump_ID_EX = jump_IF_ID;
        state_ID_EX = state_IF_ID;
        address_ID_EX = address_IF_ID;
        memRead_ID_EX = memRead;
        memWrite_ID_EX = memWrite;
        memToReg_ID_EX = memToReg;
        aluSrc_ID_EX = aluSrc;
        immVal_ID_EX = immVal;
    end
end

endmodule
