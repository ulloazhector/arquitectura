
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 23:18:50
// Design Name: 
// Module Name: InstrDecoder
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


module InstrDecoder(
    input logic [6:0] op,
    output logic [1:0] ImmSrc 
    );
    
    always_comb
        case(op)
            7'b0000011: ImmSrc = 2'b00; // I-type
            7'b0100011: ImmSrc = 2'b01; // S-type
            7'b1100011: ImmSrc = 2'b10; // B-type
            7'b1101111: ImmSrc = 2'b11; // J-type
            default:;
        endcase

endmodule
