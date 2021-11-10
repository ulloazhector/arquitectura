
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2021 16:12:08
// Design Name: 
// Module Name: imem
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


module imem(
    input   logic [31:0] a,
    output  logic [31:0] rd
    );

    logic [31:0] RAM[64];

    initial $readmemh("loadmem.mem", RAM);

    assign rd = RAM[a[7:2]]; // word aligned
endmodule
