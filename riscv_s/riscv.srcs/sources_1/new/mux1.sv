`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2021 21:09:05
// Design Name: 
// Module Name: mux1
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

// Mux con 3 entradas, con prioridad en el bit más significativo
module mux1 #(parameter WIDTH = 8)(
            input logic [WIDTH-1:0]     d0, d1, d2,
            input logic  [1:0]           s,
            output logic [WIDTH-1:0]    y);

    assign y = s[1] ? d2 : (s[0] ? d1 : d0);
    
endmodule
