`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:25:08
// Design Name: 
// Module Name: Register_file
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

module Register_file(readData1,readData2,readAddr1,readAddr2,writeAddr,
                     regWriteData,regWrite,clk,reset);
output reg [31:0]readData1,readData2;
input [4:0]readAddr1,readAddr2,writeAddr;
input [31:0]regWriteData;
input regWrite,clk,reset;
reg [31:0]regMem[31:0];
integer i;

always@(negedge clk)
begin
readData1 = regMem[readAddr1];
readData2 = regMem[readAddr2];
end

always@(negedge reset)
begin
if(reset==0) for(i=0;i<32;i=i+1) 
regMem[i] = 0; 
end

always@(negedge reset)
begin
if(reset==0)
begin

end
end


always@(*)
begin
if (regWrite==1 && writeAddr!=5'b00000) regMem[writeAddr] = regWriteData;
end

endmodule
