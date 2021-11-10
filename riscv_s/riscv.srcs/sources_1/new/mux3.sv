
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 07:56:33 PM
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter WIDTH = 8)
            (input logic [WIDTH-1:0] d0, d1, d2, d3, d4,
             input logic [2:0]        s,
             output logic [WIDTH-1:0] y);

    //assign y = s[1] ? d2 : (s[0] ? d1 : d0);

always_comb
    case(s)
        3'b000: y = d0;
        3'b001: y = d1;
        3'b010: y = d2;
        3'b011: y = d3;
        3'b100: y = d4;
        default:;
    endcase
 
endmodule
