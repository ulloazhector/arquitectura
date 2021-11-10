
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 23:17:16
// Design Name: 
// Module Name: MainFSM
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


module MainFSM(
    input logic         clk, reset,
    input logic [6:0]   op,
    output logic        Branch, PCUpdate,
    output logic        RegWrite, MemWrite, IRWrite,
    output logic [1:0]  ResultSrc,
    output logic [1:0]  ALUSrcA, ALUSrcB,
    output logic        AdrSrc,
    output logic [1:0]  ALUOp

    );

    logic [6:0] op_aux;

    typedef enum logic [3:0] {  FETCH,  DECODE,     MEM_ADR,    MEM_READ,
                                MEM_WB, MEM_WRITE,  EXEC_R,     ALU_WB, 
                                EXEC_I, JAL,        BEQ} states_t;

    // typedef enum [6:0] {  LOAD    = 7'b0000011,   S_TYPE = 7'b0100011, 
    //                             R_TYPE  = 7'b0110011,   I_TYPE = 7'b0010011, 
    //                             J_TYPE  = 7'b1101111,   B_TYPE = 7'b1100011 } types_t;

    // types_t instr_type;
    states_t state_reg, state_next;

    always_ff @( posedge clk, posedge reset )
        if (reset)  state_reg <= FETCH;
        else        state_reg <= state_next;


    always_comb begin 
        // instr_type = op;
        Branch      = 0;
        PCUpdate    = 0;
        RegWrite    = 0;
        MemWrite    = 0;
        IRWrite     = 0;
        ResultSrc   = 0;
        ALUSrcA     = 0;
        ALUSrcB     = 0;
        AdrSrc      = 0;
        ALUOp       = 0;

        //state_next = FETCH;

        case (state_reg)
            FETCH:  begin 
                        op_aux      = op; 
                        // out
                        AdrSrc      = 0;
                        IRWrite     = 1;
                        ALUSrcA     = 2'b00;
                        ALUSrcB     = 2'b10;
                        ALUOp       = 2'b00;
                        ResultSrc   = 2'b10;
                        PCUpdate    = 1;

                        // state update
                        // if (op_aux == 7'b0000011 || op_aux == 7'b0100011 || 
                        //     op_aux == 7'b0110011 || op_aux == 7'b0010011 ||
                        //     op_aux == 7'b1101111 || op_aux == 7'b1100011)
                            state_next = DECODE;
                    end


            DECODE: begin
                        // out
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b01;
                        ALUOp   = 2'b00;
                         
                        // state update
                        case(op)
                            7'b0000011: state_next = MEM_ADR;
                            7'b0100011: state_next = MEM_ADR;
                            7'b0110011: state_next = EXEC_R;
                            7'b0010011: state_next = EXEC_I;
                            7'b1101111: state_next = JAL;
                            7'b1100011: state_next = BEQ;
                        endcase
                    end


            MEM_ADR: begin
                        // out
                        ALUSrcA = 2'b10;
                        ALUSrcB = 2'b01;
                        ALUOp   = 2'b00;

                        // state update
                        state_next = (op == 7'b0000011) ? MEM_READ : MEM_WRITE;
                     end
            

            MEM_READ: begin
                        // out
                        ResultSrc   = 2'b00;
                        AdrSrc      = 1;

                        // state update
                        state_next = MEM_WB;
                      end


            MEM_WB: begin
                        // out
                        ResultSrc   = 2'b01;
                        RegWrite    = 1;

                        // state update
                        state_next = FETCH;
                    end


            MEM_WRITE:  begin
                        // out
                            ResultSrc   = 2'b00;
                            AdrSrc      = 1;
                            MemWrite    = 1;

                        // state update
                            state_next = FETCH;
                        end


            EXEC_R: begin
                        // out
                        ALUSrcA = 2'b10;
                        ALUSrcB = 2'b00;
                        ALUOp   = 2'b10;

                        // state update
                        state_next = ALU_WB;
                    end


            ALU_WB: begin 
                        // out
                        ResultSrc   = 2'b00;
                        RegWrite    = 1;

                        // state update
                        state_next = FETCH;
                    end


            EXEC_I: begin
                        // out
                        ALUSrcA = 2'b10;
                        ALUSrcB = 2'b01;
                        ALUOp   = 2'b10;

                        // state update
                        state_next = ALU_WB;
                    end 


            JAL:    begin 
                        // out
                        ALUSrcA     = 2'b01;
                        ALUSrcB     = 2'b10;
                        ALUOp       = 2'b00;
                        ResultSrc   = 2'b00;
                        PCUpdate    = 1;

                        // state update
                        state_next = ALU_WB;
                    end


            BEQ:    begin
                        // out
                        ALUSrcA     = 2'b10;
                        ALUSrcB     = 2'b00;
                        ALUOp       = 2'b01;
                        ResultSrc   = 2'b00;
                        Branch      = 1;

                        // state update
                        state_next = FETCH; 
                    end


            default: state_next = FETCH;
        endcase
    end

endmodule
