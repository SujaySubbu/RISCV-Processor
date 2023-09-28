`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2023 14:06:17
// Design Name: 
// Module Name: Instruction_decoder
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

module Branch_Jump(jumpAddr,branch,jump,ecall,inCode);
output reg[31:0]jumpAddr;
output reg branch,jump,ecall;
input [31:0]inCode;
wire [6:0]opCode;

assign opCode = inCode[6:0];

always@(inCode)
begin
case(opCode)
7'b1100011: begin branch = 1; jump = 0; ecall = 0;
                  jumpAddr[31:0] = {{20{inCode[31]}},inCode[7],inCode[30:25],inCode[11:8],1'b0};
            end   
7'b1101111: begin branch = 0; jump = 1; ecall = 0;
                  jumpAddr[31:0] = {{12{inCode[31]}},inCode[19:12],inCode[20],inCode[30:21],1'b0};
            end
7'b1110011: begin branch = 0; jump = 0; ecall = 1; end
default: begin branch = 0; jump = 0; ecall = 0; end
endcase
end

endmodule
