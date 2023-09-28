`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:25:22
// Design Name: 
// Module Name: ALU
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

module ALU(aluResult,zero,less,in1,in2,aluOp);
output reg [31:0] aluResult;
output reg zero,less;
input [31:0] in1,in2;
input [3:0] aluOp;

always@(*)
begin 
case(aluOp)
4'b0000: aluResult = in1 + in2;  
4'b0001: aluResult = in1 - in2;
4'b0010: aluResult = in1 << in2[4:0];
4'b0011: aluResult = in1 >> in2[4:0];
4'b0100: aluResult = (in1<in2) ? 1:0;
endcase
end

always@(aluResult)
begin
if(aluResult==0) 
    begin zero = 1; less = 0; end
else if (aluResult[31]==1) 
    begin zero = 0; less = 1; end
else
    begin zero = 0; less = 0; end
end

endmodule
