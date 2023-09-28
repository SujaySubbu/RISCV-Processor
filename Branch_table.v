`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2023 12:33:01
// Design Name: 
// Module Name: Branch_table
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

module Branch_table(state,addr,addr_ID_EX,entry,branch_ID_EX,reset);
output [1:0]state;
input [1:0] addr,addr_ID_EX,entry;
input branch_ID_EX,reset;
        
reg [1:0]branchTable[3:0];

assign state = branchTable[addr];

always@(negedge reset)
begin
if(reset==0)
    begin
        branchTable[0] = 2'b00; 
        branchTable[1] = 2'b00; 
        branchTable[2] = 2'b00; 
        branchTable[3] = 2'b00;
    end
end
 
always@(*)
begin
    if(branch_ID_EX==1) branchTable[addr_ID_EX] = entry;
end
endmodule

