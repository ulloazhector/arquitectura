
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 09:44:36 PM
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
module top( input logic clk, reset,
            output logic [31:0] WriteData, DataAdr,
            output logic MemWrite);
 
 
 logic [31:0] PC;
 logic [31:0] Instr, ReadData;
 logic [2:0] DataSize;
 // instantiate processor and memories
 riscvsingle rvsingle(clk, reset, PC, Instr, MemWrite, 
                       DataAdr, WriteData, ReadData, DataSize);
 
 imem imem(PC, Instr);
 dmem dmem(clk, MemWrite, DataAdr, WriteData, DataSize, ReadData);
endmodule
