
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2021 16:15:42
// Design Name: 
// Module Name: testbench
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


module testbench;

    logic clk = 1, reset = 1;
    logic [31:0] WriteData, DataAdr;
    logic MemWrite;

    top dut(.*);

    always #22
        reset = 0;

    always #5
        clk = ~clk;

endmodule
