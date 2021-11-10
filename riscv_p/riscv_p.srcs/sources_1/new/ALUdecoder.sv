
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:18:10
// Design Name: 
// Module Name: ALUdecoder
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


module ALUdecoder(
    input   logic       opb5, // R = 1, I = 0
    input   logic [2:0] funct3,
    input   logic       funct7b5,
    input   logic [1:0] ALUOp,
    
    output  logic [3:0] ALUControl
    );

                        // ALUOp
localparam  ADDITION    = 2'b00,
            SUBTRACTION = 2'b01,
            R_I_TYPE    = 2'b10,
            BRANCHES    = 2'b11;

logic RtypeSub;
assign RtypeSub = funct7b5 & opb5; // TRUE for R–type subtract\

always_comb
    case(ALUOp)
        ADDITION:       ALUControl = 4'b0000;
        SUBTRACTION:    ALUControl = 4'b0001;
        R_I_TYPE:
            case(funct3) // R–type or I–type ALU
                3'b000: ALUControl = (RtypeSub) ? 4'b0001 : 4'b0000;// sub / add
                3'b001: ALUControl = 4'b0100;                       // sll
                3'b010: ALUControl = 4'b0101;                       // slt, slti
                3'b011: ALUControl = 4'b0110;                       // sltu, sltui
                3'b100: ALUControl = 4'b0111;                       // xor, xori
                3'b101: ALUControl = funct7b5 ? 4'b1001 : 4'b1000;  // sra / srl
                3'b110: ALUControl = 4'b0011;                       // or, ori
                3'b111: ALUControl = 4'b0010;                       // and, andi

                default: ALUControl = 4'bxxxx;                      // ???
            endcase
        BRANCHES: 
            case(funct3)            
                3'b000:  ALUControl = 4'b0001; // branch if =
                3'b001:  ALUControl = 4'b1100; // branch if !=
                3'b100:  ALUControl = 4'b1011; // branch if <
                3'b101:  ALUControl = 4'b0101; // branch if >=
                3'b110:  ALUControl = 4'b1010; // branch if <  unsigned
                3'b111:  ALUControl = 4'b0110; // branch if >= unsigned
                default: ALUControl = 4'bxxxx; // ???
            endcase

        default:;
    endcase
endmodule
