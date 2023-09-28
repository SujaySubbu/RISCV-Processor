`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2023 14:43:36
// Design Name: 
// Module Name: main_tb
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

module main_tb();
reg clk,reset;

main m1(clk,reset);

initial begin
clk = 0; reset = 1;
#1 reset = 0;
#1 reset = 1;
end

always #5 clk = ~clk;

endmodule
