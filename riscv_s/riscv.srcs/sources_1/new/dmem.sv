
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 08:59:16 PM
// Design Name: 
// Module Name: dmem
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


module dmem(input   logic clk, we,
            input   logic [31:0] a, wd,
            input   logic [2:0] size,
            output  logic [31:0] rd);

logic [7:0] RAM[128][4];
logic [31:0] Adr;

assign RAM[28] = '{10, 0, 0, 0};


// initial begin
//     for (int i = 0; i < 128; i++) begin
//         RAM[i] = '{i,i,i,i};
//     end
// end


assign Adr = a << 2;
assign rd = {RAM[Adr[8:2]][3], RAM[Adr[8:2]][2], RAM[Adr[8:2]][1], RAM[Adr[8:2]][0]}; // word aligned
    


always_ff @(posedge clk)
    if (we) begin 
        case(size)
            3'b000: 
                RAM[Adr[8:2]][0] <=  wd[7:0];                                   // byte
            3'b001: 
                {RAM[Adr[8:2]][1], RAM[Adr[8:2]][0]} <= {wd[15:8], wd[7:0]};    // half
            3'b010:
                RAM[Adr[8:2]] <= '{wd[7:0], wd[15:8], wd[23:16], wd[31:24]};  // word
            default:;
        endcase
    end
    

endmodule
