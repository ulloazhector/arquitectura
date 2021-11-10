
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:18:10
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
    input   logic clk, reset,

    input   logic [6:0] op,
    input   logic [2:0] funct3,
    input   logic       funct7b5,

    // DECODE
    output  logic [1:0] ImmSrcD,

    // EXECUTION
    input   logic       FlushE, ZeroE,
    output  logic       PCSrcE, ResultSrcEb0, ALUSrcE,
    output  logic [3:0] ALUControlE,

    // MEMORY
    output  logic       RegWriteM, MemWriteM,

    // WRITEBACK
    output  logic       RegWriteW,
    output  logic [1:0] ResultSrcW
    );

    logic [1:0] ALUOp;

    // DECODE
    logic RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;
    logic [1:0] ResultSrcD;
    logic [3:0] ALUControlD;
    // EXECUTION
    logic RegWriteE, MemWriteE, JumpE, BranchE;
    logic [1:0] ResultSrcE;
    // MEMORY
    logic [1:0] ResultSrcM;



    MAINdecoder MAINdecoder(op, RegWriteD, ResultSrcD, MemWriteD, JumpD, 
                            BranchD, ALUSrcD, ImmSrcD, ALUOp);
    ALUdecoder  ALUdecoder( op[5], funct3, funct7b5, ALUOp, ALUControlD);



    // EXECUTION
    always_ff @( posedge clk, posedge reset) // flush asincronico?
        if (FlushE | reset) begin
            RegWriteE   <= 0;
            ResultSrcE  <= 0;
            MemWriteE   <= 0;
            JumpE       <= 0;
            BranchE     <= 0;
            ALUControlE <= 0;
            ALUSrcE     <= 0;
        end
        else begin
            RegWriteE   <= RegWriteD;
            ResultSrcE  <= ResultSrcD;
            MemWriteE   <= MemWriteD;
            JumpE       <= JumpD;
            BranchE     <= BranchD;
            ALUControlE <= ALUControlD;
            ALUSrcE     <= ALUSrcD;
        end
    assign ResultSrcEb0 = ResultSrcE[0];
    assign PCSrcE = BranchE & ZeroE | JumpE;
    //////////////////////////////////////////////////////////////////////////////////

    // MEMORY
    always_ff @( posedge clk, posedge reset ) begin
        if( reset )begin
            RegWriteM   <= 0;    
            ResultSrcM  <= 0;    
            MemWriteM   <= 0;    
        end else begin
            RegWriteM   <= RegWriteE;    
            ResultSrcM  <= ResultSrcE;    
            MemWriteM   <= MemWriteE;    
        end
    end
    //////////////////////////////////////////////////////////////////////////////////

    // WRITEBACK
    always_ff @( posedge clk, posedge reset ) begin 
        if (reset) begin
            RegWriteW   <= 0;
            ResultSrcW  <= 0;
        end else begin
            RegWriteW   <= RegWriteM;
            ResultSrcW  <= ResultSrcM;
        end

    end
    //////////////////////////////////////////////////////////////////////////////////


endmodule
