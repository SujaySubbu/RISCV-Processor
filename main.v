`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 18:03:58
// Design Name: 
// Module Name: main
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

module main(clk,reset);
input clk,reset;

wire [31:0] pc,immVal,inCode,pc_IF_ID,inCode_IF_ID,readData1,readData2,
            regWriteData,pc_ID_EX,data1_ID_EX,data2_ID_EX,aluResult,in2,
            aluResult_EX_MEM,data2_EX_MEM,readData,data_MEM_WB,aluResult_MEM_WB,
            jumpAddr_IF_ID,writeData,immVal_ID_EX,jumpAddr,returnAddr_IF_ID,
            returnAddr_ID_EX,returnAddr_EX_MEM,returnAddr_MEM_WB;
wire [4:0] rd_ID_EX,rs1_ID_EX,rs2_ID_EX,rd_EX_MEM,rd_MEM_WB;
wire [3:0] aluOp,aluOp_ID_EX;
wire [1:0] entry,addr_IF_ID,addr_ID_EX,state,state_IF_ID,state_ID_EX,forwardRs1,forwardRs2;
wire outcome,branch,jump,zero,less,stall,flush,regWrite,aluSrc,memWrite,memToReg,inCode14_ID_EX,
     memRead,regWrite_ID_EX,branch_ID_EX,memRead_ID_EX,memWrite_ID_EX,memToReg_ID_EX,ecall,
     aluSrc_ID_EX,regWrite_EX_MEM,memWrite_EX_MEM,memRead_EX_MEM,memToReg_EX_MEM,jump_IF_ID,
     regWrite_MEM_WB,memToReg_MEM_WB,jump_ID_EX,jump_EX_MEM,jump_MEM_WB,branch_IF_ID;
     
reg [31:0]in1,data2;

assign writeData = memToReg_MEM_WB ? data_MEM_WB : aluResult_MEM_WB;
assign regWriteData = jump_MEM_WB ? returnAddr_MEM_WB : writeData;

always@(*)
begin
case(forwardRs1)
2'b00: in1 = data1_ID_EX;
2'b01: in1 = aluResult_EX_MEM;
2'b10: in1 = regWriteData;
endcase
end  

always@(*)
begin
case(forwardRs2)
2'b00: data2 = data2_ID_EX;
2'b01: data2 = aluResult_EX_MEM;
2'b10: data2 = regWriteData;
endcase
end 

assign in2 = aluSrc_ID_EX ? immVal_ID_EX : data2;

assign outcome = inCode14_ID_EX ? (branch_ID_EX & less) : (branch_ID_EX & zero);


PC            m1 (pc,pc_ID_EX,jumpAddr,state,branch,branch_ID_EX,jump,outcome,clk,reset,stall,ecall);
                  
Instruction_memory  m2 (inCode,pc,reset);
                    
Branch_Jump m3 (jumpAddr,branch,jump,ecall,inCode);
                    
IF_ID_reg               m4 (pc_IF_ID,inCode_IF_ID,returnAddr_IF_ID,addr_IF_ID,
                        jumpAddr_IF_ID,branch_IF_ID,jump_IF_ID,state_IF_ID,
                        pc,inCode,jumpAddr,branch,jump,state,clk,reset,flush,stall);

Register_file       m5 (readData1,readData2,inCode_IF_ID[19:15],inCode_IF_ID[24:20],
                        rd_MEM_WB,regWriteData,regWrite_MEM_WB,clk,reset);
                       
Control_unit        m6 (aluOp,aluSrc,regWrite,memWrite,memRead,memToReg,inCode_IF_ID,immVal,stall);
                                             
ID_EX_reg               m7 (pc_ID_EX,returnAddr_ID_EX,data1_ID_EX,data2_ID_EX,rd_ID_EX,aluOp_ID_EX,regWrite_ID_EX,
                        rs1_ID_EX,rs2_ID_EX,branch_ID_EX,jump_ID_EX,inCode14_ID_EX,addr_ID_EX,memRead_ID_EX,
                        memWrite_ID_EX,memToReg_ID_EX,aluSrc_ID_EX,state_ID_EX,immVal_ID_EX,
                        readData1,readData2,inCode_IF_ID[11:7],aluOp,regWrite,inCode_IF_ID[19:15],inCode_IF_ID[24:20],
                        returnAddr_IF_ID,branch_IF_ID,jump_IF_ID,pc_IF_ID,addr_IF_ID,inCode_IF_ID,jumpAddr_IF_ID,
                        state_IF_ID,memRead,memWrite,memToReg,aluSrc,immVal,clk,reset,flush,stall);
                      
ALU                 m8 (aluResult,zero,less,in1,in2,aluOp_ID_EX);

EX_MEM_reg              m9 (returnAddr_EX_MEM,regWrite_EX_MEM,memWrite_EX_MEM,memRead_EX_MEM,
                        memToReg_EX_MEM,rd_EX_MEM,aluResult_EX_MEM,data2_EX_MEM,jump_EX_MEM,
                        regWrite_ID_EX,memWrite_ID_EX,memRead_ID_EX,returnAddr_ID_EX,
                        memToReg_ID_EX,rd_ID_EX,aluResult,data2_ID_EX,jump_ID_EX,clk,reset);      
                        
Data_memory         m10 (readData,aluResult_EX_MEM,data2_EX_MEM,memWrite_EX_MEM,memRead_EX_MEM,reset); 
                       
MEM_WB_reg              m11 (returnAddr_MEM_WB,regWrite_MEM_WB,memToReg_MEM_WB,
                         data_MEM_WB,aluResult_MEM_WB,rd_MEM_WB,jump_MEM_WB,
                         regWrite_EX_MEM,memToReg_EX_MEM,readData,aluResult_EX_MEM, 
                         rd_EX_MEM,jump_EX_MEM,returnAddr_EX_MEM,clk,reset);  
                    
Forwarding_unit     m12 (forwardRs1,forwardRs2,rs1_ID_EX,rs2_ID_EX,rd_EX_MEM,rd_MEM_WB,
                         regWrite_EX_MEM,regWrite_MEM_WB);
                             
Hazard_detection       m13 (stall,memRead_ID_EX,rd_ID_EX,inCode_IF_ID[19:15],inCode_IF_ID[24:20],reset);       
                        
Branch_table        m14 (state,pc[4:3],addr_ID_EX,entry,branch_ID_EX,reset);   
                        
Branch_predictor    m15 (entry,flush,state_ID_EX,outcome);  
         
endmodule
