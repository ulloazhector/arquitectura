
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2021 02:18:29
// Design Name: 
// Module Name: top
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


module top(
    input logic clk, reset,
    output logic [31:0] WriteData, MemAdr,
    output logic MemWrite
    );

    logic [31:0] MemRead;

    riscvmulti  rvmulti(clk, reset, MemRead, MemAdr, MemWrite, WriteData);
    idmem       idmem( clk, MemWrite, MemAdr, WriteData, MemRead);


endmodule
