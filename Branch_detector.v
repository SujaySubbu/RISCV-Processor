`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2023 16:29:37
// Design Name: 
// Module Name: Branch_predictor
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

module Branch_predictor(entry,flush,state_ID_EX,outcome);
output reg [1:0]entry;
output flush;
input [1:0] state_ID_EX;
input outcome;
parameter s0=0,s1=1,s2=2,s3=3;

assign flush = state_ID_EX[1] ^ outcome;

always@(*)
begin
    case(state_ID_EX)
        s0: entry = outcome ? s1 : s0;
        s1: entry = outcome ? s2 : s0;
        s2: entry = outcome ? s3 : s1;
        s3: entry = outcome ? s3 : s2;
    endcase
end

endmodule
