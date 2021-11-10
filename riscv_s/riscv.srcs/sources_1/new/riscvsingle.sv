
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 09:31:56 PM
// Design Name: 
// Module Name: riscvsingle
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


module riscvsingle(
    input logic clk, reset,
    output logic [31:0] PC,
    input logic [31:0] Instr,
    output logic MemWrite,
    output logic [31:0] ALUResult, WriteData,
    input logic [31:0] ReadData,
    output logic [2:0] DataSize);

logic ALUSrc, RegWrite, Jump, Zero;
logic [1:0] PCSrc; 
logic Load;
logic [2:0] ResultSrc, ImmSrc;
logic [3:0] ALUControl;

ControlUnit c(Instr[6:0], Instr[14:12], Instr[30], Zero,
            ResultSrc, MemWrite, PCSrc,
            ALUSrc, RegWrite, Jump, Load,
            ImmSrc, ALUControl, DataSize);

datapath dp(clk, reset, Load, ResultSrc, PCSrc,
            ALUSrc, RegWrite,
            ImmSrc, ALUControl, DataSize,
            Zero, PC, Instr,
            ALUResult, WriteData, ReadData);
endmodule
