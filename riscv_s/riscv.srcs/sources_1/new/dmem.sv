
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


module dmem(input logic clk, we,
            input logic [31:0] a, wd,
            input logic [2:0] size,
            output logic [31:0] rd);

logic [7:0] RAM[128][4];
//assign RAM[28] = '{171,250,170,10};
// assign RAM[28] = '{3,0,0,0};

// assign RAM[28] = '{8'hfd,8'hff,8'hff,8'hff}; // -3
// assign RAM[28] = '{8'hff,8'hff,8'hff,8'hff}; // -1
// assign RAM[28] = '{8'h02,8'h00,8'h00,8'h00}; // 2
// assign RAM[28] = '{8'h04,8'h00,8'h00,8'h00}; // 4

assign rd = {RAM[a[6:0]][3], RAM[a[6:0]][2], RAM[a[6:0]][1], RAM[a[6:0]][0]}; // word aligned

always_ff @(posedge clk)
    if (we) begin 
        case(size)
            3'b000: 
                RAM[a[6:0]][0] <=  wd[7:0];                                 // byte
            3'b001: 
                {RAM[a[6:0]][1], RAM[a[6:0]][0]} <= {wd[15:8], wd[7:0]};    // half
            3'b010:
                RAM[a[6:0]] <= '{wd[7:0], wd[15:8], wd[23:16], wd[31:24]};  // word
            default:;
        endcase
    end
    

endmodule
