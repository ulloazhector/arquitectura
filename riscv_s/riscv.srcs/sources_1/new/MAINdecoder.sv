
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2021 11:36:46 PM
// Design Name: 
// Module Name: MAINdecoder
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


module MAINdecoder(
    input logic [6:0] op,
    output logic [2:0] ResultSrc,
    output logic  MemWrite,
    output logic  Branch,ALUSrc, Load,
    output logic  RegWrite, Jump,
 
    output logic [2:0] ImmSrc,
    output logic [1:0] ALUOp,
    output logic PCAlu
    );

logic [14:0] controls;
assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
        ResultSrc, PCAlu, Load, Branch, ALUOp, Jump} = controls;

always_comb
    case(op)
                                // RegWrite ImmSrc ALUSrc MemWrite ResultSrc PCAlu Load Branch ALUOp Jump
        7'b0000011: controls = 15'b1________000____1______0________001_______0_____1____0______00____0; // (3)   lw
        7'b0010011: controls = 15'b1________000____1______0________000_______0_____0____0______10____0; // (19)  I–type ALU
        7'b0010111: controls = 15'b1________100____x______0________100_______0_____0____0______00____0; // (23)  add upper immediate to PC
        7'b0100011: controls = 15'b0________001____1______1________xxx_______0_____0____0______00____0; // (35)  S-type
        7'b0110011: controls = 15'b1________xxx____0______0________000_______0_____0____0______10____0; // (51)  R–type
        7'b0110111: controls = 15'b1________100____x______0________011_______0_____0____0______00____0; // (55)  load upper immediate (lui)
        7'b1100011: controls = 15'b0________010____0______0________000_______0_____0____1______11____0; // (99)  B-type
        7'b1100111: controls = 15'b1________000____1______0________010_______1_____0____0______00____1; // (103) jump and link register
        7'b1101111: controls = 15'b1________011____x______0________010_______0_____0____0______xx____1; // (111) jal
        default:    controls = 15'b0________xxx____x______0________xxx_______x_____x____x______xx____x; // ??? 
    endcase
endmodule

