
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2021 18:07:47
// Design Name: 
// Module Name: idmem
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


module idmem(input logic clk, we,
            input logic [31:0] a, wd,
            output logic [31:0] rd);
    

    logic [31:0] RAM[128];
    initial $readmemh("loadmem.mem",RAM);

    //assign RAM[4] = 11;
    //assign RAM[6] = 254;
    assign RAM[7] = 10;

    /* * * * * * * * * * * * * * * * *

    FFC4A303: lw x6, -4(x9) ---> x6 = RAM[7]    (7 = 28 >> 2)
    0064A423: sw x6, 8(x9)  ---> RAM[10] = x6   (10 = 32 >> 2)
    0062E233: or x4, x5, x6 ---> x4 = x5 | x6   ()

    * * * * * * * * * * * * * * * * * */ 

    assign rd = RAM[a[6:2]];

    always_ff @(posedge clk)
        if (we) RAM[a[6:2]] <= wd;

endmodule
