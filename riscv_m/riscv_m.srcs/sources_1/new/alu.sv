
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 17:49:58
// Design Name: 
// Module Name: alu
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


module alu(input logic [31:0] SrcA, SrcB,
           input logic [3:0] ALUControl,
           output logic [31:0] ALUResult,
           output logic Zero
    );

always_comb
    case(ALUControl) 
        4'b0000: ALUResult = SrcA + SrcB;
        4'b0001: ALUResult = SrcA - SrcB;
        4'b0010: ALUResult = SrcA & SrcB;
        4'b0011: ALUResult = SrcA | SrcB;
        4'b0100: ALUResult = SrcA << SrcB[4:0];
        4'b0101: ALUResult = {31'b0, (signed'(SrcA) < signed'(SrcB))};
        4'b0110: ALUResult = {31'b0, (SrcA < SrcB)}; //unsigned
        4'b0111: ALUResult = SrcA ^ SrcB;
        4'b1000: ALUResult = SrcA >> SrcB[4:0];
        4'b1001: ALUResult = signed'(SrcA) >>> SrcB[4:0];

        4'b1010: ALUResult = {31'b0, (SrcA >= SrcB)}; //unsigned
        4'b1011: ALUResult = {31'b0, (signed'(SrcA) >= signed'(SrcB))};
        4'b1100: ALUResult = {31'b0, (SrcA == SrcB)};

        default: ALUResult = 32'bx;

    endcase 

assign Zero = (ALUResult == 0) ;

endmodule
