
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:09:02
// Design Name: 
// Module Name: riscvpipe
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


module riscvpipe(
    input   logic           clk,
    input   logic           reset,

    // Instruction memory logic
    output  logic [31:0]    PCF,
    input   logic [31:0]    InstrF,

    // Data memory logic
    output  logic [31:0]    ALUResultM, WriteDataM,
    output  logic           MemWriteM,
    input   logic [31:0]    ReadDataM
    );


    // Signals
    logic StallF;           // Fetch

    logic StallD, FlushD;   // Decode
    logic [31:0] InstrD;
    logic [1:0] ImmSrcD;

    logic FlushE;           // Execution
    logic [4:0] Rs1E, Rs2E, RdE;
    logic PCSrcE, ResultSrcEb0, ALUSrcE, ZeroE;
    logic [1:0] ForwardAE, ForwardBE;
    logic [3:0] ALUControlE;

    logic RegWriteM;        // Memory
    logic [4:0] RdM;

    logic RegWriteW;        // Writeback
    logic [4:0] RdW;
    logic [1:0] ResultSrcW;




    ControlUnit c(  clk, reset, InstrD[6:0], InstrD[14:12], InstrD[30], 
                    ImmSrcD, 
                    FlushE, ZeroE, PCSrcE, ResultSrcEb0, ALUSrcE, ALUControlE,
                    RegWriteM, MemWriteM,
                    RegWriteW, ResultSrcW);

    datapath    dp( clk, reset, PCSrcE, StallF, InstrF, PCF,
                    StallD, FlushD, ImmSrcD, InstrD, InstrD[19:15], InstrD[24:20],
                    FlushE, ForwardAE, ForwardBE, Rs1E, Rs2E, RdE, ALUSrcE, ALUControlE, ZeroE,
                    ALUResultM, WriteDataM, ReadDataM, RdM,
                    RegWriteW, ResultSrcW, RdW);

    HazardUnit  hz( InstrD[19:15], InstrD[24:20], Rs1E, Rs2E, RdE, PCSrcE, ResultSrcEb0,
                    RdM, RdW, RegWriteM, RegWriteW, StallF, StallD, 
                    FlushD, FlushE, ForwardAE, ForwardBE);


endmodule
