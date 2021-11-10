
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 23:20:47
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input logic clk, reset,
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7b5,
    input logic Zero,

    output logic PCWrite,
    output logic RegWrite, MemWrite, IRWrite,
    output logic [1:0] ResultSrc,
    output logic [1:0] ALUSrcA, ALUSrcB,
    output logic AdrSrc,

    output logic [3:0] ALUControl,
    output logic [1:0] ImmSrc
    );

    logic [1:0] ALUOp;
    logic Branch, PCUpdate;


    MainFSM         MainFSM(clk, reset, op, Branch, PCUpdate, 
                            RegWrite, MemWrite, IRWrite, ResultSrc,
                            ALUSrcA, ALUSrcB, AdrSrc, ALUOp);

    ALUDecoder      ALUDecoder(op[5], funct3, funct7b5, ALUOp, ALUControl);

    InstrDecoder    InstrDecoder(op, ImmSrc);




    assign PCWrite = Branch & Zero | PCUpdate;
endmodule
