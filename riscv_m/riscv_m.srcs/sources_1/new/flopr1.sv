`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 16:54:47
// Design Name: 
// Module Name: flopr1
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


module flopr1 #(parameter WIDTH = 8)(
    input logic clk, reset, enable,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q);

 always_ff @(posedge clk, posedge reset)
    if (reset)      q <= 0;
    elseif (enable) q <= d;

endmodule
