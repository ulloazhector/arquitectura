
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:12:28
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


module dmem(
    input   logic           clk, we,
    input   logic [31:0]    a, wd,
    output  logic [31:0]    rd
    );

    logic [31:0] RAM[128];

    // Sample Program
    assign RAM[28] = 32'd10;
    /////////////////

    assign rd = RAM[a[6:0]];


    always_ff @( posedge clk ) 
        if (we) RAM[a[6:0]] <= wd;
    
endmodule
