
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2021 11:36:46 PM
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
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7b5,
    input logic Zero,
    output logic [2:0]  ResultSrc,
    output logic MemWrite, 
    output logic [1:0] PCSrc,
    output logic ALUSrc, RegWrite,Jump, Load,
    output logic [2:0]  ImmSrc,
    output logic [3:0] ALUControl,
    output logic [2:0] DataSize
    );
 
    logic [1:0] ALUOp;
    logic Branch;
    logic PCAlu;

    MAINdecoder MAINdecoder(op, ResultSrc,MemWrite,Branch,
                            ALUSrc, Load, RegWrite, Jump, ImmSrc, ALUOp, PCAlu);
    ALUdecoder  ALUdecoder(op[5], funct3, funct7b5,ALUOp, ALUControl);

    //MEMdecoder
    assign DataSize = funct3;

    assign PCSrc = {PCAlu, Branch & Zero | Jump};

    
endmodule
