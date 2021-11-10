
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 17:31:04
// Design Name: 
// Module Name: extend
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


module extend(  input logic [31:7] instr,
                input logic [1:0] immsrc,
                output logic [31:0] immext);

always_comb
    case(immsrc)
        2'b00:      immext = { {20{instr[31]}}, instr[31:20]};                                  // I-type
        2'b01:      immext = { {20{instr[31]}}, instr[31:25], instr[11:7]};                     // S-type
        2'b10:      immext = { {20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};     // B-type
        2'b11:      immext = { {12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};   // J-type
        default:    immext = 32'bx; // undefined
    endcase

endmodule
