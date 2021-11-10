
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2021 02:39:09
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


module testbench();

    logic clk, reset;
    logic [31:0] WriteData, MemAdr;
    logic MemWrite;

    top dut(clk, reset, WriteData, MemAdr, MemWrite);

    initial 
        begin
            reset = 1; 
            #22;
            reset = 0;
        end
    always begin
        clk =1; 
        #5;
        clk = 0;
        #5;
    end

endmodule
