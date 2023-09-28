`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:24:40
// Design Name: 
// Module Name: Data_memory
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

module Data_memory(readData,address,memWriteData,memWrite,memRead,reset);
output reg [31:0]readData;
input [31:0]memWriteData,address;
input memWrite,memRead,reset;

reg [7:0] mem [19:0];

always@(negedge reset)
begin
if(reset==0) 
    begin 
        mem[3] = 0; mem[2] = 0; mem[1] = 0; mem[0] = 9;
        mem[7] = 0; mem[6] = 0; mem[5] = 0; mem[4] = 6;
        mem[11] = 1; mem[10] = 1; mem[9] = 1; mem[8] = 1;
        mem[15] = 1; mem[14] = 1; mem[13] = 1; mem[12] = 1;
        mem[19] = 1; mem[18] = 1; mem[17] = 1; mem[16] = 1; 
    end
end

always@(*)
begin
if (memRead == 1 && address[1:0]==2'b00) 
    readData = {mem[address+3],mem[address+2],mem[address+1],mem[address]};
else if (memWrite == 1 && address[1:0]==2'b00) 
    {mem[address+3],mem[address+2],mem[address+1],mem[address]} = memWriteData;
end

endmodule
