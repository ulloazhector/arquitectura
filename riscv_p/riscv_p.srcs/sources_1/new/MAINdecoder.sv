
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:18:10
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
    input   logic [6:0] op,
    
    output  logic       RegWrite,
    output  logic [1:0] ResultSrc,
    output  logic       MemWrite, Jump, Branch,
    output  logic       ALUSrc,
    output  logic [1:0] ImmSrc,
    output  logic [1:0] ALUOp
    );
    
    typedef enum  { NOP = 7'd0, LOAD = 7'd3,   I__TYPE = 7'd19, STORE = 7'd35, 
                 R__TYPE = 7'd51, BRANCH = 7'd99, JUMP = 7'd111 } operations;
    operations optype = NOP;

    localparam  LOADS = 7'd3,   I_TYPE = 7'd19, S_TYPE = 7'd35, 
                R_TYPE = 7'd51, B_TYPE = 7'd99, J_TYPE = 7'd111;

    logic [10:0] controls;
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
            ResultSrc, Branch, ALUOp, Jump} = controls;

    always_comb begin
        case (op)
            //                           RegWrite ImmSrc ALUSrc MemWrite ResultSrc Branch ALUOp  Jump
            LOADS:  begin controls = 11'b1________00_____1______0________01________0______00_____0; optype = LOAD; end 
            I_TYPE: begin controls = 11'b1________00_____1______0________00________0______10_____0; optype = I__TYPE; end
            S_TYPE: begin controls = 11'b0________01_____1______1________00________0______00_____0; optype = STORE; end
            R_TYPE: begin controls = 11'b1________xx_____0______0________00________0______10_____0; optype = R__TYPE; end
            B_TYPE: begin controls = 11'b0________10_____0______0________00________1______01_____0; optype = BRANCH; end
            J_TYPE: begin controls = 11'b1________11_____0______0________10________0______00_____1; optype = JUMP; end
            default:begin controls = 11'b0________xx_____x______0________xx________0______xx_____0; optype = NOP; end 
        endcase
    end
endmodule
