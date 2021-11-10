
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:18:10
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(
    input logic [4:0]   Rs1D, Rs2D,
    input logic [4:0]   Rs1E, Rs2E, RdE,
    input logic         PCSrcE, ResultSrcEb0,
    input logic [4:0]   RdM, RdW,
    input logic         RegWriteM, RegWriteW,

    output logic        StallF, StallD, 
    output logic        FlushD, FlushE,
    output logic [1:0]  ForwardAE, ForwardBE
    );

    logic lwStall;
    
    
    
    // Load hazard
    assign lwStall = ResultSrcEb0 & ((Rs1D == RdE) | (Rs2D == RdE));

        

    assign StallF = lwStall;
    assign StallD = lwStall;

    // branch is taken
    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;

    // data hazards
    always_comb begin 
        if      (((Rs1E == RdM) & RegWriteM) & (Rs1E != 0))
            ForwardAE = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))
            ForwardAE = 2'b01;
        else
            ForwardAE = 2'b00;
    end

    always_comb begin 
        if      (((Rs2E == RdM) & RegWriteM) & (Rs2E != 0))
            ForwardBE = 2'b10;
        else if (((Rs2E == RdW) & RegWriteW) & (Rs2E != 0))
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
    end

endmodule
