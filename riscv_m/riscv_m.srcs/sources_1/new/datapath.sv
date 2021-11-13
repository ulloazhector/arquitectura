
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 18:42:52
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
    input logic clk, reset,
    input logic [1:0] ResultSrc,
    input logic [1:0] ALUSrcA, ALUSrcB,
    input logic [3:0] ALUControl,
    input logic [1:0] ImmSrc,
    input logic RegWrite,

    input logic PCWrite,
    input logic AdrSrc,
    input logic MemWrite,
    input logic IRWrite,
    output logic Zero,
    output logic [31:0] Instr,

    // Memory
    input logic [31:0] MemRead,
    output logic [31:0] Adr,
    output logic [31:0] WriteData
    );

logic [31:0] Result;
logic [31:0] OldPC;
logic [31:0] Data;
logic [31:0] RD1, RD2;
logic [31:0] A, PC;
logic [31:0] ImmExt;
logic [31:0] SrcA, SrcB;
logic [31:0] ALUResult;
logic [31:0] ALUOut;

logic [31:0] aux;


    // PC logic
    flopr #(32) pcreg(clk, reset, PCWrite, Result, PC);
    assign Adr = AdrSrc ? Result : PC;
    flopr #(32) oldpcreg(clk, reset, IRWrite, PC, OldPC);
    
    flopr #(32) instrreg(clk, reset, IRWrite, MemRead, Instr);
    flopr #(32) datareg(clk, reset, 1'b1, MemRead, Data);

    // register file logic
    regFile     rf( clk, RegWrite, Instr[19:15], Instr[24:20],
                Instr[11:7], Result, RD1, RD2);
    flopr #(32) rfAdr(clk, reset, 1'b1, RD1, A);
    flopr #(32) rfData(clk, reset, 1'b1, RD2, WriteData);
    extend      ext(Instr[31:7], ImmSrc, ImmExt);

    // AlU logic
    mux3 #(32)  amux(PC, OldPC, A, ALUSrcA, SrcA);
    mux3 #(32)  bmux(WriteData, ImmExt, 32'd1, ALUSrcB, SrcB); // Hago PC = PC + 1
    alu         alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
    flopr #(32) alureg(clk, reset, 1'b1, ALUResult, ALUOut);

    mux3 #(32)  resultmux(ALUOut, Data, ALUResult, ResultSrc, Result);






endmodule
