`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 17:22:12
// Design Name: 
// Module Name: IF_ID
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

module IF_ID_reg(pc_IF_ID,inCode_IF_ID,returnAddr_IF_ID,address_IF_ID,
             jumpAddr_IF_ID,branch_IF_ID,jump_IF_ID,state_IF_ID,
             pc,inCode,jumpAddr,branch,jump,state,clk,reset,flush,stall);
output reg [31:0]pc_IF_ID,inCode_IF_ID,returnAddr_IF_ID,jumpAddr_IF_ID;
output reg [1:0]address_IF_ID,state_IF_ID;
output reg branch_IF_ID,jump_IF_ID;
input [31:0]pc,inCode,jumpAddr;
input [1:0]state;
input branch,jump,clk,reset,flush,stall;

always@(posedge clk, negedge reset) 
begin 
if(reset==0 || flush==1) 
    begin 
        pc_IF_ID = 0; 
        address_IF_ID = 0;
        inCode_IF_ID = 0; 
        returnAddr_IF_ID = 0;
        jumpAddr_IF_ID = 0;
        branch_IF_ID = 0; 
        jump_IF_ID = 0;
        state_IF_ID = 0;
    end  
else if(stall==0)
    begin 
        pc_IF_ID = pc;
        address_IF_ID = pc[4:3];
        inCode_IF_ID = inCode; 
        returnAddr_IF_ID = pc + 4;
        jumpAddr_IF_ID = jumpAddr;
        branch_IF_ID = branch; 
        jump_IF_ID = jump;
        state_IF_ID = state;
    end 
end

endmodule
