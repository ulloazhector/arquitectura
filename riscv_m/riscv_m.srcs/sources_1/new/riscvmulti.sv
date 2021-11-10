
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2021 02:24:28
// Design Name: 
// Module Name: riscvmulti
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


module riscvmulti(
    input logic clk, reset,

    // Memory
    input logic [31:0] MemRead,
    output logic [31:0] Adr,
    output logic MemWrite,
    output logic [31:0] WriteData
    );

    logic [31:0] Instr;
    logic Zero;

    logic PCWrite, RegWrite, IRWrite, AdrSrc;
    logic [1:0] ResultSrc;
    logic [1:0] ALUSrcA, ALUSrcB;
    logic [3:0] ALUControl;
    logic [1:0] ImmSrc;


    ControlUnit c(  clk, reset, Instr[6:0], Instr[14:12], Instr[30],
                    Zero, PCWrite, RegWrite, MemWrite, IRWrite,
                    ResultSrc, ALUSrcA, ALUSrcB, AdrSrc, ALUControl, ImmSrc);

    datapath dp(    clk, reset, ResultSrc, ALUSrcA, ALUSrcB, ALUControl,
                    ImmSrc, RegWrite, PCWrite, AdrSrc, MemWrite, IRWrite,
                    Zero, Instr, MemRead, Adr, WriteData);



endmodule

