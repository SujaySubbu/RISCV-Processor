`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:26:01
// Design Name: 
// Module Name: Control_unit
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

module Control_unit(aluOp,aluSrc,regWrite,memWrite,memRead,memToReg,inCode,immVal,stall);
output reg [31:0]immVal;
output reg [3:0]aluOp;
output reg aluSrc,regWrite,memWrite,memRead,memToReg;
input [31:0]inCode;
input stall;

wire [10:0]control;
wire [6:0]opCode;

assign control = {inCode[30],inCode[14:12],inCode[6:0]};
assign opCode = inCode[6:0];

always@(*)
begin
if(stall==1) 
    begin 
        regWrite = 0;
        aluSrc = 0;
        memWrite = 0;
        memToReg = 0;
        memRead = 0;
        immVal[31:0] = 32'h00000000;
    end
else
begin
case(opCode)
7'b0110011:             //R-type
    begin 
        regWrite = 1;       
        aluSrc = 0;
        memWrite = 0;
        memToReg = 0;
        memRead = 0;
        immVal[31:0] = 32'hxxxxxxxx;
    end
7'b0000011:             //I-type (LW)
    begin 
        regWrite = 1;       
        aluSrc = 1;
        memWrite = 0;
        memToReg = 1;
        memRead = 1;
        immVal[31:0] = {{21{inCode[31]}},inCode[30:20]};
    end
7'b0010011:             //I-type (ADDI)
    begin 
        regWrite = 1;       
        aluSrc = 1;
        memWrite = 0;
        memToReg = 0;
        memRead = 0;
        immVal[31:0] = {{21{inCode[31]}},inCode[30:20]};
    end
7'b0100011:             //S-type
    begin 
        regWrite = 0;       
        aluSrc = 1;
        memWrite = 1;
        memToReg = 1'bx;
        memRead = 0;
        immVal[31:0] = {{21{inCode[31]}},inCode[30:25],inCode[11:7]};
    end
7'b1100011:             //B-type
    begin 
        regWrite = 0;       
        aluSrc = 0;
        memWrite = 0;
        memToReg = 1'bx;
        memRead = 0;
        immVal[31:0] = 32'hxxxxxxxx;
    end
7'b1101111:             //J-type
    begin 
        regWrite = 1;       
        aluSrc = 1'bx;
        memWrite = 0;
        memToReg = 1'bx;
        memRead = 0;
        immVal[31:0] = 32'hxxxxxxxx;
    end
7'b1110011: memWrite = 0; //ecall

endcase
end
end

always@(*)
begin
if(stall==1) aluOp = 4'b0000;
else
begin
casez(control)
11'b0_000_0110011: aluOp = 4'b0000; //add
11'b1_000_0110011: aluOp = 4'b0001; //sub
11'b0_001_0110011: aluOp = 4'b0010; //sll
11'b0_101_0110011: aluOp = 4'b0011; //srl
11'b0_010_0110011: aluOp = 4'b0100; //slt
11'b?_000_0010011: aluOp = 4'b0000; //addi
11'b?_010_0000011: aluOp = 4'b0000; //lw
11'b?_010_0100011: aluOp = 4'b0000; //sw
11'b?_000_1100011: aluOp = 4'b0001; //beq
11'b?_100_1100011: aluOp = 4'b0001; //blt
11'b?_???_1101111: aluOp = 4'bxxxx; //jal
11'b0_000_1110011: aluOp = 4'bxxxx; //ecall
endcase
end
end

endmodule

