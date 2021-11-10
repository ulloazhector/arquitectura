
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 22:53:40
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

    // FETCH
    input   logic           PCSrcE, StallF,
    input   logic [31:0]    InstrF,
    output  logic [31:0]    PCF,

    // DECODE
    input   logic           StallD, FlushD,
    input   logic [1:0]     ImmSrcD,
    output  logic [31:0]    InstrD,
    output  logic [4:0]     Rs1D, Rs2D,

    // EXECUTION
    input   logic           FlushE,
    input   logic [1:0]     ForwardAE, ForwardBE,
    output  logic [4:0]     Rs1E, Rs2E, RdE,

    input   logic           ALUSrcE,
    input   logic [3:0]     ALUControlE,
    output  logic           ZeroE,

    // MEMORY
    output  logic [31:0]    ALUResultM, WriteDataM,
    input   logic [31:0]    ReadDataM,
    output  logic [4:0]     RdM,

    // WRITEBACK
    input   logic           RegWriteW,
    input   logic [1:0]     ResultSrcW,
    output  logic [4:0]     RdW

    );


    // FETCH
    logic [31:0] PCPlus4F, PCFnext;
    // DECODE
    logic [31:0] RD1D, RD2D, PCD, ImmExtD, PCPlus4D;
    logic [4:0] RdD;
    // EXECUTION
    logic [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E, SrcAE, SrcBE, WriteDataE, ALUResultE, PCTargetE;
    // MEMORY
    logic [31:0] PCPlus4M;
    // WRITEBACK
    logic [31:0] ALUResultW, ReadDataW, PCPlus4W, ResultW;


    //////////////////////////////////////////////////////////////////////////////////

    // FETCH
    always_ff @( posedge clk, posedge reset) 
        if (reset) PCF <= 0;
        else if (!StallF) PCF <= PCFnext;    // negado?
    assign PCFnext  = (PCSrcE) ? PCTargetE : PCPlus4F;
    assign PCPlus4F = PCF + 32'd4;
    //////////////////////////////////////////////////////////////////////////////////
    

    // DECODE
    always_ff @( posedge clk, posedge reset ) // flush asincronico?
        if (FlushD | reset) begin
            InstrD      <= 0;
            PCD         <= 0;
            PCPlus4D    <= 0;
        end
        else if (!StallD) begin   // negado?
            InstrD      <= InstrF;
            PCD         <= PCF;
            PCPlus4D    <= PCPlus4F;
        end
    regFile     rf(clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
    extend      ext(InstrD[31:7], ImmSrcD, ImmExtD);
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD  = InstrD[11:7];
    //////////////////////////////////////////////////////////////////////////////////


    // EXECUTION
    always_ff @( posedge clk, posedge reset) // flush asincronico?
        if(FlushE | reset) begin
            RD1E        <= 0;
            RD2E        <= 0;
            PCE         <= 0;
            Rs1E        <= 0;
            Rs2E        <= 0;
            RdE         <= 0;
            ImmExtE     <= 0;
            PCPlus4E    <= 0;
        end
        else begin
            RD1E        <= RD1D;
            RD2E        <= RD2D;
            PCE         <= PCD;
            Rs1E        <= Rs1D;
            Rs2E        <= Rs2D;
            RdE         <= RdD;
            ImmExtE     <= ImmExtD;
            PCPlus4E    <= PCPlus4D;
        end
    mux3 #(32)  faemux(RD1E, ResultW, ALUResultM, ForwardAE, SrcAE);
    mux3 #(32)  fbemux(RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
    assign SrcBE        = (ALUSrcE) ? ImmExtE : WriteDataE;
    alu         alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);
    assign PCTargetE    = PCE + ImmExtE;
    //////////////////////////////////////////////////////////////////////////////////


    // MEMORY
    always_ff @( posedge clk, posedge reset ) begin
        if (reset) begin
            ALUResultM  <= 0;
            WriteDataM  <= 0;
            RdM         <= 0;
            PCPlus4M    <= 0;
        end else begin
            ALUResultM  <= ALUResultE;
            WriteDataM  <= WriteDataE;
            RdM         <= RdE;
            PCPlus4M    <= PCPlus4E;
        end
    end
    //////////////////////////////////////////////////////////////////////////////////


    // WRITEBACK
    always_ff @( posedge clk, posedge reset ) begin
        if (reset) begin
            ALUResultW  <= 0;
            ReadDataW   <= 0;
            RdW         <= 0;
            PCPlus4W    <= 0;
        end else begin
            ALUResultW  <= ALUResultM;
            ReadDataW   <= ReadDataM;
            RdW         <= RdM;
            PCPlus4W    <= PCPlus4M;
        end
    end
    mux3 #(32)  resultmux(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);


    








endmodule

