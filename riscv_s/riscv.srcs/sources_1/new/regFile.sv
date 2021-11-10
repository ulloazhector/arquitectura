
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 08:18:19 PM
// Design Name: 
// Module Name: regFile
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


module regFile(input logic         clk,
               input logic         load,
               input logic         we3,
               input logic  [4:0]  a1, a2, a3,
               input logic  [31:0] wd3,
               input logic  [2:0]  size,
               output logic [31:0] rd1, rd2);

logic [7:0] rf[32][4];

// assign rf[5] = '{8'hfd,8'hff,8'hff,8'hff}; // -3
// assign rf[5] = '{8'hff,8'hff,8'hff,8'hff}; // -1
// assign rf[5] = '{8'h08,8'h00,8'h00,8'h00}; // 2
// assign rf[5] = '{8'h04,8'h00,8'h00,8'h00}; // 4

//assign rf[6] = '{8'haa,8'haa,8'haa,8'haa};
// assign rf[9] = '{8'h20,8'h00,8'h00,8'h00};

assign rf[0] = '{'0, '0, '0, '0}; // x0 = 0

// three ported register file
// read two ports combinationally (A1/RD1, A2/RD2)
// write third port on rising edge of clock (A3/WD3/WE3)
// register 0 hardwired to 0
    always_ff @(posedge clk)
        if (we3) begin 
            rf[a3] <= '{wd3[7:0], wd3[15:8], wd3[23:16], wd3[31:24]};       // word

            if (load) //op #0000011
                case(size)
                    3'b000: rf[a3] <= '{wd3[7:0], {8{wd3[7]}}, {8{wd3[7]}}, {8{wd3[7]}}};   // byte
                    3'b001: rf[a3] <= '{wd3[7:0], wd3[15:8], {8{wd3[15]}}, {8{wd3[15]}}};   // half
                    3'b010: rf[a3] <= '{wd3[7:0], wd3[15:8], wd3[23:16], wd3[31:24]};       // word
                    3'b100: rf[a3] <= '{wd3[7:0], '0, '0, '0};                              // byte unsigned
                    3'b101: rf[a3] <= '{wd3[7:0], wd3[15:8], '0, '0};                       // half unsigned
                    default;
                endcase
        end

    assign rd1 = (a1 != 0) ? {rf[a1][3], rf[a1][2],rf[a1][1],rf[a1][0]} : 0;
    assign rd2 = (a2 != 0) ? {rf[a2][3], rf[a2][2],rf[a2][1],rf[a2][0]} : 0;
endmodule
