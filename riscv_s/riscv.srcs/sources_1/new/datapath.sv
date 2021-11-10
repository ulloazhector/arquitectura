
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 07:46:01 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input   logic           clk, reset,
    input   logic           Load,
    input   logic [2:0]     ResultSrc,
    input   logic [1:0]     PCSrc,
    input   logic           ALUSrc,
    input   logic           RegWrite,
    input   logic [2:0]     ImmSrc,
    input   logic [3:0]     ALUControl,
    input   logic [2:0]     DataSize,
    output  logic           Zero,
    output  logic [31:0]    PC,
    input   logic [31:0]    Instr,
    output  logic [31:0]    ALUResult, WriteData,
    input   logic [31:0]    ReadData);

logic [31:0] PCNext, PCPlus4, PCTarget;
logic [31:0] ImmExt;
logic [31:0] SrcA, SrcB;
logic [31:0] Result;

    // next PC logic
    flopr #(32) pcreg(clk, reset, PCNext, PC);
    assign PCPlus4 = PC + 32'd4;
    assign PCTarget = PC + ImmExt;
    mux1 #(32)  pcmux(PCPlus4, PCTarget, ALUResult, PCSrc, PCNext);

    // register file logic
    regFile     rf( clk, Load, RegWrite, Instr[19:15], Instr[24:20],
                    Instr[11:7], Result, DataSize,SrcA, WriteData);
    extend      ext(Instr[31:7], ImmSrc, ImmExt);

    // ALU logic
    mux2 #(32)  srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
    alu         alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
    mux3 #(32)  resultmux(   ALUResult, ReadData, PCPlus4, ImmExt, PCTarget,
                            ResultSrc, Result);
    
endmodule
